using System;
using System.Collections.Generic;
using Imms.Data;
using Imms.Data.Domain;

namespace Imms.Mes.Exchange
{
    public class FromCad : IThirdPartDataPullLogic
    {
        public string[] ExchangeRules
        {
            get { return new string[] { GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__CAD_2_MES }; }
            set => throw new System.NotImplementedException();
        }

        public SortedDictionary<string, Type> DTOTypes => throw new NotImplementedException();

        public SortedDictionary<string, ThirdPartDataPullProcessHandler> Handlers => throw new NotImplementedException();
    }
}