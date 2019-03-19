using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class WorkstationCheckIn:Entity<long>
    {        
        public long WorkStationId { get; set; }
        public long OperatorId { get; set; }
        public DateTime? CheckInTime { get; set; }
        public DateTime? CheckOutTime { get; set; }
    }
}
