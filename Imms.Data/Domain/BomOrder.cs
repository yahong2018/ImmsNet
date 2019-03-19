using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class BomOrder:OrderEntity<long>
    {   
        public int BomOrderType { get; set; }
        public long MaterialId { get; set; }        
    }
}
