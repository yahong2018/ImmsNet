using System;
using System.Collections.Generic;

namespace Imms.Data.Domain
{
    public partial class Operation: TrackableEntity<long>
    {        
        public string OperationNo { get; set; }
        public string OperationName { get; set; }
        public string StandardOperationProcedure { get; set; }
        public long MachineTypeId { get; set; }
        public double? StandardTime { get; set; }
        public double? StandardPrice { get; set; }
        public string PartType { get; set; }
        public string SectionType { get; set; }
        public string SectionName { get; set; }
        public short IsOutsource { get; set; }
        public string QaProcedure { get; set; }
        public string QualityRequirement { get; set; }
        public byte? SkillLevel { get; set; }       
    }
}
