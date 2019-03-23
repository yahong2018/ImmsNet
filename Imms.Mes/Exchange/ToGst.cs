using System;
using Imms.Data;
using Imms.Mes.Domain;
using Imms.Data.Domain;

namespace Imms.Mes.Exchange{
    public class ToGst : IDataChangeNotifyEventListener
    {
        public Type[] ListenTypes { get { return new Type[] { typeof(ProductionOrder) }; } set => throw new NotImplementedException(); }

        public void ProcessEvent(DataChangedNotifyEvent e)
        {
            throw new NotImplementedException();
        }
    }
}
