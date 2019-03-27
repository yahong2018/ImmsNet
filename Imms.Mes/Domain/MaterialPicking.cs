using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;
using System.ComponentModel.DataAnnotations;

namespace Imms.Mes.Domain
{
    public partial class MaterialPickingSchedule : OrderEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public int Priority { get; set; }
        public virtual ProductionOrder ProductionOrder { get; set; }
        public virtual List<MaterialPickingScheduleBom> PickingBoms { get; set; } = new List<MaterialPickingScheduleBom>();
    }

    public partial class MaterialPickingScheduleBom : TrackableEntity<long>
    {
        public long MaterialPickingOrderId { get; set; }
        public long ComponentMaterialId { get; set; }
        public long ComponentUnitId { get; set; }
        public double PlanQty { get; set; }        
        public double PickedQty { get; set; }

        public virtual MaterialPickingSchedule Schedule { get; set; }
    }

    public partial class MaterialPickingOrder : OrderEntity<long>
    {                
        public long PickingScheduleId { get; set; }        
        public string ContainerNo { get; set; }        
        public long OperatorId { get; set; }
        public virtual MaterialPickingSchedule Schedule { get; set; }
        public virtual List<MaterialPickingOrderDetail> PickedDetails { get; set; } = new List<MaterialPickingOrderDetail>();
    }

    public partial class MaterialPickingOrderDetail : TrackableEntity<long>
    {
        public long MaterialPickingOrderId { get; set; }
        public long MaterialId { get; set; }
        public double PickedQty { get; set; }

        public virtual MaterialPickingOrder PickingOrder{get;set;}
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

            builder.HasOne(e=>e.PickingOrder).WithMany(e=>e.PickedDetails).HasForeignKey(e=>e.MaterialPickingOrderId).IsRequired();
        }
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

            builder.HasOne(e=>e.Schedule).WithMany().HasForeignKey(e=>e.PickingScheduleId).IsRequired();            
        }
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

            builder.Property(e => e.ComponentUnitId)
                .HasColumnName("component_material_unit_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.MaterialPickingOrderId)
                                .HasColumnName("material_picking_order_id")
                                .HasColumnType("bigint(20)");

            builder.Property(e => e.PickedQty)
                    .HasColumnName("picked_qty")
                    .HasColumnType("double(8,2)");

            builder.Property(e => e.PlanQty)
                .HasColumnName("qty")
                .HasColumnType("double(8,2)");

            builder.HasOne(e => e.Schedule).WithMany(e => e.PickingBoms).HasForeignKey(e => e.MaterialPickingOrderId).IsRequired();
        }
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

            builder.HasOne(e => e.ProductionOrder).WithMany().HasForeignKey(e => e.ProductionOrderId).IsRequired();
        }
    }
}
