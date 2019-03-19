using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class PlanCode: TrackableEntity<long>
    {        
        public int CodeType { get; set; }
        public string CodeNo { get; set; }
        public string CodeName { get; set; }
        public string Description { get; set; }       
    }
}
