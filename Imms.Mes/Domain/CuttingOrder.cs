﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;

namespace Imms.Mes.Domain
{
    public partial class CuttingOrder : OrderEntity<long>
    {
        public long ProductionOrderId { get; set; }
        public string CuttingTableNo { get; set; }
        public string ContainerNo { get; set; }
        public int PlannedQty { get; set; }
        public string FgMaterialId { get; set; }
        public string FabricMaterialType { get; set; }
        public long FabricMaterialId { get; set; }
        public int Plies { get; set; }
        public double Width { get; set; }
        public double Length { get; set; }
        public double CuttingEfficiency { get; set; }
        public long? WorkStationId { get; set; }
        public DateTime PlannedCuttingDate { get; set; }
        public DateTime PlannedEndDate { get; set; }
        public DateTime? ActualCuttingDate { get; set; }
        public DateTime? ActualEndDate { get; set; }
        public int FinishedQty { get; set; }
        public long? OperatorId { get; set; }
    }

    public class CuttingOrderConfigure : OrderEntityConfigure<CuttingOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<CuttingOrder> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("cutting_order");

            builder.Property(e => e.ActualCuttingDate).HasColumnName("actual_cutting_date");
            builder.Property(e => e.ActualEndDate).HasColumnName("actual_end_date");
            builder.Property(e => e.ContainerNo)
                .HasColumnName("container_no")
                .HasMaxLength(64)
                .IsUnicode(false);

            builder.Property(e => e.CuttingEfficiency)
                    .HasColumnName("cutting_efficiency")
                    .HasColumnType("double(7,4)");

            builder.Property(e => e.CuttingTableNo)
                .HasColumnName("cutting_table_no")
                .HasMaxLength(64)
                .IsUnicode(false);

            builder.Property(e => e.FabricMaterialId)
                .HasColumnName("fabric_material_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.FabricMaterialType)
                .IsRequired()
                .HasColumnName("fabric_material_type")
                .HasMaxLength(64)
                .IsUnicode(false);

            builder.Property(e => e.FgMaterialId)
                .IsRequired()
                .HasColumnName("fg_material_id")
                .HasMaxLength(64)
                .IsUnicode(false);

            builder.Property(e => e.FinishedQty)
                .HasColumnName("finished_qty")
                .HasColumnType("int(11)")
                .HasDefaultValueSql("0");

            builder.Property(e => e.Length)
                .HasColumnName("length")
                .HasColumnType("double(8,4)");

            builder.Property(e => e.OperatorId)
                .HasColumnName("operator_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.PlannedCuttingDate).HasColumnName("planned_cutting_date");

            builder.Property(e => e.PlannedEndDate).HasColumnName("planned_end_date");

            builder.Property(e => e.PlannedQty)
                .HasColumnName("planned_qty")
                .HasColumnType("int(11)")
                .HasDefaultValueSql("0");

            builder.Property(e => e.Plies)
                .HasColumnName("plies")
                .HasColumnType("int(11)");

            builder.Property(e => e.ProductionOrderId)
                .HasColumnName("production_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.Width)
                    .HasColumnName("width")
                    .HasColumnType("double(8,4)");

            builder.Property(e => e.WorkStationId)
                .HasColumnName("work_station_id")
                .HasColumnType("bigint(20)");

        }
    }
}