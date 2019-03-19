using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class SystemUser:Entity<long>
    {        
        public string UserCode { get; set; }
        public string UserName { get; set; }
        public string Pwd { get; set; }
        public byte UserStatus { get; set; }
        public string Email { get; set; }
        public short IsOnline { get; set; }
        public DateTime? LastLoginTime { get; set; }
    }
}
