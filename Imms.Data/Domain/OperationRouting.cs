using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class OperationRouting: TrackableEntity<long>
    {        
        public long OperationRoutingOrderId { get; set; }
        public long OperationId { get; set; }
        public int SequenceNo { get; set; }
        public long? PreRoutingId { get; set; }        
    }
}
