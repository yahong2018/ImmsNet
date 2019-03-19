using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class MaterialPickingSchedule: TrackableEntity<long>
    {   
        public string OrderNo { get; set; }
        public int OrderStatus { get; set; }
        public long ProductionOrderId { get; set; }        
    }
}
