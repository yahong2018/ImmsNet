using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class Operator: TrackableEntity<long>
    {        
        public long UserId { get; set; }
        public long OrganizationId { get; set; }
        public long SupervisorId { get; set; }        
    }
}
