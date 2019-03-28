using System;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Cutting;
using Imms.Mes.Picking;
using Imms.Mes.Production;

namespace Imms.Mes.Exchange
{
    public class ToKanban : IDataChangeNotifyEventListener
    {
        public Type[] ListenTypes
        {
            get
            {
                return new Type[] {
                    typeof(ProductionOrder),
                    typeof(PickingOrder),                    
                    typeof(CuttingOrder),
                    typeof(ProductionWorkOrder)
                };
            }
            set => throw new NotImplementedException();
        }

        public void ProcessEvent(DataChangedNotifyEvent e)
        {
            throw new NotImplementedException();
        }
    }
}