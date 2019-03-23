using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;

namespace Imms.Mes.Domain
{
    public partial class MaterialPickingOrder : TrackableEntity<long>
    {
        public string OrderNo { get; set; }
        public int OrderStatus { get; set; }
        public long PickingScheduleId { get; set; }
        public string ContainerNo { get; set; }
        public long OperatorId { get; set; }
    }

    public class MaterialPickingOrderConfigure : OrderEntityConfigure<MaterialPickingOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<MaterialPickingOrder> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("material_picking_order");
            builder.Property(e => e.ContainerNo)
                    .IsRequired()
                    .HasColumnName("container_no")
                    .HasMaxLength(64)
                    .IsUnicode(false);

            builder.Property(e => e.OperatorId)
                    .HasColumnName("operator_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.PickingScheduleId)
                    .HasColumnName("picking_schedule_id")
                    .HasColumnType("bigint(20)");
        }
    }
}
