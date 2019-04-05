using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Imms.Data;
using System;
using Imms.Mes.Stitch;
using Imms.Mes.MasterData;
using Imms.Mes.Picking;

namespace Imms.Mes.Cutting
{
    public class CuttingLogic
    {
        public void PlanCuttingOrder(CuttingOrder cuttingOrder, WorkStation cuttingWorkStation, DbContext dbContext)
        {
            cuttingOrder.TimetartPlanned = DateTime.Now;
            cuttingOrder.TimeEndPlanned = DateTime.Now.AddMinutes(30);   //默认30分钟内裁剪完成
            cuttingOrder.WorkStationId = cuttingWorkStation.RecordId;
            cuttingOrder.OrderStatus = GlobalConstants.STATUS_ORDER_PLANNED;

            EntityEntry<CuttingOrder> entry = dbContext.Attach<CuttingOrder>(cuttingOrder);
            entry.State = EntityState.Modified;
        }

        public void PlanCuttingOrders(CuttingOrder[] cuttingOrders, WorkStation cuttingWorkStation)
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                foreach (CuttingOrder cuttingOrder in cuttingOrders)
                {
                    this.PlanCuttingOrder(cuttingOrder, cuttingWorkStation,dbContext);
                }

                dbContext.SaveChanges();
            });
        }

        public void CuttingOrderStarted(CuttingOrder cuttingOrder)
        {
            CommonDAO.UseDbContext((dbContext) =>
            {
                cuttingOrder.OrderStatus = GlobalConstants.STATUS_CUTTING_ORDER_CUTTING;
                cuttingOrder.TimeStartActual = DateTime.Now;
                EntityEntry<CuttingOrder> entry = dbContext.Attach<CuttingOrder>(cuttingOrder);
                entry.State = EntityState.Modified;

                ProductionOrder productionOrder = cuttingOrder.ProductionOrder;
                productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_CUTTING;
                productionOrder.DateStartActual = DateTime.Now;   //开始裁剪表示已开始生产，此时，这个单据不可以被删除。
                
                EntityEntry<ProductionOrder> entryProductionOrder = dbContext.Attach<ProductionOrder>(productionOrder);
                entryProductionOrder.State = EntityState.Modified;

                dbContext.SaveChanges();
            });
        }

        public void CuttinngOrderFinished(CuttingOrder cuttingOrder)
        {
            CommonDAO.UseDbContext((dbContext) =>
            {
                cuttingOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
                cuttingOrder.TimeEndActual = DateTime.Now;
                int qtyActual = cuttingOrder.Sizes.Sum(x => x.QtyActual);
                cuttingOrder.QtyActual = qtyActual;
                EntityEntry<CuttingOrder> entry = dbContext.Attach<CuttingOrder>(cuttingOrder);
                entry.State = EntityState.Modified;

                ProductionOrder productionOrder = cuttingOrder.ProductionOrder;
                productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_CUTTED;

                long materialId = dbContext.Set<Bom>().Where(x =>
                   x.IsMainFabric &&
                   x.BomOrderId == (dbContext.Set<PickingOrder>()
                       .Where(p => p.RecordId == cuttingOrder.PickingOrderId)
                       .Select(p => p.PickingBomOrderId)
                       .Single()
                   )
               ).Select(b => b.ComponentMaterialId)
               .Single();
                if (cuttingOrder.FabricMaterialId == materialId)//只有主面料的床次报工，才计算生产订单的实际生产量
                {
                    productionOrder.QtyActual += cuttingOrder.QtyActual;   //实际生产量为实际的裁剪量
                    EntityEntry<ProductionOrder> entryProductionOrder = dbContext.Attach<ProductionOrder>(productionOrder);
                    entryProductionOrder.State = EntityState.Modified;
                }

                dbContext.SaveChanges();
            });
        }
    }
}