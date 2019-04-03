using System;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Stitch;

namespace Imms.Mes.Exchange
{
    /*
       针对目前必须全部裁剪完才可以生产的问题，解决如下：
       对某个生产订单进行分批生产：在生产计划那里增加“再生产”功能。
       
       数据结构变化：
       1.一个生产订单可以有多个裁剪单
       2.一个生产订单可以有多个领料单       
       3.辅料的投递：新建辅料投递作业单
     */
    public class ToCad : IDataChangeNotifyEventListener
    {
        Type[] IDataChangeNotifyEventListener.ListenTypes { get { return new Type[] { typeof(ProductionOrder) }; } set => throw new NotImplementedException(); }        

        void IDataChangeNotifyEventListener.ProcessEvent(DataChangedNotifyEvent e)
        {
            throw new NotImplementedException();
        }
    }
}