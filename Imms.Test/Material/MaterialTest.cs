using System.Collections.Generic;
using System.Linq;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.MasterData;
using Imms.Mes.Picking;
using Imms.Mes.Stitch;
using Microsoft.EntityFrameworkCore;

namespace Imms.Test
{
    public class MaterialTest
    {
        static MaterialTest()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
            dbContext = GlobalConstants.DbContextFactory.GetContext();
            GlobalConstants.CurrentUserGetFunction = () =>
            {
                return dbContext.Set<SystemUser>().First();
            };
            Data.DataChangedNotifier.Instance.Dispatcher = new Data.DataChangeNotifyEventDispatcher();
        }
        protected static DbContext dbContext = null;

        public void TestMaterial()
        {
            foreach (var material in dbContext.Set<Material>().Where(x => x.RecordId == 16))
            {
                System.Console.WriteLine(material);
            }
        }


        public void BomOrderInsert()
        {
            BomOrder bomOrder = new BomOrder();
            bomOrder.MaterialId = 16;
            bomOrder.BomOrderType = GlobalConstants.TYPE_BOM_ORDER_PRODUCTION_ORDER;
            bomOrder.OrderStatus = GlobalConstants.STATUS_DOCUMENT_NORMAL;

            dbContext.Set<BomOrder>().Add(bomOrder);
            dbContext.SaveChanges();

            System.Console.WriteLine(bomOrder);
        }

        public void BomInsertTest()
        {
            Bom[] testBoms = new Bom[]
            {
                new Bom(),
                new Bom(),
                new Bom()
            };

            dbContext.Set<Bom>().AddRange(testBoms);
            dbContext.SaveChanges();
        }



        public void TestBomOrderSelect()
        {
            foreach (var bomOrder in dbContext.Set<BomOrder>().Include(x => x.Boms).ThenInclude(x => x.ComponentMaterial))
            {
                System.Console.WriteLine(bomOrder);
                System.Console.WriteLine("The bom is :");

                foreach (var bom in bomOrder.Boms)
                {
                    System.Console.WriteLine(bom);
                }
            }
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
                    .Join(dbContext.Set<Material>(), b => b.ComponentMaterialId, m => m.RecordId, (b, m) => new { bom = b, material = m })
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
                    .Join(dbContext.Set<Material>(), b => b.ComponentMaterialId, m => m.RecordId, (b, m) => new { bom = b, material = m })
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
        
        public void PickingOrderPrepareTest()
        {
            PickingOrder pickingOrder = dbContext.Set<PickingOrder>()
                .Where(x => x.OrderType == GlobalConstants.TYPE_PICKING_ORDER_CUTTING)
                .Include(x => x.ProductionOrder)
                .Single();
            PickingLogic.Instance.MaterialPrepared(pickingOrder);

            //Assert.IsTrue(pickingOrder.ReachStatus(GlobalConstants.STATUS_PICKING_ORDER_PREPARED));
            //Assert.IsTrue(pickingOrder.ProductionOrder.ReachStatus(GlobalConstants.STATUS_PRODUCTION_ORDER_PICKING));
        }


        public void PickingOrderReportTest()
        {
            PickingOrder pickingOrder = dbContext.Set<PickingOrder>()
                .Where(x => x.OrderStatus==GlobalConstants.STATUS_PICKING_ORDER_PREPARED)
                .Include(x => x.ProductionOrder)
                .Single();

            //Assert.IsNotNull(pickingOrder);

            PickingLogic.Instance.MaterialPicked(pickingOrder);
        }

    }
}