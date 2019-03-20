using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using Microsoft.EntityFrameworkCore;

namespace Imms.Data
{
    public class DataChangeEventDispatcher
    {
        protected internal void OnDateChanged(DataChangedEvent e)
        {
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

        public void start()
        {
            if (!this.teriminated)
            {
                return;
            }
            this.teriminated = false;
            this.thread = new Thread(this.dispatch);
            this.thread.Start();
            this.waitLock.Reset();
        }

        public void stop()
        {
            this.teriminated = true;
            waitLock.WaitOne();
        }

        private void dispatch()
        {
            while (!teriminated)
            {
                Thread.Sleep(30);

                DataChangedEvent[] changedEvents;
                lock (this)
                {
                    changedEvents = this.changedEvents.ToArray();
                    this.changedEvents.Clear();
                }

                foreach (DataChangedEvent e in changedEvents)
                {                     
                    foreach (IDataChangeEventListener listener in this.listeners)
                    {
                        if (listener.MonitorType == e.Entity.GetType())
                        {
                            listener.ProcessEvent(e);
                        }
                    }
                }
            }
            waitLock.Set();
        }

        private readonly List<DataChangedEvent> changedEvents = new List<DataChangedEvent>();
        public bool teriminated { get; private set; }
        private Thread thread;
        private AutoResetEvent waitLock = new AutoResetEvent(true);
        private readonly List<IDataChangeEventListener> listeners = new List<IDataChangeEventListener>();

        public static readonly DataChangeEventDispatcher Instance = new DataChangeEventDispatcher();
        protected DataChangeEventDispatcher()
        {
            this.teriminated = false;
        }
        public void RegisterListener(IDataChangeEventListener listener)
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

    public class DataChangedEvent : IComparable
    {
        public IEntity Entity { get; set; }
        public EntityState State { get; set; }

        public int CompareTo(object obj)
        {
            if (!(obj is DataChangedEvent))
            {
                return 1;
            }

            if (this.Entity == null)
            {
                return -1;
            }

            if (((DataChangedEvent)obj).Entity == null)
            {
                return 1;
            }

            return this.Entity.CompareTo(obj);
        }
    }

    public interface IDataChangeEventListener
    {
        Type MonitorType { get; set; }
        void ProcessEvent(DataChangedEvent e);
    }
}