using System.Linq;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Imms.Data;
using Imms.Data.Domain;
using System.Threading;
using System;
using Imms.Mes.Production;

namespace Imms.Mes.Cutting
{
    public class CuttingLogic
    {
        public void PlanCuttingOrder(long cuttingOrderId,DateTime dateStartPlanned,DateTime dateEndPlanned,long cutWorkStationId)
        {
            CommonDAO.UseDbContext((dbContext) =>
            {
                CuttingOrder cuttingOrder = dbContext.Set<CuttingOrder>().Where(x=>x.RecordId==cuttingOrderId).First();
                cuttingOrder.DateStartPlanned = dateStartPlanned;
                cuttingOrder.DateEndPlanned = dateEndPlanned;
                cuttingOrder.WorkStationId = cutWorkStationId;
                cuttingOrder.OrderStatus = GlobalConstants.STATUS_ORDER_PLANNED;
                
                EntityEntry<CuttingOrder> entry = dbContext.Attach<CuttingOrder>(cuttingOrder);
                entry.State = EntityState.Modified;

                dbContext.SaveChanges();
                DataChangedNotifier.Notify(cuttingOrder, GlobalConstants.DML_OPERATION_UPDATE);
            });
        }

        public void Cutted(CuttingOrder cuttingOrder)
        {
            CommonDAO.UseDbContext((dbContext) =>
            {
                cuttingOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
                EntityEntry<CuttingOrder> entry = dbContext.Attach<CuttingOrder>(cuttingOrder);
                entry.State = EntityState.Modified;

                ProductionOrder productionOrder = cuttingOrder.ProductionOrder;
                productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_CUTTING;
                EntityEntry<ProductionOrder> entryProductionOrder = dbContext.Attach<ProductionOrder>(productionOrder);
                entryProductionOrder.State = EntityState.Modified;

                dbContext.SaveChanges();
                DataChangedNotifier.Notify(cuttingOrder, GlobalConstants.DML_OPERATION_UPDATE);
                DataChangedNotifier.Notify(productionOrder, GlobalConstants.DML_OPERATION_UPDATE);
            });
        }
    }
}