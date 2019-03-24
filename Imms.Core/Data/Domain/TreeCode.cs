using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class TreeCode : TrackableEntity<long>
    {
      //  public string CodeType { get; set; }
  
        public string CodeNo { get; set; }
        public string CodeName { get; set; }
        public string Description { get; set; }
        public long ParentId { get; set; }
        public string CodeNoPath { get; set; }
        public string CodeNamePath { get; set; }
    }

    public class TreeCodeConfigure : TrackableEntityConfigure<TreeCode>
    {
        protected override void InternalConfigure(EntityTypeBuilder<TreeCode> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("tree_code");

            builder.Property(e => e.CodeName)
                    .IsRequired()
                    .HasColumnName("code_name")
                    .HasMaxLength(30)
                    .IsUnicode(false);

            builder.Property(e => e.CodeNamePath)
                .IsRequired()
                .HasColumnName("code_name_path")
                .HasMaxLength(330)
                .IsUnicode(false);

            builder.Property(e => e.CodeNo)
                .IsRequired()
                .HasColumnName("code_no")
                .HasMaxLength(10)
                .IsUnicode(false);

            builder.Property(e => e.CodeNoPath)
                .IsRequired()
                .HasColumnName("code_no_path")
                .HasMaxLength(110)
                .IsUnicode(false);

            //builder.Property(e => e.CodeType)
            //    .HasColumnName("code_type")
            //    .HasColumnType("int(11)");

            builder.Property(e => e.Description)
                   .HasColumnName("description")
                   .HasMaxLength(250)
                   .IsUnicode(false);

            builder.Property(e => e.ParentId)
                    .HasColumnName("parent_id")
                    .HasColumnType("bigint(20)")
                    .HasDefaultValueSql("0");

        }

    }
}
