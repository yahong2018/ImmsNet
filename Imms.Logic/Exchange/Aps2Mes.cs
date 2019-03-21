using System;
using System.IO;
using System.Transactions;
using Imms.Data;
using Imms.Data.Domain;
using Newtonsoft.Json;
using System.Linq;
using Imms.Data.DAO;

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
                    ShceduleOrderDTO shceduleOrder = (ShceduleOrderDTO)serializer.Deserialize(reader, typeof(ShceduleOrderDTO));

                    this.ImportScheduleOrder(shceduleOrder);
                }
            }
        }

        private void ImportScheduleOrder(ShceduleOrderDTO shceduleOrder)
        {
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required))
            {
                using (ImmsDbContext dbContext = new ImmsDbContext())
                {
                    Material fgMaterial = MaterialDAO.GetByMaterialCode(shceduleOrder.MaterialCode);
                    if (fgMaterial == null)
                    {
                        return;
                    }
                    

                    ProductionOrder productionOrder = new ProductionOrder();
                    productionOrder.RequirementOrderNo = shceduleOrder.RequirementOrderNo;
                    productionOrder.ScheduleOrderNo = shceduleOrder.ScheduleOrderNo;
                    productionOrder.FgMaterialId = fgMaterial.RecordId;
                    
                }
            }
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

    public class ShceduleOrderDTO
    {
        public string ScheduleOrderNo { get; set; }
        public string RequirementOrderNo { get; set; }
        public string BomOrderNo { get; set; }
        public string MaterialCode { get; set; }
        public int plannedQty { get; set; }
        public string Plan { get; set; }
        public string workCenter { get; set; }
        public DateTime requiredDeliveryDate { get; set; }
        public DateTime plannedStartDate { get; set; }
        public DateTime plannedEndDate { get; set; }

        public OrderSizeDTO[] OrderSizes { get; set; }
        public BomDTO[] boms { get; set; }
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
        public double Qty { get; set; }
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