using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class ProductionOrder: OrderEntity<long>
    {   
        public long? RequirementOrderId { get; set; }
        public long? ScheduleOrderId { get; set; }
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
}
