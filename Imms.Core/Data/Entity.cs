using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data
{
    public interface IEntity : IComparable
    {
        IComparable RecordId { get; set; }
    }

    public class Entity<T> : IEntity where T : IComparable
    {
        public T RecordId { get; set; }
        IComparable IEntity.RecordId { get => this.RecordId; set => this.RecordId = (T)value; }

        int IComparable.CompareTo(object obj)
        {
            if (obj == null)
            {
                return 1;
            }

            if (((IEntity)this).RecordId == null)
            {
                return -1;
            }

            if (!(obj is IEntity))
            {
                return -1;
            }

            if (((IEntity)obj).RecordId == null)
            {
                return -1;
            }

            return ((IComparable)this.RecordId).CompareTo(((IEntity)obj).RecordId);
        }

        public override string ToString()
        {
            Guid key = this.GetType().GUID;
            lock (_Properties)
            {
                if (!_Properties.ContainsKey(key))
                {
                    _Properties.Add(key, this.GetType().GetProperties(BindingFlags.Public | BindingFlags.Instance));
                }
            }
            PropertyInfo[] properties = _Properties[key];
            StringBuilder stringBuilder = new StringBuilder();
            foreach (PropertyInfo property in properties)
            {
                object value = property.GetValue(this);
                if (value == null)
                {
                    value = "[null]";
                }
                stringBuilder.Append($"{property.Name}={value.ToString()};");
            }
            stringBuilder.Remove(stringBuilder.Length - 1, 1);

            return stringBuilder.ToString();
        }

        private static readonly SortedList<Guid, PropertyInfo[]> _Properties = new SortedList<Guid, PropertyInfo[]>();
    }

    public interface ITrackableEntity
    {
        long CreateBy { get; set; }
        DateTime CreateDate { get; set; }
        long? UpdateBy { get; set; }
        DateTime? UpdateDate { get; set; }
        int OptFlag { get; set; }
    }

    public class TrackableEntity<T> : Entity<T>, ITrackableEntity where T : IComparable
    {
        public long CreateBy { get; set; }
        public DateTime CreateDate { get; set; }
        public long? UpdateBy { get; set; }
        public DateTime? UpdateDate { get; set; }
        public int OptFlag { get; set; }
    }

    public interface IOrderEntry
    {
        string OrderNo { get; set; }
    }

    public class OrderEntity<T> : TrackableEntity<T>, IOrderEntry where T : IComparable
    {
        public string OrderNo { get; set; }

        private int _OrderStatus;
        public int OrderStatus
        {
            get { return _OrderStatus; }
            set
            {
                this.SetOrderStatus(value);
            }
        }

        protected virtual void SetOrderStatus(int status)
        {
            if (status == GlobalConstants.STATUS_ORDER_FINISHED
              || status == GlobalConstants.STATUS_ORDER_PLANNED
            )
            {
                this.DirectSetStatus(status);
            }
            else
            {
                this._OrderStatus |= status;
            }
        }

        protected void DirectSetStatus(int status)
        {
            this._OrderStatus = status;
        }

        public bool ReachStatus(int status)
        {
            return (this.OrderStatus & status) == status;
        }
    }

    public abstract class EntityConfigure<E> : IEntityTypeConfiguration<E> where E : class
    {
        public void Configure(EntityTypeBuilder<E> builder)
        {
            this.InternalConfigure(builder);
        }

        protected virtual void InternalConfigure(EntityTypeBuilder<E> builder)
        {
            Type entityType = typeof(E);
            PropertyInfo propertyInfo = entityType.GetProperty("RecordId", BindingFlags.Public | BindingFlags.Instance);
            builder.HasKey("RecordId");
            builder.Property(propertyInfo.PropertyType, "RecordId").HasColumnName("record_id");
        }
    }

    public abstract class TrackableEntityConfigure<E> : EntityConfigure<E> where E : class
    {
        protected override void InternalConfigure(EntityTypeBuilder<E> builder)
        {
            base.InternalConfigure(builder);

            builder.Property(typeof(long), "CreateBy").HasColumnName("create_by");
            builder.Property(typeof(DateTime), "CreateDate").HasColumnName("create_date");
            builder.Property(typeof(long?), "UpdateBy").HasColumnName("update_by");
            builder.Property(typeof(DateTime?), "UpdateDate").HasColumnName("update_date");
            builder.Property(typeof(int), "OptFlag").HasColumnName("opt_flag");
        }
    }

    public abstract class OrderEntityConfigure<E> : TrackableEntityConfigure<E> where E : class
    {
        protected override void InternalConfigure(EntityTypeBuilder<E> builder)
        {
            base.InternalConfigure(builder);

            builder.Property(typeof(int), "OrderStatus").HasColumnName("order_status");
            builder.Property(typeof(string), "OrderNo").HasColumnName("order_no").HasMaxLength(12);
        }
    }
}