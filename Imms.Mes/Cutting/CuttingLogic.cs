using System.Linq;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Imms.Data;
using Imms.Data.Domain;
using System.Threading;
using System;
using Imms.Mes.Production;
using Imms.Mes.MasterData;

namespace Imms.Mes.Cutting
{
    public class CuttingLogic
    {
        public void PlanCuttingOrder(CuttingOrder cuttingOrder, WorkStation cuttingWorkStation)
        {
            CommonDAO.UseDbContext((dbContext) =>
            {                
                cuttingOrder.TimetartPlanned = DateTime.Now;
                cuttingOrder.TimeEndPlanned = DateTime.Now.AddMinutes(30);   //默认30分钟内裁剪完成
                cuttingOrder.WorkStationId = cuttingWorkStation.RecordId;
                cuttingOrder.OrderStatus = GlobalConstants.STATUS_ORDER_PLANNED;

                EntityEntry<CuttingOrder> entry = dbContext.Attach<CuttingOrder>(cuttingOrder);
                entry.State = EntityState.Modified;

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
                EntityEntry<CuttingOrder> entry = dbContext.Attach<CuttingOrder>(cuttingOrder);
                entry.State = EntityState.Modified;

                ProductionOrder productionOrder = cuttingOrder.ProductionOrder;
                productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_CUTTED;                   
                int qtyActual = cuttingOrder.Sizes.Sum(x=>x.QtyActual);
                productionOrder.QtyActual = qtyActual;   //实际生产量等于实际的裁剪量
                EntityEntry<ProductionOrder> entryProductionOrder = dbContext.Attach<ProductionOrder>(productionOrder);
                entryProductionOrder.State = EntityState.Modified;

                dbContext.SaveChanges();
            });
        }
    }
}