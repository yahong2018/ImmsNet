using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class WorkstationCheckIn : Entity<long>
    {
        public long WorkStationId { get; set; }
        public long OperatorId { get; set; }
        public DateTime? CheckInTime { get; set; }
        public DateTime? CheckOutTime { get; set; }
    }

    public class WorkstationCheckInConfigure : EntityConfigure<WorkstationCheckIn>
    {
        protected override void InternalConfigure(EntityTypeBuilder<WorkstationCheckIn> builder)
        {
            base.Configure(builder);
            builder.ToTable("workstation_check_in");

            builder.Property(e => e.CheckInTime).HasColumnName("check_in_time");

            builder.Property(e => e.CheckOutTime).HasColumnName("check_out_time");

            builder.Property(e => e.OperatorId)
                .HasColumnName("operator_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.WorkStationId)
                .HasColumnName("work_station_id")
                .HasColumnType("bigint(20)");
        }
    }
}
