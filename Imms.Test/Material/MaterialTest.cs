using System.Linq;
using Imms.Data.Domain;
using Imms.Mes.MasterData;
using Microsoft.EntityFrameworkCore;
using Xunit;

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


        [Fact]
        public void TestMaterial()
        {
            foreach (var material in dbContext.Set<Material>().Where(x => x.RecordId == 16))
            {
                System.Console.WriteLine(material);
            }
        }

        [Fact]
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

        [Fact]
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




    }
}