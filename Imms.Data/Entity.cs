using System;

namespace Imms.Data
{
    public class Entity<T>
    {
        public T RecordId { get; set; }
    }

    public class TrackableEntity<T> : Entity<T>
    {
        public long CreateBy { get; set; }
        public DateTime CreateDate { get; set; }        
        public long? UpdateBy { get; set; }
        public DateTime? UpdateDate { get; set; }
        public int OptFlag { get; set; }
    }

    public class OrderEntity<T>:TrackableEntity<T>
    {
        public string OrderNo { get; set; }
        public int OrderStatus{get;set;}
    }
}