using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class SystemRole : Entity<long>
    {
        public string RoleCode { get; set; }
        public string RoleName { get; set; }
    }

    public class SystemRoleConfigure : EntityConfigure<SystemRole>
    {
        protected override void InternalConfigure(EntityTypeBuilder<SystemRole> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("system_role");

            builder.Property(e => e.RoleCode)
                    .IsRequired()
                    .HasColumnName("role_code")
                    .HasMaxLength(20)
                    .IsUnicode(false);

            builder.Property(e => e.RoleName)
                .IsRequired()
                .HasColumnName("role_name")
                .HasMaxLength(50)
                .IsUnicode(false);
        }
    }
}
