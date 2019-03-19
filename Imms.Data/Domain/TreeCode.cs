using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class TreeCode: TrackableEntity<long>
    {        
        public int CodeType { get; set; }
        public string CodeNo { get; set; }
        public string CodeName { get; set; }
        public string Description { get; set; }
        public long ParentId { get; set; }
        public string CodeNoPath { get; set; }
        public string CodeNamePath { get; set; }        
    }
}
