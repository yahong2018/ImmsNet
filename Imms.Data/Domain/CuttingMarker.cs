using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class CuttingMarker:TrackableEntity<long>
    {        
        public long CuttingOrderId { get; set; }
        public long? MediaId { get; set; }
        public string Remark { get; set; }
        public long? MarkerFileId { get; set; }     
    }
}
