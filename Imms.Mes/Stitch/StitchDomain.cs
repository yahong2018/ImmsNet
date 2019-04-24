using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Quality;
using Imms.Mes.Organization;
using Imms.Mes.Material;

namespace Imms.Mes.Stitch
{
    public partial class ProductionOrder : OrderEntity<long>
    {
        public string RequirementOrderNo { get; set; }
        public string ScheduleOrderNo { get; set; }
        public int OrderType { get; set; }
        public long FgMaterialId { get; set; }
        public byte Priority { get; set; }
        public long WorkCenterId { get; set; }
        public long? RoutingOrderId { get; set; }
        public long BomOrderId { get; set; }
        public int QtyPlanned { get; set; }
        public int QtyFinished { get; set; }
        public int QtySecondQuality { get; set; }
        public int QtyDefect { get; set; }
        public int QtyActual { get; set; }
        public DateTime TimeStartPlanned { get; set; }
        public DateTime TimeEndPlanned { get; set; }
        public DateTime? TimeStartActual { get; set; }
        public DateTime? TimeEndActual { get; set; }

        public virtual OperationRoutingOrder RoutingOrder { get; set; }
        public virtual Material.Material FgMaterial { get; set; }
        public virtual BomOrder BomOrder { get; set; }
        public virtual List<ProductionOrderSize> Sizes { get; set; } = new List<ProductionOrderSize>();
        public virtual List<ProductionOrderMeasure> Measures { get; set; } = new List<ProductionOrderMeasure>();
        public virtual List<ProductionOrderPatternRelation> PatternImages { get; set; } = new List<ProductionOrderPatternRelation>();
        public virtual List<QualityCheck> QualityChecks { get; set; } = new List<QualityCheck>();
        public virtual List<ProductionWorkOrder> WorkOrders { get; set; } = new List<ProductionWorkOrder>();
    }

    public partial class ProductionOrderSize : TrackableEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public string Size { get; set; }
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
        public long OperationRoutingOrderId { get; set; } //工艺
        public long CuttingOrderId { get; set; }
        public string Size { get; set; }
        public int QtyPlanned { get; set; }   //计划数量，针对单件流，则固定为1
        public int QtyFinished { get; set; }  //单件流，数量则为1
        public DateTime TimeStartPlanned { get; set; }
        public DateTime TimeEndPlanned { get; set; }
        public DateTime? TimeStartActual { get; set; }
        public DateTime? TimeEndActual { get; set; }
        public long CurrentRoutingId { get; set; }

