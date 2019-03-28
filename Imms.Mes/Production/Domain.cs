using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Quality;
using Imms.Mes.Routing;
using Imms.Mes.MasterData;

namespace Imms.Mes.Production
{
    public partial class ProductionOrder : OrderEntity<long>
    {
        public string RequirementOrderNo { get; set; }
        public string ScheduleOrderNo { get; set; }
        public int OrderType { get; set; }
        public long FgMaterialId { get; set; }
        public byte Priority { get; set; }
        public long? WorkCenterId { get; set; }
        public long? RoutingOrderId { get; set; }
        public long BomOrderId { get; set; }
        public int QtyPlanned { get; set; }
        public int QtyFinished { get; set; }
        public int SecondQualityQty { get; set; }
        public int QtyDefect { get; set; }
        public int QtyActual { get; set; }
        public DateTime DateStartPlanned { get; set; }
        public DateTime DateEndPlanned { get; set; }
        public DateTime? DateStartActual { get; set; }
        public DateTime? DateEndActual { get; set; }

        public virtual OperationRoutingOrder RoutingOrder { get; set; }
        public virtual Material FgMaterial { get; set; }
        public virtual BomOrder BomOrder { get; set; }
        public virtual List<ProductionOrderSize> Sizes { get; set; } = new List<ProductionOrderSize>();
        public virtual List<ProductionOrderMeasure> Measures { get; set; } = new List<ProductionOrderMeasure>();
        public virtual List<ProductionOrderPatternRelation> PatternImages { get; set; } = new List<ProductionOrderPatternRelation>();
        public virtual List<QualityCheck> QualityChecks { get; set; } = new List<QualityCheck>();

        protected override void SetOrderStatus(int status)
        {
            if (status == GlobalConstants.STATUS_PRODUCTION_ORDER_PICKING
               || status == GlobalConstants.STATUS_PRODUCTION_ORDER_PICKED
               || status == GlobalConstants.STATUS_PRODUCTION_ORDER_CUTTING
               || status == GlobalConstants.STATUS_PRODUCTION_ORDER_CUTTED
               || status == GlobalConstants.STATUS_PRODUCTION_ORDER_HANGING
               || status == GlobalConstants.STATUS_PRODUCTION_ORDER_HANGED
               || status == GlobalConstants.STATUS_PRODUCTION_ORDER_SEWING
               || status == GlobalConstants.STATUS_PRODUCTION_ORDER_SEWED
               )
            {
                base.DirectSetStatus(status);
            }
            else
            {
                base.SetOrderStatus(status);
            }
        }
    }

    public partial class ProductionOrderSize : TrackableEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public long SizeId { get; set; }
        //  public string SizeCode { get; set; }
        public int QytPlanned { get; set; }

