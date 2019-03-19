using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class RolePrivilege : Entity<long>
    {
        public long ProgramPrivilegeId { get; set; }
        public long RoleId { get; set; }
        public string ProgramId { get; set; }
        public string PrivilegeCode { get; set; }
    }

    public class RolePrivilegeConfigure : EntityConfigure<RolePrivilege>
    {
        protected override void InternalConfigure(EntityTypeBuilder<RolePrivilege> builder)
        {
            base.Configure(builder);
            builder.ToTable("role_privilege");

            builder.Property(e => e.PrivilegeCode)
                    .IsRequired()
                    .HasColumnName("privilege_code")
                    .HasMaxLength(50)
                    .IsUnicode(false);

            builder.Property(e => e.ProgramId)
                .IsRequired()
                .HasColumnName("program_id")
                .HasMaxLength(50)
                .IsUnicode(false);

            builder.Property(e => e.ProgramPrivilegeId)
                .HasColumnName("program_privilege_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.RoleId)
                .HasColumnName("role_id")
                .HasColumnType("bigint(20)");
        }
    }
}
