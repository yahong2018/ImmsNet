using System;
using System.Linq;
using System.Collections.Generic;
using Imms.Data;
using Imms.Mes.Cutting;
using Imms.Mes.Picking;
using Imms.Mes.Production;
using Imms.Mes.MasterData;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;

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

        public MainFlow()
        {
            Handlers.Add(this.PushToGstAndCad);
            Handlers.Add(this.PushToAps);
            Handlers.Add(this.PlanCuttingOrder);
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

            //裁剪完成，安排缝制作业单
            if (cuttingOrder == null || cuttingOrder.OrderStatus != GlobalConstants.STATUS_ORDER_FINISHED)
            {
                return;
            }

            
        }

        private readonly List<ProcessHandler> Handlers = new List<ProcessHandler>();
        private delegate void ProcessHandler(DataChangedNotifyEvent e);
    }
}