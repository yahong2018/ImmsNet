using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class Material:TrackableEntity<long>
    {     
        public string MaterialNo { get; set; }
        public string MaterialName { get; set; }
        public long MaterialTypeId { get; set; }
        public long UnitId { get; set; }
        public decimal? Width { get; set; }
        public decimal? Weight { get; set; }
        public long? SizeId { get; set; }
        public decimal? Price { get; set; }
        public string Color { get; set; }
        public string Description { get; set; }        
    }
}
