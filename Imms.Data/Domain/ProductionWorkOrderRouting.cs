using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class ProductionWorkOrderRouting : TrackableEntity<long>
    {
        public long OperationRoutingOrderId { get; set; }
        public long ProductionWorkOrderId { get; set; }
        public long OperationRoutingId { get; set; }
        public long? OperatorId { get; set; }
        public long? WorkStationId { get; set; }
        public int? ScrapQty { get; set; }
        public int? CompleteQty { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? CompleteTime { get; set; }
        public int OrderStatus { get; set; }
    }

    public class ProductionWorkOrderRoutingConfigure : OrderEntityConfigure<ProductionWorkOrderRouting>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionWorkOrderRouting> builder)
        {
            base.Configure(builder);
            builder.ToTable("production_work_order_routing");

            builder.Property(e => e.CompleteQty)
                    .HasColumnName("complete_qty")
                    .HasColumnType("int(11)")
                    .HasDefaultValueSql("0");

            builder.Property(e => e.CompleteTime).HasColumnName("complete_time");

            builder.Property(e => e.OperationRoutingId)
                    .HasColumnName("operation_routing_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OperationRoutingOrderId)
                .HasColumnName("operation_routing_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.OperatorId)
                .HasColumnName("operator_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.OrderStatus)
                .HasColumnName("order_status")
                .HasColumnType("int(11)");

            builder.Property(e => e.ProductionWorkOrderId)
                .HasColumnName("production_work_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.ScrapQty)
                .HasColumnName("scrap_qty")
                .HasColumnType("int(11)")
                .HasDefaultValueSql("0");

            builder.Property(e => e.StartTime).HasColumnName("start_time");

            builder.Property(e => e.WorkStationId)
                    .HasColumnName("work_station_id")
                    .HasColumnType("bigint(20)");
        }
    }
}
