using System;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace Imms.Test.Cutting
{
    public class CuttingTest
    {
        static CuttingTest()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
        }
        protected DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();

        [Fact]
        public void CreateCuttingOrderTest()
        {

        }
    }
}
