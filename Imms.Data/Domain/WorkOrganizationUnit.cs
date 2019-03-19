using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class WorkOrganizationUnit: TrackableEntity<long>
    {        
        public int OrganizationType { get; set; }
        public string OrganizationCode { get; set; }
        public string OrganizationName { get; set; }
        public string Description { get; set; }
        public string Parameters { get; set; }
        public long ParentOrganizationId { get; set; }        
    }
}
