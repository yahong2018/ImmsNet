using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Collections.Generic;
using Imms.Data.Domain;
using Xunit;

namespace Imms.Test
{
    public class OrgTest
    {
        static OrgTest()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
        }
        protected DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();

        [Fact]
        public void TestOrganization()
        {
            foreach (WorkOrganizationUnit org in dbContext.Set<WorkOrganizationUnit>().Include(x => x.Children).Include(x => x.Parent).ToList())
            {
                Console.WriteLine(org);
            }
        }
    }
}