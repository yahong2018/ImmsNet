using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class ProductionWorkOrder: OrderEntity<long>
    {  
        public long ProductionOrderId { get; set; }
        public long BomOrderId { get; set; }
        public long OperationRoutingOrderId { get; set; }
        public long CuttingOrderId { get; set; }
        public long SizeId { get; set; }
        public DateTime PlannedStartDate { get; set; }
        public DateTime PlannedEndDate { get; set; }
        public DateTime? ActualStartDate { get; set; }
        public DateTime? ActualEndDate { get; set; }
        public byte SynFinishStatus { get; set; }        
    }
}
