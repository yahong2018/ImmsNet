using System;
using System.Collections.Generic;
using System.Text;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Domain;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace Imms.Mes.Logic
{
    public class Picking
    {
        //
        //生成领料计划
        //
        public MaterialPickingSchedule CreatePickingSchedule(ProductionOrder productionOrder, int qty)
        {
            if (productionOrder.OrderStatus < GlobalConstants.STATUS_PRODUCTION_ORDER_TECH_ALL_READY)
            {
                return null;
            }
            MaterialPickingSchedule pickingSchedule = new MaterialPickingSchedule();
            pickingSchedule.ProductionOrder = productionOrder;
            pickingSchedule.Priority = productionOrder.Priority;
            pickingSchedule.OrderStatus = GlobalConstants.STATUS_ORDER_PLANNED;

            Bom[] boms = CommonDAO.GetAllByFilter<Bom>(x => x.BomOrderId == productionOrder.BomOrderId);
            List<MaterialPickingScheduleBom> pickingBoms = new List<MaterialPickingScheduleBom>(boms.Length);
            foreach (Bom bom in boms)
            {
                MaterialPickingScheduleBom pickingBom = new MaterialPickingScheduleBom();
                pickingBom.ComponentMaterialId = bom.ComponentMaterialId;
                pickingBom.ComponentUnitId = bom.ComponentUnitId;
                pickingBom.PickedQty = 0;
                pickingBom.Qty = (bom.ComponentQty / productionOrder.PlannedQty) * qty;

                pickingSchedule.PickingBoms.Add(pickingBom);
            }

            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                dbContext.Set<MaterialPickingSchedule>().Add(pickingSchedule);
                dbContext.SaveChanges();
            }

            return pickingSchedule;
        }

        //
        //执行领料
        //
        public void ExecuteMaterialPicking(MaterialPickingOrder pickingOrder)
        {
            CommonDAO.Insert<MaterialPickingOrder>(pickingOrder, handlerBeforeInsert: (x, dmlType, dbContext) =>
            {
                //更新领料计划
                MaterialPickingSchedule schedule = pickingOrder.Schedule;
                foreach (MaterialPickingScheduleBom bom in schedule.PickingBoms)
                {
                    bom.PickedQty += pickingOrder.PickedDetails.Where(e => e.MaterialId == bom.ComponentMaterialId).Select(e => e.PickedQty).First();
                }
                schedule.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_PICKING;
                if (schedule.PickingBoms.Where(e => (e.Qty - e.PickedQty) > 0).Count() == 0) //物料已全部领完
                {
                    schedule.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
                }               

                //更新生产订单
                ProductionOrder productionOrder = (
                    from ps in dbContext.Set<MaterialPickingSchedule>()
                    join po in dbContext.Set<ProductionOrder>() on ps.ProductionOrderId equals po.RecordId
                    where ps.RecordId == x.PickingScheduleId
                    select po
                ).First();
                productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_PICKING;
                productionOrder.ActualStartDate = DateTime.Now;  //已开始生产

                EntityEntry<MaterialPickingSchedule> scheduleEntry = dbContext.Entry<MaterialPickingSchedule>(schedule);
                schedule.ProductionOrder = productionOrder;               
                scheduleEntry.State = EntityState.Modified;

                EntityEntry<ProductionOrder> productionOrderEntry = dbContext.Entry<ProductionOrder>(productionOrder);
                productionOrderEntry.State = EntityState.Modified;

            },handlerAfterInsert:(x, dmlType, dbContext)=>{

            });
        }
    }
}
