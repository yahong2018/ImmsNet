using System;
using System.Collections.Generic;

namespace Imms.Data
{
    public partial class SystemUser
    {
        public long RecordId { get; set; }
        public string UserCode { get; set; }
        public string UserName { get; set; }
        public string Pwd { get; set; }
        public byte UserStatus { get; set; }
        public string Email { get; set; }
        public short Online { get; set; }
        public DateTime? LastLoginTime { get; set; }
    }
}
