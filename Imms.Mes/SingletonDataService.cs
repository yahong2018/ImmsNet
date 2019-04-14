using System.Collections.Generic;
using Imms.Mes.MasterData;
using Microsoft.EntityFrameworkCore;

namespace Imms.Mes
{
    public class SingletonDataService
    {
        public static readonly SingletonDataService Instance = new SingletonDataService();
        protected SingletonDataService() { }

        public List<WorkStation> WorkStations { get; set; }
        public List<OperatorCapability> OperatorCapabilities { get; set; }
        public List<WorkLine> ProudctionLines { get; set; }
        public List<WorkCenter> WorkCenters { get; set; }
        // public List<Size> Sizes{get;set;}

    }
}