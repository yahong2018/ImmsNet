using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class CodeSeed : Entity<long>
    {
        public string SeedNo { get; set; }
        public string SeedName { get; set; }
        public int InitialValue { get; set; }
        public string Prefix { get; set; }
        public string Postfix { get; set; }
        public int TotalLength { get; set; }
    }

    public class CodeSeedConfigure : EntityConfigure<CodeSeed>
    {
        protected override void InternalConfigure(EntityTypeBuilder<CodeSeed> builder)
        {
            base.Configure(builder);

            builder.ToTable("code_seed");
            builder.Property(e => e.InitialValue).HasColumnName("initial_value");
            builder.Property(e => e.Postfix).IsRequired().HasColumnName("postfix").HasMaxLength(10);
            builder.Property(e => e.Prefix).IsRequired().HasColumnName("prefix").HasMaxLength(10);
            builder.Property(e => e.SeedName).IsRequired().HasColumnName("seed_name").HasMaxLength(50);
            builder.Property(e => e.SeedNo).IsRequired().HasColumnName("seed_no").HasMaxLength(50);
            builder.Property(e => e.TotalLength).HasColumnName("total_length");
        }
    }
}
