using Imms.Data;
using Imms.Data.Domain;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Transactions;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Imms.Mes.Stitch;
using Imms.Mes.MasterData;

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
            ProductionOrderRoutingDTO dto = (ProductionOrderRoutingDTO)dtoObj;
            ProductionOrder productionOrder = CommonDAO.AssureExistsByFilter<ProductionOrder>(x=>x.OrderNo == dto.ProductionOrderNo);
            Material material = CommonDAO.AssureExistsByFilter<Material>(x=>x.MaterialNo == dto.MaterialNo);
            if (material.RecordId != productionOrder.FgMaterialId)
            {
                throw new BusinessException(GlobalConstants.EXCEPTION_CODE_NOT_EXCEPTED_DATA, $"Gst返回工艺的物料Id{material.RecordId}与Id为{productionOrder.RecordId}的生产订单的物料编号{productionOrder.FgMaterialId}不一致!");
            }
            OperationRoutingOrder routingOrder = CreateProductionRoutingOrder(material);
            OperationRouting[] operationRoutings = ConvertRoutings(dto.OperationRoutings);

            this.SetProductionOrderRouting(productionOrder, routingOrder, operationRoutings);
        }

        private void SetProductionOrderRouting(ProductionOrder productionOrder, OperationRoutingOrder routingOrder, OperationRouting[] operationRoutings)
        {
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required))
            {
                CommonDAO.UseDbContext((dbContext) =>
                {
                    routingOrder.Routings.AddRange(operationRoutings);
                    dbContext.Set<OperationRoutingOrder>().Add(routingOrder);

                    productionOrder.ReachStatus(GlobalConstants.STATUS_PRODUCTION_ORDER_ROUTING_READY); //生产工艺已准备
                    productionOrder.RoutingOrder = routingOrder;
                    
                    EntityEntry<ProductionOrder> entry = dbContext.Attach<ProductionOrder>(productionOrder);
                    entry.State = EntityState.Modified;

                    dbContext.SaveChanges();
                    // this.SetNextAndPrevRoutingId(routingOrder.RecordId, dbContext);
                });

                scope.Complete();
            }
        }

        // private void SetNextAndPrevRoutingId(long routingOrderId, DbContext dbContext)
        // {
        //     string sql = @"update operation_routing
        //            set o.next_operation_routing_id = n.record_id,
        //                o.prev_operation_routing_id = p.record_id
        //         from operation_routing o 
        //                    left join operation_routing n on o.next_operation_no = n.operation_no
        //                    left join operation_routing p on o.prev_opreation_no = p.operation_no
        //         where o.operation_routing_order_id = @0";

        //     dbContext.Database.ExecuteSqlCommand(sql, routingOrderId);
        // }



        // private Media GetOperationMedia(Operation operation,int mediaType){
        //     /*
        //     select *
        //       from media
        //     where record_id in(
        //         select media_id
        //         from media_belong 
        //         where belong_to_id = opertation.record_id  -- 外键
        //           and belong_to_record_type = 25 -- operation_roder
        //           and media_type = mediaType   -- sop文件
        //       )
        //      */
        // }

        private OperationRoutingOrder CreateProductionRoutingOrder(Material material)
        {
            return new OperationRoutingOrder()
            {
                MaterialId = material.RecordId,
                OrderType = GlobalConstants.TYPE_OPERATION_ORDER_PRODUCTION
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
            foreach(OperationRouting routing in result){
                var prevOperations = result.Where(x=>x.NextOpertionNo == routing.OperationNo);
                foreach(OperationRouting prev in prevOperations){
                    routing.PrevOpreatons.Add(prev);
                    prev.NextRouting = routing;
                }
            }

            return result;
        }

        private OperationRouting ConvertOperationRouting(OperationRoutingDTO dto)
        {
            OperationRouting routing = new OperationRouting();
            Operation operation = CommonDAO.AssureExistsByFilter<Operation>(x=>x.OperationNo == dto.OperationNo);
            MachineType machineType = CommonDAO.AssureExistsByFilter<MachineType>( x=>x.CodeNo == dto.MachineType);

            routing.OperationId = operation.RecordId;
            routing.OperationNo = operation.OperationNo;
            routing.OperationName = operation.OperationName;
            routing.IsOutsource = dto.IsOutsource;
            routing.MachineTypeId = machineType.RecordId;
            routing.NextOpertionNo = dto.NextOperationNo;            
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
        public byte RequiredLevel { get; set; }
        public string[] PreOperations { get; set; }
    }
}