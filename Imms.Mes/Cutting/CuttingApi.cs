using System.Linq;
using Imms.Data;
using Imms.Data.Domain;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Imms.Mes.Organization;

namespace Imms.Mes.Cutting
{
    [Route("/Imms/Mes/Cutting")]
    public class CuttingApi : Controller
    {  

        [HttpGet("GetToStart")]
        public CuttingOrder[] GetCuttingOrderToStart()
        {
            CuttingOrder[] result = null;
            CommonDAO.UseDbContext(dbContext =>
            {
                result = dbContext.Set<CuttingOrder>().Where(x => x.OrderStatus == GlobalConstants.STATUS_ORDER_PLANNED).ToArray();
            });

            return result;
        }

        [HttpPost("StartCutting/{cutingOrderNo}&{operatorCode}&{workStationCode}")]
        public void StartCutting(string cuttingOrderNo, string operatorCode,string workStationCode)
        {
            CuttingOrder cuttingOrder = CommonDAO.AssureExistsByFilter<CuttingOrder>(x => x.OrderNo == cuttingOrderNo);
            SystemUser user = CommonDAO.AssureExistsByFilter<SystemUser>(x => x.UserCode == operatorCode);
            cuttingOrder.OperatorId = user.RecordId;
            WorkStation workStation = CommonDAO.AssureExistsByFilter<WorkStation>(x => x.OrganizationCode == workStationCode);            

            CuttingLogic.Instance.StartCuttingOrder(cuttingOrder,workStation);
        }

        [HttpPost("CuttingFinished")]
        public void CuttingFinished(CutingReportDTO report)
        {
            CuttingOrder cuttingOrder = report.ToCuttingOrder();
            CuttingLogic.Instance.CuttinngOrderFinished(cuttingOrder);
        }
    }

    public class CutingReportDTO
    {
        public string CuttingOrdreNo;
        public string ContainerNo;
        public string OperatorCode;
        public SortedDictionary<string, int> Sizes { get; set; } = new SortedDictionary<string, int>();

        public CuttingOrder ToCuttingOrder()
        {
            CuttingOrder result = null;
            CommonDAO.UseDbContext(dbContext =>
            {
                result = dbContext.Set<CuttingOrder>().Where(x => x.OrderNo == this.CuttingOrdreNo).Include(x => x.Sizes).Single();
                result.ContainerNo = this.ContainerNo;
                SystemUser user = dbContext.Set<SystemUser>().Where(x => x.UserCode == this.OperatorCode).Single();
                result.OperatorId = user.RecordId;
                foreach (KeyValuePair<string, int> item in this.Sizes)
                {
                    CuttingOrderSize size =  result.Sizes.Where(x=>x.Size==item.Key).Single();
                    size.QtyFinished = item.Value;                    
                }
            });

            return result;
        }
    }
}