using System;
using Imms.Data;
using Imms.Mes.Domain;
using System.Linq;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;
using Imms.Mes.MasterData;

namespace Imms.Mes.Picking
{
    public class PickingApi
    {
        public PickingLogic PickingLogic { get; set; }

        public void ReportMaterialPicked(PickingReportDTO pickingReport)
        {
            PickingOrder pickingOrder = pickingReport.ToPickingOrder();
            PickingLogic.MaterialPicked(pickingOrder);
        }
    }

    public class PickedItemDTO
    {
        public string MaterialNo { get; set; }
        public double QtyPicked { get; set; }
    }

    public class PickingReportDTO
    {
        public string PickingOrderNo { get; set; }
        
        public string ContainerNo { get; set; }
        public string OperatorCode { get; set; }
        public DateTime OperationTime { get; set; }
        public PickedItemDTO[] PickedDetails { get; set; }

        public PickingOrder ToPickingOrder()
        {
            PickingOrder result = null;
            CommonDAO.UseDbContext((dbContext) =>
            {
                result = dbContext.Set<PickingOrder>().Where(x => x.OrderNo == this.PickingOrderNo).Include(x => x.PickingBomOrder).ThenInclude(x => x.Boms).Single();
                result.ContainerNo = this.ContainerNo;
                SystemUser operatorUser = dbContext.Set<SystemUser>().Where(x => x.UserCode == this.OperatorCode).Single();
                result.OperatorId = operatorUser.RecordId;
                result.TimePickingActual = this.OperationTime;

                foreach (PickedItemDTO detail in this.PickedDetails)
                {
                    PickingOrderItem item = new PickingOrderItem();
                    item.PickingOrder = result;
                    long materialId = dbContext.Set<Material>().Where(x => x.MaterialNo == detail.MaterialNo).Select(x => x.RecordId).Single();
                    item.Bom = result.PickingBomOrder.Boms.Where(x => x.ComponentMaterialId == materialId).Single();
                    item.PickedQty = detail.QtyPicked;

                    result.PickedItems.Add(item);
                }
            });

            return result;
        }
    }

}