        public virtual ProductionWorkOrderRouting CurrentRouting { get; set; }
        public virtual BomOrder WorkOrderBom { get; set; }
        public virtual ProductionOrder ProductionOrder { get; set; }
        public virtual OperationRoutingOrder OperationRoutingOrder { get; set; }
        public virtual List<ProductionWorkOrderRouting> ProductionWorkOrderRoutings { get; set; } = new List<ProductionWorkOrderRouting>();
    }

    //
    //缝制工艺报工单
    //
    public partial class ProductionWorkOrderRouting : TrackableEntity<long>
    {
        public long ProductionWorkOrderId { get; set; }
        public long OperationRoutingId { get; set; }
        public long? OperatorId { get; set; }
        public long? WorkStationId { get; set; }
        public int QtyScrap { get; set; }
        public int QtyPlanned { get; set; }
        public int QtyFinished { get; set; }
        public string ConatinerNo { get; set; }
        public DateTime? TimeScheduled { get; set; }
        public DateTime? TimeStarted { get; set; }
        public DateTime? TimeFinished { get; set; }
        public DateTime? TimePushedIn { get; set; }
        public DateTime? TimePushedOut { get; set; }

        public virtual ProductionWorkOrder ProductionWorkOrder { get; set; }
        public virtual OperationRouting OperationRouting { get; set; }
    }

    public partial class BaseOperation : TrackableEntity<long>
    {
        public string OperationNo { get; set; }
        public string Description { get; set; }

        public long MachineTypeId { get; set; }
        public double? StandardTime { get; set; }
        public double? StandardPrice { get; set; }
        public string SectionType { get; set; }
        public string SectionName { get; set; }
        public bool IsOutsource { get; set; }
        public string QaProcedure { get; set; }
        public string Requirement { get; set; }
        public string RequiredLevel { get; set; }

        public virtual EquipmentType MachineType { get; set; }
    }

    public partial class Operation : BaseOperation
    {
        public virtual List<OperationMedia> Medias { get; set; } = new List<OperationMedia>();
    }

    public class OperationMedia : TrackableEntity<long>
    {
        public long MediaId { get; set; }
        public long OperationId { get; set; }
        public int MediaType { get; set; }

        public virtual Media Media { get; set; }
        public virtual Operation Operation { get; set; }
    }

    public partial class OperationRouting : BaseOperation
    {
        public long OperationRoutingOrderId { get; set; }
        public long OperationId { get; set; }
        public long NextOperationId { get; set; }
        public string NextOpertionNo { get; set; }
        public long? NextRoutingId { get; set; }

        public virtual OperationRoutingOrder RoutingOrder { get; set; }
        public virtual OperationRouting NextRouting { get; set; }
        public virtual List<OperationRouting> PrevOpreatons { get; set; } = new List<OperationRouting>();

        public virtual Operation Operation { get; set; }
    }

    public partial class OperationRoutingOrder : OrderEntity<long>
    {
        public int OrderType { get; set; }
        public long MaterialId { get; set; }

        public virtual Material.Material Material { get; set; }
        public virtual List<OperationRouting> Routings { get; set; } = new List<OperationRouting>();
    }

    public class BaseOperationConfigure<E> : TrackableEntityConfigure<E> where E : BaseOperation
    {
        protected override void InternalConfigure(EntityTypeBuilder<E> builder)
        {
            base.InternalConfigure(builder);

            builder.Property(e => e.OperationNo).IsRequired().HasColumnName("operation_no").HasMaxLength(20).IsUnicode(false);
            builder.Property(e => e.Description).IsRequired().HasColumnName("description").HasMaxLength(3000).IsUnicode(false);
            builder.Property(e => e.MachineTypeId).HasColumnName("machine_type_id").HasColumnType("bigint(20)");
            builder.Property(e => e.IsOutsource).HasColumnName("is_outsource").HasColumnType("bit(1)");
            builder.Property(e => e.QaProcedure).HasColumnName("qa_procedure").HasMaxLength(1000).IsUnicode(false);
            builder.Property(e => e.SectionName).HasColumnName("section_name").HasMaxLength(30).IsUnicode(false);
            builder.Property(e => e.SectionType).HasColumnName("section_type").HasMaxLength(12).IsUnicode(false);
            builder.Property(e => e.Requirement).HasColumnName("requirement").HasMaxLength(1000).IsUnicode(false);
            builder.Property(e => e.RequiredLevel).HasColumnName("required_level");
            builder.Property(e => e.StandardPrice).HasColumnName("standard_price").HasColumnType("double(8,4)");
            builder.Property(e => e.StandardTime).HasColumnName("standard_time").HasColumnType("double(8,4)");

            builder.HasOne(e => e.MachineType).WithMany().HasForeignKey(e => e.MachineTypeId);
        }
    }

    public class OperationConfigure : BaseOperationConfigure<Operation>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Operation> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("operation");
            builder.HasMany(e => e.Medias).WithOne(e => e.Operation).HasForeignKey(e => e.OperationId);
        }
    }

    public class OpetaionMediaConfigure : TrackableEntityConfigure<OperationMedia>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperationMedia> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("operation_media");

            builder.Property(e => e.MediaId).HasColumnName("media_id");
            builder.Property(e => e.OperationId).HasColumnName("operation_id");
            builder.Property(e => e.MediaType).HasColumnName("media_type");

            builder.HasOne(e => e.Media).WithMany().HasForeignKey(e => e.MediaId);
        }
    }

    public class OperationRoutingConfigure : BaseOperationConfigure<OperationRouting>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperationRouting> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operation_routing");

            builder.Property(e => e.OperationId).HasColumnName("operation_id").HasColumnType("bigint(20)");
            builder.Property(e => e.OperationRoutingOrderId).HasColumnName("operation_routing_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.NextRoutingId).HasColumnName("next_routing_id").HasColumnType("int(11)");
            builder.Property(e => e.NextOperationId).HasColumnName("next_operation_id");
            builder.Property(e => e.NextOpertionNo).HasColumnName("next_operation_no").HasColumnType("varchar(20)");

            builder.HasOne(e => e.RoutingOrder).WithMany(e => e.Routings).HasForeignKey(e => e.OperationRoutingOrderId);
            builder.HasOne(e => e.NextRouting).WithMany(e => e.PrevOpreatons).HasForeignKey(e => e.NextRoutingId);
            builder.HasOne(e => e.Operation).WithMany().HasForeignKey(e => e.OperationId);
        }
    }

    public class OperationRoutingOrderConfigure : OrderEntityConfigure<OperationRoutingOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperationRoutingOrder> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operation_routing_order");

            builder.Property(e => e.MaterialId).HasColumnName("material_id").HasColumnType("bigint(20)");
            builder.Property(e => e.OrderType).HasColumnName("order_type").HasColumnType("int(11)");

            builder.HasOne(e => e.Material).WithMany().HasForeignKey(e => e.MaterialId);
            builder.HasMany(e => e.Routings).WithOne(e => e.RoutingOrder).HasForeignKey(e => e.OperationRoutingOrderId);
        }
    }

    public class ProductionWorkOrderRoutingConfigure : TrackableEntityConfigure<ProductionWorkOrderRouting>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionWorkOrderRouting> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_work_order_routing");

            builder.Property(e => e.ProductionWorkOrderId).HasColumnName("production_work_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.OperationRoutingId).HasColumnName("operation_routing_id").HasColumnType("bigint(20)");
            builder.Property(e => e.OperatorId).HasColumnName("operator_id").HasColumnType("bigint(20)");
            builder.Property(e => e.WorkStationId).HasColumnName("work_station_id").HasColumnType("bigint(20)");

            builder.Property(e => e.QtyScrap).HasColumnName("qty_scrap").HasColumnType("int(11)").HasDefaultValueSql("0");
            builder.Property(e => e.QtyFinished).HasColumnName("qty_finished").HasColumnType("int(11)").HasDefaultValueSql("0");
            builder.Property(e => e.QtyPlanned).HasColumnName("qty_planned").HasColumnType("int(11)").HasDefaultValueSql("0");

            builder.Property(e => e.TimeFinished).HasColumnName("time_finished");
            builder.Property(e => e.TimeStarted).HasColumnName("time_started");
            builder.Property(e => e.TimeScheduled).HasColumnName("time_scheduled");
            builder.Property(e => e.TimePushedIn).HasColumnName("time_pushed_in");
            builder.Property(e => e.TimePushedOut).HasColumnName("time_pushed_out");
            builder.Property(e => e.ConatinerNo).HasColumnName("container_no");


            builder.HasOne(e => e.ProductionWorkOrder).WithMany(e => e.ProductionWorkOrderRoutings)
                .HasForeignKey(e => e.ProductionWorkOrderId).HasConstraintName("production_work_order_id");

            builder.HasOne(e => e.OperationRouting).WithMany()
                .HasForeignKey(e => e.OperationRoutingId).HasConstraintName("operation_routing_id");
        }
    }

    public class ProductionWorkOrderConfigure : OrderEntityConfigure<ProductionWorkOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionWorkOrder> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_work_order");

            builder.Property(e => e.BomOrderId).HasColumnName("bom_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.CuttingOrderId).HasColumnName("cutting_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.OperationRoutingOrderId).HasColumnName("operation_routing_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.TimeEndPlanned).HasColumnName("time_end_planned");
            builder.Property(e => e.TimeStartPlanned).HasColumnName("time_start_planned");
            builder.Property(e => e.ProductionOrderId).HasColumnName("production_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.TimeEndActual).HasColumnName("time_end_actual");
            builder.Property(e => e.TimeStartActual).HasColumnName("time_start_actual");
            builder.Property(e => e.Size).HasColumnName("size");
            builder.Property(e => e.QtyPlanned).HasColumnName("qty_planned");
            builder.Property(e => e.QtyFinished).HasColumnName("qty_finished");
            builder.Property(e => e.CurrentRoutingId).HasColumnName("current_routing_id");

            builder.HasOne(e => e.CurrentRouting).WithMany().HasForeignKey(e => e.CurrentRoutingId).HasConstraintName("current_routing_id");
            builder.HasOne(e => e.ProductionOrder).WithMany(e => e.WorkOrders).HasForeignKey(e => e.ProductionOrderId).HasConstraintName("production_order_id");
            builder.HasOne(e => e.WorkOrderBom).WithMany().HasForeignKey(e => e.BomOrderId).HasConstraintName("bom_order_id");
            builder.HasOne(e => e.OperationRoutingOrder).WithMany().HasForeignKey(e => e.OperationRoutingOrderId).HasConstraintName("operation_routing_order_id");
        }
    }

    public class ProductionOrderSizeConfigure : TrackableEntityConfigure<ProductionOrderSize>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionOrderSize> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_order_size");

            builder.Property(e => e.ProductionOrderId).HasColumnName("production_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.QytPlanned).HasColumnName("qyt_planned").HasColumnType("int(11)");
            builder.Property(e => e.Size).HasColumnName("size").HasColumnType("varchar(20)");

            builder.HasOne(s => s.ProductionOrder).WithMany(p => p.Sizes).HasForeignKey(s => s.ProductionOrderId);
        }
    }

    public class ProductionOrderMeasureConfigure : TrackableEntityConfigure<ProductionOrderMeasure>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionOrderMeasure> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_order_measure");

            builder.Property(e => e.ProductionOrderId).HasColumnName("order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.BodyNo).IsRequired().HasColumnName("body_no").HasMaxLength(20).IsUnicode(false);
            builder.Property(e => e.MeasureData).HasColumnName("measure_data").HasColumnType("varchar(10)");
            builder.Property(e => e.GarmentSize).HasColumnName("garment_size").HasColumnType("varchar(10)");

            builder.HasOne(m => m.ProductionOrder).WithMany(p => p.Measures).HasForeignKey(m => m.ProductionOrderId);
        }
    }

    public class ProductionOrderPatternRelationConfigure : TrackableEntityConfigure<ProductionOrderPatternRelation>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionOrderPatternRelation> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_order_pattern_relation");

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
            builder.Property(e => e.ScheduleOrderNo).HasColumnName("schedule_order_no").HasColumnType("varchar(12)");
            builder.Property(e => e.RequirementOrderNo).HasColumnName("requirement_order_no").HasColumnType("varchar(12)");
            builder.Property(e => e.Priority).HasColumnName("priority").HasColumnType("tinyint(4)");
            builder.Property(e => e.RoutingOrderId).HasColumnName("routing_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.FgMaterialId).HasColumnName("fg_material_id").HasColumnType("bigint(20)");
            builder.Property(e => e.BomOrderId).HasColumnName("bom_order_id").HasColumnType("bigint(20)");

            builder.Property(e => e.WorkCenterId).HasColumnName("work_center_id").HasColumnType("bigint(20)");

            builder.Property(e => e.QtyPlanned).HasColumnName("qty_planned").HasColumnType("int(11)");
            builder.Property(e => e.QtyActual).HasColumnName("qty_actual").HasColumnType("int(11)");
            builder.Property(e => e.QtyFinished).HasColumnName("qty_finished").HasColumnType("int(11)");
            builder.Property(e => e.QtySecondQuality).HasColumnName("qty_second_quality").HasColumnType("int(11)");
            builder.Property(e => e.QtyDefect).HasColumnName("qty_defect").HasColumnType("int(11)");

            builder.Property(e => e.TimeStartPlanned).HasColumnName("time_start_planned");
            builder.Property(e => e.TimeEndPlanned).HasColumnName("time_end_planned");
            builder.Property(e => e.TimeStartActual).HasColumnName("time_start_actual");
            builder.Property(e => e.TimeEndActual).HasColumnName("time_end_actual");

            builder.HasOne(e => e.RoutingOrder).WithMany().HasForeignKey(e => e.RoutingOrderId);
            builder.HasOne(e => e.FgMaterial).WithMany().HasForeignKey(e => e.FgMaterialId);
            builder.HasOne(e => e.BomOrder).WithMany().HasForeignKey(e => e.BomOrderId);
            builder.HasMany(p => p.Sizes).WithOne(s => s.ProductionOrder).HasForeignKey(s => s.ProductionOrderId);
            builder.HasMany(p => p.Measures).WithOne(m => m.ProductionOrder).HasForeignKey(m => m.ProductionOrderId);
            builder.HasMany(p => p.PatternImages).WithOne(i => i.ProductionOrder).HasForeignKey(i => i.ProductionOrderId);
        }
    }
}
