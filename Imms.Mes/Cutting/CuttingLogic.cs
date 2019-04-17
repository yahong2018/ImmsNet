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
        private CuttingLogic() { }
        public static readonly CuttingLogic Instance = new CuttingLogic();

        public void PlanCuttingOrders(WorkStation cuttingWorkStation, params CuttingOrder[] cuttingOrders)
        {
            if (cuttingOrders == null || cuttingOrders.Length == 0)
            {
                return;
            }

            CommonDAO.UseDbContext(dbContext =>
            {
                foreach (CuttingOrder cuttingOrder in cuttingOrders)
                {
                    this.PlanCuttingOrder(cuttingOrder, cuttingWorkStation);
                    GlobalConstants.ModifyEntityStatus<CuttingOrder>(cuttingOrder, dbContext);
                }
                dbContext.SaveChanges();
            });
        }

        internal void PlanCuttingOrder(CuttingOrder cuttingOrder, WorkStation cuttingWorkStation)
        {
            cuttingOrder.TimeStartPlanned = DateTime.Now;
            cuttingOrder.TimeEndPlanned = DateTime.Now.AddMinutes(30);   //默认30分钟内裁剪完成
            cuttingOrder.WorkStationId = cuttingWorkStation.RecordId;
            cuttingOrder.OrderStatus = GlobalConstants.STATUS_ORDER_PLANNED;
        }

        public void StartCuttingOrder(CuttingOrder cuttingOrder)
        {
            CommonDAO.UseDbContext((dbContext) =>
            {
                cuttingOrder.OrderStatus = GlobalConstants.STATUS_CUTTING_ORDER_CUTTING;
                cuttingOrder.TimeStartActual = DateTime.Now;

                ProductionOrder productionOrder = cuttingOrder.ProductionOrder;
                productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_CUTTING;
                productionOrder.TimeStartActual = DateTime.Now;   //开始裁剪表示已开始生产，此时，这个单据不可以被删除。

                GlobalConstants.ModifyEntityStatus<CuttingOrder>(cuttingOrder, dbContext);
                GlobalConstants.ModifyEntityStatus<ProductionOrder>(productionOrder, dbContext);
                dbContext.SaveChanges();
            });
        }

        public void CuttinngOrderFinished(CuttingOrder cuttingOrder)
        {
            CommonDAO.UseDbContext((dbContext) =>
            {
                cuttingOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
                cuttingOrder.TimeEndActual = DateTime.Now;
                int qtyActual = cuttingOrder.Sizes.Sum(x => x.QtyFinished);
                cuttingOrder.QtyActual = qtyActual;

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
                }

                //生成缝制作业单
                if (cuttingOrder.CuttingTableNo != GlobalConstants.TYPE_MATERIAL_KT //非捆条  
                    && cuttingOrder.QtyActual > 0
                    && cuttingOrder.FabricMaterialId != cuttingOrder.FgMaterialId  //必须是主面料所在的床次
                  )
                {
                    StitchLogic.Instance.CreateProducitonWorkOrders(cuttingOrder, dbContext);
                }

                //保存数据
                GlobalConstants.ModifyEntityStatus<CuttingOrder>(cuttingOrder, dbContext);
                GlobalConstants.ModifyEntityStatus<ProductionOrder>(productionOrder, dbContext);
                dbContext.SaveChanges();
            });
        }
    }
}