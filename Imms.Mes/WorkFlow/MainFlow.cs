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
      4.向APS汇报进度:ProductionOrder
      5.向MCS派工：ProductionWorkOrderRouting
      6.缝制作业单完成以后，更新ProductoinOrder的进度，同时会触发第4条
     */
    public class MainFlow : IDataChangeNotifyEventListener
    {
        public CuttingLogic CuttingLogic { get; set; }
        public StitchLogic ProductionLogic { get; set; }

        public MainFlow()
        {
            Handlers.Add(this.SynchronizeProductionOrderToGstAndCad);
            Handlers.Add(this.ReporOrderStatusToAps);            
            Handlers.Add(this.CreateProductionWorkOrder);
            Handlers.Add(this.DispatchWorkOrderRouting);
            Handlers.Add(this.OnProductionWorkOrderFinished);            
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
            //ProductionWorkOrder:如果缝制作业单已全部完成，则PO状态为已完成，否则修改PO的完成数量
            //
            foreach (ProcessHandler handler in this.Handlers)
            {
                handler(e);
            }
        }

        private void SynchronizeProductionOrderToGstAndCad(DataChangedNotifyEvent e)
        {
            //初始化状态的订单，系统会自动推送给GST和CAD
            if (!(e.Entity is ProductionOrder productionOrder) || productionOrder.OrderStatus != GlobalConstants.STATUS_ORDER_INITIATE)
            {
                return;
            }

        }

        private void ReporOrderStatusToAps(DataChangedNotifyEvent e)
        {
            //只有订单状态有更改才会推送给APS
            if (!(e.Entity is ProductionOrder productionOrder) || e.DMLType != GlobalConstants.DML_OPERATION_UPDATE)
            {
                return;
            }
        }       

        private void CreateProductionWorkOrder(DataChangedNotifyEvent e)
        {
            //裁剪完成以后，生成缝制作业单
            if (!(e.Entity is CuttingOrder cuttingOrder) || cuttingOrder.OrderStatus != GlobalConstants.STATUS_ORDER_FINISHED)
            {
                return;
            }

            this.ProductionLogic.CreateStitchWorkOrder(cuttingOrder);
        }

        private void DispatchWorkOrderRouting(DataChangedNotifyEvent e)
        {
            //派工:向MCS发送派工信息
            if (!(e.Entity is ProductionWorkOrderRouting workOrderRouting) || workOrderRouting.OrderStatus != GlobalConstants.STATUS_ORDER_PLANNED)
            {
                return;
            }
            //
            //向MCS发送派工信息
            //
        }

        private void OnProductionWorkOrderFinished(DataChangedNotifyEvent e)
        {
            //缝制作业单完成以后，更新生产订单的状态
            if (!(e.Entity is ProductionWorkOrder workOrder)
                || workOrder.OrderStatus != GlobalConstants.STATUS_ORDER_FINISHED)
            {
                return;
            }

            ProductionOrder productionOrder = CommonDAO.GetOneByFilter<ProductionOrder>(x => x.RecordId == workOrder.ProductionOrderId);
            productionOrder.QtyFinished += 1;
            if (productionOrder.QtyFinished == productionOrder.QtyActual)
            {
                productionOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
            }
            CommonDAO.Update(productionOrder);
        }

        private readonly List<ProcessHandler> Handlers = new List<ProcessHandler>();
        private delegate void ProcessHandler(DataChangedNotifyEvent e);
    }
}