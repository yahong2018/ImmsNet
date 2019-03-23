using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class SystemProgram : Entity<string>
    {
        public string ProgramCode { get; set; }
        public string ProgramName { get; set; }
        public string Url { get; set; }
        public string Glyph { get; set; }
        public int ShowOrder { get; set; }
        public string Parameters { get; set; }
        public string ParentId { get; set; }
    }

    public class SystemProgramConfigure : EntityConfigure<SystemProgram>
    {
        protected override void InternalConfigure(EntityTypeBuilder<SystemProgram> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("system_program");

            builder.Property(e => e.Glyph)
                    .HasColumnName("glyph")
                    .HasMaxLength(100)
                    .IsUnicode(false);

            builder.Property(e => e.Parameters)
                .IsRequired()
                .HasColumnName("parameters")
                .HasMaxLength(255)
                .IsUnicode(false);

            builder.Property(e => e.ParentId)
                .IsRequired()
                .HasColumnName("parent_id")
                .HasMaxLength(50)
                .IsUnicode(false);

            builder.Property(e => e.ProgramCode)
                .IsRequired()
                .HasColumnName("program_code")
                .HasMaxLength(50)
                .IsUnicode(false);

            builder.Property(e => e.ProgramName)
                .IsRequired()
                .HasColumnName("program_name")
                .HasMaxLength(120)
                .IsUnicode(false);

            builder.Property(e => e.ShowOrder)
                .HasColumnName("show_order")
                .HasColumnType("int(11)");

            builder.Property(e => e.Url)
                .IsRequired()
                .HasColumnName("url")
                .HasMaxLength(255)
                .IsUnicode(false);
        }
    }
}
