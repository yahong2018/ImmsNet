using System;
using Imms.Data;
using Imms.Mes.Domain;
using Imms.Data.Domain;

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
                    typeof(MaterialPickingSchedule),
                    typeof(MaterialPickingOrder),
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