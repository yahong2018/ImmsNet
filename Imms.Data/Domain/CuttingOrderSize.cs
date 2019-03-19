using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class CuttingOrderSize:TrackableEntity<long>
    {        
        public long CuttingOrderId { get; set; }
        public string Size { get; set; }
        public int? LayerQty { get; set; }
        public int? PlannedQty { get; set; }
        public int? ActualQty { get; set; }
        public int? CreatedWorkOrderQty { get; set; }        
    }
}
