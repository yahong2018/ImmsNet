using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class PlanCode : TrackableEntity<long>
    {
        public int CodeType { get; set; }
        public string CodeNo { get; set; }
        public string CodeName { get; set; }
        public string Description { get; set; }
    }

    public class PlanCodeConfigure : TrackableEntityConfigure<PlanCode>
    {
        protected override void InternalConfigure(EntityTypeBuilder<PlanCode> builder)
        {
            base.Configure(builder);
            builder.ToTable("plan_code");

            builder.Property(e => e.CodeName)
                                .IsRequired()
                                .HasColumnName("code_name")
                                .HasMaxLength(30)
                                .IsUnicode(false);

            builder.Property(e => e.CodeNo)
                .IsRequired()
                .HasColumnName("code_no")
                .HasMaxLength(10)
                .IsUnicode(false);

            builder.Property(e => e.CodeType)
                .HasColumnName("code_type")
                .HasColumnType("int(11)");

            builder.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(250)
                    .IsUnicode(false);
        }
    }
}
