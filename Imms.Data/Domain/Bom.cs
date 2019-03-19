using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class Bom : TrackableEntity<long>
    {
        public long BomOrderId { get; set; }
        public long ComponentMaterialId { get; set; }
        public long? ComponentAbstractMaterialId { get; set; }
        public float ComponentQty { get; set; }
        public int ComponentUnitId { get; set; }
        public string ComponentMaterialNoPath { get; set; }
        public string ComponentMaterialNamePath { get; set; }
        public short IsFabric { get; set; }
        public long ParentBomId { get; set; }
    }
}
