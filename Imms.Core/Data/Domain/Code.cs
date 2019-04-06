using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class CodeSeed : Entity<long>
    {
        public string SeedNo { get; set; }
        public string SeedName { get; set; }
        public int InitialValue { get; set; }
        public string Prefix { get; set; }
        public string Postfix { get; set; }
        public int TotalLength { get; set; }
    }

    public partial class PlanCode : TrackableEntity<long>
    {
        //public string CodeType { get; set; }        
        public string CodeNo { get; set; }
        public string CodeName { get; set; }
        public string Description { get; set; }
    }

    public class MaterialUnit : PlanCode
    {
        public string UnitNo { get { return base.CodeNo; } set { base.CodeNo = value; } }
        public string UnitName { get { return base.CodeName; } set { base.CodeName = value; } }
    }

    public partial class TreeCode : TrackableEntity<long>
    {
        //  public string CodeType { get; set; }

        public string CodeNo { get; set; }
        public string CodeName { get; set; }
        public string Description { get; set; }
        public long ParentId { get; set; }

        public virtual List<TreeCode> Children { get; set; } = new List<TreeCode>();
        public virtual TreeCode Parent { get; set; }
    }

    public class TreeCodeConfigure : TrackableEntityConfigure<TreeCode>
    {
        protected override void InternalConfigure(EntityTypeBuilder<TreeCode> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("tree_code");

            builder.Property(e => e.CodeNo).IsRequired().HasColumnName("code_no").HasMaxLength(10).IsUnicode(false);
            builder.Property(e => e.CodeName).IsRequired().HasColumnName("code_name").HasMaxLength(30).IsUnicode(false);
            builder.Property(e => e.Description).HasColumnName("description").HasMaxLength(250).IsUnicode(false);
            builder.Property(e => e.ParentId).HasColumnName("parent_id").HasColumnType("bigint(20)").HasDefaultValueSql("0");

            builder.HasMany(e => e.Children).WithOne(e => e.Parent).HasForeignKey(e => e.ParentId).HasConstraintName("parent_id");
        }
    }

    public class PlanCodeConfigure : TrackableEntityConfigure<PlanCode>
    {
        protected override void InternalConfigure(EntityTypeBuilder<PlanCode> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("plan_code");

            builder.HasDiscriminator("code_type", typeof(string))
                .HasValue<MaterialUnit>(GlobalConstants.TYPE_CODE_TABLE_MATERIAL_UNIT)
                ;

            builder.Property(e => e.CodeName).IsRequired().HasColumnName("code_name").HasMaxLength(30).IsUnicode(false);
            builder.Property(e => e.CodeNo).IsRequired().HasColumnName("code_no").HasMaxLength(10).IsUnicode(false);
            builder.Property(e => e.Description).HasColumnName("description").HasMaxLength(250).IsUnicode(false);
        }
    }

    public class MaterialUnitConfigure : IEntityTypeConfiguration<MaterialUnit>
    {
        public void Configure(EntityTypeBuilder<MaterialUnit> builder)
        {
            builder.Ignore(e => e.UnitNo);
            builder.Ignore(e => e.UnitName);
        }
    }

    public class CodeSeedConfigure : EntityConfigure<CodeSeed>
    {
        protected override void InternalConfigure(EntityTypeBuilder<CodeSeed> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("code_seed");
            builder.Property(e => e.InitialValue).HasColumnName("initial_value");
            builder.Property(e => e.Postfix).IsRequired().HasColumnName("postfix").HasMaxLength(10);
            builder.Property(e => e.Prefix).IsRequired().HasColumnName("prefix").HasMaxLength(10);
            builder.Property(e => e.SeedName).IsRequired().HasColumnName("seed_name").HasMaxLength(50);
            builder.Property(e => e.SeedNo).IsRequired().HasColumnName("seed_no").HasMaxLength(50);
            builder.Property(e => e.TotalLength).HasColumnName("total_length");
        }
    }
}
