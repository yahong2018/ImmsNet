using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class SystemUser : Entity<long>
    {
        public string UserCode { get; set; }
        public string UserName { get; set; }
        public string Pwd { get; set; }
        public byte UserStatus { get; set; }
        public string Email { get; set; }
        public short IsOnline { get; set; }
        public DateTime? LastLoginTime { get; set; }
    }

    public class SystemUserConfigure : EntityConfigure<SystemUser>
    {
        protected override void InternalConfigure(EntityTypeBuilder<SystemUser> builder)
        {
            base.Configure(builder);
            builder.ToTable("system_user");

            builder.Property(e => e.Email)
                                .IsRequired()
                                .HasColumnName("email")
                                .HasMaxLength(255)
                                .IsUnicode(false);

            builder.Property(e => e.IsOnline)
                .HasColumnName("is_online")
                .HasColumnType("bit(1)")
                .HasDefaultValueSql("b'0'");

            builder.Property(e => e.LastLoginTime).HasColumnName("last_login_time");

            builder.Property(e => e.Pwd)
                .IsRequired()
                .HasColumnName("pwd")
                .HasMaxLength(50)
                .IsUnicode(false);

            builder.Property(e => e.UserCode)
                .IsRequired()
                .HasColumnName("user_code")
                .HasMaxLength(20)
                .IsUnicode(false);

            builder.Property(e => e.UserName)
                .IsRequired()
                .HasColumnName("user_name")
                .HasMaxLength(50)
                .IsUnicode(false);

            builder.Property(e => e.UserStatus)
                .HasColumnName("user_status")
                .HasColumnType("tinyint(4)");

        }
    }
}
