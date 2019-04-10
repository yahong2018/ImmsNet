using System;
using System.Linq;
using Imms.Data.Domain;
using Imms.Mes.Stitch;
using Microsoft.EntityFrameworkCore;

namespace Imms.Test
{
    public class StichTest
    {
        static StichTest()
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

      
        public void TestProductionOrder()
        {
            ProductionOrder productionOrder = new ProductionOrder();
            productionOrder.BomOrderId = 2;
            productionOrder.RoutingOrderId = 1;
            productionOrder.FgMaterialId = 16;
            productionOrder.QtyPlanned = 40;
            productionOrder.Priority = 5;
            productionOrder.TimeStartPlanned = DateTime.Parse("2019/04/09 18:35");
            productionOrder.TimeEndPlanned = DateTime.Parse("2019/04/10 10:30");
            productionOrder.WorkCenterId = 3;

            productionOrder.Sizes.AddRange(this.CreateSizes());

            dbContext.Set<ProductionOrder>().Add(productionOrder);
            dbContext.SaveChanges();
        }

        private ProductionOrderSize[] CreateSizes()
        {
            ProductionOrderSize[] sizes = new ProductionOrderSize[4];
            sizes[0] = new ProductionOrderSize();
            sizes[0].Size = "S165/88A";
            sizes[0].QytPlanned = 10;

            sizes[1] = new ProductionOrderSize();
            sizes[1].Size = "M170/92A";
            sizes[1].QytPlanned = 10;

            sizes[2] = new ProductionOrderSize();
            sizes[2].Size = "L175/96A";
            sizes[2].QytPlanned = 10;

            sizes[3] = new ProductionOrderSize();
            sizes[3].Size = "XL180/100A";
            sizes[3].QytPlanned = 10;

            return sizes;
        }
    }
}