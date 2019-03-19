using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class CuttingOrder:OrderEntity<long>
    { 
        public long ProductionOrderId { get; set; }
        public string CuttingTableNo { get; set; }
        public string ContainerNo { get; set; }
        public int PlannedQty { get; set; }
        public string FgMaterialId { get; set; }
        public string FabricMaterialType { get; set; }
        public long FabricMaterialId { get; set; }
        public int Plies { get; set; }
        public double Width { get; set; }
        public double Length { get; set; }
        public double CuttingEfficiency { get; set; }
        public long? WorkStationId { get; set; }
        public DateTime PlannedCuttingDate { get; set; }
        public DateTime PlannedEndDate { get; set; }
        public DateTime? ActualCuttingDate { get; set; }
        public DateTime? ActualEndDate { get; set; }
        public int FinishedQty { get; set; }
        public long? OperatorId { get; set; }        
    }
}
