using System;
using System.Transactions;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes;
using Imms.Mes.Domain;

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
            program.testGetPlantByProperty();

            Console.Read();
        }
       
        private void testGetPlantByProperty()
        {
            Plant plant = CommonDAO.GetOneByFilter<Plant>(x=>x.OrganizationCode == "A");

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
