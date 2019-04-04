using System;
using System.Linq;
using System.Collections.Generic;
using Imms.Data;
using Imms.Mes.Cutting;
using Imms.Mes.Picking;
using Imms.Mes.Stitch;
using Imms.Mes.MasterData;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace Imms.Mes.WorkFlow
{
    /*
      1.向CAD、GST发送数据:ProductionOrder
      2.领料完成以后，安排裁剪单:PickingOrder
      3.裁剪完成以后，生成缝制作业单:CuttingOrder
      4.向APS汇报进度:ProductionOrder
     */
    public class MainFlow : IDataChangeNotifyEventListener
    {
        public CuttingLogic CuttingLogic { get; set; }
        public StitchLogic ProductionLogic { get; set; }

        public MainFlow()
        {
            Handlers.Add(this.PushToGstAndCad);
            Handlers.Add(this.PushToAps);
            Handlers.Add(this.PlanCuttingOrder);
            Handlers.Add(this.OnProductionWorkOrderFinished);
            Handlers.Add(this.OnWorkOrderRoutingFinished);
        }

        public Type[] ListenTypes
        {
            get => new Type[] { typeof(ProductionOrder), typeof(PickingOrder), typeof(CuttingOrder) };
            set => throw new NotImplementedException();
        }

        public void ProcessEvent(DataChangedNotifyEvent e)
        {
            //
            //ProductionOrder:
            //   1.如果是ProductionOrder新增，则向GST、CAD同步数据
            //   2.如果是ProductionOrder更新，则向APS同步数据
            //
            //PickingOrder:如果领料完成，则安排裁剪单
            //CuttingOrder:如果裁剪完成，则生成缝制作业单
            //
            //ProductionWorkOrderRouting:如果是最后一道工序，则作业单完成，否则派工到下一道工序。
            //
            //ProductionWorkOrder:如果缝制作业单已全部完成，则PO状态为已完成，否则修改PO的完成数量
            //
            foreach (ProcessHandler handler in this.Handlers)
            {
                handler(e);
            }
        }

        private void PushToGstAndCad(DataChangedNotifyEvent e)
        {
            ProductionOrder productionOrder = e.Entity as ProductionOrder;
            //初始化状态的订单，系统会自动推送给GST和CAD
            if (productionOrder == null || productionOrder.OrderStatus != GlobalConstants.STATUS_ORDER_INITIATE)
            {
                return;
            }

        }

        private void PushToAps(DataChangedNotifyEvent e)
        {
            ProductionOrder productionOrder = e.Entity as ProductionOrder;
            //只有订单状态有更改才会推送给APS
            if (productionOrder == null || e.DMLType != GlobalConstants.DML_OPERATION_UPDATE)
            {
                return;
            }
        }

        private void PlanCuttingOrder(DataChangedNotifyEvent e)
        {
            PickingOrder pickingOrder = e.Entity as PickingOrder;
            //领料完成，进行裁剪计划安排
            if (pickingOrder == null || pickingOrder.OrderStatus != GlobalConstants.STATUS_ORDER_FINISHED)
            {
                return;
            }

            WorkStation cuttingWorkStation = CommonDAO.GetOneByFilter<WorkStation>(x =>
                x.Parameters.Exists(p =>
                    p.ParameterCode == GlobalConstants.TYPE_ORG_PARAMETER_TYPE_WORK_STATION_TYPE
                 && p.ParameterValue == GlobalConstants.TYPE_WORK_STATION_CUTTING)
             );
            CuttingOrder[] cuttingOrders = CommonDAO.GetAllByFilter<CuttingOrder>(x =>
                x.PickingOrderId == pickingOrder.RecordId
                && x.OrderStatus == GlobalConstants.STATUS_ORDER_INITIATE
            );
            foreach (CuttingOrder cuttingOrder in cuttingOrders)
            {
                CuttingLogic.PlanCuttingOrder(cuttingOrder, cuttingWorkStation);
            }
        }

        public void CreateProductionWorkOrder(DataChangedNotifyEvent e)
        {
            CuttingOrder cuttingOrder = e.Entity as CuttingOrder;
            if (cuttingOrder == null)
            {
                return;
            }

            this.ProductionLogic.CreateCuttedWorkOrder(cuttingOrder);
        }

        public void OnWorkOrderRoutingFinished(DataChangedNotifyEvent e)
        {
            ProductionWorkOrderRouting workOrderRouting = e.Entity as ProductionWorkOrderRouting;
            if (workOrderRouting == null || workOrderRouting.OrderStatus != GlobalConstants.STATUS_ORDER_FINISHED)
            {
                return;
            }

            CommonDAO.UseDbContext(dbContext =>
            {
                ProductionWorkOrder workOrder = dbContext.Set<ProductionWorkOrder>()
                                    .Where(x => x.RecordId == workOrderRouting.ProductionWorkOrderId)                                      
                                    .Single();

                bool isLastRouting = dbContext.Set<OperationRouting>().Where(x =>
                     x.OperationRoutingOrderId == workOrder.OperationRoutingOrderId
                     && x.RecordId == workOrderRouting.OperationRoutingId
                     && x.NextRoutingId == null
                     ).Count() > 0;

                if (isLastRouting)
                {
                    workOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
                    workOrder.TimeActualEnd = DateTime.Now;
                    EntityEntry<ProductionWorkOrder> workOrderEntry = dbContext.Entry<ProductionWorkOrder>(workOrder);
                    workOrderEntry.State = EntityState.Modified;               
                }

                dbContext.SaveChanges();
            });
        }

        public void OnProductionWorkOrderFinished(DataChangedNotifyEvent e)
        {
            ProductionWorkOrder workOrder = e.Entity as ProductionWorkOrder;
            if(workOrder==null || workOrder.OrderStatus!=GlobalConstants.STATUS_ORDER_FINISHED)            {
                return;
            }

            ProductionOrder productionOrder = CommonDAO.GetOneByFilter<ProductionOrder>(x=>x.RecordId==workOrder.ProductionOrderId);
            productionOrder.QtyFinished +=1;           

        }

        private readonly List<ProcessHandler> Handlers = new List<ProcessHandler>();
        private delegate void ProcessHandler(DataChangedNotifyEvent e);
    }
}