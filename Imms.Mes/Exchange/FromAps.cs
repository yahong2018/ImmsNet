using System;
using System.IO;
using System.Collections.Generic;
using System.Transactions;
using Imms.Data;
using Imms.Data.Domain;
using Newtonsoft.Json;
using Imms.Mes.Domain;
using Microsoft.EntityFrameworkCore;
using System.Threading;
using Imms.Mes.Stitch;
using Imms.Mes.Organization;
using Imms.Mes.Material;

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
                OrderStatus = GlobalConstants.STATUS_DOCUMENT_NORMAL,
                Material = productionOrder.FgMaterial
            };
            ProductionOrderSize[] sizes = ConvertSizes(scheduleOrder.OrderSizes);
            ProductionOrderMeasure[] measures = ConvertMeasures(scheduleOrder.BodyDatas);

            bomOrder.Boms.AddRange(boms);
            productionOrder.BomOrder = bomOrder;
            productionOrder.OrderStatus = productionOrder.OrderStatus | GlobalConstants.STATUS_PRODUCTION_ORDER_BOM_READY;
            productionOrder.Sizes.AddRange(sizes);
            productionOrder.Measures.AddRange(measures);

            CommonDAO.UseDbContext((dbContext) =>
              {
                  dbContext.Set<BomOrder>().Add(bomOrder);
                  dbContext.Set<ProductionOrder>().Add(productionOrder);
                  dbContext.SaveChanges();
              });
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
            // Size size = CommonDAO.AssureExistsByFilter<Size>(x=>x.CodeNo == dto.Size);
            ProductionOrderSize orderSize = new ProductionOrderSize
            {
                Size = dto.Size,
                QytPlanned = dto.PlannedQty
            };
            return orderSize;
        }

        private ProductionOrder ConvertProductionOrder(ScheduleOrderDTO scheduleOrder)
        {
            Material.Material fgMaterial = CommonDAO.AssureExistsByFilter<Material.Material>(x=>x.MaterialNo == scheduleOrder.MaterialCode);
            Plant plant = CommonDAO.AssureExistsByFilter<Plant>(x=>x.OrganizationCode == scheduleOrder.Plant);
            WorkCenter workCenter = CommonDAO.AssureExistsByFilter<WorkCenter>(x=>x.OrganizationCode == scheduleOrder.WorkCenter);

            ProductionOrder productionOrder = new ProductionOrder
            {
                RequirementOrderNo = scheduleOrder.RequirementOrderNo,
                ScheduleOrderNo = scheduleOrder.ScheduleOrderNo,
                OrderType = scheduleOrder.OrderType,
                FgMaterial = fgMaterial,
                WorkCenterId = workCenter.RecordId,
                TimeStartPlanned = scheduleOrder.PlannedStartDate,
                TimeEndPlanned = scheduleOrder.PlannedEndDate,
                QtyPlanned = scheduleOrder.PlannedQty,
                OrderStatus = GlobalConstants.STATUS_ORDER_PLANNED //已计划
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
            Material.Material abstractMaterial = CommonDAO.AssureExistsByFilter<Material.Material>(x=>x.MaterialNo == dto.ComponentAbstractMaterial);
            Material.Material componentMaterial = CommonDAO.AssureExistsByFilter<Material.Material>(x=>x.MaterialNo == dto.MaterialCode);

            Bom bom = new Bom()
            {
                ComponentAbstractMaterialId = abstractMaterial.RecordId,
                ComponentMaterialId = componentMaterial.RecordId,
                QtyComponent = dto.Qty,
                IsMainFabric = dto.IsMainFabric,
                ComponentUnit = dto.ComponentMaterialUnit
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