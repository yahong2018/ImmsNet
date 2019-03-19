using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class ProductionWorkOrderRouting: TrackableEntity<long>
    {        
        public long OperationRoutingOrderId { get; set; }
        public long ProductionWorkOrderId { get; set; }
        public long OperationRoutingId { get; set; }
        public long? OperatorId { get; set; }
        public long? WorkStationId { get; set; }
        public int? ScrapQty { get; set; }
        public int? CompleteQty { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? CompleteTime { get; set; }
        public int OrderStatus { get; set; }        
    }
}
