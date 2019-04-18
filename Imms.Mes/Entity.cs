using System;
using Imms.Data;
using Imms.Mes.Organization;

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
