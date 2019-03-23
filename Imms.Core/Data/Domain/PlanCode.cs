using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class PlanCode : TrackableEntity<long>
    {
        //public string CodeType { get; set; }        
        public string CodeNo { get; set; }
        public string CodeName { get; set; }
        public string Description { get; set; }
    }

    public class MaterialUnit : PlanCode
    {
        [NotMapped]
        public string UnitNo { get { return base.CodeNo; } set { base.CodeNo = value; } }
        [NotMapped]
        public string UnitName { get { return base.CodeName; } set { base.CodeName = value; } }
    }

    public class PlanCodeConfigure : TrackableEntityConfigure<PlanCode>
    {
        protected override void InternalConfigure(EntityTypeBuilder<PlanCode> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("plan_code");

            builder.HasDiscriminator("code_type", typeof(string))
                .HasValue<MaterialUnit>(GlobalConstants.CODE_TABLE_TYPE_MATERIAL_UNIT)
                ;

            builder.Property(e => e.CodeName)
                                .IsRequired()
                                .HasColumnName("code_name")
                                .HasMaxLength(30)
                                .IsUnicode(false);

            builder.Property(e => e.CodeNo)
                .IsRequired()
                .HasColumnName("code_no")
                .HasMaxLength(10)
                .IsUnicode(false);

            //builder.Property(e => e.CodeType)
            //    .HasColumnName("code_type")
            //    .HasColumnType("int(11)");

            builder.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(250)
                    .IsUnicode(false);
        }
    }
}
