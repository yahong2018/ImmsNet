using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class OrderMeasure: TrackableEntity<long>
    {        
        public long OrderId { get; set; }
        public string BodyNo { get; set; }
        public int MeasureData { get; set; }    
    }
}
