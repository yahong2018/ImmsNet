using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class ProgramPrivilege : Entity<long>
    {
        public string ProgramId { get; set; }
        public string PrivilegeCode { get; set; }
        public string PrivilegeName { get; set; }
    }

    public class ProgramPrivilegeConfigure : EntityConfigure<ProgramPrivilege>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProgramPrivilege> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("program_privilege");

            builder.Property(e => e.PrivilegeCode)
                    .IsRequired()
                    .HasColumnName("privilege_code")
                    .HasMaxLength(50)
                    .IsUnicode(false);

            builder.Property(e => e.PrivilegeName)
                .IsRequired()
                .HasColumnName("privilege_name")
                .HasMaxLength(120)
                .IsUnicode(false);

            builder.Property(e => e.ProgramId)
                .IsRequired()
                .HasColumnName("program_id")
                .HasMaxLength(50)
                .IsUnicode(false);
        }
    }
}
