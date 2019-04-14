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

        public MainFlow()
        {
            Handlers.Add(this.SynchronizeProductionOrderToGstAndCad);
            Handlers.Add(this.ReporOrderStatusToAps);
            Handlers.Add(this.DispatchWorkOrderRouting);
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



        private readonly List<ProcessHandler> Handlers = new List<ProcessHandler>();
        private delegate void ProcessHandler(DataChangedNotifyEvent e);
    }
}