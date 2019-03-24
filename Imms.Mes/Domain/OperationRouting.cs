using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data;

namespace Imms.Mes.Domain
{
    public partial class BaseOperation : TrackableEntity<long>
    {
        public string OperationNo { get; set; }
        public string OperationName { get; set; }
        public string StandardOperationProcedure { get; set; }
        public long MachineTypeId { get; set; }
        public double? StandardTime { get; set; }
        public double? StandardPrice { get; set; }
        public string PartType { get; set; }
        public string SectionType { get; set; }
        public string SectionName { get; set; }
        public bool IsOutsource { get; set; }
        public string QaProcedure { get; set; }
        public string Requirement { get; set; }
        public byte? RequiredLevel { get; set; }
    }

    public partial class Operation : BaseOperation
    {
    }

    public partial class OperationRouting : BaseOperation
    {
        public long OperationRoutingOrderId { get; set; }
        public long OperationId { get; set; }
        public string NextOpertionNo{get;set;}
        public long? NextRoutingId { get; set; }
        public long? PreRoutingId { get; set; }
        public string PrevOperationNo{get;set;}
    }

    public partial class OperationRoutingOrder : OrderEntity<long>
    {
        public int OrderType { get; set; }
        public long MaterialId { get; set; }
    }

    public class BaseOperationConfigure<E> : TrackableEntityConfigure<E> where E : BaseOperation
    {
        protected override void InternalConfigure(EntityTypeBuilder<E> builder)
        {
            base.InternalConfigure(builder);

            builder.Property(e => e.IsOutsource)
                   .HasColumnName("is_outsource")
                   .HasColumnType("bit(1)");

            builder.Property(e => e.MachineTypeId)
                .HasColumnName("machine_type_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.OperationName)
                .IsRequired()
                .HasColumnName("operation_name")
                .HasMaxLength(120)
                .IsUnicode(false);

            builder.Property(e => e.OperationNo)
                .IsRequired()
                .HasColumnName("operation_no")
                .HasMaxLength(20)
                .IsUnicode(false);

            builder.Property(e => e.PartType)
                    .HasColumnName("part_type")
                    .HasMaxLength(12)
                    .IsUnicode(false);

            builder.Property(e => e.QaProcedure)
                .HasColumnName("qa_procedure")
                .HasMaxLength(1000)
                .IsUnicode(false);

            builder.Property(e => e.Requirement)
                .HasColumnName("requirement")
                .HasMaxLength(1000)
                .IsUnicode(false);

            builder.Property(e => e.SectionName)
                .HasColumnName("section_name")
                .HasMaxLength(30)
                .IsUnicode(false);

            builder.Property(e => e.SectionType)
                .HasColumnName("section_type")
                .HasMaxLength(12)
                .IsUnicode(false);

            builder.Property(e => e.RequiredLevel)
                .HasColumnName("skill_level")
                .HasColumnType("tinyint(4)");

            builder.Property(e => e.StandardOperationProcedure)
                .HasColumnName("standard_operation_procedure")
                .HasMaxLength(200)
                .IsUnicode(false);

            builder.Property(e => e.StandardPrice)
                .HasColumnName("standard_price")
                .HasColumnType("double(8,4)");

            builder.Property(e => e.StandardTime)
                .HasColumnName("standard_time")
                .HasColumnType("double(8,4)");
        }
    }

    public class OperationConfigure : BaseOperationConfigure<Operation>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Operation> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("operation");
        }
    }

    public class OperationRoutingConfigure : BaseOperationConfigure<OperationRouting>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperationRouting> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operation_routing");

            builder.Property(e => e.OperationId)
                    .HasColumnName("operation_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OperationRoutingOrderId)
                .HasColumnName("operation_routing_order_id")
                .HasColumnType("bigint(20)");

            builder.Property(e => e.PreRoutingId)
                   .HasColumnName("pre_routing_id")
                   .HasColumnType("bigint(20)");

            builder.Property(e => e.NextRoutingId)
                .HasColumnName("next_routing_id")
                .HasColumnType("int(11)");
        }
    }

    public class OperationRoutingOrderConfigure : OrderEntityConfigure<OperationRoutingOrder>
    {
        protected override void InternalConfigure(EntityTypeBuilder<OperationRoutingOrder> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("operation_routing_order");

            builder.Property(e => e.MaterialId)
                    .HasColumnName("material_id")
                    .HasColumnType("bigint(20)");

            builder.Property(e => e.OrderType)
                    .HasColumnName("order_type")
                    .HasColumnType("int(11)");
        }
    }
}
