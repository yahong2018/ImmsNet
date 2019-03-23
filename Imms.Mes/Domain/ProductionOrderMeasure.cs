using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;

namespace Imms.Mes.Domain
{
    public partial class ProductionOrderMeasure : TrackableEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public string BodyNo { get; set; }
        public string MeasureData { get; set; }
        public string GarmentSize { get; set; }
    }

    public class ProductionOrderMeasureConfigure : TrackableEntityConfigure<ProductionOrderMeasure>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionOrderMeasure> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_order_measure");

            builder.Property(e => e.ProductionOrderId)
                .HasColumnName("order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.BodyNo)
                   .IsRequired()
                   .HasColumnName("body_no")
                   .HasMaxLength(20)
                   .IsUnicode(false);

            builder.Property(e => e.MeasureData)
                    .HasColumnName("measure_data")
                    .HasColumnType("varchar(10)");

            builder.Property(e => e.GarmentSize)
                    .HasColumnName("garment_size")
                    .HasColumnType("varchar(10)");


        }
    }
}
