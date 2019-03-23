using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;

namespace Imms.Mes.Domain
{
    public partial class MaterialPickingOrderDetail : TrackableEntity<long>
    {
        public long MaterialPickingOrderId { get; set; }
        public long? MaterialId { get; set; }
        public double? PickedQty { get; set; }
    }

    public class MaterialPickingOrderDetailConfigure : TrackableEntityConfigure<MaterialPickingOrderDetail>
    {
        protected override void InternalConfigure(EntityTypeBuilder<MaterialPickingOrderDetail> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("material_picking_order_detail");

            builder.Property(e => e.MaterialId)
                    .HasColumnName("material_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.MaterialPickingOrderId)
                .HasColumnName("material_picking_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.PickedQty)
                    .HasColumnName("picked_qty")
                    .HasColumnType("double(10,4)");
        }
    }
}
