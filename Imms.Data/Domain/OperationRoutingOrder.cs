using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class OperationRoutingOrder: OrderEntity<long>
    {   
        public int OrderType { get; set; }
        public long MaterialId { get; set; }
    }
}
