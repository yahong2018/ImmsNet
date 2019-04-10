using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Imms.Data
{
    public interface IVerifier
    {
        void VerifyData(DbContext dbContext, IEntity entity, int dmlType);
    }

    public class VerifierFactory
    {
        public static void Verify(DbContext dbContext, IEntity entity, int dmlType)
        {
            if (entity == null)
            {
                return;
            }

            Type entityType = entity.GetType();
            IVerifier verify = GetVerifier(entityType);
            if (verify == null)
            {
                return;
            }
            
            if (dmlType != GlobalConstants.DML_OPERATION_INSERT && dmlType != GlobalConstants.DML_OPERATION_UPDATE && dmlType != GlobalConstants.DML_OPERATION_DELETE)
            {
                throw new BusinessException(GlobalConstants.EXCEPTION_CODE_PARAMETER_INVALID, "错误的dmlType");
            }
            if (dmlType == GlobalConstants.DML_OPERATION_INSERT)
            {
                if (dbContext.Find(entityType, entity.RecordId) != null)
                {
                    throw new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_ALREADY_EXISTS, $"Id为{entity.RecordId}的{entityType}数据已存在!");
                }
            }
            else if (dmlType == GlobalConstants.DML_OPERATION_UPDATE || dmlType == GlobalConstants.DML_OPERATION_DELETE)
            {
                if (dbContext.Find(entityType, entity.RecordId) == null)
                {
                    throw new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_ALREADY_EXISTS, $"Id为{entity.RecordId}的{entityType}数据不存在!");
                }
            }

            verify.VerifyData(dbContext, entity, dmlType);
        }

        public static IVerifier GetVerifier(Type entityType)
        {
            Guid key = entityType.GUID;
            lock (_VerifyList)
            {
                if (_VerifyList.ContainsKey(key))
                {
                    return _VerifyList[key];
                }
            }
            return null;
        }

        public static void RegisterDataVerify(Type entityType, IVerifier verify)
        {
            Guid key = entityType.GUID;
            lock (_VerifyList)
            {
                if (_VerifyList.ContainsKey(key))
                {
                    _VerifyList[key] = verify;
                }
                else
                {
                    _VerifyList.Add(key, verify);
                }
            }
        }
        private static readonly SortedList<Guid, IVerifier> _VerifyList = new SortedList<Guid, IVerifier>();
    }
}