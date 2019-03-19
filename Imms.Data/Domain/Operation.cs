using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class Operation : TrackableEntity<long>
    {
        public string OperationNo { get; set; }
        public string OperationName { get; set; }
        public string StandardOperationProcedure { get; set; }
        public long MachineTypeId { get; set; }
        public double? StandardTime { get; set; }
        public double? StandardPrice { get; set; }
        public string PartType { get; set; }
        public string SectionType { get; set; }
        public string SectionName { get; set; }
        public short IsOutsource { get; set; }
        public string QaProcedure { get; set; }
        public string QualityRequirement { get; set; }
        public byte? SkillLevel { get; set; }
    }

    public class OperationConfigure : TrackableEntityConfigure<Operation>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Operation> builder)
        {
            base.Configure(builder);
            builder.ToTable("operation");

            builder.Property(e => e.IsOutsource)
                    .HasColumnName("is_outsource")
                    .HasColumnType("bit(1)");

            builder.Property(e => e.MachineTypeId)
                .HasColumnName("machine_type_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.OperationName)
                .IsRequired()
                .HasColumnName("operation_name")
                .HasMaxLength(120)
                .IsUnicode(false);

            builder.Property(e => e.OperationNo)
                .IsRequired()
                .HasColumnName("operation_no")
                .HasMaxLength(20)
                .IsUnicode(false);

            builder.Property(e => e.PartType)
                    .HasColumnName("part_type")
                    .HasMaxLength(12)
                    .IsUnicode(false);

            builder.Property(e => e.QaProcedure)
                .HasColumnName("qa_procedure")
                .HasMaxLength(1000)
                .IsUnicode(false);

            builder.Property(e => e.QualityRequirement)
                .HasColumnName("quality_requirement")
                .HasMaxLength(1000)
                .IsUnicode(false);

            builder.Property(e => e.SectionName)
                .HasColumnName("section_name")
                .HasMaxLength(30)
                .IsUnicode(false);

            builder.Property(e => e.SectionType)
                .HasColumnName("section_type")
                .HasMaxLength(12)
                .IsUnicode(false);

            builder.Property(e => e.SkillLevel)
                .HasColumnName("skill_level")
                .HasColumnType("tinyint(4)");

            builder.Property(e => e.StandardOperationProcedure)
                .HasColumnName("standard_operation_procedure")
                .HasMaxLength(200)
                .IsUnicode(false);

            builder.Property(e => e.StandardPrice)
                .HasColumnName("standard_price")
                .HasColumnType("double(8,4)");

            builder.Property(e => e.StandardTime)
                .HasColumnName("standard_time")
                .HasColumnType("double(8,4)");
        }
    }
}
