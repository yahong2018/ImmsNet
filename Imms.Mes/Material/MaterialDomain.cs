using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Organization;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Text;

namespace Imms.Mes.Material
{
    public partial class Material : TrackableEntity<long>
    {
        public string MaterialNo { get; set; }
        public string MaterialName { get; set; }
        public long MaterialTypeId { get; set; }
        public string Unit { get; set; }
        public decimal? Width { get; set; }
        public decimal? Weight { get; set; }
        public decimal? Price { get; set; }
        public string Color { get; set; }
        public string Description { get; set; }

        public virtual MaterialType MaterialType { get; set; }
    }   

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
        public double QtyComponent { get; set; }
        public string ComponentUnit { get; set; }
        public bool IsMainFabric { get; set; }
        public long? ParentBomId { get; set; }

        public virtual BomOrder BomOrder { get; set; }
        public virtual Material ComponentMaterial { get; set; }
        public virtual Material AbstractComponentMaterial { get; set; }
        public virtual Bom ParentBom { get; set; }
        public virtual List<Bom> Children { get; set; } = new List<Bom>();
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
            builder.Property(e => e.QtyComponent).HasColumnName("qty_component");
            builder.Property(e => e.ComponentUnit).HasColumnName("component_unit");
            builder.Property(e => e.IsMainFabric).HasColumnName("is_main_fabric").HasColumnType("bit");
            builder.Property(e => e.ParentBomId).HasColumnName("parent_bom_id");

            builder.HasOne(e => e.BomOrder).WithMany(e => e.Boms).HasForeignKey(e => e.BomOrderId);
            builder.HasOne(e => e.ComponentMaterial).WithMany().HasForeignKey(e => e.ComponentMaterialId);
            builder.HasOne(e => e.AbstractComponentMaterial).WithMany().HasForeignKey(e => e.ComponentAbstractMaterialId);
            builder.HasOne(e => e.ParentBom).WithMany(e => e.Children).HasForeignKey(e => e.ParentBomId).HasConstraintName("parent_bom_id");
        }
    }

    public class MaterialConfigure : TrackableEntityConfigure<Material>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Material> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("material");

            builder.Property(e => e.Color).HasColumnName("color").HasMaxLength(20).IsUnicode(false);
            builder.Property(e => e.Description).HasColumnName("description").HasMaxLength(250).IsUnicode(false);
            builder.Property(e => e.MaterialName).IsRequired().HasColumnName("material_name").HasMaxLength(50).IsUnicode(false);
            builder.Property(e => e.MaterialNo).IsRequired().HasColumnName("material_no").HasMaxLength(20).IsUnicode(false);
            builder.Property(e => e.MaterialTypeId).HasColumnName("material_type_id").HasColumnType("bigint(20)");
            builder.Property(e => e.Price).HasColumnName("price").HasColumnType("decimal(10,2)");
            builder.Property(e => e.Unit).HasColumnName("unit").HasColumnType("varchar(20)");
            builder.Property(e => e.Weight).HasColumnName("weight").HasColumnType("decimal(10,4)");
            builder.Property(e => e.Width).HasColumnName("width").HasColumnType("decimal(10,4)");
        }
    }
}
