using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class RequirementOrder: OrderEntity<long>
    {   
        public int OrderType { get; set; }
        public int Priority { get; set; }
        public long WorkCenterId { get; set; }
        public long FgMaterialId { get; set; }
        public int PlannedQty { get; set; }
        public DateTime RequiredDeliveryDate { get; set; }
        public string SaleOrderNo { get; set; }
        public int RepeatType { get; set; }       
    }
}
