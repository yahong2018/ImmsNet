using System;
using System.Collections.Generic;
using System.Text;
using Imms.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Mes.Production;

namespace Imms.Mes.Quality
{
    public class QualityCheck:TrackableEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public string SizeNo { get; set; }
        public string SizeName { get; set; }

        public ProductionOrder ProductionOrder{get;set;}
        public virtual List<QualityCheckDetail> Details{get;set;}
    }

    public class QualityCheckDetail:TrackableEntity<long>
    {
        public long QualityCheckId { get; set; }
        public string ComponentNo { get; set; }
        public string ComponentName { get; set; }
        public double StandardValue { get; set; }

        public virtual QualityCheck QualityCheck{get;set;}
    }

    public class QualityCheckConfigure : TrackableEntityConfigure<QualityCheck>
    {
        protected override void InternalConfigure(EntityTypeBuilder<QualityCheck> builder)
        {
            base.InternalConfigure(builder);

            builder.Property(e => e.ProductionOrderId).HasColumnName("production_order_id");
            builder.Property(e => e.SizeNo).HasColumnName("size_no");
            builder.Property(e => e.SizeName).HasColumnName("size_name");

            builder.HasOne(x=>x.ProductionOrder).WithMany().HasForeignKey(x=>x.ProductionOrderId);
        }
    }

    public class QualityCheckDetailConfigure : TrackableEntityConfigure<QualityCheckDetail>
    {
        protected override void InternalConfigure(EntityTypeBuilder<QualityCheckDetail> builder)
        {
            base.InternalConfigure(builder);

            builder.Property(e => e.QualityCheckId).HasColumnName("quality_check_id");
            builder.Property(e => e.ComponentNo).HasColumnName("component_no");
            builder.Property(e => e.ComponentName).HasColumnName("component_name");
            builder.Property(e => e.StandardValue).HasColumnName("standard_value");

            builder.HasOne(e=>e.QualityCheck).WithMany(e=>e.Details).HasForeignKey(e=>e.QualityCheckId);
        }
    }
}
