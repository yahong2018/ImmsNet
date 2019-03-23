
using System;
using Imms.Data;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;

namespace Imms.Data
{
    public class ThridPartDataPullListener : IDataChangeNotifyEventListener
    {
        public Type[] ListenTypes { get { return new Type[]{typeof(ThirdPartDataExchange)}; } set => throw new NotImplementedException(); }

        public void ProcessEvent(DataChangedNotifyEvent e)
        {
            if (e.DMLType != DMLType.Insert)
            {
                return;
            }

            ThirdPartDataExchange log = (ThirdPartDataExchange)e.Entity;
            foreach (IThirdPartDataPullLogic logic in this.logics)
            {
                bool isMatch = (from r in logic.ExchangeRules where r == log.ExchangeRuleCode select r).Count() > 0;
                if (isMatch)
                {
                    logic.Process(log);
                }
            }
        }

        private List<IThirdPartDataPullLogic> logics = new List<IThirdPartDataPullLogic>();
    }

    public interface IThirdPartDataPullLogic
    {
        string[] ExchangeRules { get; set; }
        void Process(ThirdPartDataExchange log);
    }

    /*
    数据交换采用json，格式如下：
    {
        "MessageId":"xxxx-xxxx-xxxxx-xxxx-xxxx",
        "ExchangeRuleCode":"DATA_EXCHANGE_RULE__PRODUCITON_ORDER__APS_2_MES",
        "CreateTime":"2019-03-21 14:40:36 339",   // 发送方填写
        "ReceiveTime":"0000-00-00 00:00:00 000",  // 接收方填写
        "SendTime":"2019-03-21 14:40:36 341",     // 发送方填写
        "RawData":"{
            具体的数据
        }"
    }    
     */
}