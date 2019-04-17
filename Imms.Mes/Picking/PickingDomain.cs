using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;
using System.ComponentModel.DataAnnotations;
using Imms.Mes.Stitch;
using Imms.Mes.MasterData;

namespace Imms.Mes.Picking
{
    public partial class PickingOrder : OrderEntity<long>, IWrokStationFinderParameter
    {
        public long ProductionOrderId { get; set; }
        public long PickingBomOrderId { get; set; }//如果是手工建领料单，则需要手工建一个领料的BomOrder和Boms
        public int OrderType { get; set; }   //领料单类型：裁剪面料、辅料
        public int Priority { get; set; }

        public DateTime TimeStartPlanned { get; set; }
        public DateTime TimeEndPlanned { get; set; }

        public DateTime? TimeStartActual { get; set; }
        public DateTime? TimeEndActual { get; set; }

        public string ContainerNo { get; set; }
        public long OperatorId { get; set; }

        public virtual ProductionOrder ProductionOrder { get; set; }
        public virtual BomOrder PickingBomOrder { get; set; }
        public virtual List<PickingOrderItem> PickedItems { get; set; } = new List<PickingOrderItem>();
    }

    public partial class PickingOrderItem : TrackableEntity<long>
    {
        public long PickingOrderId { get; set; }
        public long BomId { get; set; }
        public double PickedQty { get; set; }

        public virtual PickingOrder PickingOrder { get; set; }
        public virtual Bom Bom { get; set; }
    }

    public class PickingOrderItemConfigure : TrackableEntityConfigure<PickingOrderItem>
    {
        protected override void InternalConfigure(EntityTypeBuilder<PickingOrderItem> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("picking_order_item");

            builder.Property(e => e.BomId).HasColumnName("bom_id");
            builder.Property(e => e.PickingOrderId).HasColumnName("picking_order_id");
            builder.Property(e => e.PickedQty).HasColumnName("picked_qty").HasColumnType("double(10,4)");

            builder.HasOne(e => e.Bom).WithMany().HasForeignKey(e => e.BomId).IsRequired().HasConstraintName("bom_id");
            builder.HasOne(e => e.PickingOrder).WithMany(e => e.PickedItems).HasForeignKey(e => e.PickingOrderId).HasConstraintName("picking_order_id");
        }
    }

    public class MaterialPickingOrderConfigure : OrderEntityConfigure<PickingOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<PickingOrder> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("picking_order");
            builder.Property(e => e.ProductionOrderId).HasColumnName("production_order_id");
            builder.Property(e => e.PickingBomOrderId).HasColumnName("picking_bom_order_id");
            builder.Property(e => e.Priority).HasColumnName("priority");
            builder.Property(e => e.ContainerNo).IsRequired().HasColumnName("container_no").HasMaxLength(64).IsUnicode(false);
            builder.Property(e => e.OperatorId).HasColumnName("operator_id");
            builder.Property(e => e.OrderType).HasColumnName("order_type");
            builder.Property(e => e.TimeStartActual).HasColumnName("time_start_actual");
            builder.Property(e => e.TimeStartPlanned).HasColumnName("time_start_planned");
            builder.Property(e => e.TimeEndActual).HasColumnName("time_end_actual");
            builder.Property(e => e.TimeEndPlanned).HasColumnName("time_end_planned");

            builder.HasOne(e => e.PickingBomOrder).WithMany().HasForeignKey(e => e.PickingBomOrderId).HasConstraintName("picking_bom_order_id");
            builder.HasOne(e => e.ProductionOrder).WithMany().HasForeignKey(e => e.ProductionOrderId).HasConstraintName("production_order_id");
        }
    }
}
