using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class RolePrivilege:Entity<long>
    {        
        public long ProgramPrivilegeId { get; set; }
        public long RoleId { get; set; }
        public string ProgramId { get; set; }
        public string PrivilegeCode { get; set; }
    }
}
