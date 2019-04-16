using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
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

        protected BaseTestClass()
        {
            GlobalConstants.CurrentUserGetFunction = () =>
            {
                return dbContext.Set<SystemUser>().First();
            };
            Data.DataChangedNotifier.Instance.Dispatcher = new Data.DataChangeNotifyEventDispatcher();
        }
        protected readonly DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();
        public  ITestOutputHelper Output { get; protected set; }        
    }
}
