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
        internal static void Notify(DataChangedNotifyEvent e)
        {
            ThreadPool.QueueUserWorkItem(DataChangeNotifyEventDispatcher.Instance.OnDateChanged, e);
        }

        internal static void Notify(IEntity item, int dmlType)
        {
            //
            //TODO:在这里实现一次过滤，不需要的进行监控的数据，直接丢弃。
            //
            
            DataChangedNotifyEvent e = new DataChangedNotifyEvent()
            {
                Entity = item,
                DMLType = dmlType
            };

            ThreadPool.QueueUserWorkItem(DataChangeNotifyEventDispatcher.Instance.OnDateChanged, e);
        }

        private static readonly SortedDictionary<Guid, DateTime> DataChangedLastTime = new SortedDictionary<Guid, DateTime>();
    }

    public class DataChangeNotifyEventDispatcher
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

        public void Start()
        {
            if (!this.teriminated)
            {
                return;
            }
            this.teriminated = false;
            this.dispatcherThread = new Thread(this.Dispatch);
            this.dispatcherThread.Start();
            this.waitLock.Reset();
        }

        public void Stop()
        {
            this.teriminated = true;
            waitLock.WaitOne();
        }

        private void Dispatch()
        {
            while (!teriminated)
            {
                Thread.Sleep(30);

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
            waitLock.Set();
        }

        private readonly List<DataChangedNotifyEvent> changedEvents = new List<DataChangedNotifyEvent>();
        public bool teriminated { get; private set; }
        private Thread dispatcherThread;
        private AutoResetEvent waitLock = new AutoResetEvent(true);
        private readonly List<IDataChangeNotifyEventListener> listeners = new List<IDataChangeNotifyEventListener>();

        public static readonly DataChangeNotifyEventDispatcher Instance = new DataChangeNotifyEventDispatcher();
        protected DataChangeNotifyEventDispatcher()
        {
            this.teriminated = false;
        }
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
        IEntity[] LoadUnProcessedItemFromDb();
    }
}