using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;

namespace Imms.Mes.Domain
{
    public partial class MaterialPickingSchedule : OrderEntity<long>
    {
        public long ProductionOrderId { get; set; }
    }

    public class MaterialPickingScheduleConfigure : OrderEntityConfigure<MaterialPickingSchedule>
    {
        protected override void InternalConfigure(EntityTypeBuilder<MaterialPickingSchedule> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("material_picking_schedule");

            builder.Property(e => e.ProductionOrderId)
                        .HasColumnName("production_order_id")
                        .HasColumnType("bigint(20)");

        }
    }
}
