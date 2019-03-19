using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class SystemRole:Entity<long>
    {        
        public string RoleCode { get; set; }
        public string RoleName { get; set; }
    }
}
