using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;

namespace Imms.Mes.Domain
{
    public partial class ProductionOrder : OrderEntity<long>
    {
        public string RequirementOrderNo { get; set; }
        public string ScheduleOrderNo { get; set; }
        public long FgMaterialId { get; set; }
        public byte Priority { get; set; }
        public long? WorkCenterId { get; set; }
        public int? PlannedQty { get; set; }
        public long? RoutingOrderId { get; set; }
        public long? BomOrderId { get; set; }
        public int? FinishedQty { get; set; }
        public int? SecondQualityQty { get; set; }
        public int? DefectQty { get; set; }
        public int? ActualQty { get; set; }
        public DateTime PlannedStartDate { get; set; }
        public DateTime PlannedEndDate { get; set; }
        public DateTime? ActualStartDate { get; set; }
        public DateTime? ActualEndDate { get; set; }
    }

    public class ProductionOrderConfigure : OrderEntityConfigure<ProductionOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<ProductionOrder> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("production_order");

            builder.Property(e => e.ActualEndDate).HasColumnName("actual_end_date");

            builder.Property(e => e.ActualQty)
                .HasColumnName("actual_qty")
                .HasColumnType("int(11)");

            builder.Property(e => e.ActualStartDate).HasColumnName("actual_start_date");

            builder.Property(e => e.BomOrderId)
                .HasColumnName("bom_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.DefectQty)
                    .HasColumnName("defect_qty")
                    .HasColumnType("int(11)");

            builder.Property(e => e.FgMaterialId)
                .HasColumnName("fg_material_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.FinishedQty)
                .HasColumnName("finished_qty")
                .HasColumnType("int(11)");

            builder.Property(e => e.PlannedEndDate).HasColumnName("planned_end_date");

            builder.Property(e => e.PlannedQty)
                .HasColumnName("planned_qty")
                .HasColumnType("int(11)");

            builder.Property(e => e.PlannedStartDate).HasColumnName("planned_start_date");

            builder.Property(e => e.Priority)
                .HasColumnName("priority")
                .HasColumnType("tinyint(4)");

            builder.Property(e => e.RequirementOrderNo)
                .HasColumnName("requirement_order_no")
                .HasColumnType("varchar(12)");

            builder.Property(e => e.RoutingOrderId)
                .HasColumnName("routing_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.ScheduleOrderNo)
                .HasColumnName("schedule_order_no")
                .HasColumnType("varchar(12)");

            builder.Property(e => e.SecondQualityQty)
                .HasColumnName("second_quality_qty")
                .HasColumnType("int(11)");

            builder.Property(e => e.WorkCenterId)
                    .HasColumnName("work_center_id")
                    .HasColumnType("bigint(20)");
        }
    }
}
