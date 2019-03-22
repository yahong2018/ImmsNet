using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Reflection;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class Bom : TrackableEntity<long>
    {           
        public long BomOrderId { get; set; }
        public long ComponentMaterialId { get; set; }
        public long? ComponentAbstractMaterialId { get; set; }
        public float ComponentQty { get; set; }
        public long ComponentUnitId { get; set; }
        public string ComponentMaterialNoPath { get; set; }
        public string ComponentMaterialNamePath { get; set; }
        public short IsFabric { get; set; }
        public long ParentBomId { get; set; }
    }

    public class BomConfigure : TrackableEntityConfigure<Bom>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Bom> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("bom");

            builder.Property(e => e.BomOrderId).HasColumnName("bom_order_id");
            builder.Property(e => e.ComponentAbstractMaterialId).HasColumnName("component_abstract_material_id");
            builder.Property(e => e.ComponentMaterialId).IsRequired().HasColumnName("component_material_id");
            builder.Property(e => e.ComponentMaterialNamePath).IsRequired().HasColumnName("component_material_name_path").HasMaxLength(330);
            builder.Property(e => e.ComponentMaterialNoPath).IsRequired().HasColumnName("component_material_no_path").HasMaxLength(130);
            builder.Property(e => e.ComponentQty).HasColumnName("component_qty");
            builder.Property(e => e.ComponentUnitId).HasColumnName("component_unit_id");
            builder.Property(e => e.IsFabric).HasColumnName("is_fabric");
            builder.Property(e => e.ParentBomId).HasColumnName("parent_bom_id");
        }
    }

}
