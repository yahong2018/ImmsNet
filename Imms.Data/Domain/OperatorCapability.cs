using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class OperatorCapability : TrackableEntity<long>
    {
        public long OperatorId { get; set; }
        public long OperationId { get; set; }
        public byte SkillLevel { get; set; }
    }

    public class OperatorCapabilityConfigure : TrackableEntityConfigure<OperatorCapability>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperatorCapability> builder)
        {
            base.Configure(builder);
            builder.ToTable("operator_capability");

            builder.Property(e => e.OperationId)
                    .HasColumnName("operation_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OperatorId)
                .HasColumnName("operator_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.SkillLevel)
                   .HasColumnName("skill_level")
                   .HasColumnType("tinyint(4)");

        }
    }
}
