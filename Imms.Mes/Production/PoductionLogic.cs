using System;
using System.Collections.Generic;
using System.Linq;
using Imms.Data;
using Imms.Mes.Cutting;
using Imms.Mes.MasterData;
using Imms.Mes.Picking;
using Microsoft.EntityFrameworkCore;

namespace Imms.Mes.Production
{
    //
    //功能：
    //   生成缝制作业单(作业单、作业单BOM、缝制报工单）
    //   获取某个工位所需要的作业单及其当前工序（工艺）  
    //   作业单工艺报工   
    //   派工
    //    
    public class ProductionLogic
    {
        
        public ProductionWorkOrder[] GetProductionWorkOrdersByWorkStation(WorkStation WorkStation)
        {
            return null;
        }

        //
        //生成缝制作业单
        //
        public ProductionWorkOrder[] CreateCuttedWorkOrder(CuttingOrder cuttingOrder)
        {
            //裁剪完成，安排缝制作业单
            if (cuttingOrder == null
                || cuttingOrder.OrderStatus != GlobalConstants.STATUS_ORDER_FINISHED
                || cuttingOrder.CuttingTableNo == GlobalConstants.TYPE_MATERIAL_KT //KT床次   
                || cuttingOrder.QtyActual <= 0
                || cuttingOrder.FabricMaterialId != cuttingOrder.FgMaterialId  //非主面料
            )
            {
                return null;
            }

            ProductionWorkOrder[] result = null;
            CommonDAO.UseDbContext(dbContext =>
            {
                bool alReadyCreated = dbContext.Set<ProductionWorkOrder>().Where(x => x.CuttingOrderId == cuttingOrder.RecordId).Count() > 0;
                if (alReadyCreated)
                {
                    return;
                }

                ProductionOrder productionOrder = dbContext.Set<ProductionOrder>()
                   .Where(x => x.RecordId == cuttingOrder.ProductionOrderId)
                   .Include(x => x.RoutingOrder).ThenInclude(x => x.Routings)
                   .Single();

                long bomOrderId = dbContext.Set<PickingOrder>()
                  .Where(x => x.RecordId == cuttingOrder.PickingOrderId)
                  .Select(x => x.PickingBomOrderId)
                  .Single();
                var pickingBoms = dbContext.Set<Bom>().Where(x => x.BomOrderId == bomOrderId);

                result = new ProductionWorkOrder[cuttingOrder.QtyActual];
                for (int i = 0; i < cuttingOrder.Sizes.Count; i++)
                {
                    CuttingOrderSize orderSize = cuttingOrder.Sizes[i];
                    //创建作业单
                    ProductionWorkOrder productionWorkOrder = this.CreateProductionWorkOrder(cuttingOrder, productionOrder, orderSize);
                    result[i] = productionWorkOrder;

                    //创建缝制BOM
                    BomOrder bomOrder = this.CreateWorkOrderBom(productionOrder, cuttingOrder, pickingBoms);  //生成BOM
                    dbContext.Set<BomOrder>().Add(bomOrder);

                    //创建缝制工艺报工单
                    ProductionWorkOrderRouting[] workOrderRoutings = this.CreateWorkOrderRoutings(productionOrder.RoutingOrder.Routings);
                    foreach (ProductionWorkOrderRouting routing in workOrderRoutings)
                    {
                        routing.ProductionWorkOrder = productionWorkOrder;
                        dbContext.Set<ProductionWorkOrderRouting>().Add(routing);
                    }
                    dbContext.Set<ProductionWorkOrder>().Add(productionWorkOrder);

                    dbContext.SaveChanges();
                }
            });

            return result;
        }

        private ProductionWorkOrder CreateProductionWorkOrder(CuttingOrder cuttingOrder, ProductionOrder productionOrder, CuttingOrderSize orderSize)
        {
            ProductionWorkOrder productionWorkOrder = new ProductionWorkOrder();
            productionWorkOrder.CuttingOrderId = cuttingOrder.RecordId;
            productionWorkOrder.Size = orderSize.Size;
            productionWorkOrder.OrderStatus = GlobalConstants.STATUS_ORDER_INITIATE;
            productionWorkOrder.ProductionOrderId = productionOrder.RecordId;
            return productionWorkOrder;
        }

        private BomOrder CreateWorkOrderBom(ProductionOrder productionOrder, CuttingOrder cuttingOrder, IQueryable<Bom> boms)
        {
            BomOrder bomOrder = new BomOrder();
            bomOrder.BomOrderType = GlobalConstants.TYPE_BOM_ORDER_PRODUCTION_ORDER;
            bomOrder.MaterialId = cuttingOrder.FgMaterialId;
            bomOrder.OrderStatus = GlobalConstants.STATUS_BOM_ORDER_NORMAL;

            foreach (Bom bom in boms)
            {
                bom.BomOrderId = 0;
                bom.BomOrder = bomOrder;
                bom.ComponentQty = (productionOrder.QtyPlanned / bom.ComponentQty) * cuttingOrder.QtyActual;

                bomOrder.Boms.Add(bom);
            }

            return bomOrder;
        }

        private ProductionWorkOrderRouting[] CreateWorkOrderRoutings(List<OperationRouting> routings)
        {
            ProductionWorkOrderRouting[] workOrderRoutings = new ProductionWorkOrderRouting[routings.Count];
            for (int i = 0; i < routings.Count; i++)
            {
                OperationRouting operationRouting = routings[i];
                ProductionWorkOrderRouting workOrderRouting = new ProductionWorkOrderRouting();
                workOrderRoutings[i] = workOrderRouting;
                workOrderRouting.OperationRoutingId = operationRouting.RecordId;
                workOrderRouting.OrderStatus = GlobalConstants.STATUS_ORDER_INITIATE;
            }

            return workOrderRoutings;
        }
    }
}