using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class OperationRoutingOrder : OrderEntity<long>
    {
        public int OrderType { get; set; }
        public long MaterialId { get; set; }
    }

    public class OperationRoutingOrderConfigure : OrderEntityConfigure<OperationRoutingOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperationRoutingOrder> builder)
        {
            base.Configure(builder);
            builder.ToTable("operation_routing_order");

            builder.Property(e => e.MaterialId)
                    .HasColumnName("material_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OrderType)
                    .HasColumnName("order_type")
                    .HasColumnType("int(11)");
        }
    }
}
