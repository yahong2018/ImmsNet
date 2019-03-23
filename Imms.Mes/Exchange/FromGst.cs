using Imms.Data;
using Imms.Mes.Domain;
using Imms.Data.Domain;
using System;
using System.Collections.Generic;

namespace Imms.Mes.Exchange{
    public class FromGst : IThirdPartDataPullLogic
    {
        public string[] ExchangeRules { get => throw new System.NotImplementedException(); set => throw new System.NotImplementedException(); }

        public SortedDictionary<string, Type> DTOTypes => throw new NotImplementedException();

        public SortedDictionary<string, ThirdPartDataPullProcessHandler> Handlers => throw new NotImplementedException();
    }
}