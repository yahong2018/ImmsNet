using System;
using System.IO;
using System.Collections.Generic;
using System.Transactions;
using Imms.Data;
using Imms.Data.Domain;
using Newtonsoft.Json;
using Imms.Mes.Domain;

namespace Imms.Mes.Exchange
{
    public class FromAps : IThirdPartDataPullLogic
    {
        public SortedDictionary<string, ThirdPartDataPullProcessHandler> Handlers
        {
            get
            {
                return new SortedDictionary<string, ThirdPartDataPullProcessHandler>(){
                    {GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__APS_2_MES,this.ImportScheduleOrder}
                };
            }
        }

        public SortedDictionary<string, Type> DTOTypes
        {
            get
            {
                return new SortedDictionary<string, Type>(){
                    {GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__APS_2_MES,typeof(ScheduleOrderDTO)}
                };
            }
        }

        private void ImportScheduleOrder(object dto)
        {
            ScheduleOrderDTO scheduleOrder = (ScheduleOrderDTO)dto;

            ProductionOrder productionOrder = this.ConvertProductionOrder(scheduleOrder);
            Bom[] boms = ConvertBoms(scheduleOrder.Boms);
            BomOrder bomOrder = new BomOrder
            {
                BomOrderType = GlobalConstants.TYPE_BOM_ORDER_PRODUCTION_ORDER,
                OrderStatus = GlobalConstants.STATUS_BOM_ORDER_NORMAL
            };
            ProductionOrderSize[] sizes = ConvertSizes(scheduleOrder.OrderSizes);
            ProductionOrderMeasure[] measures = ConvertMeasures(scheduleOrder.BodyDatas);

            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required))
            {
                CommonDAO.Insert<BomOrder>(bomOrder);
                foreach (Bom bom in boms)
                {
                    bom.BomOrderId = bomOrder.RecordId;
                }
                CommonDAO.Insert<Bom>(boms);

                productionOrder.BomOrderId = bomOrder.RecordId;
                productionOrder.OrderStatus = productionOrder.OrderStatus | GlobalConstants.STATUS_PRODUCTION_ORDER_BOM_READY;
                CommonDAO.Insert<ProductionOrder>(productionOrder, notifyChangeEvent: true);

                foreach (ProductionOrderSize size in sizes)
                {
                    size.ProductionOrderId = productionOrder.RecordId;
                }
                CommonDAO.Insert<ProductionOrderSize>(sizes);

                foreach (ProductionOrderMeasure measure in measures)
                {
                    measure.ProductionOrderId = productionOrder.RecordId;
                }
                CommonDAO.Insert<ProductionOrderMeasure>(measures);

                scope.Complete();
            }
        }

        private ProductionOrderMeasure[] ConvertMeasures(BodyMeasureDTO[] dtos)
        {
            if (dtos == null || dtos.Length == 0)
            {
                return new ProductionOrderMeasure[] { };
            }

            ProductionOrderMeasure[] result = new ProductionOrderMeasure[dtos.Length];
            for (int i = 0; i < dtos.Length; i++)
            {
                result[i] = ConvertMeasure(dtos[i]);
            }

            return result;
        }

        private ProductionOrderMeasure ConvertMeasure(BodyMeasureDTO dto)
        {
            return new ProductionOrderMeasure()
            {
                BodyNo = dto.BodyCode,
                MeasureData = dto.MeasureData,
                GarmentSize = dto.GarmentSize
            };
        }

        private ProductionOrderSize[] ConvertSizes(OrderSizeDTO[] dtos)
        {
            if (dtos == null || dtos.Length == 0)
            {
                return new ProductionOrderSize[] { };
            }

            ProductionOrderSize[] result = new ProductionOrderSize[dtos.Length];
            for (int i = 0; i < dtos.Length; i++)
            {
                result[i] = ConvertSize(dtos[i]);
            }

            return result;
        }

        private ProductionOrderSize ConvertSize(OrderSizeDTO dto)
        {
            Size size = CommonDAO.AssureExistsByFilter<Size>("CodeNo == @0", dto.Size);
            ProductionOrderSize orderSize = new ProductionOrderSize
            {
                SizeId = size.RecordId,
                QytPlanned = dto.PlannedQty
            };
            return orderSize;
        }

        private ProductionOrder ConvertProductionOrder(ScheduleOrderDTO scheduleOrder)
        {
            Material fgMaterial = CommonDAO.AssureExistsByFilter<Material>("MaterialNo == @0", scheduleOrder.MaterialCode);
            Plant plant = CommonDAO.AssureExistsByFilter<Plant>("OrganizationCode == @0", scheduleOrder.Plant);
            WorkCenter workCenter = CommonDAO.AssureExistsByFilter<WorkCenter>("OrganizationCode == @0", scheduleOrder.WorkCenter);
            BomOrder bomOrder = CommonDAO.AssureExistsByFilter<BomOrder>("OrderNo == @0", scheduleOrder.BomOrderNo);

            ProductionOrder productionOrder = new ProductionOrder
            {
                RequirementOrderNo = scheduleOrder.RequirementOrderNo,
                ScheduleOrderNo = scheduleOrder.ScheduleOrderNo,
                OrderType = scheduleOrder.OrderType,
                FgMaterialId = fgMaterial.RecordId,
                WorkCenterId = workCenter.RecordId,
                BomOrderId = bomOrder.RecordId,
                PlannedStartDate = scheduleOrder.PlannedStartDate,
                PlannedEndDate = scheduleOrder.PlannedEndDate,
                PlannedQty = scheduleOrder.PlannedQty,
                OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_PLANNED //已计划
            };

            return productionOrder;
        }

        private Bom[] ConvertBoms(BomDTO[] dtos)
        {
            if (dtos == null || dtos.Length == 0)
            {
                return new Bom[] { };
            }

            Bom[] result = new Bom[dtos.Length];
            for (int i = 0; i < dtos.Length; i++)
            {
                result[i] = ConvertBom(dtos[i]);
            }

            return result;
        }

        private Bom ConvertBom(BomDTO dto)
        {
            Material abstractMaterial = CommonDAO.AssureExistsByFilter<Material>("MaterialNo == @0", dto.ComponentAbstractMaterial);
            Material componentMaterial = CommonDAO.AssureExistsByFilter<Material>("MaterialNo == @0", dto.MaterialCode);
            MaterialUnit unit = CommonDAO.AssureExistsByFilter<MaterialUnit>("CodeNo == @0", dto.ComponentMaterialUnit);

            Bom bom = new Bom()
            {
                ComponentAbstractMaterialId = abstractMaterial.RecordId,
                ComponentMaterialId = componentMaterial.RecordId,
                ComponentQty = dto.Qty,
                IsMainFabric = dto.IsMainFabric,
                ComponentUnitId = unit.RecordId
            };

            return bom;
        }

        public FromAps()
        {
            this._ExchangeRules = new string[]{
                GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__APS_2_MES
            };
        }

        private string[] _ExchangeRules;
        public string[] ExchangeRules { get { return this._ExchangeRules; } set => throw new NotImplementedException(); }
    }
    /*
    {       
        shceduleOrder:{
            scheduleOrderNo:"PO-35001",
            requirementOrder:"123456",
            material:"MSC-001",
            plannedQty:5,
            plan:"A",
            workCenter:"WC01",
            requiredDeliveryDate:"2019/03/25",
            plannedStartDate:"2019/03/20 14:30",
            plannedEndDate:"2019/03/20 15:00",

            orderSizes:[
                {
                    size:"170/88A",
                    plannedQty:3
                },
                {
                    size:"175/93B",
                    plannedQty:2
                }
            ],  
            boms:[
                {
                    bomOrder:"BO-001",
                    material:"A",
                    componentAbstractMaterial:"",
                    qty:1.05,
                    componentMaterialUnit:"米",
                    materialMatchRule:"RULE001",
                    isMainFabric:true
                },
                {
                    bomOrder:"BO-001",
                    material:"B",
                    componentAbstractMaterial:"",
                    qty:13.32,
                    componentMaterialUnit:"厘米",
                    materialMatchRule:"RULE001",
                    isMainFabric:false
                }
            ],
            bodyMeasure:[
                {
                    bodyCode:"A",
                    bodyName:"臂长",
                    data:"82.31",
                    size:""
                }
            ]
        }        
    }    
    */

    public class ScheduleOrderDTO
    {
        public string ScheduleOrderNo { get; set; }
        public string RequirementOrderNo { get; set; }
        public int OrderType { get; set; }
        public string BomOrderNo { get; set; }
        public string MaterialCode { get; set; }
        public int PlannedQty { get; set; }
        public string Plant { get; set; }
        public string WorkCenter { get; set; }
        public DateTime RequiredDeliveryDate { get; set; }
        public DateTime PlannedStartDate { get; set; }
        public DateTime PlannedEndDate { get; set; }

        public OrderSizeDTO[] OrderSizes { get; set; }
        public BomDTO[] Boms { get; set; }
        public BodyMeasureDTO[] BodyDatas { get; set; }
    }

    public class OrderSizeDTO
    {
        public string Size { get; set; }
        public int PlannedQty { get; set; }
    }

    public class BomDTO
    {
        public string MaterialCode { get; set; }
        public string ComponentAbstractMaterial { get; set; }
        public float Qty { get; set; }
        public string ComponentMaterialUnit { get; set; }
        public string MaterialMatchRule { get; set; }
        public bool IsMainFabric { get; set; }
    }

    public class BodyMeasureDTO
    {
        public string BodyCode { get; set; }
        public string BodyName { get; set; }
        public string MeasureData { get; set; }  //静体尺寸   
        public string GarmentSize { get; set; }  //成衣尺寸
    }
}