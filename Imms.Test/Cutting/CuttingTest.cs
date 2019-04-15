using System;
using Microsoft.EntityFrameworkCore;

namespace Imms.Test.Cutting
{
    public class CuttingTest
    {
        static CuttingTest()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
        }
        protected DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();        
    }
}
