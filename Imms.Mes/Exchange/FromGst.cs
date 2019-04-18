using Imms.Data;
using Imms.Data.Domain;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Transactions;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Imms.Mes.Stitch;
using Imms.Mes.Organization;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Imms.Mes.Exchange
{
    public class FromGst : IThirdPartDataPullLogic
    {
        public string[] ExchangeRules { get { return new string[] { GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__GST_2_MES }; } set => throw new System.NotImplementedException(); }

        public SortedDictionary<string, Type> DTOTypes =>
            new SortedDictionary<string, Type>(){
                    {GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__GST_2_MES,typeof(ProductionOrderRoutingDTO)}
            };

        public SortedDictionary<string, ThirdPartDataPullProcessHandler> Handlers =>
            new SortedDictionary<string, ThirdPartDataPullProcessHandler>()
            {
                {GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__GST_2_MES,this.ImportProducitonOrderRouting}
            };

        public void ImportProducitonOrderRouting(object dtoObj)
        {
            OperationRoutingOrder routingOrder = null;
            OperationRouting[] operationRoutings = null;
            ProductionOrder productionOrder = null;
                       
            CommonDAO.UseDbContext(dbContext =>
            {
                ProductionOrderRoutingDTO dto = (ProductionOrderRoutingDTO)dtoObj;
                productionOrder = dbContext.Set<ProductionOrder>().Single(x => x.OrderNo == dto.ProductionOrderNo);
                Material.Material material = dbContext.Set<Material.Material>().Single(x => x.MaterialNo == dto.MaterialNo);
                if (material.RecordId != productionOrder.FgMaterialId)
                {
                    throw new BusinessException(GlobalConstants.EXCEPTION_CODE_NOT_EXCEPTED_DATA, $"Gst返回工艺的物料Id{material.RecordId}与Id为{productionOrder.RecordId}的生产订单的物料编号{productionOrder.FgMaterialId}不一致!");
                }
                routingOrder = CreateProductionRoutingOrder(material);
                operationRoutings = ConvertRoutings(dto.OperationRoutings,dbContext);
            });

            StitchLogic.Instance.SetProductionOrderRouting(productionOrder, routingOrder, operationRoutings);
        }

        private OperationRoutingOrder CreateProductionRoutingOrder(Material.Material material)
        {
            return new OperationRoutingOrder()
            {
                MaterialId = material.RecordId,
                OrderType = GlobalConstants.TYPE_OPERATION_ROUTING_ORDER_PRODUCTION
            };
        }

        public OperationRouting[] ConvertRoutings(OperationRoutingDTO[] dtos, DbContext dbContext)
        {
            if (dtos == null || dtos.Length == 0)
            {
                return new OperationRouting[] { };
            }

            OperationRouting[] result = new OperationRouting[dtos.Length];
            for (int i = 0; i < dtos.Length; i++)
            {
                result[i] = ConvertOperationRouting(dtos[i],dbContext);
            }
            foreach (OperationRouting routing in result)
            {
                var prevOperations = result.Where(x => x.NextOpertionNo == routing.OperationNo);
                foreach (OperationRouting prev in prevOperations)
                {
                    routing.PrevOpreatons.Add(prev);
                    prev.NextRouting = routing;
                }
            }

            return result;
        }

        private OperationRouting ConvertOperationRouting(OperationRoutingDTO dto, DbContext dbContext)
        {
            OperationRouting routing = new OperationRouting();
            Operation operation = dbContext.Set<Operation>().Single(x => x.OperationNo == dto.OperationNo);
            EquipmentType machineType = dbContext.Set<EquipmentType>().Single(x => x.CodeNo == dto.MachineType);

            routing.OperationId = operation.RecordId;
            routing.OperationNo = operation.OperationNo;
            routing.Description = operation.Description;
            routing.IsOutsource = dto.IsOutsource;
            routing.MachineTypeId = machineType.RecordId;
            routing.NextOpertionNo = dto.NextOperationNo;
            routing.QaProcedure = dto.QaProcedure;
            routing.Requirement = dto.Requirement;
            routing.RequiredLevel = dto.RequiredLevel;
            routing.SectionType = dto.SectionType;
            routing.SectionName = operation.SectionName;
            routing.StandardPrice = dto.StandardPrice;
            routing.StandardTime = dto.StandardTime;

            return routing;
        }
    }

    public class ProductionOrderRoutingDTO
    {
        public string ProductionOrderNo { get; set; }
        public string MaterialNo { get; set; }

        public OperationRoutingDTO[] OperationRoutings { get; set; }        
    }

    public class OperationRoutingDTO
    {
        public string OperationNo { get; set; }
        public string NextOperationNo { get; set; }
        public string MachineType { get; set; }
        public bool IsOutsource { get; set; }
        public string QaProcedure { get; set; }
        public string Requirement { get; set; }
        public double StandardTime { get; set; }
        public double StandardPrice { get; set; }
        public string SectionType { get; set; }
        public string RequiredLevel { get; set; }
        public string[] PreOperations { get; set; }
    }
}