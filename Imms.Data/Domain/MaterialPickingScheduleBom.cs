using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class MaterialPickingScheduleBom : TrackableEntity<long>
    {
        public long MaterialPickingOrderId { get; set; }
        public long ComponentMaterialId { get; set; }
        public double Qty { get; set; }
        public long? ComponentMaterialUomId { get; set; }
        public double PickedQty { get; set; }
    }

    public class MaterialPickingScheduleBomConfigure : TrackableEntityConfigure<MaterialPickingScheduleBom>
    {
        protected override void InternalConfigure(EntityTypeBuilder<MaterialPickingScheduleBom> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("material_picking_schedule_bom");

            builder.Property(e => e.ComponentMaterialId)
                   .HasColumnName("component_material_id")
                   .HasColumnType("bigint(20)");

            builder.Property(e => e.ComponentMaterialUomId)
                .HasColumnName("component_material_unit_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.MaterialPickingOrderId)
                                .HasColumnName("material_picking_order_id")
                                .HasColumnType("bigint(20)");

            builder.Property(e => e.PickedQty)
                    .HasColumnName("picked_qty")
                    .HasColumnType("double(8,2)");

            builder.Property(e => e.Qty)
                .HasColumnName("qty")
                .HasColumnType("double(8,2)");
        }
    }
}
