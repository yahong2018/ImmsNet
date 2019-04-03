using System;
using System.Linq;
using Imms.Data;
using Imms.Mes.MasterData;
using Microsoft.AspNetCore.Mvc;

namespace Imms.Mes.Stitch
{
    [Route("/Imms/Mes/Stich")]
    public class StitchApi
    {
        public StitchLogic ProductionLogic{get;set;}

        public ProductionWorkOrderRouting[] GetWorkStationRoutings(string workStationCode){
            WorkStation workStation = CommonDAO.GetOneByFilter<WorkStation>(x => x.OrganizationCode == workStationCode);
            if (workStation != null)
            {
                return ProductionLogic.GetWorkStationRoutings(workStation);
            }
            return null;
        }
    }
}