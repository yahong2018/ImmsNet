﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class BomOrder : OrderEntity<long>
    {
        public int BomOrderType { get; set; }
        public long MaterialId { get; set; }
    }

    public class BomOrderConfigure : OrderEntityConfigure<BomOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<BomOrder> builder)
        {
            base.Configure(builder);

            builder.ToTable("bom_order");
            builder.Property(e => e.BomOrderType).HasColumnName("bom_order_type");
            builder.Property(e => e.MaterialId).HasColumnName("material_id");
        }
    }
}