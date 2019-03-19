using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class ScheduleOrder: TrackableEntity<long>
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
}
