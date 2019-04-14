using System;
using Imms.Data;
using Imms.Mes.MasterData;

namespace Imms.Mes
{
    public interface IWorkStationFinder
    {
        WorkStation FindWorkStation(IWrokStationFinderParameter imputParameter);
    }

    public interface IWrokStationFinderParameter
    {

    }
}
