using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Imms.Data;
using System;
using Imms.Mes.Stitch;
using Imms.Mes.Organization;
using Imms.Mes.Picking;
using Imms.Mes.Material;

namespace Imms.Mes.Cutting
{
    public class CuttingLogic
    {
        private CuttingLogic() { }
        public static readonly CuttingLogic Instance = new CuttingLogic();

        public void StartCuttingOrder(CuttingOrder cuttingOrder, WorkStation cuttingStation)
        {
            CommonDAO.UseDbContext((dbContext) =>
            {
                cuttingOrder.WorkStationId = cuttingStation.RecordId;
                cuttingOrder.OrderStatus = GlobalConstants.STATUS_CUTTING_ORDER_CUTTING;
                cuttingOrder.TimeStartActual = DateTime.Now;

                ProductionOrder productionOrder = cuttingOrder.ProductionOrder;
                if (productionOrder == null)
                {
                    productionOrder = dbContext.Set<ProductionOrder>().Single(x => x.RecordId == cuttingOrder.ProductionOrderId);
                }
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
                cuttingOrder.QtyFinished = cuttingOrder.QtyActual = qtyActual;

                ProductionOrder productionOrder = cuttingOrder.ProductionOrder;
                if (productionOrder == null)
                {
                    productionOrder = dbContext.Set<ProductionOrder>().Single(x => x.RecordId == cuttingOrder.ProductionOrderId);
                }
                productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_CUTTED;
                long materialId = dbContext.Set<Bom>().Where(x =>
                   x.IsMainFabric &&
                   (dbContext.Set<PickingOrder>()
                       .Where(p => p.RecordId == cuttingOrder.PickingOrderId)
                       .Select(p => p.PickingBomOrderId)
                       .Contains(x.BomOrderId)
                   )
               ).Select(b => b.ComponentMaterialId)
               .Single();

                if (cuttingOrder.FabricMaterialId == materialId)//只有主面料的床次报工，才计算生产订单的实际生产量
                {
                    productionOrder.QtyActual += cuttingOrder.QtyActual;   //实际生产量为实际的裁剪量      

                    //生成缝制作业单
                    if (cuttingOrder.CuttingTableNo != GlobalConstants.TYPE_MATERIAL_KT //非捆条  
                        && cuttingOrder.QtyActual > 0)
                    {
                        StitchLogic.Instance.CreateProducitonWorkOrders(cuttingOrder, dbContext);
                    }
                }

                //保存数据
                GlobalConstants.ModifyEntityStatus(cuttingOrder, dbContext);
                foreach (CuttingOrderSize size in cuttingOrder.Sizes)
                {
                    GlobalConstants.ModifyEntityStatus(size, dbContext);
                }
                GlobalConstants.ModifyEntityStatus(productionOrder, dbContext);
                dbContext.SaveChanges();
            });
        }
    }
}