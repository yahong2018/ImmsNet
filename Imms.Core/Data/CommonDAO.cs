using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Transactions;

namespace Imms.Data
{
    public class CommonDAO
    {
        private static readonly SortedList<Guid, string> _TypeKeyPropertyNameList = new SortedList<Guid, string>();
        private static readonly SortedDictionary<Guid, string> _TableDisplayLabelList = new SortedDictionary<Guid, string>();
        private static readonly SortedList<Guid, SortedDictionary<string, string>> _TypePropertyDisplayLabelList = new SortedList<Guid, SortedDictionary<string, string>>();

        public static T[] GetAllByFilter<T>(Expression<Func<T, bool>> filter) where T : class
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                return dbContext.Set<T>().Where(filter).ToArray();
            }
        }

        public static T GetOneByFilter<T>(Expression<Func<T, bool>> filter) where T : class
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                return dbContext.Set<T>().Where(filter).FirstOrDefault();
            }
        }

        public static T GetOneByWhere<T>(string where, params object[] parameters) where T : class
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                return dbContext.Set<T>().Where(where, parameters).FirstOrDefault();
            }
        }

        public static T AssureExistsByFilter<T>(string where, params object[] parameters) where T : class
        {
            T result = GetOneByWhere<T>(where, parameters);
            if (result == null)
            {
                string tableName = typeof(T).Name;
                StringBuilder stringBuilder = new StringBuilder();
                foreach(object obj in parameters){
                    stringBuilder.Append(obj.ToString());
                    stringBuilder.Append(",");
                }               

                string log = $"系统错误:{tableName}中没有找到条件为{where},值为{stringBuilder.ToString()}'的数据！";
                GlobalConstants.DefaultLogger.Error(log);
                throw new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_NOT_FOUND, log);
            }
            return result;
        }

        public static T AssureExistsByFilter<T>(Expression<Func<T, bool>> filter) where T : class
        {
            T result = GetOneByFilter<T>(filter);
            if (result == null)
            {
                string filterStr = filter.ToString();
                string tableName = typeof(T).Name;
                string log = $"系统错误:{tableName}中没有找到条件为{filterStr}'的数据！";
                GlobalConstants.DefaultLogger.Error(log);
                throw new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_NOT_FOUND, log);
            }
            return result;
        }

        public static T AssureNotExistsByFilter<T>(Expression<Func<T, bool>> filter) where T : class
        {
            T result = GetOneByFilter<T>(filter);
            if (result != null)
            {
                string filterStr = filter.ToString();
                string tableName = typeof(T).Name;
                string log = $"系统错误:{tableName}中已存在条件为{filterStr}'的数据！";
                GlobalConstants.DefaultLogger.Error(log);
                throw new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_ALREADY_EXISTS, log);
            }
            return result;
        }

        public static void AssureNotExists<T>(T item) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                if (item.RecordId != null)
                {
                    T oldItem = dbContext.Set<T>().Where(x => x.RecordId == item.RecordId).FirstOrDefault();
                    if (oldItem != null)
                    {
                        BusinessException businessException
                            = new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_ALREADY_EXISTS, $"数据RecordId={item.RecordId}的数据已存在！");
                        throw businessException;
                    }
                }
            }
        }

        public static T AssureExists<T>(T item) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                if (item.RecordId != null)
                {
                    Func<T, bool> filter = (x) =>
                    {
                        return x.RecordId == item.RecordId;
                    };
                    //Expression<Func<T>() filter = 

                    T oldItem = dbContext.Set<T>().Where(x => x.RecordId == item.RecordId).FirstOrDefault();
                    if (oldItem == null)
                    {
                        BusinessException businessException
                            = new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_ALREADY_EXISTS, $"数据RecordId={item.RecordId}的不已存在！");
                        throw businessException;
                    }
                    return oldItem;
                }
            }
            return null;
        }

        public static int Insert<T>(T[] items, DMLGenericHandler<T> handlerBeforeInsert = null, DMLGenericHandler<T> handlerAfterInsert = null, bool notifyChangeEvent = false) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                foreach (T item in items)
                {
                    DoSingleInsert(dbContext, item, handlerBeforeInsert, handlerAfterInsert, notifyChangeEvent);
                }
            }
            return items.Length;
        }

        public static int Insert<T>(T item, DMLGenericHandler<T> handlerBeforeInsert = null, DMLGenericHandler<T> handlerAfterInsert = null, bool notifyChangeEvent = false) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                return DoSingleInsert(dbContext, item, handlerBeforeInsert, handlerAfterInsert, notifyChangeEvent);
            }
        }

        private static int DoSingleInsert<T>(DbContext dbContext, T item, DMLGenericHandler<T> handlerBeforeInsert = null, DMLGenericHandler<T> handlerAfterInsert = null, bool notifyChangeEvent = false) where T : class, IEntity
        {
            AssureNotExists<T>(item);
            GetCustomDataVerifyHandler(typeof(T), DMLType.Insert)?.Invoke(item, DMLType.Insert);
            handlerBeforeInsert?.Invoke(item, DMLType.Insert);
            try
            {
                dbContext.Set<T>().Add(item);
                return dbContext.SaveChanges();
            }
            finally
            {
                if (notifyChangeEvent)
                {
                    DataChangedNotifyEvent changedEvent = new DataChangedNotifyEvent
                    {
                        Entity = item,
                        DMLType = DMLType.Insert
                    };

                    ThreadPool.QueueUserWorkItem<DataChangedNotifyEvent>(DataChangeNotifyEventDispatcher.Instance.OnDateChanged, changedEvent, false);
                }

                handlerAfterInsert?.Invoke(item, DMLType.Insert);
            }
        }

        public static int Update<T>(T item, DMLGenericHandler<T> handlerBeforeUpdate = null, DMLGenericHandler<T> handlerAfterUpdate = null, bool notifyDataChanged = false) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                T dbItem = AssureExists<T>(item);
                GetCustomDataVerifyHandler(typeof(T), DMLType.Update)?.Invoke(dbItem, DMLType.Update);
                handlerBeforeUpdate?.Invoke(item, DMLType.Update);
                try
                {
                    EntityEntry<T> entry = dbContext.Entry<T>(dbItem);
                    entry.CurrentValues.SetValues(item);

                    return dbContext.SaveChanges();
                }
                finally
                {
                    if (notifyDataChanged)
                    {
                        DataChangedNotifyEvent changedEvent = new DataChangedNotifyEvent
                        {
                            Entity = item,
                            DMLType = DMLType.Update
                        };

                        ThreadPool.QueueUserWorkItem<DataChangedNotifyEvent>(DataChangeNotifyEventDispatcher.Instance.OnDateChanged, changedEvent, false);
                    }

                    handlerAfterUpdate?.Invoke(item, DMLType.Update);
                }
            }
        }


        public static int Delete<T>(T item, DMLGenericHandler<T> handlerBeforeDelete = null, DMLGenericHandler<T> handlerAfterDelete = null, bool notifyChangeEvent = false) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                T dbItem = AssureExists<T>(item);
                GetCustomDataVerifyHandler(typeof(T), DMLType.Delete)?.Invoke(dbItem, DMLType.Delete);
                handlerBeforeDelete?.Invoke(dbItem, DMLType.Delete);
                try
                {
                    dbContext.Remove<T>(dbItem);

                    return dbContext.SaveChanges();
                }
                finally
                {
                    if (notifyChangeEvent)
                    {
                        DataChangedNotifyEvent changedEvent = new DataChangedNotifyEvent
                        {
                            Entity = dbItem,
                            DMLType = DMLType.Delete
                        };

                        ThreadPool.QueueUserWorkItem<DataChangedNotifyEvent>(DataChangeNotifyEventDispatcher.Instance.OnDateChanged, changedEvent, false);
                    }

                    handlerAfterDelete?.Invoke(dbItem, DMLType.Delete);
                }
            }
        }


        public static void RegisterDMLCommonHandler(Type itemType, DMLType dmlType, DMLCommonHandler handler)
        {
            Guid key = itemType.GUID;
            lock (_CustomDataVerifyHandlers)
            {
                if (!_CustomDataVerifyHandlers.ContainsKey(key))
                {
                    _CustomDataVerifyHandlers.Add(key, new SortedDictionary<DMLType, DMLCommonHandler>());
                }
                else if (!_CustomDataVerifyHandlers[key].ContainsKey(dmlType))
                {
                    _CustomDataVerifyHandlers[key].Add(dmlType, handler);
                }
                else
                {
                    _CustomDataVerifyHandlers[key][dmlType] = handler;
                }
            }
        }


        private static DMLCommonHandler GetCustomDataVerifyHandler(Type itemType, DMLType dmlType)
        {
            Guid key = itemType.GUID;

            lock (_CustomDataVerifyHandlers)
            {
                if (_CustomDataVerifyHandlers.ContainsKey(key) && _CustomDataVerifyHandlers[key].ContainsKey(dmlType))
                {
                    return _CustomDataVerifyHandlers[key][dmlType];
                }
            }
            return null;
        }
        private static readonly SortedList<Guid, SortedDictionary<DMLType, DMLCommonHandler>> _CustomDataVerifyHandlers = new SortedList<Guid, SortedDictionary<DMLType, DMLCommonHandler>>();
    }

    public enum DMLType
    {
        Insert,
        Update,
        Delete
    }

    public delegate void DMLCommonHandler(object item, DMLType dmlType);
    public delegate void DMLGenericHandler<T>(T item, DMLType dmlType);
}
