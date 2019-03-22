using System;
using System.IO;
using System.Transactions;
using Imms.Data;
using Imms.Data.Domain;
using Newtonsoft.Json;
using System.Linq;
using Imms.Core;

namespace Imms.Logic.Exchange
{
    public class Aps2Mes : ISystemDataExchangeLogic
    {
        public void Process(SystemExchangeDataLog log)
        {
            using (StringReader strReader = new StringReader(log.RawData))
            {
                using (JsonTextReader reader = new JsonTextReader(strReader))
                {
                    JsonSerializer serializer = new JsonSerializer();
                    ScheduleOrderDTO shceduleOrder = (ScheduleOrderDTO)serializer.Deserialize(reader, typeof(ScheduleOrderDTO));

                    this.ImportScheduleOrder(shceduleOrder);
                }
            }
        }

        private void ImportScheduleOrder(ScheduleOrderDTO scheduleOrder)
        {
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required))
            {
                using (ImmsDbContext dbContext = new ImmsDbContext())
                {
                    ProductionOrder productionOrder = this.ConvertProductionOrder(scheduleOrder);                    
                    Bom[] boms = ConvertBoms(scheduleOrder.Boms);
                    //ProductionOrderSize

                    BomOrder bomOrder = new BomOrder
                    {
                        BomOrderType = GlobalConstants.BOM_ORDER_TYPE_PRODUCTION_ORDER,
                        OrderStatus = GlobalConstants.BOM_ORDER_STATUS_NORMAL
                    };
                }
            }
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
            Size size = CommonDAO.CheckExistsByProperty<Size>("CodeNo", dto.Size);
            ProductionOrderSize orderSize = new ProductionOrderSize
            {
                SizeId = size.RecordId,
                QytPlanned = dto.PlannedQty
            };
            return orderSize;
        }

        private ProductionOrder ConvertProductionOrder(ScheduleOrderDTO scheduleOrder)
        {
            Material fgMaterial = CommonDAO.CheckExistsByProperty<Material>("MaterialNo", scheduleOrder.MaterialCode);            
            Plant plant = CommonDAO.CheckExistsByProperty<Plant>("OrganizationCode",scheduleOrder.Plant);            
            WorkCenter workCenter = CommonDAO.CheckExistsByProperty<WorkCenter>("OrganizationCode", scheduleOrder.WorkCenter);           
            BomOrder bomOrder = CommonDAO.CheckExistsByProperty<BomOrder>("BomOrderNo",scheduleOrder.BomOrderNo);            

            ProductionOrder productionOrder = new ProductionOrder
            {
                RequirementOrderNo = scheduleOrder.RequirementOrderNo,
                ScheduleOrderNo = scheduleOrder.ScheduleOrderNo,
                FgMaterialId = fgMaterial.RecordId,
                WorkCenterId = workCenter.RecordId,
                BomOrderId = bomOrder.RecordId,
                PlannedStartDate = scheduleOrder.PlannedStartDate,
                PlannedEndDate = scheduleOrder.PlannedEndDate,
                PlannedQty = scheduleOrder.PlannedQty
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
            Material abstractMaterial = CommonDAO.CheckExistsByProperty<Material>("ComponentAbstractMaterial", dto.ComponentAbstractMaterial);
            Material componentMaterial = CommonDAO.CheckExistsByProperty<Material>("MaterialCode",dto.MaterialCode);
            MaterialUnit unit = CommonDAO.CheckExistsByProperty<MaterialUnit>("CodeNo", dto.ComponentMaterialUnit);

            Bom bom = new Bom()
            {
                ComponentAbstractMaterialId=abstractMaterial.RecordId,
                ComponentMaterialId = componentMaterial.RecordId,
                ComponentQty = dto.Qty,
                IsFabric = (short)(dto.IsMainFabric?1:0),
                ComponentUnitId = unit.RecordId
            };

            return bom;
        }

        public Aps2Mes()
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
        public BodyMeasureDTO BodyDatas { get; set; }
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
        public double MeasureData { get; set; }   //静体尺寸   
        public string GarmentSize { get; set; }  //成衣尺寸
    }
}