
using System;
using Imms.Data;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;
using System.IO;
using Newtonsoft.Json;

namespace Imms.Data
{
    public class ThridPartDataPullListener : IDataChangeNotifyEventListener
    {
        Type[] IDataChangeNotifyEventListener.ListenTypes { get { return new Type[] { typeof(DataExchangeTask) }; } set => throw new NotImplementedException(); }

        void IDataChangeNotifyEventListener.ProcessEvent(DataChangedNotifyEvent e)
        {
            if (e.DMLType != GlobalConstants.DML_OPERATION_INSERT)
            {
                return;
            }

            DataExchangeTask log = (DataExchangeTask)e.Entity;
            foreach (IThirdPartDataPullLogic logic in this.logics)
            {
                bool isMatch = (from r in logic.ExchangeRules where r == log.ExchangeRuleCode select r).Count() > 0;
                if (isMatch)
                {
                    if (!logic.DTOTypes.ContainsKey(log.ExchangeRuleCode))
                    {
                        throw new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_NOT_FOUND, $"指定的ExchangeRule:{log.ExchangeRuleCode}不被支持.");
                    }
                    if (!logic.Handlers.ContainsKey(log.ExchangeRuleCode))
                    {
                        throw new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_NOT_FOUND, $"指定的ExchangeRule:{log.ExchangeRuleCode}无处理程序.");
                    }

                    Type dtoType = logic.DTOTypes[log.ExchangeRuleCode];
                    using (StringReader strReader = new StringReader(log.RawData))
                    {
                        using (JsonTextReader reader = new JsonTextReader(strReader))
                        {
                            JsonSerializer serializer = new JsonSerializer();
                            if (log.ExchangeRuleCode == GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__APS_2_MES)
                            {
                                object dto = serializer.Deserialize(reader, dtoType);
                                ThirdPartDataPullProcessHandler handler = logic.Handlers[log.ExchangeRuleCode];
                                handler(dto);
                            }
                        }
                    }
                }
            }
        }

        public void RegisterPullLogic(IThirdPartDataPullLogic logic)
        {
            lock (this.logics)
            {
                logics.Add(logic);
            }
        }
        private List<IThirdPartDataPullLogic> logics = new List<IThirdPartDataPullLogic>();
    }

    public interface IThirdPartDataPullLogic
    {
        string[] ExchangeRules { get; set; }
        SortedDictionary<string, Type> DTOTypes { get; }
        SortedDictionary<string, ThirdPartDataPullProcessHandler> Handlers { get; }
    }

    public delegate void ThirdPartDataPullProcessHandler(object dto);

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