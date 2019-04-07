using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using Imms.Data;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Mes.MasterData
{
    public class EquipmentType : PlanCode
    {
        public string EquipmentTypeNo { get { return base.CodeNo; } set { base.CodeNo = value; } }
        public string EquipmentTypeName { get { return base.CodeName; } set { base.CodeName = value; } }
    }

    public partial class Operator : TrackableEntity<long>
    {
        public long UserId { get; set; }
        public long OrganizationId { get; set; }
        public long SupervisorId { get; set; }
    }

    public partial class OperatorCapability : TrackableEntity<long>
    {
        public long OperatorId { get; set; }
        public long OperationId { get; set; }
        public byte SkillLevel { get; set; }
    }

    public class Plant : WorkOrganizationUnit
    {
        public string PlantCode { get { return base.OrganizationCode; } set { base.OrganizationCode = value; } }
        public string PlantName { get { return base.OrganizationName; } set { base.OrganizationName = value; } }
        public double CostPriceRatio { get; set; }
    }

    public class WorkCenter : WorkOrganizationUnit
    {
        public string WorkCenterCode { get { return base.OrganizationCode; } set { base.OrganizationCode = value; } }
        public string WorkCenterName { get { return base.OrganizationName; } set { base.OrganizationName = value; } }

        public int MainOrbitLength { get; set; }
        public int RotateDirection { get; set; }
    }

    public class WorkLine : WorkOrganizationUnit
    {
        public string LineCode { get { return base.OrganizationCode; } set { base.OrganizationCode = value; } }
        public string LineName { get { return base.OrganizationName; } set { base.OrganizationName = value; } }

        public int LineDistance { get; set; }
        public int RotateDirection { get; set; }
    }

    public class WorkStation : WorkOrganizationUnit
    {
        public string WorkStationCode { get { return base.OrganizationCode; } set { base.OrganizationCode = value; } }
        public string WorkStationName { get { return base.OrganizationName; } set { base.OrganizationName = value; } }

        public string WorkStationType { get; set; }
        public long MachineTypeId { get; set; }
        public bool IsOnLine { get; set; }
        public long OperatorId { get; set; }
        public bool IsAvailable { get; set; }
        public int WipMax { get; set; }
        public int WipCurrent { get; set; }
        public int WipInTransit { get; set; }
        public int Direction { get; set; }
    }

    public partial class WorkstationCheckIn : Entity<long>
    {
        public long WorkStationId { get; set; }
        public long OperatorId { get; set; }
        public DateTime? CheckInTime { get; set; }
        public DateTime? CheckOutTime { get; set; }
    }

    public partial class Material : TrackableEntity<long>
    {
        public string MaterialNo { get; set; }
        public string MaterialName { get; set; }
        public long MaterialTypeId { get; set; }
        public string Unit { get; set; }
        public decimal? Width { get; set; }
        public decimal? Weight { get; set; }
        public decimal? Price { get; set; }
        public string Color { get; set; }
        public string Description { get; set; }

        public virtual MaterialType MaterialType { get; set; }
    }

    public class MaterialType : PlanCode
    {
        public string MaterialTypeCode { get { return base.CodeNo; } set { base.CodeNo = value; } }
        public string MaterialTypeName { get { return base.CodeName; } set { base.CodeName = value; } }
    }

    public partial class BomOrder : OrderEntity<long>
    {
        public int BomOrderType { get; set; }
        public long MaterialId { get; set; }

        public virtual Material Material { get; set; }
        public virtual List<Bom> Boms { get; set; } = new List<Bom>();
    }

    public partial class Bom : TrackableEntity<long>
    {
        public long BomOrderId { get; set; }
        public long ComponentMaterialId { get; set; }
        public long? ComponentAbstractMaterialId { get; set; }
        public double QtyComponent { get; set; }
        public string ComponentUnit { get; set; }
        public string ComponentMaterialNoPath { get; set; }
        public string ComponentMaterialNamePath { get; set; }
        public bool IsMainFabric { get; set; }
        public long ParentBomId { get; set; }

        public virtual BomOrder BomOrder { get; set; }
    }

    public class BomOrderConfigure : OrderEntityConfigure<BomOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<BomOrder> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("bom_order");
            builder.Property(e => e.BomOrderType).HasColumnName("bom_order_type");
            builder.Property(e => e.MaterialId).HasColumnName("material_id");

            builder.HasOne(e => e.Material).WithMany().HasForeignKey(e => e.MaterialId);
            builder.HasMany(e => e.Boms).WithOne(e => e.BomOrder).HasForeignKey(e => e.BomOrderId);
        }
    }

    public class BomConfigure : TrackableEntityConfigure<Bom>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Bom> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("bom");

            builder.Property(e => e.BomOrderId).HasColumnName("bom_order_id");
            builder.Property(e => e.ComponentAbstractMaterialId).HasColumnName("component_abstract_material_id");
            builder.Property(e => e.ComponentMaterialId).IsRequired().HasColumnName("component_material_id");
            builder.Property(e => e.ComponentMaterialNamePath).IsRequired().HasColumnName("component_material_name_path").HasMaxLength(330);
            builder.Property(e => e.ComponentMaterialNoPath).IsRequired().HasColumnName("component_material_no_path").HasMaxLength(130);
            builder.Property(e => e.QtyComponent).HasColumnName("qty_component");
            builder.Property(e => e.ComponentUnit).HasColumnName("component_unit");
            builder.Property(e => e.IsMainFabric).HasColumnName("is_main_fabric");
            builder.Property(e => e.ParentBomId).HasColumnName("parent_bom_id");

            builder.HasOne(e => e.BomOrder).WithMany(e => e.Boms).HasForeignKey(e => e.BomOrderId);
        }
    }

    public class MaterialConfigure : TrackableEntityConfigure<Material>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Material> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("material");

            builder.Property(e => e.Color).HasColumnName("color").HasMaxLength(20).IsUnicode(false);
            builder.Property(e => e.Description).HasColumnName("description").HasMaxLength(250).IsUnicode(false);
            builder.Property(e => e.MaterialName).IsRequired().HasColumnName("material_name").HasMaxLength(50).IsUnicode(false);
            builder.Property(e => e.MaterialNo).IsRequired().HasColumnName("material_no").HasMaxLength(20).IsUnicode(false);
            builder.Property(e => e.MaterialTypeId).HasColumnName("material_type_id").HasColumnType("bigint(20)");
            builder.Property(e => e.Price).HasColumnName("price").HasColumnType("decimal(10,2)");
            builder.Property(e => e.Unit).HasColumnName("unit").HasColumnType("varchar(20)");
            builder.Property(e => e.Weight).HasColumnName("weight").HasColumnType("decimal(10,4)");
            builder.Property(e => e.Width).HasColumnName("width").HasColumnType("decimal(10,4)");
        }
    }


    public class WorkstationCheckInConfigure : EntityConfigure<WorkstationCheckIn>
    {
        protected override void InternalConfigure(EntityTypeBuilder<WorkstationCheckIn> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("workstation_check_in");

            builder.Property(e => e.CheckInTime).HasColumnName("check_in_time");
            builder.Property(e => e.CheckOutTime).HasColumnName("check_out_time");
            builder.Property(e => e.OperatorId).HasColumnName("operator_id").HasColumnType("bigint(20)");
            builder.Property(e => e.WorkStationId).HasColumnName("work_station_id").HasColumnType("bigint(20)");
        }
    }

    public class WorkOrganizationUnitConfigure : IEntityTypeConfiguration<WorkOrganizationUnit>
    {
        public void Configure(EntityTypeBuilder<WorkOrganizationUnit> builder)
        {
            builder.HasDiscriminator("organization_type", typeof(string))
            .HasValue<Plant>(GlobalConstants.TYPE_ORG_PLANT)
            .HasValue<WorkCenter>(GlobalConstants.TYPE_ORG_WORK_CENTER)
            .HasValue<WorkLine>(GlobalConstants.TYPE_ORG_WORK_LINE)
            .HasValue<WorkStation>(GlobalConstants.TYPE_ORG_WORK_STATETION)
            ;
        }
    }

    public class PlantConfigure : IEntityTypeConfiguration<Plant>
    {
        public void Configure(EntityTypeBuilder<Plant> builder)
        {
            builder.Ignore(e => e.PlantCode);
            builder.Ignore(e => e.PlantName);

            builder.Property(e => e.CostPriceRatio).HasColumnName("cost_price_ratio").HasColumnType("double(8,4)");
        }
    }
    public class WorkCenterConfigure : IEntityTypeConfiguration<WorkCenter>
    {
        public void Configure(EntityTypeBuilder<WorkCenter> builder)
        {
            builder.Ignore(e => e.WorkCenterCode);
            builder.Ignore(e => e.WorkCenterName);

            builder.Property(e => e.MainOrbitLength).HasColumnName("main_orbit_length");
            builder.Property(e => e.RotateDirection).HasColumnName("rotate_direction");
        }
    }

    public class WorkLineConfigure : IEntityTypeConfiguration<WorkLine>
    {
        public void Configure(EntityTypeBuilder<WorkLine> builder)
        {
            builder.Ignore(e => e.LineCode);
            builder.Ignore(e => e.LineName);

            builder.Property(e => e.LineDistance).HasColumnName("line_distance");
            builder.Property(e => e.RotateDirection).HasColumnName("rotate_direction");
        }
    }

    public class WorkStationConfigure : IEntityTypeConfiguration<WorkStation>
    {
        public void Configure(EntityTypeBuilder<WorkStation> builder)
        {
            builder.Ignore(e => e.WorkStationCode);
            builder.Ignore(e => e.WorkStationName);

            builder.Property(e => e.WorkStationType).HasColumnName("work_station_type");
            builder.Property(e => e.MachineTypeId).HasColumnName("machine_type_id");
            builder.Property(e => e.IsOnLine).HasColumnName("is_on_line").HasColumnType("bit");
            builder.Property(e => e.OperatorId).HasColumnName("operator_id");
            builder.Property(e => e.IsAvailable).HasColumnName("is_available").HasColumnType("bit");
            builder.Property(e => e.WipMax).HasColumnName("wip_max");
            builder.Property(e => e.WipCurrent).HasColumnName("wip_current");
            builder.Property(e => e.WipInTransit).HasColumnName("wip_in_transit");
            builder.Property(e => e.Direction).HasColumnName("direction");
        }
    }


    public class OperatorCapabilityConfigure : TrackableEntityConfigure<OperatorCapability>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperatorCapability> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operator_capability");

            builder.Property(e => e.OperationId).HasColumnName("operation_id").HasColumnType("bigint(20)");
            builder.Property(e => e.OperatorId).HasColumnName("operator_id").HasColumnType("bigint(20)");
            builder.Property(e => e.SkillLevel).HasColumnName("skill_level").HasColumnType("tinyint(4)");
        }
    }

    public class OperatorConfigure : TrackableEntityConfigure<Operator>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Operator> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operator");

            builder.Property(e => e.OrganizationId).HasColumnName("organization_id").HasColumnType("bigint(20)");
            builder.Property(e => e.SupervisorId).HasColumnName("supervisor_id").HasColumnType("bigint(20)");
            builder.Property(e => e.UserId).HasColumnName("user_id").HasColumnType("bigint(20)");
        }
    }

    public class PlanCodeConfigure : IEntityTypeConfiguration<PlanCode>
    {
        public void Configure(EntityTypeBuilder<PlanCode> builder)
        {
            builder.HasDiscriminator("code_type", typeof(string))
                .HasValue<EquipmentType>(GlobalConstants.TYPE_CODE_TYPE_EQUIPMENT_TYPE)
                .HasValue<MaterialType>(GlobalConstants.TYPE_CODE_TYPE_MATERIAL_TYPE)
                ;
        }
    }

    public class EquipmentTypeCofigure : IEntityTypeConfiguration<EquipmentType>
    {
        public void Configure(EntityTypeBuilder<EquipmentType> builder)
        {
            builder.Ignore(e => e.EquipmentTypeNo);
            builder.Ignore(e => e.EquipmentTypeName);
        }
    }

    public class MaterialTypeeCofigure : IEntityTypeConfiguration<MaterialType>
    {
        public void Configure(EntityTypeBuilder<MaterialType> builder)
        {
            builder.Ignore(e => e.MaterialTypeCode);
            builder.Ignore(e => e.MaterialTypeName);
        }
    }


}