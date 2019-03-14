using System;
using System.Transactions;


namespace Imms.Data
{
    public class Class1
    {
        public void TestInsert_01(int i)
        {
            this.doInsert(i);
        }

        private void doInsert(int i)
        {
            bool error = i > 100;
            int end = i + 3;
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required))
            {
                System.Console.WriteLine("Start Insert");
                using (ImmsDbContext dbContext = new ImmsDbContext())
                {
                    for (; i < end; i++)
                    {
                        SystemUser user = new SystemUser();
                        user.UserCode = $"U_{i}";
                        user.UserName = $"U_NAME_{i}";
                        user.Pwd = "1234";
                        user.UserStatus = 0;
                        user.Email = "aaa";
                        user.Online = 0;

                        dbContext.SystemUser.Add(user);
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
        }


        public void TestInsert_02()
        {
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required))
            {
                this.doInsert(30);

                this.doInsert(1000);

                // System.Console.WriteLine("Beginning divid by zero");
                // int a = 0; int b = 1;
                // int c = b / a;
                // System.Console.WriteLine("OK");

                scope.Complete();
            }
        }

    }
}
