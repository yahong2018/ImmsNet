using System;
using System.Collections.Generic;
using System.Linq;
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
        }

        public ImmsDbContext(DbContextOptions options)
            : base(options)
        {
        }

        public override int SaveChanges()
        {
            ChangeTracker.DetectChanges();

            var modifiedEntities = this.ChangeTracker.Entries().Where(x => x.State == EntityState.Modified || x.State == EntityState.Added || x.State == EntityState.Deleted);
            List<DataChangedNotifyEvent> eventList = new List<DataChangedNotifyEvent>();
            foreach (var e in modifiedEntities)
            {
                IEntity entity = (e as IEntity);
                if (entity == null)
                {
                    continue;
                }

                if (entity is ITrackableEntity)
                {
                    ITrackableEntity trackableEntity = entity as ITrackableEntity;
                    if (e.State == EntityState.Added)
                    {
                        trackableEntity.CreateBy = GlobalConstants.GetCurrentUser().RecordId;
                        trackableEntity.CreateDate = DateTime.Now;
                    }
                    else if (e.State == EntityState.Modified)
                    {
                        trackableEntity.UpdateBy = GlobalConstants.GetCurrentUser().RecordId;
                        trackableEntity.UpdateDate = DateTime.Now;
                    }
                }

                int dmlType = 0;
                if (e.State == EntityState.Added)
                {
                    dmlType = GlobalConstants.DML_OPERATION_INSERT;
                }
                else if (e.State == EntityState.Deleted)
                {
                    dmlType = GlobalConstants.DML_OPERATION_DELETE;
                }
                else if (e.State == EntityState.Modified)
                {
                    dmlType = GlobalConstants.DML_OPERATION_UPDATE;
                }
                eventList.Add(new DataChangedNotifyEvent() { Entity = entity, DMLType = dmlType });
            }
            int result = base.SaveChanges();
            foreach (DataChangedNotifyEvent e in eventList)
            {
                DataChangedNotifier.Instance.Notify(e);
            }
            return result;
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
            modelBuilder.ApplyConfiguration(new DataExchangeRuleConfigure());
            modelBuilder.ApplyConfiguration(new DataExcahngeConfigure());
            modelBuilder.ApplyConfiguration(new MediaConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Data.Domain.TreeCodeConfigure());
            modelBuilder.ApplyConfiguration(new PlanCodeConfigure());
            modelBuilder.ApplyConfiguration(new CodeSeedConfigure());
            modelBuilder.ApplyConfiguration(new MaterialUnitConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Data.Domain.WorkOrganizationUnitConfigure());            

            base.OnModelCreating(modelBuilder);
        }

        // public virtual DbSet<CodeSeed> CodeSeeds { get; set; }
        // public virtual DbSet<PlanCode> PlanCodes { get; set; }
        // public virtual DbSet<ProgramPrivilege> ProgramPrivileges { get; set; }
        // public virtual DbSet<RolePrivilege> RolePrivileges { get; set; }
        // public virtual DbSet<RoleUser> RoleUsers { get; set; }
        // public virtual DbSet<SystemProgram> SystemPrograms { get; set; }
        // public virtual DbSet<SystemRole> SystemRoles { get; set; }
        // public virtual DbSet<SystemUser> SystemUsers { get; set; }
        // public virtual DbSet<TreeCode> TreeCodes { get; set; }
        // public virtual DbSet<WorkOrganizationUnit> WorkOrganizationUnits { get; set; }
        // public virtual DbSet<SystemApp> SystemApps { get; set; }
        // public virtual DbSet<ThirdPartDataExcahngeRule> ThirdPartDataExcahngeRules { get; set; }
        // public virtual DbSet<ThirdPartDataExchangeTask> ThirdPartDataExchanges { get; set; }
        // public virtual DbSet<Media> Medias { get; set; }        
    }
}