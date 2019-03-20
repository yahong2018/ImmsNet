
using System;
using Imms.Data;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;

namespace Imms.Logic.Exchange
{
    public class SystemDataExchangeListener : IDataChangeEventListener
    {
        public Type MonitorType { get { return typeof(SystemExchangeDataLog); } set => throw new NotImplementedException(); }

        public void ProcessEvent(DataChangedEvent e)
        {
            if (e.State != EntityState.Added)
            {
                return;
            }

            SystemExchangeDataLog log = (SystemExchangeDataLog)e.Entity;
            foreach (ISystemDataExchangeLogic logic in this.logics)
            {
                bool isMatch = (from r in logic.ExchangeRules where r == log.ExchangeRuleCode select r).Count() > 0;
                if (isMatch)
                {
                    logic.Process(log);
                }
            }
        }

        private List<ISystemDataExchangeLogic> logics = new List<ISystemDataExchangeLogic>();
    }

    public interface ISystemDataExchangeLogic
    {
        string[] ExchangeRules { get; set; }
        void Process(SystemExchangeDataLog log);
    }
}