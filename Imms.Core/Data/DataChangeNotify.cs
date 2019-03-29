using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace Imms.Data
{
    public class DataChangedNotifier
    {
        public DataChangeNotifyEventDispatcher Dispatcher { get; set; }

        public void Notify(DataChangedNotifyEvent e)
        {
            ThreadPool.QueueUserWorkItem(Dispatcher.OnDateChanged, e);
        }

        public void Notify(IEntity item, int dmlType)
        {
            DataChangedNotifyEvent e = new DataChangedNotifyEvent()
            {
                Entity = item,
                DMLType = dmlType
            };

            ThreadPool.QueueUserWorkItem(Dispatcher.OnDateChanged, e);
        }

        protected DataChangedNotifier()
        {
        }

        public static readonly DataChangedNotifier Instance = new DataChangedNotifier();
    }

    public class DataChangeNotifyEventDispatcher : BaseService
    {
        protected virtual internal void OnDateChanged(object objE)
        {
            DataChangedNotifyEvent e = (DataChangedNotifyEvent)objE;

            if (e.Entity != null || e.Entity.RecordId == null)
            {
                return;
            }

            lock (this)
            {
                int index = changedEvents.FindIndex(x => x.CompareTo(e) == 0);
                if (index >= 0)
                {
                    changedEvents[index] = e;
                }
                else
                {
                    changedEvents.Add(e);
                }
            }
        }

        protected override void DoInternalThreadProc()
        {
            DataChangedNotifyEvent[] changedEvents;
            lock (this)
            {
                changedEvents = this.changedEvents.ToArray();
                this.changedEvents.Clear();
            }

            foreach (DataChangedNotifyEvent e in changedEvents)
            {
                foreach (IDataChangeNotifyEventListener listener in this.listeners)
                {
                    if (listener.ListenTypes.Contains(e.Entity.GetType()))
                    {
                        listener.ProcessEvent(e);
                    }
                }
            }
        }

        private readonly List<DataChangedNotifyEvent> changedEvents = new List<DataChangedNotifyEvent>();
        internal readonly List<IDataChangeNotifyEventListener> listeners = new List<IDataChangeNotifyEventListener>();

        public void RegisterListener(IDataChangeNotifyEventListener listener)
        {
            lock (this)
            {
                if (listeners.Contains(listener))
                {
                    return;
                }

                listeners.Add(listener);
            }
        }
    }

    public class DataChangedNotifyEvent : IComparable
    {
        public IEntity Entity { get; set; }
        public int DMLType { get; set; }

        public int CompareTo(object obj)
        {
            if (!(obj is DataChangedNotifyEvent))
            {
                return 1;
            }

            if (this.Entity == null)
            {
                return -1;
            }

            if (((DataChangedNotifyEvent)obj).Entity == null)
            {
                return 1;
            }

            return this.Entity.CompareTo(obj);
        }
    }

    public interface IDataChangeNotifyEventListener
    {
        Type[] ListenTypes { get; set; }
        void ProcessEvent(DataChangedNotifyEvent e);
    }
}