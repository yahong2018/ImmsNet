using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace Imms.Data
{
    public partial class ImmsDbContext : DbContext
    {
        public ImmsDbContext()
        {
        }

        public ImmsDbContext(DbContextOptions<ImmsDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<SystemUser> SystemUser { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseMySQL("server=localhost;user=root;database=Imms_Dev;port=3306;password=root");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.3-servicing-35854");

            modelBuilder.Entity<SystemUser>(entity =>
            {
                entity.HasKey(e => e.RecordId);

                entity.ToTable("system_user", "Imms_Dev");

                entity.HasIndex(e => e.Online)
                    .HasName("IDX_SYSTEM_USER_3");

                entity.HasIndex(e => e.UserCode)
                    .HasName("IDX_SYSTEM_USER_0");

                entity.HasIndex(e => e.UserName)
                    .HasName("IDX_SYSTEM_USER_1");

                entity.HasIndex(e => e.UserStatus)
                    .HasName("IDX_SYSTEM_USER_2");

                entity.Property(e => e.RecordId)
                    .HasColumnName("record_id")
                    .HasColumnType("bigint(20)");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasColumnName("email")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.LastLoginTime).HasColumnName("last_login_time");

                entity.Property(e => e.Online)
                    .HasColumnName("online")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("b'0'");

                entity.Property(e => e.Pwd)
                    .IsRequired()
                    .HasColumnName("pwd")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UserCode)
                    .IsRequired()
                    .HasColumnName("user_code")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasColumnName("user_name")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UserStatus)
                    .HasColumnName("user_status")
                    .HasColumnType("tinyint(4)");
            });
        }
    }
}