        public virtual ProductionOrder ProductionOrder { get; set; }
    }

    public partial class ProductionOrderMeasure : TrackableEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public string BodyNo { get; set; }
        public string MeasureData { get; set; }
        public string GarmentSize { get; set; }

        public virtual ProductionOrder ProductionOrder { get; set; }
    }

    public class ProductionOrderPatternRelation : TrackableEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public long MaterialId { get; set; }
        public long MediaId { get; set; }

        public virtual Media Media { get; set; }
        public virtual ProductionOrder ProductionOrder { get; set; }
    }

    public partial class ProductionWorkOrder : OrderEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public long BomOrderId { get; set; }
        public long OperationRoutingOrderId { get; set; }
        public long CuttingOrderId { get; set; }
        public long SizeId { get; set; }
        public DateTime PlannedStartDate { get; set; }
        public DateTime PlannedEndDate { get; set; }
        public DateTime? ActualStartDate { get; set; }
        public DateTime? ActualEndDate { get; set; }
        public byte SynFinishStatus { get; set; }
    }

     public partial class ProductionWorkOrderRouting : TrackableEntity<long>
    {
        public long OperationRoutingOrderId { get; set; }
        public long ProductionWorkOrderId { get; set; }
        public long OperationRoutingId { get; set; }
        public long? OperatorId { get; set; }
        public long? WorkStationId { get; set; }
        public int? ScrapQty { get; set; }
        public int? CompleteQty { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? CompleteTime { get; set; }
        public int OrderStatus { get; set; }
    }

    public class ProductionWorkOrderRoutingConfigure : OrderEntityConfigure<ProductionWorkOrderRouting>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionWorkOrderRouting> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_work_order_routing");

            builder.Property(e => e.CompleteQty)
                    .HasColumnName("complete_qty")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

            builder.Property(e => e.CompleteTime).HasColumnName("complete_time");

            builder.Property(e => e.OperationRoutingId)
                    .HasColumnName("operation_routing_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OperationRoutingOrderId)
                .HasColumnName("operation_routing_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.OperatorId)
                .HasColumnName("operator_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.OrderStatus)
                .HasColumnName("order_status")
                .HasColumnType("int(11)");

            builder.Property(e => e.ProductionWorkOrderId)
                .HasColumnName("production_work_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.ScrapQty)
                .HasColumnName("scrap_qty")
                .HasColumnType("int(11)")
                .HasDefaultValueSql("0");

            builder.Property(e => e.StartTime).HasColumnName("start_time");

            builder.Property(e => e.WorkStationId)
                    .HasColumnName("work_station_id")
                    .HasColumnType("bigint(20)");
        }
    }

    public class ProductionWorkOrderConfigure : OrderEntityConfigure<ProductionWorkOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionWorkOrder> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_work_order");

            builder.Property(e => e.ActualEndDate).HasColumnName("actual_end_date");

            builder.Property(e => e.ActualStartDate).HasColumnName("actual_start_date");

            builder.Property(e => e.BomOrderId)
                .HasColumnName("bom_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.CuttingOrderId)
                    .HasColumnName("cutting_order_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OperationRoutingOrderId)
                .HasColumnName("operation_routing_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.PlannedEndDate).HasColumnName("planned_end_date");

            builder.Property(e => e.PlannedStartDate).HasColumnName("planned_start_date");

            builder.Property(e => e.ProductionOrderId)
                .HasColumnName("production_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.SizeId)
                .HasColumnName("size_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.SynFinishStatus)
                .HasColumnName("syn_finish_status")
                .HasColumnType("tinyint(4)")
                .HasDefaultValueSql("0");
        }
    }


    public class ProductionOrderSizeConfigure : TrackableEntityConfigure<ProductionOrderSize>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionOrderSize> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_order_size");

            builder.Property(e => e.ProductionOrderId)
                   .HasColumnName("production_order_id")
                   .HasColumnType("bigint(20)");

            builder.Property(e => e.QytPlanned)
                .HasColumnName("qyt_planned")
                .HasColumnType("int(11)");

            builder.Property(e => e.SizeId)
                .HasColumnName("size_id")
                .HasColumnType("bigint(20)");

            builder.HasOne(s => s.ProductionOrder).WithMany(p => p.Sizes).HasForeignKey(s => s.ProductionOrderId);
        }
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

            builder.HasOne(m => m.ProductionOrder).WithMany(p => p.Measures).HasForeignKey(m => m.ProductionOrderId);
        }
    }

    public class ProductionOrderPatternRelationConfigure : TrackableEntityConfigure<ProductionOrderPatternRelation>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionOrderPatternRelation> builder)
        {
            base.InternalConfigure(builder);

            builder.Property(e => e.ProductionOrderId).HasColumnName("production_order_id");
            builder.Property(e => e.MaterialId).HasColumnName("material_id");
            builder.Property(e => e.MediaId).HasColumnName("media_id");

            builder.HasOne(e => e.Media).WithMany().HasForeignKey(e => e.MediaId);
            builder.HasOne(i => i.ProductionOrder).WithMany(p => p.PatternImages).HasForeignKey(i => i.ProductionOrderId);
        }
    }

    public class ProductionOrderConfigure : OrderEntityConfigure<ProductionOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionOrder> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_order");

            builder.Property(e => e.OrderType).HasColumnName("order_type").HasColumnType("int(11)");
            builder.Property(e => e.DateEndActual).HasColumnName("actual_end_date");
            builder.Property(e => e.QtyActual).HasColumnName("actual_qty").HasColumnType("int(11)");
            builder.Property(e => e.DateStartActual).HasColumnName("actual_start_date");

            builder.Property(e => e.BomOrderId)
                .HasColumnName("bom_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.QtyDefect)
                    .HasColumnName("defect_qty")
                    .HasColumnType("int(11)");

            builder.Property(e => e.FgMaterialId)
                .HasColumnName("fg_material_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.QtyFinished)
                .HasColumnName("finished_qty")
                .HasColumnType("int(11)");

            builder.Property(e => e.DateEndPlanned).HasColumnName("planned_end_date");

            builder.Property(e => e.QtyPlanned)
                .HasColumnName("planned_qty")
                .HasColumnType("int(11)");

            builder.Property(e => e.DateStartPlanned).HasColumnName("planned_start_date");

            builder.Property(e => e.Priority)
                .HasColumnName("priority")
                .HasColumnType("tinyint(4)");

            builder.Property(e => e.RequirementOrderNo)
                .HasColumnName("requirement_order_no")
                .HasColumnType("varchar(12)");

            builder.Property(e => e.RoutingOrderId)
                .HasColumnName("routing_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.ScheduleOrderNo)
                .HasColumnName("schedule_order_no")
                .HasColumnType("varchar(12)");

            builder.Property(e => e.SecondQualityQty)
                .HasColumnName("second_quality_qty")
                .HasColumnType("int(11)");

            builder.Property(e => e.WorkCenterId)
                    .HasColumnName("work_center_id")
                    .HasColumnType("bigint(20)");

            builder.HasOne(e => e.RoutingOrder).WithMany().HasForeignKey(e => e.RoutingOrderId);
            builder.HasOne(e => e.FgMaterial).WithMany().HasForeignKey(e => e.FgMaterialId);
            builder.HasOne(e => e.BomOrder).WithMany().HasForeignKey(e => e.BomOrderId);
            builder.HasMany(p => p.Sizes).WithOne(s => s.ProductionOrder).HasForeignKey(s => s.ProductionOrderId);
            builder.HasMany(p => p.Measures).WithOne(m => m.ProductionOrder).HasForeignKey(m => m.ProductionOrderId);
            builder.HasMany(p => p.PatternImages).WithOne(i => i.ProductionOrder).HasForeignKey(i => i.ProductionOrderId);
        }
    }
}
