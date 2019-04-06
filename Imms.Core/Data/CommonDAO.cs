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

        public static T AssureExistsByFilter<T>(Expression<Func<T, bool>> filter, bool throwException = true) where T : class
        {
            T result = GetOneByFilter<T>(filter);
            if (result == null && throwException)
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

        public static void UseDbContext(params DBContextHandler[] handlers)
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                foreach (DBContextHandler handler in handlers)
                {
                    handler(dbContext);
                }
            }
        }

        public static void UseDbContextWithTransaction(params DBContextHandler[] handlers)
        {
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required))
            {
                using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
                {
                    foreach (DBContextHandler handler in handlers)
                    {
                        handler(dbContext);
                    }
                }

                scope.Complete();
            }
        }


        public void Validate<T>(int dmlType, params T[] items)
        {
            DMLCommonHandler verifyHandler = GetCustomDataVerifyHandler(typeof(T), dmlType);
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                foreach (T item in items)
                {
                    verifyHandler(item, dmlType, dbContext);
                }
            }
        }

        public static int Insert<T>(T[] items, DMLGenericHandler<T> handlerBeforeInsert = null, DMLGenericHandler<T> handlerAfterInsert = null) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                foreach (T item in items)
                {
                    DoSingleInsert(dbContext, item, handlerBeforeInsert, handlerAfterInsert);
                }
            }
            return items.Length;
        }

        public static int Insert<T>(T item, DMLGenericHandler<T> handlerBeforeInsert = null, DMLGenericHandler<T> handlerAfterInsert = null) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                return DoSingleInsert(dbContext, item, handlerBeforeInsert, handlerAfterInsert);
            }
        }

        private static int DoSingleInsert<T>(DbContext dbContext, T item, DMLGenericHandler<T> handlerBeforeInsert = null, DMLGenericHandler<T> handlerAfterInsert = null) where T : class, IEntity
        {
            AssureNotExists<T>(item);
            GetCustomDataVerifyHandler(typeof(T), GlobalConstants.DML_OPERATION_INSERT)?.Invoke(item, GlobalConstants.DML_OPERATION_INSERT, dbContext);
            handlerBeforeInsert?.Invoke(item, GlobalConstants.DML_OPERATION_INSERT, dbContext);
            try
            {
                dbContext.Set<T>().Add(item);
                return dbContext.SaveChanges();
            }
            finally
            {
                handlerAfterInsert?.Invoke(item, GlobalConstants.DML_OPERATION_INSERT, dbContext);
            }
        }

        public static int Update<T>(T item, DMLGenericHandler<T> handlerBeforeUpdate = null, DMLGenericHandler<T> handlerAfterUpdate = null) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                T dbItem = AssureExists<T>(item);
                GetCustomDataVerifyHandler(typeof(T), GlobalConstants.DML_OPERATION_UPDATE)?.Invoke(dbItem, GlobalConstants.DML_OPERATION_UPDATE, dbContext);
                handlerBeforeUpdate?.Invoke(item, GlobalConstants.DML_OPERATION_UPDATE, dbContext);
                try
                {
                    EntityEntry<T> entry = dbContext.Entry<T>(dbItem);
                    entry.CurrentValues.SetValues(item);

                    return dbContext.SaveChanges();
                }
                finally
                {
                    handlerAfterUpdate?.Invoke(item, GlobalConstants.DML_OPERATION_UPDATE, dbContext);
                }
            }
        }


        public static int Delete<T>(T item, DMLGenericHandler<T> handlerBeforeDelete = null, DMLGenericHandler<T> handlerAfterDelete = null) where T : class, IEntity
        {
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                T dbItem = AssureExists<T>(item);
                GetCustomDataVerifyHandler(typeof(T), GlobalConstants.DML_OPERATION_DELETE)?.Invoke(dbItem, GlobalConstants.DML_OPERATION_DELETE, dbContext);
                handlerBeforeDelete?.Invoke(dbItem, GlobalConstants.DML_OPERATION_DELETE, dbContext);
                try
                {
                    dbContext.Remove<T>(dbItem);

                    return dbContext.SaveChanges();
                }
                finally
                {
                    handlerAfterDelete?.Invoke(dbItem, GlobalConstants.DML_OPERATION_DELETE, dbContext);
                }
            }
        }


        public static void RegisterDMLCommonHandler(Type itemType, int dmlType, DMLCommonHandler handler)
        {
            Guid key = itemType.GUID;
            lock (_CustomDataVerifyHandlers)
            {
                if (!_CustomDataVerifyHandlers.ContainsKey(key))
                {
                    _CustomDataVerifyHandlers.Add(key, new SortedDictionary<int, DMLCommonHandler>());
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


        private static DMLCommonHandler GetCustomDataVerifyHandler(Type itemType, int dmlType)
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
        private static readonly SortedList<Guid, SortedDictionary<int, DMLCommonHandler>> _CustomDataVerifyHandlers = new SortedList<Guid, SortedDictionary<int, DMLCommonHandler>>();
    }

    public delegate void DBContextHandler(DbContext dbContext);
    public delegate void DMLCommonHandler(object item, int dmlType, DbContext dbContext);
    public delegate void DMLGenericHandler<T>(T item, int dmlType, DbContext dbContext);
}
