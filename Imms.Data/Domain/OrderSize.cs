using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class OrderSize : TrackableEntity<long>
    {
        public long OrderId { get; set; }
        public long SizeId { get; set; }
        public string SizeCode { get; set; }
        public int? QytPlanned { get; set; }
    }


    public class OrderSizeConfigure : TrackableEntityConfigure<OrderSize>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OrderSize> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("order_size");

            builder.Property(e => e.OrderId)
                   .HasColumnName("order_id")
                   .HasColumnType("bigint(20)");

            builder.Property(e => e.QytPlanned)
                .HasColumnName("qyt_planned")
                .HasColumnType("int(11)");

            builder.Property(e => e.SizeCode)
                .IsRequired()
                .HasColumnName("size_code")
                .HasMaxLength(10)
                .IsUnicode(false);

            builder.Property(e => e.SizeId)
                .HasColumnName("size_id")
                .HasColumnType("bigint(20)");
        }
    }
}
