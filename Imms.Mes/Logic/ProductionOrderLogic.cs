
using System.Transactions;
using Imms.Data;
using System.Linq;
using Imms.Mes.Domain;
using Microsoft.EntityFrameworkCore;

namespace Imms.Mes.Logic
{
    public class ProductionOrderLogic
    {
        public void SetProductionOrderRouting(ProductionOrder productionOrder, OperationRoutingOrder routingOrder, OperationRouting[] operationRoutings)
        {
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required))
            {
                CommonDAO.Insert<OperationRoutingOrder>(routingOrder);

                productionOrder.RoutingOrderId = routingOrder.RecordId;
                CommonDAO.Update<ProductionOrder>(productionOrder, notifyDataChanged: true);

                foreach (OperationRouting routing in operationRoutings)
                {
                    routing.OperationRoutingOrderId = routingOrder.RecordId;
                    CommonDAO.Insert<OperationRouting>(routing);
                }
                this.SetNextAndPrevRoutingId(routingOrder.RecordId);

                scope.Complete();
            }
        }

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

        private void SetNextAndPrevRoutingId(long routingOrderId)
        {
            string sql = $@"update operation_routing
                   set o.next_operation_routing_id = n.record_id,
                       o.prev_operation_routing_id = p.record_id
                from operation_routing o 
                           left join operation_routing n on o.next_operation_no = n.operation_no
                           left join operation_routing p on o.prev_opreation_no = p.operation_no
                where o.operation_routing_order_id = {routingOrderId}";

            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                dbContext.Database.ExecuteSqlCommand(sql);
            }
        }

        private bool CheckCuttingMarkerExists(long producitonOrderId)
        {
            // string sql =
            //  $@"select 1 from cutting_marker 
            //      where cutting_order_id in(
            //          select record_id from cutting_order
            //             where production_order_id = {producitonOrderId}
            //      )";
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                bool exists = (from m in dbContext.Set<CuttingMarker>()
                               join o in dbContext.Set<CuttingOrder>() on m.CuttingOrderId equals o.RecordId
                               where o.ProductionOrderId == producitonOrderId
                               select m
                        ).Count() > 0;

                return exists;
            }
        }
    }
}