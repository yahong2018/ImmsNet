using System;
using System.Linq;
using System.Threading;
using System.Transactions;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Cutting;
using Imms.Mes.Organization;
using Imms.Mes.Stitch;
using Microsoft.EntityFrameworkCore;
using Xunit;
using Xunit.Abstractions;

namespace Imms.Test.Stitch
{
    public class StichTest:BaseTestClass
    {
        static StichTest()
        {        
            Data.DataChangedNotifier.Instance.Dispatcher = new Data.DataChangeNotifyEventDispatcher();
        }

        public StichTest(ITestOutputHelper output)
        {
            this.Output = output;
        }


        [Fact]
        public void ProductionWorkOrderAllReport()
        {
            string productionWorkOrderNo = "WO0000000035";
            while (true)
            {
                ProductionWorkOrder workOrder
                    = GlobalConstants.DbContextFactory.GetContext().Set<ProductionWorkOrder>().Where(x => x.OrderNo == productionWorkOrderNo).Include(x=>x.CurrentRouting).First();
                ProductionWorkOrderRouting currentWorkOrderRouting = workOrder.CurrentRouting;
                if (currentWorkOrderRouting == null || workOrder.OrderStatus == GlobalConstants.STATUS_ORDER_FINISHED)
                {
                    break;
                }

                currentWorkOrderRouting.QtyFinished = 1;
                long operatorId = dbContext.Set<WorkStation>().Where(x => x.RecordId == currentWorkOrderRouting.WorkStationId).Select(x => x.OperatorId).Single();
                currentWorkOrderRouting.OperatorId = operatorId;
                StitchLogic.Instance.WorkOrderRoutingReport(currentWorkOrderRouting);

                Thread.Sleep(30);
            }

        }
        
        [Fact]
        public void HangingReportTest()
        {
            ProductionWorkOrderRouting hangRouting = StitchLogic.Instance.GetFirstRoutings("SZ00004")[0];
            Assert.NotNull(hangRouting);
            hangRouting.OperatorId = 1;
            hangRouting.WorkStationId = 10;
            hangRouting.ConatinerNo = "0123456789ABCDEFG";
            hangRouting.QtyFinished = 1;

            StitchLogic.Instance.WorkOrderRoutingReport(hangRouting);
        }

        [Fact]
        public void GetHangingRoutingsTest()
        {
            ProductionWorkOrderRouting[] routings = StitchLogic.Instance.GetFirstRoutings("SZ00004");
            foreach(ProductionWorkOrderRouting routing in routings)
            {
                Console.WriteLine(routing.ToJson());
            }
        }


        [Fact]
        public void CreateStitchWorkOrderTest()
        {
            CuttingOrder cuttingOrder = dbContext.Set<CuttingOrder>().Include(x => x.Sizes).Single(x => x.RecordId == 152);                
            ProductionWorkOrder[] productionWorkOrders=StitchLogic.Instance.CreateStitchWorkOrder(cuttingOrder);            
            foreach(ProductionWorkOrder workOrder in productionWorkOrders)
            {
                string str = workOrder.ToString();
                this.Output.WriteLine(str);
            }
        }

        [Fact]
        public void ProductionOrderInsertTest()
        {
            ProductionOrder productionOrder = new ProductionOrder();
            productionOrder.BomOrderId = 1;
           // productionOrder.RoutingOrderId = 2;
            productionOrder.FgMaterialId = 275;
            productionOrder.QtyPlanned = 1;
            productionOrder.Priority = 3;
            productionOrder.OrderStatus = GlobalConstants.STATUS_ORDER_PLANNED; //注意是已计划
            productionOrder.TimeStartPlanned = DateTime.Parse("2019/04/28 18:35");
            productionOrder.TimeEndPlanned = DateTime.Parse("2019/04/29 10:30");
            productionOrder.WorkCenterId = 3;

            productionOrder.Sizes.AddRange(this.CreateSizes());

            dbContext.Set<ProductionOrder>().Add(productionOrder);
            dbContext.SaveChanges();
        }

        private ProductionOrderSize[] CreateSizes()
        {
            ProductionOrderSize[] sizes = new ProductionOrderSize[1];
            sizes[0] = new ProductionOrderSize();
            sizes[0].Size = "S160/84A";
            sizes[0].QytPlanned = 1;

            return sizes;
        }

        public void TestProductionOrderOne()
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

            productionOrder.Sizes.AddRange(this.CreateSizesOne());

            dbContext.Set<ProductionOrder>().Add(productionOrder);
            dbContext.SaveChanges();
        }

        private ProductionOrderSize[] CreateSizesOne()
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