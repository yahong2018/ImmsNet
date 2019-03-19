using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class ScheduleOrder : TrackableEntity<long>
    {
        public string OrderNo { get; set; }
        public int OrderStatus { get; set; }
        public long? RequirementOrderId { get; set; }
        public byte Priority { get; set; }
        public long PlanId { get; set; }
        public long WorkCenterId { get; set; }
        public long FgMaterialId { get; set; }
        public int QtyPlanned { get; set; }
        public int? QtyActual { get; set; }
        public DateTime DatePlanStart { get; set; }
        public DateTime DatePlanEnd { get; set; }
        public DateTime? DateActualStart { get; set; }
        public DateTime? DateActualEnd { get; set; }
    }

    public class ScheduleOrderConfigure : OrderEntityConfigure<ScheduleOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ScheduleOrder> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("schedule_order");

            builder.Property(e => e.DateActualEnd).HasColumnName("date_actual_end");

            builder.Property(e => e.DateActualStart).HasColumnName("date_actual_start");

            builder.Property(e => e.DatePlanEnd).HasColumnName("date_plan_end");

            builder.Property(e => e.DatePlanStart).HasColumnName("date_plan_start");

            builder.Property(e => e.FgMaterialId)
                .HasColumnName("fg_material_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.PlanId)
                    .HasColumnName("plan_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.Priority)
                .HasColumnName("priority")
                .HasColumnType("tinyint(4)");

            builder.Property(e => e.QtyActual)
                .HasColumnName("qty_actual")
                .HasColumnType("int(11)");

            builder.Property(e => e.QtyPlanned)
                .HasColumnName("qty_planned")
                .HasColumnType("int(11)");

            builder.Property(e => e.RequirementOrderId)
                .HasColumnName("requirement_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.WorkCenterId)
                    .HasColumnName("work_center_id")
                    .HasColumnType("bigint(20)");
        }
    }
}
