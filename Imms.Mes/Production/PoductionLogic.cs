using System;
using System.Linq;
using Imms.Data;
using Imms.Mes.Cutting;
using Imms.Mes.MasterData;
using Imms.Mes.Picking;

namespace Imms.Mes.Production
{
    public class ProductionLogic
    {
        public ProductionWorkOrder[] CreateCuttedWorkOrder(CuttingOrder cuttingOrder)
        {
            //裁剪完成，安排缝制作业单
            if (cuttingOrder == null
                || cuttingOrder.OrderStatus != GlobalConstants.STATUS_ORDER_FINISHED
                || cuttingOrder.CuttingTableNo == GlobalConstants.TYPE_MATERIAL_KT //KT床次   
                || cuttingOrder.QtyActual <= 0
            )
            {
                return null;
            }

            ProductionWorkOrder[] result = new ProductionWorkOrder[cuttingOrder.QtyActual];
            CommonDAO.UseDbContext(dbContext =>
            {
                long materialId = dbContext.Set<Bom>().Where(x =>
                    x.IsMainFabric &&
                    x.BomOrderId == (dbContext.Set<PickingOrder>()
                        .Where(p => p.RecordId == cuttingOrder.PickingOrderId)
                        .Select(p => p.PickingBomOrderId)
                        .Single()
                    )
                ).Select(b => b.ComponentMaterialId)
                .Single();

                if (cuttingOrder.FabricMaterialId != materialId)//非主面料
                {
                    return;
                }

                long bomOrderId = dbContext.Set<PickingOrder>().Where(x => x.RecordId == cuttingOrder.PickingOrderId).Select(x => x.PickingBomOrderId).Single();
                var pickingBoms = dbContext.Set<Bom>().Where(x => x.BomOrderId == bomOrderId);
                //创建缝制作业单 
                for(int i=0;i<cuttingOrder.QtyActual;i++){
                    
                }
            });


            return result;
        }
    }
}