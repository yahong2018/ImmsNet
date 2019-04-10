using System.Linq;
using Imms.Data.Domain;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Imms.Mes.Stitch;


namespace Imms.Test.Routing
{
    public class RoutingTest
    {
        static RoutingTest()
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


        public void TestOperation()
        {
            foreach (var operation in dbContext.Set<Operation>().Include(x => x.MachineType).Take(10))
            {
                System.Console.WriteLine(operation);
            }
        }


        public void OperationRoutingOrderInsertTest()
        {
            OperationRoutingOrder operationRoutingOrder = new OperationRoutingOrder();
            operationRoutingOrder.MaterialId = 16;
            operationRoutingOrder.OrderType = GlobalConstants.TYPE_OPERATION_ROUTING_ORDER_PRODUCTION;
            operationRoutingOrder.OrderStatus = GlobalConstants.STATUS_DOCUMENT_NORMAL;

            dbContext.Set<OperationRoutingOrder>().Add(operationRoutingOrder);
            dbContext.SaveChanges();
        }

   
        public void OperationRoutingOrderItemsInsertTest()
        {
            string[] operations = new string[]{
                "OP0001","T0001","SMCSOH001","SMCSCL021","SMCSCL022","SMCSCL025",
                "SMCSCL026","SMCSSL015","SMCSSL008","SMCSFR018","SMCSBK009","SMCSCL028",
                "SWCSAS039","SMCSAS046","SMCSAS047","SMCSAS008","SMCSAS009","SMCSAS001",
                "SMCSAS012","SMCSAS048","SMCSAS049","ZMCSAS007","SMCSAS044","SMCSAS033",
                "SMCSAS027","SMCSAS028","SMCSAS029","SMCSAS030","SMCSAS031"
            };

            string[] next_operations = new string[]{
                "T0001","SMCSOH001","SMCSCL021","SMCSCL022","SMCSCL025","SMCSCL026",
                "SMCSSL015","SMCSSL008","SMCSFR018","SMCSBK009","SMCSCL028","SWCSAS039",
                "SMCSAS046","SMCSAS047","SMCSAS008","SMCSAS009","SMCSAS001","SMCSAS012",
                "SMCSAS048","SMCSAS049","ZMCSAS007","SMCSAS044","SMCSAS033","SMCSAS027",
                "SMCSAS028","SMCSAS029","SMCSAS030","SMCSAS031",""
            };

            List<OperationRouting> operationRoutings = new List<OperationRouting>();

            for (int i = 0; i < operations.Length; i++)
            {
                OperationRouting operationRouting = new OperationRouting();
                Operation operation = dbContext.Set<Operation>().Where(x => x.OperationNo == operations[i]).Single();
                operationRouting.OperationId = operation.RecordId;
                operationRouting.NextOpertionNo = next_operations[i];
                Operation nextOperation = dbContext.Set<Operation>().Where(x => x.OperationNo == next_operations[i]).FirstOrDefault();
                if(nextOperation!=null){
                    operationRouting.NextOperationId = nextOperation.RecordId;
                }
                operationRouting.OperationRoutingOrderId = 1;

                operationRouting.OperationNo = operations[i];
                operationRouting.Description = operation.Description;
                operationRouting.MachineTypeId = operation.MachineTypeId;
                operationRouting.StandardTime = operation.StandardTime;
                operationRouting.StandardPrice = operation.StandardPrice;
                operationRouting.SectionType = operation.SectionType;
                operationRouting.SectionName = operation.SectionName;
                operationRouting.IsOutsource = operation.IsOutsource;
                operationRouting.QaProcedure = operation.QaProcedure;
                operationRouting.Requirement = operation.Requirement;
                operationRouting.RequiredLevel = operation.RequiredLevel;

                operationRoutings.Add(operationRouting);
                dbContext.Set<OperationRouting>().Add(operationRouting);
            }

            foreach (OperationRouting item in operationRoutings)
            {
                OperationRouting next = operationRoutings.Where(x => x.OperationNo == item.NextOpertionNo).FirstOrDefault();
                if (next == null)
                {
                    continue;
                }
                item.NextRouting = next;
            }

            dbContext.SaveChanges();
        }

  
        public void TestRoutingOrderWithItems(){
            foreach(OperationRoutingOrder routingOrder in dbContext.Set<OperationRoutingOrder>()
                    .Include(x=>x.Material)
                    .Include(x=>x.Routings)
                        .ThenInclude(x=>x.Operation)
                    ){
                System.Console.WriteLine($"MaterialNo: {routingOrder.Material.MaterialNo},RoutingOrderNo:{routingOrder.OrderNo},the routing is :");
                foreach(var routing in routingOrder.Routings.OrderByDescending(x=>x.RecordId)){
                    System.Console.WriteLine($"Current:{routing.OperationNo},Next:{routing.NextOpertionNo}");
                }
            }
        }
    }
}