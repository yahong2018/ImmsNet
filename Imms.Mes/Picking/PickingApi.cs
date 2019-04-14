using System;
using Imms.Data;
using Imms.Mes.Domain;
using System.Linq;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;
using Imms.Mes.MasterData;
using Microsoft.AspNetCore.Mvc;

namespace Imms.Mes.Picking
{
    [Route("Imms/Mes/Picking")]
    public class PickingApi : Controller
    {
        public PickingOrder Create(PickingOrder pickingOrder)
        {


            return pickingOrder;
        }

        [HttpGet("MaterialToPreparePicking")]
        public PickingOrder[] GetMaterialToPreparePicking()
        {
            return CommonDAO.GetAllByFilter<PickingOrder>(x => x.OrderStatus == GlobalConstants.STATUS_ORDER_PLANNED).ToArray();
        }

        [HttpPost("MaterialPrepared/{pickingOrderNo}")]
        public void MaterialPrepared(string pickingOrderNo)
        {
            PickingOrder pickingOrder = CommonDAO.GetOneByFilter<PickingOrder>(x => x.OrderNo == pickingOrderNo);
            PickingLogic.Instance.MaterialPrepared(pickingOrder);
        }

        [HttpGet("MaterialToPicking")]
        public PickingOrder[] GetMaterialToPicking()
        {
            return CommonDAO.GetAllByFilter<PickingOrder>(x => x.OrderStatus == GlobalConstants.STATUS_PICKING_ORDER_PREPARED).ToArray();
        }

        [HttpPost("ReportMaterialPicked")]
        public void ReportMaterialPicked(PickingReportDTO pickingReport)
        {
            PickingOrder pickingOrder = pickingReport.ToPickingOrder();
            PickingLogic.Instance.MaterialPicked(pickingOrder);
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