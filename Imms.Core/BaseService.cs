using System;
using System.Threading;

namespace Imms
{
    public abstract class BaseService
    {
        public ServiceStatus Status { get; private set; }
        public int ThreadIntervals { get; set; }
        public bool Terminated { get; protected set; }
        public string ServiceId { get; set; }

        protected BaseService()
        {
            this.Status = ServiceStatus.Stopped;
        }

        AutoResetEvent _TerminatedEvent = new AutoResetEvent(false);
        protected virtual bool DoInternalStartup() { return true; }

        public virtual bool Startup()
        {
            if (Status == ServiceStatus.Running)
                return true;

            GlobalConstants.DefaultLogger.Debug("正在启动BaseService:({0})...", this.ServiceId);

            try
            {
                Terminated = false;
                if (DoInternalStartup())
                {
                    Status = ServiceStatus.Running;
                    Thread thread = new Thread(ThreadProc);
                    thread.Priority = ThreadPriority.Highest;

                    thread.Start();
                    GlobalConstants.DefaultLogger.Debug("启动BaseService:({0})成功.", this.ServiceId);
                    return true;
                }
            }
            catch (Exception ex)
            {
                GlobalConstants.DefaultLogger.Error("启动BaseService:({0})失败:{1}", this.ServiceId, ex.Message);
            }

            GlobalConstants.DefaultLogger.Error("启动BaseService:({0})失败.", this.ServiceId);
            return false;
        }

        protected virtual void DoInternalThreadProc() { }

        private void ThreadProc()
        {
            while (!Terminated)
            {
                try
                {
                    DoInternalThreadProc();
                }
                catch (Exception ex)
                {
                    GlobalConstants.DefaultLogger.Error("({0})BaseService.ThreadProc出现异常:{1}", this.ServiceId, ex.Message);
                    break;
                }

                Thread.Sleep(this.ThreadIntervals);
            }
            _TerminatedEvent.Set();
            Status = ServiceStatus.Stopped;

            GlobalConstants.DefaultLogger.Debug("BaseService.ThreadProc已停止:({0}).", this.ServiceId);
        }

        protected virtual bool DoInternalShutdown() { return true; }

        public virtual bool Shutdown()
        {
            if (Status == ServiceStatus.Stopped)
                return true;

            GlobalConstants.DefaultLogger.Debug("正在关闭BaseService:({0})...", this.ServiceId);
            Terminated = true;
            try
            {
                _TerminatedEvent.WaitOne();
                if (DoInternalShutdown())
                {
                    Status = ServiceStatus.Stopped;
                    GlobalConstants.DefaultLogger.Debug("关闭BaseService:({0})成功.", this.ServiceId);
                    return true;
                }
            }
            catch (Exception ex)
            {
                GlobalConstants.DefaultLogger.Debug("关闭BaseService:({0})失败:{1}", this.ServiceId, ex.Message);
            }
            GlobalConstants.DefaultLogger.Debug("关闭BaseService:({0})已完成.", this.ServiceId);
            return false;
        }

        public virtual bool Config()
        {
            this.ThreadIntervals = 30;
            return true;
        }
    }

    public enum ServiceStatus
    {
        Running,
        Stopped
    }
}