using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Imms
{
    public class Logger :TextWriter
    {
        public LoggerLevel LoggerLevel { get; set; }        

        protected internal Logger()
        {
#if DEBUG
            this.LoggerLevel = LoggerLevel.TRACE;
#else
            this.LoggerLevel= LoggerLevel.INFO;
#endif

        }

        public virtual void WriteMessage(string message, LoggerLevel level, params object[] parameterValues)
        {
            if (level >= this.LoggerLevel)
            {
                string msg = string.Format(string.Format("[Imms.Core.Logger--{0:yyyy/MM/dd HH:mm:ss}-{1}]:{2}{3}", DateTime.Now, level, message, Environment.NewLine), parameterValues);
                lock (this)
                {
                    Console.Write(msg);                    
                  //  File.AppendAllText(this.LoggerFileName, msg);
                }
            }
        }

        //private WriteTextHandler WriteTextFunc;
        
        public override System.Text.Encoding Encoding
        {
            get
            {
                return System.Text.Encoding.UTF8;
            }
        }         

        public string LoggerFileName
        {
            get
            {
                return DateTime.Now.ToString("yyyyMMdd")+"_log.txt";
            }
        }


        public void Debug(string message, params object[] parameterValues)
        {
            this.WriteMessage(message, LoggerLevel.DEBUG, parameterValues);
        }

        public void Trace(string message, params object[] parameterValues)
        {
            this.WriteMessage(message, LoggerLevel.TRACE, parameterValues);
        }

        public void Info(string message, params object[] parameterValues)
        {
            this.WriteMessage(message, LoggerLevel.INFO, parameterValues);
        }

        public void Warning(string message, params object[] parameterValues)
        {
            //lock (typeof(Logger))
            //{
            //    SystemEnvironment.WarnCount += 1;
            //}

            this.WriteMessage(message, LoggerLevel.WARN, parameterValues);
        }

        public void Error(string message, params object[] parameterValues)
        {
            //lock (typeof(Logger))
            //{
            //    SystemEnvironment.ErrorCount += 1;
            //}

            this.WriteMessage(message, LoggerLevel.ERROR, parameterValues);
        }
    }

    //internal delegate void WriteTextHandler(string str);

    public enum LoggerLevel
    {
        ERROR = 4,
        WARN = 3,
        INFO = 2,
        DEBUG = 1,
        TRACE = 0
    }
}
