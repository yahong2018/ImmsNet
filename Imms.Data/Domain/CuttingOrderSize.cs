using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class CuttingOrderSize : TrackableEntity<long>
    {
        public long CuttingOrderId { get; set; }
        public string Size { get; set; }
        public int? LayerQty { get; set; }
        public int? PlannedQty { get; set; }
        public int? ActualQty { get; set; }
        public int? CreatedWorkOrderQty { get; set; }
    }

    public class CuttingOrderSizeConfigure : TrackableEntityConfigure<CuttingOrderSize>
    {
        protected override void InternalConfigure(EntityTypeBuilder<CuttingOrderSize> builder)
        {
            base.Configure(builder);
            builder.ToTable("cutting_order_size");

            builder.Property(e => e.ActualQty)
                    .HasColumnName("actual_qty")
                    .HasColumnType("int(11)");

            builder.Property(e => e.CreatedWorkOrderQty)
                    .HasColumnName("created_work_order_qty")
                    .HasColumnType("int(11)");

            builder.Property(e => e.CuttingOrderId)
                .HasColumnName("cutting_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.LayerQty)
                .HasColumnName("layer_qty")
                .HasColumnType("int(11)");

            builder.Property(e => e.PlannedQty)
                    .HasColumnName("planned_qty")
                    .HasColumnType("int(11)");

            builder.Property(e => e.Size)
                .HasColumnName("size")
                .HasMaxLength(10)
                .IsUnicode(false);
        }
    }
}
