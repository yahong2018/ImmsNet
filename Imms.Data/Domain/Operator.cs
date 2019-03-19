using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class Operator : TrackableEntity<long>
    {
        public long UserId { get; set; }
        public long OrganizationId { get; set; }
        public long SupervisorId { get; set; }
    }

    public class OperatorConfigure : TrackableEntityConfigure<Operator>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Operator> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operator");

            builder.Property(e => e.OrganizationId)
                .HasColumnName("organization_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.SupervisorId)
                .HasColumnName("supervisor_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.UserId)
                    .HasColumnName("user_id")
                    .HasColumnType("bigint(20)");
        }
    }
}
