using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Collections.Generic;
using Imms.Data.Domain;
using Imms.Mes.Organization;

namespace Imms.Test
{
    public class OrgQueryTest
    {
        static OrgQueryTest()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
        }
        protected DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();

        
        public void TestOrganization()
        {
            foreach (Plant plant in dbContext.Set<WorkOrganizationUnit>().Where(x => x is Plant)
            .Include(x => x.Children)
            .ThenInclude(x => x.Children)
            .ThenInclude(x => x.Children)
            .OrderBy(x => x.OrganizationCode)
            )
            {
                Console.WriteLine($"Code:{plant.PlantCode},Name:{plant.PlantName}, WorkCenters:");
                Console.WriteLine();

                foreach (WorkCenter workCenter in plant.Children.OrderBy(x=>x.OrganizationCode))
                {
                    Console.WriteLine($"Code:{workCenter.WorkCenterCode},Name:{workCenter.WorkCenterName},WorkLines:");
                    foreach (WorkLine line in workCenter.Children.OrderBy(x=>x.OrganizationCode))
                    {
                        Console.WriteLine($"Code:{line.LineCode},Name:{line.LineName},WorkStations:");
                        foreach (WorkStation workStation in line.Children.OrderBy(x=>x.OrganizationCode))
                        {
                            Console.WriteLine($"Code:{workStation.WorkStationCode},Name:{workStation.WorkStationName}");
                        }
                        Console.WriteLine();
                    }
                    Console.WriteLine();
                }
            }
        }
    }
}