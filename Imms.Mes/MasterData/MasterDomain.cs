using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using Imms.Data;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Mes.MasterData
{
    public class Size : TreeCode
    {
        public string SizeCode { get { return base.CodeNo; } set { base.CodeNo = value; } }
        public string SizeName { get { return base.CodeName; } set { base.CodeName = value; } }
    }

    public class MachineType : TreeCode
    {
        public string MachineTypeNo { get { return base.CodeNo; } set { base.CodeNo = value; } }
        public string MachineTypeName { get { return base.CodeName; } set { base.CodeName = value; } }
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
    }

    public class WorkCenter : WorkOrganizationUnit
    {
        public string WorkCenterCode { get { return base.OrganizationCode; } set { base.OrganizationCode = value; } }
        public string WorkCenterName { get { return base.OrganizationName; } set { base.OrganizationName = value; } }
        
        public int MainOrbitLength{get;set;}
    }

    public class ProductionLine : WorkOrganizationUnit
    {
        public string LineCode { get; set; }
        public string LineName { get; set; }

        public int Sequence { get; set; }
        public int LineDistance { get; set; }
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
        public int MaxWip { get; set; }
        public int CurrentWip { get; set; }
        public int WipInTransit { get; set; }
        public int Sequence { get; set; }
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
        public long UnitId { get; set; }
        public decimal? Width { get; set; }
        public decimal? Weight { get; set; }
        public decimal? Price { get; set; }
        public string Color { get; set; }
        public string Description { get; set; }
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
        public double ComponentQty { get; set; }
        public long ComponentUnitId { get; set; }
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
            builder.Property(e => e.ComponentQty).HasColumnName("component_qty");
            builder.Property(e => e.ComponentUnitId).HasColumnName("component_unit_id");
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

            builder.Property(e => e.Color)
                    .HasColumnName("color")
                    .HasMaxLength(20)
                    .IsUnicode(false);

            builder.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(250)
                    .IsUnicode(false);

            builder.Property(e => e.MaterialName)
                .IsRequired()
                .HasColumnName("material_name")
                .HasMaxLength(30)
                .IsUnicode(false);

            builder.Property(e => e.MaterialNo)
                .IsRequired()
                .HasColumnName("material_no")
                .HasMaxLength(12)
                .IsUnicode(false);

            builder.Property(e => e.MaterialTypeId)
                .HasColumnName("material_type_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.Price)
                    .HasColumnName("price")
                    .HasColumnType("decimal(10,2)");

            builder.Property(e => e.UnitId)
                .HasColumnName("unit_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.Weight)
                    .HasColumnName("weight")
                    .HasColumnType("decimal(10,4)");

            builder.Property(e => e.Width)
                .HasColumnName("width")
                .HasColumnType("decimal(10,4)");
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

            builder.Property(e => e.OperatorId)
                .HasColumnName("operator_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.WorkStationId)
                .HasColumnName("work_station_id")
                .HasColumnType("bigint(20)");
        }
    }

    public class WorkOrganizationUnitConfigure : IEntityTypeConfiguration<WorkOrganizationUnit>
    {
        public void Configure(EntityTypeBuilder<WorkOrganizationUnit> builder)
        {
            builder.HasDiscriminator("organization_type", typeof(string))
            .HasValue<Plant>(GlobalConstants.TYPE_ORG_PLANT)
            .HasValue<WorkCenter>(GlobalConstants.TYPE_ORG_WORK_CENTER)
            .HasValue<WorkStation>(GlobalConstants.TYPE_ORG_WORK_STATETION);
        }
    }

    public class PlantConfigure : IEntityTypeConfiguration<Plant>
    {
        public void Configure(EntityTypeBuilder<Plant> builder)
        {
            builder.Ignore(e => e.PlantCode);
            builder.Ignore(e => e.PlantName);
        }
    }
    public class WorkCenterConfigure : IEntityTypeConfiguration<WorkCenter>
    {
        public void Configure(EntityTypeBuilder<WorkCenter> builder)
        {
            builder.Ignore(e => e.WorkCenterCode);
            builder.Ignore(e => e.WorkCenterName);
        }
    }

    public class WorkStationConfigure : IEntityTypeConfiguration<WorkStation>
    {
        public void Configure(EntityTypeBuilder<WorkStation> builder)
        {
            builder.Ignore(e => e.WorkStationCode);
            builder.Ignore(e => e.WorkStationName);
        }
    }


    public class OperatorCapabilityConfigure : TrackableEntityConfigure<OperatorCapability>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperatorCapability> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operator_capability");

            builder.Property(e => e.OperationId)
                    .HasColumnName("operation_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OperatorId)
                .HasColumnName("operator_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.SkillLevel)
                   .HasColumnName("skill_level")
                   .HasColumnType("tinyint(4)");
        }
    }

    public class OperatorConfigure : TrackableEntityConfigure<Operator>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Operator> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operator");

            builder.Property(e => e.OrganizationId)
                .HasColumnName("organization_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.SupervisorId)
                .HasColumnName("supervisor_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.UserId)
                    .HasColumnName("user_id")
                    .HasColumnType("bigint(20)");
        }
    }

    public class TreeCodeConfigure : IEntityTypeConfiguration<TreeCode>
    {
        public void Configure(EntityTypeBuilder<TreeCode> builder)
        {
            builder.HasDiscriminator("code_type", typeof(string))
                .HasValue<Size>(GlobalConstants.TYPE_CODE_TABLE_SIZE)
                .HasValue<MachineType>(GlobalConstants.TYPE_CODE_TABLE_MACHINE_TYPE)
                ;
        }
    }

    public class SizeConfigure : IEntityTypeConfiguration<Size>
    {
        public void Configure(EntityTypeBuilder<Size> builder)
        {
            builder.Ignore(e => e.SizeCode);
            builder.Ignore(e => e.SizeName);
        }
    }

    public class MachineTypeCofigure : IEntityTypeConfiguration<MachineType>
    {
        public void Configure(EntityTypeBuilder<MachineType> builder)
        {
            builder.Ignore(e => e.MachineTypeNo);
            builder.Ignore(e => e.MachineTypeName);
        }
    }
}