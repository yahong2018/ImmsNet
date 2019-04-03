﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;
using System.ComponentModel.DataAnnotations;
using Imms.Mes.Stitch;
using Imms.Mes.MasterData;

namespace Imms.Mes.Picking
{
    public partial class PickingOrder : OrderEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public long PickingBomOrderId { get; set; }//如果是手工建领料单，则需要手工建一个领料的BomOrder和Boms
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

            builder.HasOne(e => e.Bom).WithMany().HasForeignKey(e => e.BomId).IsRequired();
            builder.HasOne(e => e.PickingOrder).WithMany(e => e.PickedItems).HasForeignKey(e => e.PickingOrderId);
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

            builder.HasOne(e => e.PickingBomOrder).WithMany().HasForeignKey(e => e.PickingBomOrderId);
            builder.HasOne(e => e.ProductionOrder).WithMany().HasForeignKey(e => e.ProductionOrderId);
        }
    }
}
