using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using Xunit.Abstractions;

namespace Imms.Test
{
    public class BaseTestClass
    {
        static BaseTestClass()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
        }
        protected readonly DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();
        public  ITestOutputHelper Output { get; protected set; }
        
    }
}
