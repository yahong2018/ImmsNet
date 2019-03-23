using System;
using System.Reflection;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data
{
    public interface IEntity:IComparable{
        IComparable RecordId{get;set;}
    }

    public class Entity<T>:IEntity where T: IComparable
    {
        public T RecordId { get; set; }
        IComparable IEntity.RecordId { get => this.RecordId; set => this.RecordId = (T) value; }

        int IComparable.CompareTo(object obj)
        {
            if(obj==null){
                return 1;
            }

            if(((IEntity)this).RecordId==null){
                return -1;
            }

            if(!(obj is IEntity)){
                return -1;
            }

            if(((IEntity)obj).RecordId==null){
                return -1;
            }

            return ((IComparable) this.RecordId).CompareTo(((IEntity)obj).RecordId);
        }
    }

    public class TrackableEntity<T> : Entity<T> where T:IComparable
    {
        public long CreateBy { get; set; }
        public DateTime CreateDate { get; set; }        
        public long? UpdateBy { get; set; }
        public DateTime? UpdateDate { get; set; }
        public int OptFlag { get; set; }
    }

    public class OrderEntity<T>:TrackableEntity<T> where T:IComparable
    {
        public string OrderNo { get; set; }
        public int OrderStatus{get;set;}
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

            builder.Property(typeof(long),"CreateBy").HasColumnName("create_by");
            builder.Property(typeof(DateTime),"CreateDate").HasColumnName("create_date");
            builder.Property(typeof(long?),"UpdateBy").HasColumnName("update_by");
            builder.Property(typeof(DateTime?),"UpdateDate").HasColumnName("update_date");
            builder.Property(typeof(int),"OptFlag").HasColumnName("opt_flag");
        }
    }

    public abstract class OrderEntityConfigure<E>:TrackableEntityConfigure<E> where E:class{
        protected override void InternalConfigure(EntityTypeBuilder<E> builder)
        {
            base.InternalConfigure(builder);

            builder.Property(typeof(int),"OrderStatus").HasColumnName("order_status");
            builder.Property(typeof(string),"OrderNo").HasColumnName("order_no").HasMaxLength(12);
        }
    }
}