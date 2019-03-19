using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class ProductionWorkOrder : OrderEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public long BomOrderId { get; set; }
        public long OperationRoutingOrderId { get; set; }
        public long CuttingOrderId { get; set; }
        public long SizeId { get; set; }
        public DateTime PlannedStartDate { get; set; }
        public DateTime PlannedEndDate { get; set; }
        public DateTime? ActualStartDate { get; set; }
        public DateTime? ActualEndDate { get; set; }
        public byte SynFinishStatus { get; set; }
    }

    public class ProductionWorkOrderConfigure : OrderEntityConfigure<ProductionWorkOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionWorkOrder> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_work_order");

            builder.Property(e => e.ActualEndDate).HasColumnName("actual_end_date");

            builder.Property(e => e.ActualStartDate).HasColumnName("actual_start_date");

            builder.Property(e => e.BomOrderId)
                .HasColumnName("bom_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.CuttingOrderId)
                    .HasColumnName("cutting_order_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OperationRoutingOrderId)
                .HasColumnName("operation_routing_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.PlannedEndDate).HasColumnName("planned_end_date");

            builder.Property(e => e.PlannedStartDate).HasColumnName("planned_start_date");

            builder.Property(e => e.ProductionOrderId)
                .HasColumnName("production_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.SizeId)
                .HasColumnName("size_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.SynFinishStatus)
                .HasColumnName("syn_finish_status")
                .HasColumnType("tinyint(4)")
                .HasDefaultValueSql("0");
        }
    }
}
