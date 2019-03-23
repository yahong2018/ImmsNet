using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class RoleUser : Entity<long>
    {
        public long RoleId { get; set; }
        public long UserId { get; set; }
    }

    public class RoleUserConfigure : EntityConfigure<RoleUser>
    {
        protected override void InternalConfigure(EntityTypeBuilder<RoleUser> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("role_user");

            builder.Property(e => e.RoleId)
                    .HasColumnName("role_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.UserId)
                .HasColumnName("user_id")
                .HasColumnType("bigint(20)");
        }
    }
}
