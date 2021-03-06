﻿using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Imms.Data.Domain;
using System.Reflection;
using System.Threading;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.Extensions.Logging;
using Imms.Data;
using Imms.Mes.Domain;
using Imms.Mes.Organization;
using Imms.Mes.Cutting;
using Imms.Mes.Picking;
using Imms.Mes.Stitch;
using Imms.Mes.Quality;

namespace Imms.Mes
{
    public partial class ImmsMesDbContext : ImmsDbContext
    {
        public ImmsMesDbContext()
        {
        }

        public ImmsMesDbContext(DbContextOptions<ImmsMesDbContext> options)
            : base(options)
        {
        }

        //public virtual DbSet<Bom> Boms { get; set; }
        //public virtual DbSet<BomOrder> BomOrders { get; set; }

        //public virtual DbSet<CuttingMarker> CuttingMarkers { get; set; }
        //public virtual DbSet<CuttingOrder> CuttingOrders { get; set; }
        //public virtual DbSet<CuttingOrderSize> CuttingOrderSize { get; set; }

        //public virtual DbSet<Material> Material { get; set; }
        //public virtual DbSet<MaterialPickingOrder> MaterialPickingOrder { get; set; }
        //public virtual DbSet<MaterialPickingOrderDetail> MaterialPickingOrderDetail { get; set; }
        //public virtual DbSet<MaterialPickingSchedule> MaterialPickingSchedule { get; set; }
        //public virtual DbSet<MaterialPickingScheduleBom> MaterialPickingScheduleBom { get; set; }

        //public virtual DbSet<Operation> Operation { get; set; }
        //public virtual DbSet<OperationRouting> OperationRouting { get; set; }
        //public virtual DbSet<OperationRoutingOrder> OperationRoutingOrder { get; set; }
        //public virtual DbSet<Operator> Operator { get; set; }
        //public virtual DbSet<OperatorCapability> OperatorCapability { get; set; }

        //public virtual DbSet<ProductionOrderMeasure> ProductionOrderMeasure { get; set; }
        //public virtual DbSet<ProductionOrderSize> ProductionOrderSize { get; set; }
        //public virtual DbSet<ProductionOrder> ProductionOrder { get; set; }
        //public virtual DbSet<ProductionWorkOrder> ProductionWorkOrder { get; set; }
        //public virtual DbSet<ProductionWorkOrderRouting> ProductionWorkOrderRouting { get; set; }
        //public virtual DbSet<ProductionOrderPatternRelation> ProductionOrderPatternRelations { get; set; }

        //public virtual DbSet<Plant> Plants { get; set; }
        //public virtual DbSet<WorkCenter> WorkCenters { get; set; }
        //public virtual DbSet<WorkstationCheckIn> WorkstationCheckIn { get; set; }
        //// public virtual DbSet<RequirementOrder> RequirementOrder { get; set; }
        //// public virtual DbSet<ScheduleOrder> ScheduleOrder { get; set; }     

        //public virtual DbSet<QualityCheck> QualityChecks { get; set; }
        //public virtual DbSet<QualityCheckDetail> QualityCheckDetails { get; set; }

        // public virtual DbSet<Imms.Mes.Domain.Test.Body> Bodies { get; set; }
        // public virtual DbSet<Imms.Mes.Domain.Test.Foot> Feet { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySQL("server=localhost;user=root;database=imms_net;port=3306;password=root;Character Set=utf8;");
            }

            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.3-servicing-35854");

            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.WorkOrganizationUnitConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.PlantConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.WorkCenterConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.WorkLineConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.WorkStationConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.EquipmentTypeCofigure());
            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.EquipmentConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.OperatorConfigure());
            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.OperatorCapabilityConfigure());

            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.PlanCodeConfigure());            
            modelBuilder.ApplyConfiguration(new Imms.Mes.Organization.MaterialTypeeCofigure());
            modelBuilder.ApplyConfiguration(new Material.MaterialConfigure());
            modelBuilder.ApplyConfiguration(new Material.BomConfigure());
            modelBuilder.ApplyConfiguration(new Material.BomOrderConfigure());

            modelBuilder.ApplyConfiguration(new OperationConfigure());
            modelBuilder.ApplyConfiguration(new OpetaionMediaConfigure());
            modelBuilder.ApplyConfiguration(new OperationRoutingConfigure());
            modelBuilder.ApplyConfiguration(new OperationRoutingOrderConfigure());

            modelBuilder.ApplyConfiguration(new ProductionOrderConfigure());
            modelBuilder.ApplyConfiguration(new ProductionOrderSizeConfigure());
            modelBuilder.ApplyConfiguration(new ProductionOrderMeasureConfigure());
            modelBuilder.ApplyConfiguration(new ProductionOrderPatternRelationConfigure());
            modelBuilder.ApplyConfiguration(new QualityCheckConfigure());
            modelBuilder.ApplyConfiguration(new QualityCheckDetailConfigure());
            modelBuilder.ApplyConfiguration(new ProductionWorkOrderConfigure());
            modelBuilder.ApplyConfiguration(new OperatorConfigure());
            modelBuilder.ApplyConfiguration(new OperatorCapabilityConfigure());
            modelBuilder.ApplyConfiguration(new ProductionWorkOrderRoutingConfigure());

            modelBuilder.ApplyConfiguration(new MaterialPickingOrderConfigure());
            modelBuilder.ApplyConfiguration(new PickingOrderItemConfigure());

            modelBuilder.ApplyConfiguration(new CuttingMarkerConfigure());
            modelBuilder.ApplyConfiguration(new CuttingOrderConfigure());
            modelBuilder.ApplyConfiguration(new CuttingOrderSizeConfigure());
            modelBuilder.ApplyConfiguration(new CuttingOrderSpreadPlyConfigure());
            
            // // modelBuilder.ApplyConfiguration(new RequirementOrderConfigure());
            // // modelBuilder.ApplyConfiguration(new ScheduleOrderConfigure());    

            // modelBuilder.ApplyConfiguration(new WorkstationCheckInConfigure());
            // modelBuilder.ApplyConfiguration(new Imms.Mes.MasterData.TreeCodeConfigure());

            // // modelBuilder.ApplyConfiguration(new Imms.Mes.Domain.Test.HeaderConfigure());
            // // modelBuilder.ApplyConfiguration(new Imms.Mes.Domain.Test.BodyConfigure());
            // // modelBuilder.ApplyConfiguration(new Imms.Mes.Domain.Test.FootConfigure());

            base.OnModelCreating(modelBuilder);
        }
    }

    public class ImmsDbContextFactory : IDbContextFactory
    {
        public DbContext GetContext()
        {
            return new ImmsMesDbContext();
        }

        public DbContext GetContext(string connectionString)
        {
            throw new NotImplementedException();
        }
    }
}
