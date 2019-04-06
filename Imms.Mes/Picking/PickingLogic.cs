using System;
using System.Collections.Generic;
using System.Text;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Domain;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using System.Threading;
using Imms.Mes.MasterData;
using Imms.Mes.Stitch;
using Imms.Mes.Picking;
using Imms.Mes.Cutting;

namespace Imms.Mes.Picking
{
    public class PickingLogic
    {
        private PickingLogic() { }
        public static readonly PickingLogic Instance = new PickingLogic();

        //
        //生成领料BOM
        //
        public BomOrder CreatePickingBomOrder(ProductionOrder productionOrder, ICollection<Bom> pickingBoms)
        {
            BomOrder pickingBomOrder = new BomOrder()
            {
                BomOrderType = GlobalConstants.TYPE_BOM_ORDER_PICKING_ORDER,
                MaterialId = productionOrder.FgMaterialId,
            };

            pickingBomOrder.Boms.AddRange(pickingBoms);
            foreach (Bom bom in pickingBomOrder.Boms)
            {
                bom.RecordId = 0;
                bom.BomOrder = pickingBomOrder;
            }

            return pickingBomOrder;
        }

        //
        //生成领料单
        //
        public PickingOrder CreatePickingOrder(ProductionOrder productionOrder, BomOrder pickingBomOrder, int bomOrderType)
        {
            PickingOrder pickingOrder = new PickingOrder();
            pickingOrder.ProductionOrder = productionOrder;
            pickingOrder.Priority = productionOrder.Priority;
            pickingOrder.PickingBomOrder = pickingBomOrder;
            pickingOrder.OrderType = bomOrderType;

            pickingOrder.TimeStartPlanned = DateTime.Now;
            pickingOrder.TimeEndPlanned = DateTime.Now.AddMinutes(30);   //默认为30分钟内领料完成，以后要根据工序来配置
            pickingOrder.OrderStatus = GlobalConstants.STATUS_ORDER_PLANNED;

            return pickingOrder;
        }

        //
        //物料已准备，通知领料人去领料
        //
        public void PrepareMaterial(PickingOrder pickingOrder)
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                //状态更改
                pickingOrder.OrderStatus = GlobalConstants.STATUS_PICKING_ORDER_PREPARED;
                pickingOrder.TimeStartActual = DateTime.Now;
                ProductionOrder productionOrder = dbContext.Set<ProductionOrder>().Where(x => x.RecordId == pickingOrder.ProductionOrderId).Single();
                productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_PICKING;

                //数据保存              
                GlobalConstants.ModifyEntityStatus<PickingOrder>(pickingOrder, dbContext);
                GlobalConstants.ModifyEntityStatus<ProductionOrder>(productionOrder, dbContext);
                dbContext.SaveChanges();
            });
        }

        //
        //执行领料:注意，每张领料单只能领一次物料，如果需要领多次，则需要建立多个领料单。
        //
        public void MaterialPicked(PickingOrder pickingOrder)
        {
            CommonDAO.UseDbContext((dbContext) =>
            {
                pickingOrder.TimeEndActual = DateTime.Now;
                pickingOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;  //领料已完成,但这个时候并不等于开始生产

                //更新生产订单
                ProductionOrder productionOrder = (
                    from po in dbContext.Set<ProductionOrder>()
                    where po.RecordId == pickingOrder.ProductionOrderId
                    select po
                ).First();
                productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_PICKED;

                //计划裁剪订单
                IQueryable<CuttingOrder> cuttingOrders = this.PlanCuttingOrder(pickingOrder, productionOrder.WorkCenterId, dbContext);

                //数据保存                
                GlobalConstants.ModifyEntityStatus<PickingOrder>(pickingOrder, dbContext);
                GlobalConstants.ModifyEntityStatus<ProductionOrder>(productionOrder, dbContext);
                foreach (CuttingOrder cuttingOrder in cuttingOrders)
                {
                    GlobalConstants.ModifyEntityStatus<CuttingOrder>(cuttingOrder, dbContext);
                }
                dbContext.SaveChanges();
            });
        }

        private IQueryable<CuttingOrder> PlanCuttingOrder(PickingOrder pickingOrder, long workCenterId, DbContext dbContext)
        {
            if (pickingOrder.OrderType == GlobalConstants.TYPE_PICKING_ORDER_CUTTING)
            {
                return null;
            }

            WorkStation cuttingWorkStation =  //1个车间只有1个裁剪工位
                    (from w in dbContext.Set<WorkStation>()
                     join c in dbContext.Set<WorkCenter>() on w.ParentOrganizationId equals c.RecordId  //裁剪工位直属车间，不设裁剪线
                     where c.RecordId == workCenterId
                         && w.WorkStationType == GlobalConstants.TYPE_WORK_STATION_CUTTING
                     select w
                    ).Single();

            var cuttingOrders = dbContext.Set<CuttingOrder>().Where(x =>
                x.PickingOrderId == pickingOrder.RecordId
                && x.OrderStatus == GlobalConstants.STATUS_ORDER_INITIATE
            );

            foreach (CuttingOrder cuttingOrder in cuttingOrders)
            {
                CuttingLogic.Instance.PlanCuttingOrder(cuttingOrder, cuttingWorkStation);
            }

            return cuttingOrders;
        }
    }
}
