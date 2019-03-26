using Imms.Data;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Mes.Domain
{
    public partial class BomOrder : OrderEntity<long>
    {
        public int BomOrderType { get; set; }
        public long MaterialId { get; set; }

        public virtual Material Material { get; set; }
        public virtual List<Bom> Boms { get; set; } = new List<Bom>();
    }

    public partial class Bom : TrackableEntity<long>
    {
        public long BomOrderId { get; set; }
        public long ComponentMaterialId { get; set; }
        public long? ComponentAbstractMaterialId { get; set; }
        public double ComponentQty { get; set; }
        public long ComponentUnitId { get; set; }
        public string ComponentMaterialNoPath { get; set; }
        public string ComponentMaterialNamePath { get; set; }
        public bool IsMainFabric { get; set; }
        public long ParentBomId { get; set; }

        public virtual BomOrder BomOrder { get; set; }
    }

    public class BomOrderConfigure : OrderEntityConfigure<BomOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<BomOrder> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("bom_order");
            builder.Property(e => e.BomOrderType).HasColumnName("bom_order_type");
            builder.Property(e => e.MaterialId).HasColumnName("material_id");

            builder.HasOne(e => e.Material).WithMany().HasForeignKey(e => e.MaterialId);
            builder.HasMany(e => e.Boms).WithOne(e => e.BomOrder).HasForeignKey(e => e.BomOrderId);
        }
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
            builder.Property(e => e.IsMainFabric).HasColumnName("is_fabric");
            builder.Property(e => e.ParentBomId).HasColumnName("parent_bom_id");

            builder.HasOne(e => e.BomOrder).WithMany(e => e.Boms).HasForeignKey(e => e.BomOrderId);
        }
    }

}
