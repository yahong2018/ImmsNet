using Imms.Data;
using Imms.Mes.Domain;
using Imms.Data.Domain;
using System;
using System.Collections.Generic;
using System.Transactions;
using Microsoft.EntityFrameworkCore;
using Imms.Mes.Logic;

namespace Imms.Mes.Exchange
{
    public class FromGst : IThirdPartDataPullLogic
    {
        public ProductionOrderLogic productionOrderLogic{get;set;}

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
            ProductionOrderRoutingDTO dto = (ProductionOrderRoutingDTO)dtoObj;
            ProductionOrder productionOrder = CommonDAO.AssureExistsByFilter<ProductionOrder>("OrderNo == @0", dto.ProductionOrderNo);
            Material material = CommonDAO.AssureExistsByFilter<Material>("MaterialNo == @0",dto.MaterialNo);
            if (material.RecordId != productionOrder.FgMaterialId)
            {
                throw new BusinessException(GlobalConstants.EXCEPTION_CODE_NOT_EXCEPTED_DATA, $"Gst返回工艺的物料Id{material.RecordId}与Id为{productionOrder.RecordId}的生产订单的物料编号{productionOrder.FgMaterialId}不一致!");
            }
            OperationRoutingOrder routingOrder = CreateProductionRoutingOrder(material);
            OperationRouting[] operationRoutings = ConvertRoutings(dto.OperationRoutings);

            productionOrderLogic.SetProductionOrderRouting(productionOrder,routingOrder,operationRoutings);            
        }

        private OperationRoutingOrder CreateProductionRoutingOrder(Material material)
        {
            return new OperationRoutingOrder()
            {
                MaterialId = material.RecordId,
                OrderType = GlobalConstants.OPERATION_ORDER_TYPE_PRODUCTION
            };
        }

        public OperationRouting[] ConvertRoutings(OperationRoutingDTO[] dtos)
        {
            if (dtos == null || dtos.Length == 0)
            {
                return new OperationRouting[] { };
            }

            OperationRouting[] result = new OperationRouting[dtos.Length];
            for (int i = 0; i < dtos.Length; i++)
            {
                result[i] = ConvertOperationRouting(dtos[i]);
            }

            return result;
        }

        private OperationRouting ConvertOperationRouting(OperationRoutingDTO dto)
        {
            OperationRouting routing = new OperationRouting();
            Operation operation = CommonDAO.AssureExistsByFilter<Operation>("OperationNo == @0",dto.OperationNo);
            MachineType machineType = CommonDAO.AssureExistsByFilter<MachineType>("CodeNo == @0",dto.MachineType);

            routing.OperationId = operation.RecordId;
            routing.OperationNo = operation.OperationNo;
            routing.OperationName = operation.OperationName;            
            routing.IsOutsource = dto.IsOutsource;
            routing.MachineTypeId = machineType.RecordId;
            routing.NextOpertionNo = dto.NextOperationNo;
            if (dto.PreOperations != null && dto.PreOperations.Length > 0)
            {
                routing.PrevOperationNo = dto.PreOperations[0];
            }

            routing.QaProcedure = dto.QaProcedure;
            routing.Requirement = dto.Requirement;
            routing.RequiredLevel = dto.RequiredLevel;
            routing.SectionType = dto.SectionType;
            routing.SectionName = operation.SectionName;
            routing.StandardOperationProcedure = operation.StandardOperationProcedure;
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
        public byte? RequiredLevel { get; set; }
        public string[] PreOperations { get; set; }
    }
}