using System;
using Imms.Data;
using Imms.Data.Domain;

namespace Imms.Logic.Exchange{
    public class Aps2Mes : ISystemDataExchangeLogic
    {
        public void Process(SystemExchangeDataLog log)
        {
            throw new NotImplementedException();
        }

        public Aps2Mes(){
            this._ExchangeRules = new string[]{
                GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__APS_2_MES
            };
        }

        private string[] _ExchangeRules;
        public string[] ExchangeRules { get {return this._ExchangeRules;} set => throw new NotImplementedException(); }
    }
}