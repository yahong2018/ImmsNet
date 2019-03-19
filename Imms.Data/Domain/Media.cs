using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class Media: TrackableEntity<long>
    {
        public int MediaType { get; set; }
        public long BelongToId { get; set; }
        public string MediaUrl { get; set; }
        public string MediaName { get; set; }
        public int MediaSize { get; set; }
        public string Description { get; set; }
    }
}
