using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class OperatorCapability: TrackableEntity<long>
    {        
        public long OperatorId { get; set; }
        public long OperationId { get; set; }
        public byte SkillLevel { get; set; }       
    }
}
