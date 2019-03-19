using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class MaterialPickingOrderDetail: TrackableEntity<long>
    {        
        public long MaterialPickingOrderId { get; set; }
        public long? MaterialId { get; set; }
        public double? PickedQty { get; set; }        
    }
}
