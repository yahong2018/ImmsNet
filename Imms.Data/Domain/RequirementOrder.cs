// using System;
// using System.Collections.Generic;
// using Microsoft.EntityFrameworkCore;
// using Microsoft.EntityFrameworkCore.Metadata.Builders;

// namespace Imms.Data.Domain
// {
//     public partial class RequirementOrder : OrderEntity<long>
//     {
//         public int OrderType { get; set; }
//         public int Priority { get; set; }
//         public long WorkCenterId { get; set; }
//         public long FgMaterialId { get; set; }
//         public int PlannedQty { get; set; }
//         public DateTime RequiredDeliveryDate { get; set; }
//         public string SaleOrderNo { get; set; }
//         public int RepeatType { get; set; }
//     }

//     public class RequirementOrderConfigure : OrderEntityConfigure<RequirementOrder>
//     {
//         protected override void InternalConfigure(EntityTypeBuilder<RequirementOrder> builder)
//         {
//             base.InternalConfigure(builder);
//             builder.ToTable("requirement_order");

//             builder.Property(e => e.FgMaterialId)
//                     .HasColumnName("fg_material_id")
//                     .HasColumnType("bigint(20)");

//             builder.Property(e => e.OrderType)
//                     .HasColumnName("order_type")
//                     .HasColumnType("int(11)");

//             builder.Property(e => e.PlannedQty)
//                 .HasColumnName("planned_qty")
//                 .HasColumnType("int(11)");

//             builder.Property(e => e.Priority)
//                 .HasColumnName("priority")
//                 .HasColumnType("int(11)");

//             builder.Property(e => e.RepeatType)
//                 .HasColumnName("repeat_type")
//                 .HasColumnType("int(11)")
//                 .HasDefaultValueSql("0");

//             builder.Property(e => e.RequiredDeliveryDate).HasColumnName("required_delivery_date");

//             builder.Property(e => e.SaleOrderNo)
//                 .HasColumnName("sale_order_no")
//                 .HasMaxLength(64)
//                 .IsUnicode(false);

//             builder.Property(e => e.WorkCenterId)
//                                .HasColumnName("work_center_id")
//                                .HasColumnType("bigint(20)");
//         }
//     }
// }
