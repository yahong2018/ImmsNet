using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class CodeSeed:Entity<long>
    {        
        public string SeedNo { get; set; }
        public string SeedName { get; set; }
        public int InitialValue { get; set; }
        public string Prefix { get; set; }
        public string Postfix { get; set; }
        public int TotalLength { get; set; }
    }
}
