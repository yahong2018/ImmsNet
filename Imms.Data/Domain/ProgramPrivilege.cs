using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class ProgramPrivilege:Entity<long>
    {        
        public string ProgramId { get; set; }
        public string PrivilegeCode { get; set; }
        public string PrivilegeName { get; set; }
    }
}
