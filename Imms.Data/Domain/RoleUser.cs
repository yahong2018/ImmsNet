using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class RoleUser:Entity<long>
    {        
        public long RoleId { get; set; }
        public long UserId { get; set; }
    }
}
