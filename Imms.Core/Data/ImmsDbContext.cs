using System;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.Extensions.Logging;

namespace Imms.Data
{
    public abstract class ImmsDbContext : DbContext
    {
        public ImmsDbContext()
        {
            this.ChangeTracker.StateChanged += StateChanged;
        }

        public ImmsDbContext(DbContextOptions options)
            : base(options)
        {
        }

        private void StateChanged(object sender, EntityStateChangedEventArgs e)
        {
            if (e.Entry.Entity is ITrackableEntity)
            {
                ITrackableEntity trackableEntity = e.Entry.Entity as ITrackableEntity;
                if (e.NewState == EntityState.Added)
                {
                    trackableEntity.CreateBy = GlobalConstants.GetCurrentUser().RecordId;
                    trackableEntity.CreateDate = DateTime.Now;
                }
                else if (e.NewState == EntityState.Modified)
                {
                    trackableEntity.UpdateBy = GlobalConstants.GetCurrentUser().RecordId;
                    trackableEntity.UpdateDate = DateTime.Now;
                }
            }
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var loggerFactory = new LoggerFactory();
            loggerFactory.AddProvider(new EFLoggerProvider());
            optionsBuilder.UseLoggerFactory(loggerFactory);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new ProgramPrivilegeConfigure());
            modelBuilder.ApplyConfiguration(new RolePrivilegeConfigure());
            modelBuilder.ApplyConfiguration(new RoleUserConfigure());
            modelBuilder.ApplyConfiguration(new SystemProgramConfigure());
            modelBuilder.ApplyConfiguration(new SystemRoleConfigure());
            modelBuilder.ApplyConfiguration(new SystemUserConfigure());
            modelBuilder.ApplyConfiguration(new SysetmAppConfigure());
            modelBuilder.ApplyConfiguration(new ThirdPartDataExchangeRuleConfigure());
            modelBuilder.ApplyConfiguration(new ThridPartDataExcahngeConfigure());
            modelBuilder.ApplyConfiguration(new MediaConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Data.Domain.TreeCodeConfigure());
            modelBuilder.ApplyConfiguration(new PlanCodeConfigure());
            modelBuilder.ApplyConfiguration(new CodeSeedConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Data.Domain.WorkOrganizationUnitConfigure());
            modelBuilder.ApplyConfiguration(new MediaBelongConfigure());

            base.OnModelCreating(modelBuilder);
        }

        public virtual DbSet<CodeSeed> CodeSeeds { get; set; }
        public virtual DbSet<PlanCode> PlanCodes { get; set; }
        public virtual DbSet<ProgramPrivilege> ProgramPrivileges { get; set; }
        public virtual DbSet<RolePrivilege> RolePrivileges { get; set; }
        public virtual DbSet<RoleUser> RoleUsers { get; set; }
        public virtual DbSet<SystemProgram> SystemPrograms { get; set; }
        public virtual DbSet<SystemRole> SystemRoles { get; set; }
        public virtual DbSet<SystemUser> SystemUsers { get; set; }
        public virtual DbSet<TreeCode> TreeCodes { get; set; }
        public virtual DbSet<WorkOrganizationUnit> WorkOrganizationUnits { get; set; }
        public virtual DbSet<SystemApp> SystemApps { get; set; }
        public virtual DbSet<ThirdPartDataExcahngeRule> ThirdPartDataExcahngeRules { get; set; }
        public virtual DbSet<ThirdPartDataExchange> ThirdPartDataExchanges { get; set; }
        public virtual DbSet<Media> Medias { get; set; }
        public virtual DbSet<MediaBelong> MediaBelongs { get; set; }
    }
}