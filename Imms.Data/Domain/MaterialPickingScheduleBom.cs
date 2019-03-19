using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class MaterialPickingScheduleBom: TrackableEntity<long>
    {        
        public long MaterialPickingOrderId { get; set; }
        public long ComponentMaterialId { get; set; }
        public double Qty { get; set; }
        public long? ComponentMaterialUomId { get; set; }
        public double PickedQty { get; set; }       
    }
}
