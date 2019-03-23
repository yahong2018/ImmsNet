using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;

namespace Imms.Mes.Domain
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
            base.InternalConfigure(builder);
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
