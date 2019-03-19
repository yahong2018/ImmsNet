using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class OperationRouting : TrackableEntity<long>
    {
        public long OperationRoutingOrderId { get; set; }
        public long OperationId { get; set; }
        public int SequenceNo { get; set; }
        public long? PreRoutingId { get; set; }
    }

    public class OperationRoutingConfigure : TrackableEntityConfigure<OperationRouting>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperationRouting> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operation_routing");

            builder.Property(e => e.OperationId)
                    .HasColumnName("operation_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OperationRoutingOrderId)
                .HasColumnName("operation_routing_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.PreRoutingId)
                   .HasColumnName("pre_routing_id")
                   .HasColumnType("bigint(20)");

            builder.Property(e => e.SequenceNo)
                .HasColumnName("sequence_no")
                .HasColumnType("int(11)");
        }
    }
}
