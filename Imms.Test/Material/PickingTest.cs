using Imms.Data;
using Imms.Mes.Cutting;
using Imms.Mes.Organization;
using Imms.Mes.Picking;
using Imms.Mes.Stitch;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Xunit;
using Xunit.Abstractions;

namespace Imms.Test.Material
{
    public class PickingTest:BaseTestClass
    {
        public PickingTest(ITestOutputHelper output)
        {
            this.Output = output;
        }

        public void CreatePickingOrderForCadTest()
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                string[] cuttingMaterialTypes = new string[]{
                    GlobalConstants.TYPE_MATERIAL_FABRIC,  //面料
                    GlobalConstants.TYPE_MATERIAL_LINING,  //里料
                    GlobalConstants.TYPE_MATERIAL_INTER_LINING//衬布
                };

                ProductionOrder productionOrder = (ProductionOrder)dbContext.Find(typeof(ProductionOrder), 1L);
                var boms = dbContext.Set<Bom>()
                    .Join(dbContext.Set<Imms.Mes.Organization.Material>(), b => b.ComponentMaterialId, m => m.RecordId, (b, m) => new { bom = b, material = m })
                    .Join(dbContext.Set<MaterialType>(), m => m.material.MaterialTypeId, t => t.RecordId, (bm, t) => new { bm.bom, bm.material, material_type = t })
                    .Where(x => x.bom.BomOrderId == productionOrder.BomOrderId
                           && cuttingMaterialTypes.Contains(x.material_type.CodeNo)
                    ).Select(x => x.bom)
                    .ToList();

                List<Bom> theNewBoms = new List<Bom>();
                foreach (Bom bom in boms)
                {
                    Bom newBom = new Bom();
                    newBom.Clone(bom);
                    theNewBoms.Add(newBom);
                }
                BomOrder pickingBomOrder = PickingLogic.Instance.CreatePickingBomOrder(productionOrder, theNewBoms);
                PickingOrder pickingOrder = PickingLogic.Instance.CreatePickingOrder(productionOrder, pickingBomOrder, GlobalConstants.TYPE_PICKING_ORDER_CUTTING);

                dbContext.Set<PickingOrder>().Add(pickingOrder);
                dbContext.SaveChanges();
            });
        }


        public void CreatePickingOrderForStichTest()
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                string[] cuttingMaterialTypes = new string[]{
                    GlobalConstants.TYPE_MATERIAL_FABRIC,  //面料
                    GlobalConstants.TYPE_MATERIAL_LINING,  //里料
                    GlobalConstants.TYPE_MATERIAL_INTER_LINING//衬布
                };

                ProductionOrder productionOrder = (ProductionOrder)dbContext.Find(typeof(ProductionOrder), 1L);
                var boms = dbContext.Set<Bom>()
                    .Join(dbContext.Set<Imms.Mes.Organization.Material>(), b => b.ComponentMaterialId, m => m.RecordId, (b, m) => new { bom = b, material = m })
                    .Join(dbContext.Set<MaterialType>(), m => m.material.MaterialTypeId, t => t.RecordId, (bm, t) => new { bm.bom, bm.material, material_type = t })
                    .Where(x => x.bom.BomOrderId == productionOrder.BomOrderId
                           && !cuttingMaterialTypes.Contains(x.material_type.CodeNo)
                    ).Select(x => x.bom)
                    .ToList();

                List<Bom> theNewBoms = new List<Bom>();
                foreach (Bom bom in boms)
                {
                    Bom newBom = new Bom();
                    newBom.Clone(bom);
                    theNewBoms.Add(newBom);
                }
                BomOrder pickingBomOrder = PickingLogic.Instance.CreatePickingBomOrder(productionOrder, theNewBoms);
                PickingOrder pickingOrder = PickingLogic.Instance.CreatePickingOrder(productionOrder, pickingBomOrder, GlobalConstants.TYPE_PICKING_ORDER_STITCH);

                dbContext.Set<PickingOrder>().Add(pickingOrder);
                dbContext.SaveChanges();
            });
        }

        [Fact]
        public void PickingOrderPrepareTest()
        {
            PickingOrder pickingOrder = dbContext.Set<PickingOrder>()
                .Where(x => x.OrderType == GlobalConstants.TYPE_PICKING_ORDER_CUTTING)
                .Include(x => x.ProductionOrder)
                .Single();
            PickingLogic.Instance.MaterialPrepared(pickingOrder);

            Assert.True(pickingOrder.ReachStatus(GlobalConstants.STATUS_PICKING_ORDER_PREPARED));
            Assert.True(pickingOrder.ProductionOrder.ReachStatus(GlobalConstants.STATUS_PRODUCTION_ORDER_PICKING));
        }

        [Fact]
        public void PickingOrderReportTest()
        {
            PickingOrder pickingOrder = dbContext.Set<PickingOrder>()
                .Where(x => x.OrderStatus == GlobalConstants.STATUS_PICKING_ORDER_PREPARED)
                .Include(x => x.ProductionOrder)
                .Single();

            Assert.NotNull(pickingOrder);
            PickingLogic.Instance.MaterialPicked(pickingOrder);

            Assert.True(pickingOrder.ReachStatus(GlobalConstants.STATUS_PRODUCTION_ORDER_PICKED));
            foreach (CuttingOrder cuttingOrder in dbContext.Set<CuttingOrder>().Where(x => x.PickingOrderId == pickingOrder.RecordId))
            {
                Assert.True(cuttingOrder.ReachStatus(GlobalConstants.STATUS_PRODUCTION_ORDER_PICKED));
            }
        }

        [Fact]
        public void MaterialPickingPrepareStartTest()
        {
            PickingApi api = new PickingApi();
            PickingOrder[] pickingOrders = api.GetMaterialToPreparePicking();
            Assert.NotNull(pickingOrders);

            foreach(PickingOrder pickingOrder in pickingOrders)
            {
                this.Output.WriteLine(pickingOrder.ToJson());
            }
        }
    }
}
