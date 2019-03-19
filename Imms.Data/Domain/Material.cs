using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class Material : TrackableEntity<long>
    {
        public string MaterialNo { get; set; }
        public string MaterialName { get; set; }
        public long MaterialTypeId { get; set; }
        public long UnitId { get; set; }
        public decimal? Width { get; set; }
        public decimal? Weight { get; set; }
        public long? SizeId { get; set; }
        public decimal? Price { get; set; }
        public string Color { get; set; }
        public string Description { get; set; }
    }

    public class MaterialConfigure : TrackableEntityConfigure<Material>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Material> builder)
        {
            base.Configure(builder);
            builder.ToTable("material");

            builder.Property(e => e.Color)
                    .HasColumnName("color")
                    .HasMaxLength(20)
                    .IsUnicode(false);

            builder.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(250)
                    .IsUnicode(false);

            builder.Property(e => e.MaterialName)
                .IsRequired()
                .HasColumnName("material_name")
                .HasMaxLength(30)
                .IsUnicode(false);

            builder.Property(e => e.MaterialNo)
                .IsRequired()
                .HasColumnName("material_no")
                .HasMaxLength(12)
                .IsUnicode(false);

            builder.Property(e => e.MaterialTypeId)
                .HasColumnName("material_type_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.Price)
                    .HasColumnName("price")
                    .HasColumnType("decimal(10,2)");

            builder.Property(e => e.SizeId)
                .HasColumnName("size_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.UnitId)
                .HasColumnName("unit_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.Weight)
                    .HasColumnName("weight")
                    .HasColumnType("decimal(10,4)");

            builder.Property(e => e.Width)
                .HasColumnName("width")
                .HasColumnType("decimal(10,4)");
        }
    }
}
