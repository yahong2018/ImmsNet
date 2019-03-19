using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class OrderSize: TrackableEntity<long>
    {        
        public long OrderId { get; set; }
        public long SizeId { get; set; }
        public string SizeCode { get; set; }
        public int? QytPlanned { get; set; }     
    }
}
