using System;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Production;

namespace Imms.Mes.Exchange{
    public class ToGst : IDataChangeNotifyEventListener
    {
        public Type[] ListenTypes { get { return new Type[] { typeof(ProductionOrder) }; } set => throw new NotImplementedException(); }

        public IEntity[] LoadUnProcessedItemFromDb()
        {
            throw new NotImplementedException();
        }

        public void ProcessEvent(DataChangedNotifyEvent e)
        {
            throw new NotImplementedException();
        }
    }
}
