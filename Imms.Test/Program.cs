using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes;
using Imms.Mes.Domain;
using Imms.Mes.Domain.Test;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Transactions;

namespace Imms.Test
{
    class Program
    {
        static void Main(string[] args)
        {
            Program program = new Program();
            Imms.GlobalConstants.DbContextFactory = new ImmsDbContextFactory();

            // program.doInsert(0);
            //  program.doQuery();
            // program.testGetPlantByCode();
            //program.testGetPlantByProperty();

            program.One2OneQuery();
            program.One2OneInsert();
            program.One2OneQuery();

            Console.Read();
        }

        private void One2OneInsert()
        {
            Console.WriteLine("开始新增--------");
            Header header_c = new Header();
            header_c.HeaderName = "头D";

            Body body_c = new Body();
            body_c.BodyName = "身D";
            body_c.Header = header_c;
            body_c.Feet.Add(new Foot() { FootName = "左脚D" });
            body_c.Feet.Add(new Foot() { FootName = "右脚D" });

            using (ImmsMesDbContext dbContext = (ImmsMesDbContext)GlobalConstants.DbContextFactory.GetContext())
            {
                dbContext.Set<Header>().Add(header_c);
                dbContext.Set<Body>().Add(body_c);

                dbContext.SaveChanges();
            }

            Console.WriteLine("新增结束--------");
        }
        private void One2OneQuery()
        {
            Console.WriteLine("开始查询--------");
            using (ImmsMesDbContext dbContext = (ImmsMesDbContext)GlobalConstants.DbContextFactory.GetContext())
            {
                foreach (Body body in dbContext.Set<Body>().Include(e => e.Header).Include(e => e.Feet))
                {
                    Console.WriteLine($"body_id:{body.Id},body_name:{body.BodyName}");
                    if (body.Header != null)
                    {
                        Console.WriteLine($"header_id:{body.Header.Id},header_name:{body.Header.HeaderName}");
                    }

                    foreach (Foot foot in body.Feet)
                    {
                        Console.WriteLine($"foot_id:{foot.Id},foot_name:{foot.FootName},body_name:{foot.Body.BodyName}");
                    }
                }
            }
            Console.WriteLine("查询结束--------");
        }


        private void testGetPlantByProperty()
        {
            Plant plant = CommonDAO.GetOneByFilter<Plant>(x => x.OrganizationCode == "A");

            // Plant plant = CommonDAO.GetByWhere<Plant>("OrganizationCode == @0","A");
            if (plant != null)
            {
                Console.WriteLine($"PlantCode:{plant.PlantCode},PlantName:{plant.PlantName}");
            }
            else
            {
                Console.WriteLine("nothing find");
            }
        }

        private void doQuery()
        {
            using (ImmsMesDbContext dbContext = new ImmsMesDbContext())
            {
                foreach (SystemUser user in dbContext.SystemUsers)
                {
                    Console.WriteLine($"userId:{user.RecordId}, userCode:{user.UserCode},userName:{user.UserName}");
                }

                foreach (SystemRole role in dbContext.SystemRoles)
                {
                    Console.WriteLine($"roleId:{role.RecordId}, roleCode:{role.RoleCode},roleName:{role.RoleName}");
                }

                foreach (SystemProgram program in dbContext.SystemPrograms)
                {
                    Console.WriteLine($"programId:{program.RecordId}, programCode:{program.ProgramCode},programName:{program.ProgramName}");
                }

            }
        }

        private void doInsert(int i)
        {
            bool error = i > 100;
            int end = i + 3;
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required))
            {
                System.Console.WriteLine("Start Insert");
                using (ImmsMesDbContext dbContext = new ImmsMesDbContext())
                {
                    for (; i < end; i++)
                    {
                        SystemUser user = new SystemUser();
                        user.UserCode = $"U_{i}";
                        user.UserName = $"U_NAME_{i}";
                        user.Pwd = "1234";
                        user.UserStatus = 0;
                        user.Email = "aaa";
                        user.IsOnline = 0;

                        dbContext.SystemUsers.Add(user);
                    }
                    dbContext.SaveChanges();
                }

                System.Console.WriteLine("Insert finished");

                if (error)
                {
                    throw new Exception("error");
                }

                scope.Complete();
            }

            this.doQuery();

        }
    }
}
