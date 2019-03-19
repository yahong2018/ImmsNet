using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Imms.Data.Domain;

namespace Imms.Data
{
    public partial class ImmsDbContext : DbContext
    {
        public ImmsDbContext()
        {
        }

        public ImmsDbContext(DbContextOptions<ImmsDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Bom> Bom { get; set; }
        public virtual DbSet<BomOrder> BomOrder { get; set; }
        public virtual DbSet<CodeSeed> CodeSeed { get; set; }
        public virtual DbSet<CuttingMarker> CuttingMarker { get; set; }
        public virtual DbSet<CuttingOrder> CuttingOrder { get; set; }
        public virtual DbSet<CuttingOrderSize> CuttingOrderSize { get; set; }
        public virtual DbSet<Material> Material { get; set; }
        public virtual DbSet<MaterialPickingOrder> MaterialPickingOrder { get; set; }
        public virtual DbSet<MaterialPickingOrderDetail> MaterialPickingOrderDetail { get; set; }
        public virtual DbSet<MaterialPickingSchedule> MaterialPickingSchedule { get; set; }
        public virtual DbSet<MaterialPickingScheduleBom> MaterialPickingScheduleBom { get; set; }
        public virtual DbSet<Media> Media { get; set; }
        public virtual DbSet<Operation> Operation { get; set; }
        public virtual DbSet<OperationRouting> OperationRouting { get; set; }
        public virtual DbSet<OperationRoutingOrder> OperationRoutingOrder { get; set; }
        public virtual DbSet<Operator> Operator { get; set; }
        public virtual DbSet<OperatorCapability> OperatorCapability { get; set; }
        public virtual DbSet<OrderMeasure> OrderMeasure { get; set; }
        public virtual DbSet<OrderSize> OrderSize { get; set; }
        public virtual DbSet<PlanCode> PlanCode { get; set; }
        public virtual DbSet<ProductionOrder> ProductionOrder { get; set; }
        public virtual DbSet<ProductionWorkOrder> ProductionWorkOrder { get; set; }
        public virtual DbSet<ProductionWorkOrderRouting> ProductionWorkOrderRouting { get; set; }
        public virtual DbSet<ProgramPrivilege> ProgramPrivilege { get; set; }
        public virtual DbSet<RequirementOrder> RequirementOrder { get; set; }
        public virtual DbSet<RolePrivilege> RolePrivilege { get; set; }
        public virtual DbSet<RoleUser> RoleUser { get; set; }
        public virtual DbSet<ScheduleOrder> ScheduleOrder { get; set; }
        public virtual DbSet<SystemProgram> SystemProgram { get; set; }
        public virtual DbSet<SystemRole> SystemRole { get; set; }
        public virtual DbSet<SystemUser> SystemUser { get; set; }
        public virtual DbSet<TreeCode> TreeCode { get; set; }
        public virtual DbSet<WorkOrganizationUnit> WorkOrganizationUnit { get; set; }
        public virtual DbSet<WorkstationCheckIn> WorkstationCheckIn { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseMySQL("server=localhost;user=root;database=Imms_Dev;port=3306;password=root");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.3-servicing-35854");

            modelBuilder.Entity<Bom>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("bom", "Imms_Dev");

                entity.HasIndex(e => e.BomOrderId)
                    .HasName("IDX_BOM_04");

                entity.HasIndex(e => e.ComponentAbstractMaterialId)
                    .HasName("IDX_BOM_02");

                entity.HasIndex(e => e.ComponentMaterialId)
                    .HasName("IDX_BOM_01");

                entity.HasIndex(e => e.ParentBomId)
                    .HasName("IDX_BOM_03");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.BomOrderId)
                    .HasColumnName("bom_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ComponentAbstractMaterialId)
                    .HasColumnName("component_abstract_material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ComponentMaterialId)
                    .HasColumnName("component_material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ComponentMaterialNamePath)
                    .IsRequired()
                    .HasColumnName("component_material_name_path")
                    .HasMaxLength(330)
                    .IsUnicode(false);

                entity.Property(e => e.ComponentMaterialNoPath)
                    .IsRequired()
                    .HasColumnName("component_material_no_path")
                    .HasMaxLength(130)
                    .IsUnicode(false);

                entity.Property(e => e.ComponentQty)
                    .HasColumnName("component_qty")
                    .HasColumnType("float(8,2)");

                entity.Property(e => e.ComponentUnitId)
                    .HasColumnName("component_unit_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.IsFabric)
                    .HasColumnName("is_fabric")
                    .HasColumnType("bit(1)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.ParentBomId)
                    .HasColumnName("parent_bom_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<BomOrder>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("bom_order", "Imms_Dev");

                entity.HasIndex(e => e.MaterialId)
                    .HasName("IDX_BOM_ORDER_03");

                entity.HasIndex(e => e.OrderNo)
                    .HasName("IDX_BOM_ORDER_01");

                entity.HasIndex(e => e.OrderStatus)
                    .HasName("IDX_BOM_ORDER_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.BomOrderType)
                    .HasColumnName("bom_order_type")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.MaterialId)
                    .HasColumnName("material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderNo)
                    .IsRequired()
                    .HasColumnName("order_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<CodeSeed>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("code_seed", "Imms_Dev");

                entity.HasIndex(e => e.SeedNo)
                    .HasName("IDX_CODE_SEED_0");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.InitialValue)
                    .HasColumnName("initial_value")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Postfix)
                    .IsRequired()
                    .HasColumnName("postfix")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Prefix)
                    .IsRequired()
                    .HasColumnName("prefix")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.SeedName)
                    .IsRequired()
                    .HasColumnName("seed_name")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.SeedNo)
                    .IsRequired()
                    .HasColumnName("seed_no")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.TotalLength)
                    .HasColumnName("total_length")
                    .HasColumnType("int(11)");
            });

            modelBuilder.Entity<CuttingMarker>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("cutting_marker", "Imms_Dev");

                entity.HasIndex(e => e.CuttingOrderId)
                    .HasName("idx_cutting_marker_01");

                entity.HasIndex(e => e.MediaId)
                    .HasName("idx_cutting_marker_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.CuttingOrderId)
                    .HasColumnName("cutting_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.MarkerFileId)
                    .HasColumnName("marker_file_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.MediaId)
                    .HasColumnName("media_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Remark)
                    .HasColumnName("remark")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<CuttingOrder>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("cutting_order", "Imms_Dev");

                entity.HasIndex(e => e.ContainerNo)
                    .HasName("idx_cutting_order_04");

                entity.HasIndex(e => e.OrderNo)
                    .HasName("idx_cutting_order_01");

                entity.HasIndex(e => e.ProductionOrderId)
                    .HasName("idx_cutting_order_02");

                entity.HasIndex(e => e.WorkStationId)
                    .HasName("idx_cutting_order_03");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ActualCuttingDate).HasColumnName("actual_cutting_date");

                entity.Property(e => e.ActualEndDate).HasColumnName("actual_end_date");

                entity.Property(e => e.ContainerNo)
                    .HasColumnName("container_no")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.CuttingEfficiency)
                    .HasColumnName("cutting_efficiency")
                    .HasColumnType("double(7,4)");

                entity.Property(e => e.CuttingTableNo)
                    .HasColumnName("cutting_table_no")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.FabricMaterialId)
                    .HasColumnName("fabric_material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.FabricMaterialType)
                    .IsRequired()
                    .HasColumnName("fabric_material_type")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.FgMaterialId)
                    .IsRequired()
                    .HasColumnName("fg_material_id")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.FinishedQty)
                    .HasColumnName("finished_qty")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Length)
                    .HasColumnName("length")
                    .HasColumnType("double(8,4)");

