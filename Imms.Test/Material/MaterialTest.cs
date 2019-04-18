using System.Collections.Generic;
using System.Linq;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Material;
using Imms.Mes.Organization;
using Imms.Mes.Picking;
using Imms.Mes.Stitch;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace Imms.Test.Material
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
            foreach (var material in dbContext.Set<Imms.Mes.Material.Material>().Where(x => x.RecordId == 16))
            {
                System.Console.WriteLine(material);
            }
        }

        [Fact]
        public void BomOrderInsert()
        {
            BomOrder bomOrder = new BomOrder();
            // bomOrder.MaterialId = 16;
            bomOrder.MaterialId = 275;
            bomOrder.BomOrderType = GlobalConstants.TYPE_BOM_ORDER_PRODUCTION_ORDER;
            bomOrder.OrderStatus = GlobalConstants.STATUS_DOCUMENT_NORMAL;

            dbContext.Set<BomOrder>().Add(bomOrder);
            dbContext.SaveChanges();

            System.Console.WriteLine(bomOrder);
        }



        [Fact]
        public void BomOrderInsert_16001_Test()
        {
            BomOrder bomOrder = new BomOrder();            
            bomOrder.MaterialId = 72;
            bomOrder.BomOrderType = GlobalConstants.TYPE_BOM_ORDER_PRODUCTION_ORDER;
            bomOrder.OrderStatus = GlobalConstants.STATUS_DOCUMENT_NORMAL;

            dbContext.Set<BomOrder>().Add(bomOrder);
            dbContext.SaveChanges();

            System.Console.WriteLine(bomOrder);
        }


        [Fact]
        public void BomOrderInsert_12001_Test()
        {
            BomOrder bomOrder = new BomOrder();
            bomOrder.MaterialId = 271;
            bomOrder.BomOrderType = GlobalConstants.TYPE_BOM_ORDER_PRODUCTION_ORDER;
            bomOrder.OrderStatus = GlobalConstants.STATUS_DOCUMENT_NORMAL;

            dbContext.Set<BomOrder>().Add(bomOrder);
            dbContext.SaveChanges();

            System.Console.WriteLine(bomOrder);
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
        
        

    }
}