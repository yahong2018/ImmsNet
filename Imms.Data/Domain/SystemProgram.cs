using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class SystemProgram:Entity<string>
    {        
        public string ProgramCode { get; set; }
        public string ProgramName { get; set; }
        public string Url { get; set; }
        public string Glyph { get; set; }
        public int ShowOrder { get; set; }
        public string Parameters { get; set; }
        public string ParentId { get; set; }
    }
}