                entity.Property(e => e.OperatorId)
                    .HasColumnName("operator_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderNo)
                    .IsRequired()
                    .HasColumnName("order_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.PlannedCuttingDate).HasColumnName("planned_cutting_date");

                entity.Property(e => e.PlannedEndDate).HasColumnName("planned_end_date");

                entity.Property(e => e.PlannedQty)
                    .HasColumnName("planned_qty")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Plies)
                    .HasColumnName("plies")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ProductionOrderId)
                    .HasColumnName("production_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");

                entity.Property(e => e.Width)
                    .HasColumnName("width")
                    .HasColumnType("double(8,4)");

                entity.Property(e => e.WorkStationId)
                    .HasColumnName("work_station_id")
                    .HasColumnType("bigint(20)");
            });

            modelBuilder.Entity<CuttingOrderSize>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("cutting_order_size", "Imms_Dev");

                entity.HasIndex(e => e.CuttingOrderId)
                    .HasName("idx_cutting_order_size_01");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ActualQty)
                    .HasColumnName("actual_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.CreatedWorkOrderQty)
                    .HasColumnName("created_work_order_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CuttingOrderId)
                    .HasColumnName("cutting_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.LayerQty)
                    .HasColumnName("layer_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.PlannedQty)
                    .HasColumnName("planned_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Size)
                    .HasColumnName("size")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<Material>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("material", "Imms_Dev");

                entity.HasIndex(e => e.MaterialName)
                    .HasName("IDX_MATERIAL_02");

                entity.HasIndex(e => e.MaterialNo)
                    .HasName("IDX_MATERIAL_01");

                entity.HasIndex(e => e.MaterialTypeId)
                    .HasName("IDX_MATERIAL_03");

                entity.HasIndex(e => e.SizeId)
                    .HasName("IDX_MATERIAL_04");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.Color)
                    .HasColumnName("color")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(250)
                    .IsUnicode(false);

                entity.Property(e => e.MaterialName)
                    .IsRequired()
                    .HasColumnName("material_name")
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.MaterialNo)
                    .IsRequired()
                    .HasColumnName("material_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.MaterialTypeId)
                    .HasColumnName("material_type_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.Price)
                    .HasColumnName("price")
                    .HasColumnType("decimal(10,2)");

                entity.Property(e => e.SizeId)
                    .HasColumnName("size_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UnitId)
                    .HasColumnName("unit_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");

                entity.Property(e => e.Weight)
                    .HasColumnName("weight")
                    .HasColumnType("decimal(10,4)");

                entity.Property(e => e.Width)
                    .HasColumnName("width")
                    .HasColumnType("decimal(10,4)");
            });

            modelBuilder.Entity<MaterialPickingOrder>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("material_picking_order", "Imms_Dev");

                entity.HasIndex(e => e.ContainerNo)
                    .HasName("idx_material_picking_order_02");

                entity.HasIndex(e => e.OperatorId)
                    .HasName("idx_material_picking_order_03");

                entity.HasIndex(e => e.OrderNo)
                    .HasName("idx_material_picking_order_01");

                entity.HasIndex(e => e.PickingScheduleId)
                    .HasName("idx_material_picking_order_04");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ContainerNo)
                    .IsRequired()
                    .HasColumnName("container_no")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.OperatorId)
                    .HasColumnName("operator_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderNo)
                    .IsRequired()
                    .HasColumnName("order_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.PickingScheduleId)
                    .HasColumnName("picking_schedule_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<MaterialPickingOrderDetail>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("material_picking_order_detail", "Imms_Dev");

                entity.HasIndex(e => e.MaterialId)
                    .HasName("idx_material_picking_order_detail_02");

                entity.HasIndex(e => e.MaterialPickingOrderId)
                    .HasName("idx_material_picking_order_detail_01");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.MaterialId)
                    .HasColumnName("material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.MaterialPickingOrderId)
                    .HasColumnName("material_picking_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.PickedQty)
                    .HasColumnName("picked_qty")
                    .HasColumnType("double(10,4)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<MaterialPickingSchedule>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("material_picking_schedule", "Imms_Dev");

                entity.HasIndex(e => e.OrderNo)
                    .HasName("idx_material_picking_schedule_01");

                entity.HasIndex(e => e.ProductionOrderId)
                    .HasName("idx_material_picking_schedule_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderNo)
                    .IsRequired()
                    .HasColumnName("order_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ProductionOrderId)
                    .HasColumnName("production_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<MaterialPickingScheduleBom>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("material_picking_schedule_bom", "Imms_Dev");

                entity.HasIndex(e => e.ComponentMaterialId)
                    .HasName("idx_material_picking_schedule_bom_01");

                entity.HasIndex(e => e.MaterialPickingOrderId)
                    .HasName("idx_material_picking_schedule_bom_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ComponentMaterialId)
                    .HasColumnName("component_material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ComponentMaterialUomId)
                    .HasColumnName("component_material_uom_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.MaterialPickingOrderId)
                    .HasColumnName("material_picking_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.PickedQty)
                    .HasColumnName("picked_qty")
                    .HasColumnType("double(8,2)");

                entity.Property(e => e.Qty)
                    .HasColumnName("qty")
                    .HasColumnType("double(8,2)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<Media>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("media", "Imms_Dev");

                entity.HasIndex(e => e.BelongToId)
                    .HasName("IDX_MEDIA_1");

                entity.HasIndex(e => e.MediaName)
                    .HasName("IDX_MEDIA_0");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.BelongToId)
                    .HasColumnName("belong_to_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(250)
                    .IsUnicode(false);

                entity.Property(e => e.MediaName)
                    .IsRequired()
                    .HasColumnName("media_name")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.MediaSize)
                    .HasColumnName("media_size")
                    .HasColumnType("int(11)");

                entity.Property(e => e.MediaType)
                    .HasColumnName("media_type")
                    .HasColumnType("int(11)");

                entity.Property(e => e.MediaUrl)
                    .IsRequired()
                    .HasColumnName("media_url")
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Operation>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("operation", "Imms_Dev");

                entity.HasIndex(e => e.MachineTypeId)
                    .HasName("IDX_OPERATION_02");

                entity.HasIndex(e => e.OperationNo)
                    .HasName("IDX_OPERATION_01");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.IsOutsource)
                    .HasColumnName("is_outsource")
                    .HasColumnType("bit(1)");

                entity.Property(e => e.MachineTypeId)
                    .HasColumnName("machine_type_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OperationName)
                    .IsRequired()
                    .HasColumnName("operation_name")
                    .HasMaxLength(120)
                    .IsUnicode(false);

                entity.Property(e => e.OperationNo)
                    .IsRequired()
                    .HasColumnName("operation_no")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.PartType)
                    .HasColumnName("part_type")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.QaProcedure)
                    .HasColumnName("qa_procedure")
                    .HasMaxLength(1000)
                    .IsUnicode(false);

                entity.Property(e => e.QualityRequirement)
                    .HasColumnName("quality_requirement")
                    .HasMaxLength(1000)
                    .IsUnicode(false);

                entity.Property(e => e.SectionName)
                    .HasColumnName("section_name")
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.SectionType)
                    .HasColumnName("section_type")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.SkillLevel)
                    .HasColumnName("skill_level")
                    .HasColumnType("tinyint(4)");

                entity.Property(e => e.StandardOperationProcedure)
                    .HasColumnName("standard_operation_procedure")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.StandardPrice)
                    .HasColumnName("standard_price")
                    .HasColumnType("double(8,4)");

                entity.Property(e => e.StandardTime)
                    .HasColumnName("standard_time")
                    .HasColumnType("double(8,4)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<OperationRouting>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("operation_routing", "Imms_Dev");

                entity.HasIndex(e => e.OperationId)
                    .HasName("IDX_OPERATION_ROUTING_01");

                entity.HasIndex(e => e.OperationRoutingOrderId)
                    .HasName("IDX_OPERATION_ROUTING_02");

                entity.HasIndex(e => e.PreRoutingId)
                    .HasName("IDX_OPERATION_ROUTING_03");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.OperationId)
                    .HasColumnName("operation_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OperationRoutingOrderId)
                    .HasColumnName("operation_routing_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.PreRoutingId)
                    .HasColumnName("pre_routing_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.SequenceNo)
                    .HasColumnName("sequence_no")
                    .HasColumnType("int(11)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<OperationRoutingOrder>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("operation_routing_order", "Imms_Dev");

                entity.HasIndex(e => e.MaterialId)
                    .HasName("IDX_OPERATION_ROUTING_ORDER_02");

                entity.HasIndex(e => e.OrderNo)
                    .HasName("IDX_OPERATION_ROUTING_ORDER_01");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.MaterialId)
                    .HasColumnName("material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderNo)
                    .IsRequired()
                    .HasColumnName("order_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.OrderType)
                    .HasColumnName("order_type")
                    .HasColumnType("int(11)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<Operator>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("operator", "Imms_Dev");

                entity.HasIndex(e => e.OrganizationId)
                    .HasName("IDX_OPERATOR_02");

                entity.HasIndex(e => e.SupervisorId)
                    .HasName("IDX_OPERATOR_03");

                entity.HasIndex(e => e.UserId)
                    .HasName("IDX_OPERATOR_01");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrganizationId)
                    .HasColumnName("organization_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.SupervisorId)
                    .HasColumnName("supervisor_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");

                entity.Property(e => e.UserId)
                    .HasColumnName("user_id")
                    .HasColumnType("bigint(20)");
            });

            modelBuilder.Entity<OperatorCapability>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("operator_capability", "Imms_Dev");

                entity.HasIndex(e => e.OperationId)
                    .HasName("IDX_OPERATOR_CAPABILITY_02");

                entity.HasIndex(e => e.OperatorId)
                    .HasName("IDX_OPERATOR_CAPABILITY_01");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.OperationId)
                    .HasColumnName("operation_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OperatorId)
                    .HasColumnName("operator_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.SkillLevel)
                    .HasColumnName("skill_level")
                    .HasColumnType("tinyint(4)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<OrderMeasure>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("order_measure", "Imms_Dev");

                entity.HasIndex(e => e.OrderId)
                    .HasName("idx_order_measure_01");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.BodyNo)
                    .IsRequired()
                    .HasColumnName("body_no")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.MeasureData)
                    .HasColumnName("measure_data")
                    .HasColumnType("int(11)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderId)
                    .HasColumnName("order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<OrderSize>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("order_size", "Imms_Dev");

                entity.HasIndex(e => e.OrderId)
                    .HasName("idx_order_size_01");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderId)
                    .HasColumnName("order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.QytPlanned)
                    .HasColumnName("qyt_planned")
                    .HasColumnType("int(11)");

                entity.Property(e => e.SizeCode)
                    .IsRequired()
                    .HasColumnName("size_code")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.SizeId)
                    .HasColumnName("size_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<PlanCode>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("plan_code", "Imms_Dev");

                entity.HasIndex(e => e.CodeName)
                    .HasName("IDX_PLAN_CODE_02");

                entity.HasIndex(e => e.CodeNo)
                    .HasName("IDX_PLAN_CODE_01");

                entity.HasIndex(e => e.CodeType)
                    .HasName("IDX_PLAN_CODE_03");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CodeName)
                    .IsRequired()
                    .HasColumnName("code_name")
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.CodeNo)
                    .IsRequired()
                    .HasColumnName("code_no")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.CodeType)
                    .HasColumnName("code_type")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(250)
                    .IsUnicode(false);

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<ProductionOrder>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("production_order", "Imms_Dev");

                entity.HasIndex(e => e.FgMaterialId)
                    .HasName("idx_production_order_03");

                entity.HasIndex(e => e.OrderNo)
                    .HasName("idx_production_order_01");

                entity.HasIndex(e => e.OrderStatus)
                    .HasName("idx_production_order_04");

                entity.HasIndex(e => e.RequirementOrderId)
                    .HasName("idx_production_order_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ActualEndDate).HasColumnName("actual_end_date");

                entity.Property(e => e.ActualQty)
                    .HasColumnName("actual_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ActualStartDate).HasColumnName("actual_start_date");

                entity.Property(e => e.BomOrderId)
                    .HasColumnName("bom_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.DefectQty)
                    .HasColumnName("defect_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.FgMaterialId)
                    .HasColumnName("fg_material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.FinishedQty)
                    .HasColumnName("finished_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderNo)
                    .IsRequired()
                    .HasColumnName("order_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.PlannedEndDate).HasColumnName("planned_end_date");

                entity.Property(e => e.PlannedQty)
                    .HasColumnName("planned_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.PlannedStartDate).HasColumnName("planned_start_date");

                entity.Property(e => e.Priority)
                    .HasColumnName("priority")
                    .HasColumnType("tinyint(4)");

                entity.Property(e => e.RequirementOrderId)
                    .HasColumnName("requirement_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.RoutingOrderId)
                    .HasColumnName("routing_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ScheduleOrderId)
                    .HasColumnName("schedule_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.SecondQualityQty)
                    .HasColumnName("second_quality_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");

                entity.Property(e => e.WorkCenterId)
                    .HasColumnName("work_center_id")
                    .HasColumnType("bigint(20)");
            });

            modelBuilder.Entity<ProductionWorkOrder>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("production_work_order", "Imms_Dev");

                entity.HasIndex(e => e.OrderNo)
                    .HasName("idx_pro_work_order_01");

                entity.HasIndex(e => e.PlannedEndDate)
                    .HasName("idx_pro_work_order_04");

                entity.HasIndex(e => e.PlannedStartDate)
                    .HasName("idx_pro_work_order_03");

                entity.HasIndex(e => e.ProductionOrderId)
                    .HasName("idx_pro_work_order_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ActualEndDate).HasColumnName("actual_end_date");

                entity.Property(e => e.ActualStartDate).HasColumnName("actual_start_date");

                entity.Property(e => e.BomOrderId)
                    .HasColumnName("bom_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.CuttingOrderId)
                    .HasColumnName("cutting_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OperationRoutingOrderId)
                    .HasColumnName("operation_routing_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderNo)
                    .IsRequired()
                    .HasColumnName("order_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.PlannedEndDate).HasColumnName("planned_end_date");

                entity.Property(e => e.PlannedStartDate).HasColumnName("planned_start_date");

                entity.Property(e => e.ProductionOrderId)
                    .HasColumnName("production_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.SizeId)
                    .HasColumnName("size_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.SynFinishStatus)
                    .HasColumnName("syn_finish_status")
                    .HasColumnType("tinyint(4)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<ProductionWorkOrderRouting>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("production_work_order_routing", "Imms_Dev");

                entity.HasIndex(e => e.OperationRoutingOrderId)
                    .HasName("idx_production_work_order_routing_01");

                entity.HasIndex(e => e.OrderStatus)
                    .HasName("idx_production_work_order_routing_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CompleteQty)
                    .HasColumnName("complete_qty")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.CompleteTime).HasColumnName("complete_time");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.OperationRoutingId)
                    .HasColumnName("operation_routing_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OperationRoutingOrderId)
                    .HasColumnName("operation_routing_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OperatorId)
                    .HasColumnName("operator_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ProductionWorkOrderId)
                    .HasColumnName("production_work_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.ScrapQty)
                    .HasColumnName("scrap_qty")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.StartTime).HasColumnName("start_time");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");

                entity.Property(e => e.WorkStationId)
                    .HasColumnName("work_station_id")
                    .HasColumnType("bigint(20)");
            });

            modelBuilder.Entity<ProgramPrivilege>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("program_privilege", "Imms_Dev");

                entity.HasIndex(e => e.PrivilegeCode)
                    .HasName("IDX_PROGRAM_PRIVILEGE_1");

                entity.HasIndex(e => e.ProgramId)
                    .HasName("IDX_PROGRAM_PRIVILEGE_0");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.PrivilegeCode)
                    .IsRequired()
                    .HasColumnName("privilege_code")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.PrivilegeName)
                    .IsRequired()
                    .HasColumnName("privilege_name")
                    .HasMaxLength(120)
                    .IsUnicode(false);

                entity.Property(e => e.ProgramId)
                    .IsRequired()
                    .HasColumnName("program_id")
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<RequirementOrder>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("requirement_order", "Imms_Dev");

                entity.HasIndex(e => e.OrderNo)
                    .HasName("idx_requirement_order_01");

                entity.HasIndex(e => e.WorkCenterId)
                    .HasName("idx_requirement_order_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.FgMaterialId)
                    .HasColumnName("fg_material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderNo)
                    .IsRequired()
                    .HasColumnName("order_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.OrderType)
                    .HasColumnName("order_type")
                    .HasColumnType("int(11)");

                entity.Property(e => e.PlannedQty)
                    .HasColumnName("planned_qty")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Priority)
                    .HasColumnName("priority")
                    .HasColumnType("int(11)");

                entity.Property(e => e.RepeatType)
                    .HasColumnName("repeat_type")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.RequiredDeliveryDate).HasColumnName("required_delivery_date");

                entity.Property(e => e.SaleOrderNo)
                    .HasColumnName("sale_order_no")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");

                entity.Property(e => e.WorkCenterId)
                    .HasColumnName("work_center_id")
                    .HasColumnType("bigint(20)");
            });

            modelBuilder.Entity<RolePrivilege>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("role_privilege", "Imms_Dev");

                entity.HasIndex(e => e.ProgramId)
                    .HasName("IDX_ROLE_PRIVILEGE_1");

                entity.HasIndex(e => e.RoleId)
                    .HasName("IDX_ROLE_PRIVILEGE_0");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.PrivilegeCode)
                    .IsRequired()
                    .HasColumnName("privilege_code")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ProgramId)
                    .IsRequired()
                    .HasColumnName("program_id")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ProgramPrivilegeId)
                    .HasColumnName("program_privilege_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.RoleId)
                    .HasColumnName("role_id")
                    .HasColumnType("bigint(20)");
            });

            modelBuilder.Entity<RoleUser>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("role_user", "Imms_Dev");

                entity.HasIndex(e => e.RoleId)
                    .HasName("IDX_ROLE_USER_0");

                entity.HasIndex(e => e.UserId)
                    .HasName("IDX_ROLE_USER_1");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.RoleId)
                    .HasColumnName("role_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UserId)
                    .HasColumnName("user_id")
                    .HasColumnType("bigint(20)");
            });

            modelBuilder.Entity<ScheduleOrder>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("schedule_order", "Imms_Dev");

                entity.HasIndex(e => e.FgMaterialId)
                    .HasName("idx_schedule_order_03");

                entity.HasIndex(e => e.OrderNo)
                    .HasName("idx_schedule_order_01");

                entity.HasIndex(e => e.OrderStatus)
                    .HasName("idx_schedule_order_04");

                entity.HasIndex(e => e.RequirementOrderId)
                    .HasName("idx_schedule_order_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.DateActualEnd).HasColumnName("date_actual_end");

                entity.Property(e => e.DateActualStart).HasColumnName("date_actual_start");

                entity.Property(e => e.DatePlanEnd).HasColumnName("date_plan_end");

                entity.Property(e => e.DatePlanStart).HasColumnName("date_plan_start");

                entity.Property(e => e.FgMaterialId)
                    .HasColumnName("fg_material_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrderNo)
                    .IsRequired()
                    .HasColumnName("order_no")
                    .HasMaxLength(12)
                    .IsUnicode(false);

                entity.Property(e => e.OrderStatus)
                    .HasColumnName("order_status")
                    .HasColumnType("int(11)");

                entity.Property(e => e.PlanId)
                    .HasColumnName("plan_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.Priority)
                    .HasColumnName("priority")
                    .HasColumnType("tinyint(4)");

                entity.Property(e => e.QtyActual)
                    .HasColumnName("qty_actual")
                    .HasColumnType("int(11)");

                entity.Property(e => e.QtyPlanned)
                    .HasColumnName("qty_planned")
                    .HasColumnType("int(11)");

                entity.Property(e => e.RequirementOrderId)
                    .HasColumnName("requirement_order_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");

                entity.Property(e => e.WorkCenterId)
                    .HasColumnName("work_center_id")
                    .HasColumnType("bigint(20)");
            });

            modelBuilder.Entity<SystemProgram>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("system_program", "Imms_Dev");

                entity.HasIndex(e => e.ParentId)
                    .HasName("IDX_SYSTEM_PROGRAM_1");

                entity.HasIndex(e => e.ProgramCode)
                    .HasName("IDX_SYSTEM_PROGRAM_0");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Glyph)
                    .HasColumnName("glyph")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Parameters)
                    .IsRequired()
                    .HasColumnName("parameters")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.ParentId)
                    .IsRequired()
                    .HasColumnName("parent_id")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ProgramCode)
                    .IsRequired()
                    .HasColumnName("program_code")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ProgramName)
                    .IsRequired()
                    .HasColumnName("program_name")
                    .HasMaxLength(120)
                    .IsUnicode(false);

                entity.Property(e => e.ShowOrder)
                    .HasColumnName("show_order")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Url)
                    .IsRequired()
                    .HasColumnName("url")
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<SystemRole>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("system_role", "Imms_Dev");

                entity.HasIndex(e => e.RoleCode)
                    .HasName("IDX_SYSTEM_ROLE_0");

                entity.HasIndex(e => e.RoleName)
                    .HasName("IDX_SYSTEM_ROLE_1");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.RoleCode)
                    .IsRequired()
                    .HasColumnName("role_code")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.RoleName)
                    .IsRequired()
                    .HasColumnName("role_name")
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<SystemUser>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("system_user", "Imms_Dev");

                entity.HasIndex(e => e.IsOnline)
                    .HasName("IDX_SYSTEM_USER_3");

                entity.HasIndex(e => e.UserCode)
                    .HasName("IDX_SYSTEM_USER_0");

                entity.HasIndex(e => e.UserName)
                    .HasName("IDX_SYSTEM_USER_1");

                entity.HasIndex(e => e.UserStatus)
                    .HasName("IDX_SYSTEM_USER_2");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasColumnName("email")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.IsOnline)
                    .HasColumnName("is_online")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("b'0'");

                entity.Property(e => e.LastLoginTime).HasColumnName("last_login_time");

                entity.Property(e => e.Pwd)
                    .IsRequired()
                    .HasColumnName("pwd")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UserCode)
                    .IsRequired()
                    .HasColumnName("user_code")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasColumnName("user_name")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UserStatus)
                    .HasColumnName("user_status")
                    .HasColumnType("tinyint(4)");
            });

            modelBuilder.Entity<TreeCode>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("tree_code", "Imms_Dev");

                entity.HasIndex(e => e.CodeName)
                    .HasName("IDX_TREE_CODE_02");

                entity.HasIndex(e => e.CodeNo)
                    .HasName("IDX_TREE_CODE_01");

                entity.HasIndex(e => e.CodeType)
                    .HasName("IDX_TREE_CODE_04");

                entity.HasIndex(e => e.ParentId)
                    .HasName("IDX_TREE_CODE_03");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CodeName)
                    .IsRequired()
                    .HasColumnName("code_name")
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.CodeNamePath)
                    .IsRequired()
                    .HasColumnName("code_name_path")
                    .HasMaxLength(330)
                    .IsUnicode(false);

                entity.Property(e => e.CodeNo)
                    .IsRequired()
                    .HasColumnName("code_no")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.CodeNoPath)
                    .IsRequired()
                    .HasColumnName("code_no_path")
                    .HasMaxLength(110)
                    .IsUnicode(false);

                entity.Property(e => e.CodeType)
                    .HasColumnName("code_type")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(250)
                    .IsUnicode(false);

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.ParentId)
                    .HasColumnName("parent_id")
                    .HasColumnType("bigint(20)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<WorkOrganizationUnit>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("work_organization_unit", "Imms_Dev");

                entity.HasIndex(e => e.OrganizationCode)
                    .HasName("IDX_WORK_ORGANIZATION_UNIT_01");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateBy)
                    .HasColumnName("create_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CreateDate).HasColumnName("create_date");

                entity.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(250)
                    .IsUnicode(false);

                entity.Property(e => e.OptFlag)
                    .HasColumnName("opt_flag")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

                entity.Property(e => e.OrganizationCode)
                    .IsRequired()
                    .HasColumnName("organization_code")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.OrganizationName)
                    .IsRequired()
                    .HasColumnName("organization_name")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.OrganizationType)
                    .HasColumnName("organization_type")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Parameters)
                    .HasColumnName("parameters")
                    .HasMaxLength(3000)
                    .IsUnicode(false);

                entity.Property(e => e.ParentOrganizationId)
                    .HasColumnName("parent_organization_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateBy)
                    .HasColumnName("update_by")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.UpdateDate).HasColumnName("update_date");
            });

            modelBuilder.Entity<WorkstationCheckIn>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("workstation_check_in", "Imms_Dev");

                entity.HasIndex(e => e.OperatorId)
                    .HasName("IDX_workstation_check_in_01");

                entity.HasIndex(e => e.WorkStationId)
                    .HasName("IDX_workstation_check_in_02");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.CheckInTime).HasColumnName("check_in_time");

                entity.Property(e => e.CheckOutTime).HasColumnName("check_out_time");

                entity.Property(e => e.OperatorId)
                    .HasColumnName("operator_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.WorkStationId)
                    .HasColumnName("work_station_id")
                    .HasColumnType("bigint(20)");
            });
        }
    }
}
