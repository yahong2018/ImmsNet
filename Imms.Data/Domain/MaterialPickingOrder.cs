using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class MaterialPickingOrder: TrackableEntity<long>
    {        
        public string OrderNo { get; set; }
        public int OrderStatus { get; set; }
        public long PickingScheduleId { get; set; }
        public string ContainerNo { get; set; }
        public long OperatorId { get; set; }        
    }
}
