using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Imms.Data.Domain;
using System.Reflection;
using System.Threading;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.Extensions.Logging;
using Imms.Data;
using Imms.Mes.Domain;

namespace Imms.Mes
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

        public virtual DbSet<Bom> Bom { get; set; }
        public virtual DbSet<BomOrder> BomOrder { get; set; }
        public virtual DbSet<CodeSeed> CodeSeed { get; set; }
        public virtual DbSet<CuttingMarker> CuttingMarker { get; set; }
        public virtual DbSet<CuttingOrder> CuttingOrder { get; set; }
        public virtual DbSet<CuttingOrderSize> CuttingOrderSize { get; set; }
        public virtual DbSet<Material> Material { get; set; }
        public virtual DbSet<MaterialPickingOrder> MaterialPickingOrder { get; set; }
        public virtual DbSet<MaterialPickingOrderDetail> MaterialPickingOrderDetail { get; set; }
        public virtual DbSet<MaterialPickingSchedule> MaterialPickingSchedule { get; set; }
        public virtual DbSet<MaterialPickingScheduleBom> MaterialPickingScheduleBom { get; set; }
        public virtual DbSet<Media> Media { get; set; }
        public virtual DbSet<Operation> Operation { get; set; }
        public virtual DbSet<OperationRouting> OperationRouting { get; set; }
        public virtual DbSet<OperationRoutingOrder> OperationRoutingOrder { get; set; }
        public virtual DbSet<Operator> Operator { get; set; }
        public virtual DbSet<OperatorCapability> OperatorCapability { get; set; }
        public virtual DbSet<ProductionOrderMeasure> ProductionOrderMeasure { get; set; }
        public virtual DbSet<ProductionOrderSize> ProductionOrderSize { get; set; }
        public virtual DbSet<PlanCode> PlanCode { get; set; }
        public virtual DbSet<ProductionOrder> ProductionOrder { get; set; }
        public virtual DbSet<ProductionWorkOrder> ProductionWorkOrder { get; set; }
        public virtual DbSet<ProductionWorkOrderRouting> ProductionWorkOrderRouting { get; set; }
        public virtual DbSet<ProgramPrivilege> ProgramPrivilege { get; set; }
        // public virtual DbSet<RequirementOrder> RequirementOrder { get; set; }
        public virtual DbSet<RolePrivilege> RolePrivilege { get; set; }
        public virtual DbSet<RoleUser> RoleUser { get; set; }
        // public virtual DbSet<ScheduleOrder> ScheduleOrder { get; set; }
        public virtual DbSet<SystemProgram> SystemProgram { get; set; }
        public virtual DbSet<SystemRole> SystemRole { get; set; }
        public virtual DbSet<SystemUser> SystemUser { get; set; }
        public virtual DbSet<TreeCode> TreeCode { get; set; }
        public virtual DbSet<WorkOrganizationUnit> WorkOrganizationUnit { get; set; }
        public virtual DbSet<Plant> Plants { get; set; }
        public virtual DbSet<WorkCenter> WorkCenters { get; set; }

        public virtual DbSet<WorkstationCheckIn> WorkstationCheckIn { get; set; }
        public virtual DbSet<SystemApp> SystemApp { get; set; }
        public virtual DbSet<ThirdPartDataExcahngeRule> SystemDataExcahngeRule { get; set; }
        public virtual DbSet<ThirdPartDataExchange> SystemExchangeDataLog { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySQL("server=localhost;user=root;database=Imms_Dev;port=3306;password=root");
            }

            var loggerFactory = new LoggerFactory();
            loggerFactory.AddProvider(new EFLoggerProvider());
            optionsBuilder.UseLoggerFactory(loggerFactory);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.3-servicing-35854");

            modelBuilder.ApplyConfiguration(new BomConfigure());
            modelBuilder.ApplyConfiguration(new BomOrderConfigure());
            
            modelBuilder.ApplyConfiguration(new CuttingMarkerConfigure());
            modelBuilder.ApplyConfiguration(new CuttingOrderConfigure());
            modelBuilder.ApplyConfiguration(new CuttingOrderSizeConfigure());
            modelBuilder.ApplyConfiguration(new MaterialConfigure());
            modelBuilder.ApplyConfiguration(new MaterialPickingOrderConfigure());
            modelBuilder.ApplyConfiguration(new MaterialPickingOrderDetailConfigure());
            modelBuilder.ApplyConfiguration(new MaterialPickingScheduleConfigure());
            modelBuilder.ApplyConfiguration(new MaterialPickingScheduleBomConfigure());
            
            modelBuilder.ApplyConfiguration(new OperationConfigure());
            modelBuilder.ApplyConfiguration(new OperationRoutingConfigure());
            modelBuilder.ApplyConfiguration(new OperationRoutingOrderConfigure());
            modelBuilder.ApplyConfiguration(new OperatorConfigure());
            modelBuilder.ApplyConfiguration(new OperatorCapabilityConfigure());
            modelBuilder.ApplyConfiguration(new ProductionOrderMeasureConfigure());
            modelBuilder.ApplyConfiguration(new ProductionOrderSizeConfigure());
            
            modelBuilder.ApplyConfiguration(new ProductionOrderConfigure());
            modelBuilder.ApplyConfiguration(new ProductionWorkOrderConfigure());
            modelBuilder.ApplyConfiguration(new ProductionWorkOrderRoutingConfigure());
            // modelBuilder.ApplyConfiguration(new RequirementOrderConfigure());
            // modelBuilder.ApplyConfiguration(new ScheduleOrderConfigure());            
            modelBuilder.ApplyConfiguration(new Imms.Mes.Domain.WorkOrganizationUnitConfigure());
            modelBuilder.ApplyConfiguration(new WorkstationCheckInConfigure());

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
            modelBuilder.ApplyConfiguration(new TreeCodeConfigure());
            modelBuilder.ApplyConfiguration(new PlanCodeConfigure());
            modelBuilder.ApplyConfiguration(new CodeSeedConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Data.Domain.WorkOrganizationUnitConfigure());     
        }
    }

    public class ImmsDbContextFactory : IDbContextFactory
    {
        public DbContext GetContext()
        {
            return new ImmsDbContext();
        }

        public DbContext GetContext(string connectionString)
        {
            throw new NotImplementedException();
        }
    }
}
