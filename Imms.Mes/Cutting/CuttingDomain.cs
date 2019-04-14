using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Stitch;
using Imms.Mes.Picking;

namespace Imms.Mes.Cutting
{
    public partial class CuttingOrder : OrderEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public long PickingOrderId { get; set; }
        public string CuttingTableNo { get; set; }
        public long FgMaterialId { get; set; }//成品料号
        public string FabricMaterialType { get; set; }  //面料类型
        public long FabricMaterialId { get; set; }//面料物料主键

        public int Plies { get; set; }
        public double Width { get; set; }
        public double Length { get; set; }
        public double CuttingEfficiency { get; set; }

        public long? WorkStationId { get; set; }

        public int QtyPlanned { get; set; }
        public DateTime? TimetartPlanned { get; set; }
        public DateTime? TimeEndPlanned { get; set; }

        public string ContainerNo { get; set; }
        public DateTime? TimeStartActual { get; set; }
        public DateTime? TimeEndActual { get; set; }
        public int QtyActual { get; set; }
        public int QtyFinished { get; set; }
        public long OperatorId { get; set; }

        public virtual ProductionOrder ProductionOrder { get; set; }
        public virtual PickingOrder PickingOrder { get; set; }
        public virtual List<CuttingOrderSize> Sizes { get; set; } = new List<CuttingOrderSize>();
        public virtual List<CuttingMarker> Markers { get; set; } = new List<CuttingMarker>();
        public virtual List<CuttingOrderSpreadPly> SpreadPlies { get; set; } = new List<CuttingOrderSpreadPly>();
    }

    public partial class CuttingOrderSize : TrackableEntity<long>
    {
        public long CuttingOrderId { get; set; }
        public string Size { get; set; }
        public int QtyLayer { get; set; }
        public int QtyPlanned { get; set; }
        public int QtyFinished { get; set; }
        // public int? QtyCreatedWorkOrder { get; set; }

        public virtual CuttingOrder CuttingOrder { get; set; }
    }

    public partial class CuttingMarker : TrackableEntity<long>
    {
        public long CuttingOrderId { get; set; }
        public long MediaId { get; set; }
        public string Remark { get; set; }
        public long MarkerFileId { get; set; }

        public virtual CuttingOrder CuttingOrder { get; set; }
        public virtual Media Media { get; set; }
        public virtual Media MarkFile { get; set; }
    }

    public partial class CuttingOrderSpreadPly : TrackableEntity<long>
    {
        public long CuttingOrderId { get; set; }
        public double Length { get; set; }
        public int Plies { get; set; }

        public virtual CuttingOrder CuttingOrder { get; set; }
    }

    public class CuttingOrderSpreadPlyConfigure : TrackableEntityConfigure<CuttingOrderSpreadPly>
    {
        protected override void InternalConfigure(EntityTypeBuilder<CuttingOrderSpreadPly> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("cutting_marker");
            builder.Property(e => e.CuttingOrderId).HasColumnName("cutting_order_id");
            builder.Property(e => e.Length).HasColumnName("length");
            builder.Property(e => e.Plies).HasColumnName("plies");

            builder.HasOne(e => e.CuttingOrder).WithMany(e => e.SpreadPlies).HasForeignKey(e => e.CuttingOrderId);
        }
    }


    public class CuttingMarkerConfigure : TrackableEntityConfigure<CuttingMarker>
    {
        protected override void InternalConfigure(EntityTypeBuilder<CuttingMarker> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("cutting_marker");
            builder.Property(e => e.CuttingOrderId).HasColumnName("cutting_order_id");
            builder.Property(e => e.MarkerFileId).HasColumnName("marker_file_id");
            builder.Property(e => e.MediaId).HasColumnName("media_id");
            builder.Property(e => e.Remark).HasColumnName("remark").HasMaxLength(255);

            builder.HasOne(e => e.CuttingOrder).WithMany(e => e.Markers).HasForeignKey(e => e.CuttingOrderId);
            builder.HasOne(e => e.Media).WithMany().HasForeignKey(e => e.MediaId);
            builder.HasOne(e => e.MarkFile).WithMany().HasForeignKey(e => e.MarkerFileId);
        }
    }

    public class CuttingOrderSizeConfigure : TrackableEntityConfigure<CuttingOrderSize>
    {
        protected override void InternalConfigure(EntityTypeBuilder<CuttingOrderSize> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("cutting_order_size");

            builder.Property(e => e.QtyFinished).HasColumnName("actual_qty").HasColumnType("int(11)");
            builder.Property(e => e.CuttingOrderId).HasColumnName("cutting_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.QtyLayer).HasColumnName("layer_qty").HasColumnType("int(11)");
            builder.Property(e => e.QtyPlanned).HasColumnName("planned_qty").HasColumnType("int(11)");
            builder.Property(e => e.Size).HasColumnName("size").HasMaxLength(10).IsUnicode(false);
            builder.HasOne(e => e.CuttingOrder).WithMany(e => e.Sizes).HasForeignKey(e => e.CuttingOrderId);
        }
    }

    public class CuttingOrderConfigure : OrderEntityConfigure<CuttingOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<CuttingOrder> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("cutting_order");
            builder.Property(e => e.ProductionOrderId).HasColumnName("production_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.PickingOrderId).HasColumnName("picking_order_id").HasColumnType("bigint(20)");
            builder.Property(e => e.ContainerNo).HasColumnName("container_no").HasMaxLength(64).IsUnicode(false);
            builder.Property(e => e.CuttingTableNo).HasColumnName("cutting_table_no").HasMaxLength(64).IsUnicode(false);
            builder.Property(e => e.Plies).HasColumnName("plies").HasColumnType("int(11)");
            builder.Property(e => e.Width).HasColumnName("width").HasColumnType("double(8,4)");

            builder.Property(e => e.FabricMaterialId).HasColumnName("fabric_material_id").HasColumnType("bigint(20)");
            builder.Property(e => e.FabricMaterialType).IsRequired().HasColumnName("fabric_material_type").HasMaxLength(64).IsUnicode(false);
            builder.Property(e => e.FgMaterialId).IsRequired().HasColumnName("fg_material_id").HasMaxLength(64).IsUnicode(false);
            builder.Property(e => e.Length).HasColumnName("length").HasColumnType("double(8,4)");
            builder.Property(e => e.CuttingEfficiency).HasColumnName("cutting_efficiency").HasColumnType("double(7,4)");

            builder.Property(e => e.WorkStationId).HasColumnName("work_station_id").HasColumnType("bigint(20)");
            builder.Property(e => e.TimetartPlanned).HasColumnName("time_start_planned");
            builder.Property(e => e.TimeEndPlanned).HasColumnName("time_end_planned");
            builder.Property(e => e.QtyPlanned).HasColumnName("qty_planned").HasColumnType("int(11)").HasDefaultValueSql("0");

            builder.Property(e => e.TimeStartActual).HasColumnName("time_start_actual");
            builder.Property(e => e.TimeEndActual).HasColumnName("time_end_actual");
            builder.Property(e => e.QtyActual).HasColumnName("qty_actual").HasColumnType("int(11)").HasDefaultValueSql("0");
            builder.Property(e => e.QtyFinished).HasColumnName("qty_finished").HasColumnType("int(11)").HasDefaultValueSql("0");

            builder.Property(e => e.OperatorId).HasColumnName("operator_id").HasColumnType("bigint(20)");

            builder.HasOne(e => e.ProductionOrder).WithMany().HasForeignKey(e => e.ProductionOrderId);
            builder.HasOne(e => e.PickingOrder).WithMany().HasForeignKey(e => e.PickingOrderId);
            builder.HasMany(e => e.Sizes).WithOne(e => e.CuttingOrder).HasForeignKey(e => e.CuttingOrderId);
            builder.HasMany(e => e.Markers).WithOne(e => e.CuttingOrder).HasForeignKey(e => e.CuttingOrderId);
            builder.HasMany(e => e.SpreadPlies).WithOne(e => e.CuttingOrder).HasForeignKey(e => e.CuttingOrderId);
        }
    }
}
