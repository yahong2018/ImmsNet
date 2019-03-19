using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class OrderMeasure : TrackableEntity<long>
    {
        public long OrderId { get; set; }
        public string BodyNo { get; set; }
        public int MeasureData { get; set; }
    }

    public class OrderMeasureConfigure : TrackableEntityConfigure<OrderMeasure>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OrderMeasure> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("order_measure");

            builder.Property(e => e.BodyNo)
                   .IsRequired()
                   .HasColumnName("body_no")
                   .HasMaxLength(20)
                   .IsUnicode(false);

            builder.Property(e => e.MeasureData)
                    .HasColumnName("measure_data")
                    .HasColumnType("int(11)");

            builder.Property(e => e.OrderId)
                   .HasColumnName("order_id")
                   .HasColumnType("bigint(20)");
        }
    }
}
