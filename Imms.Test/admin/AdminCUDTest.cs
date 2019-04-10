using System;
using System.Linq;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;

namespace Imms.Test
{
    public class AdminCUDTest
    {
        static AdminCUDTest()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
        }
        protected DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();

        //[Fact]        
        public void TestSystemUserInsertAndSelect(DbContext dbContext)
        {
            SystemUser theNewUser = CreateNewUser();
            dbContext.Set<SystemUser>().Add(theNewUser);            
            foreach (SystemUser user in dbContext.Set<SystemUser>())
            {
                Console.WriteLine(user.ToString());
            }
        }

        private SystemUser CreateNewUser()
        {
            SystemUser user = new SystemUser();
            user.UserCode = "C00001";
            user.UserName = "刘永红";
            user.Pwd = "123456";
            user.Email = "yonghong.liu@zhxh.com";
            user.IsOnline = false;
            user.LastLoginTime = DateTime.Now.AddDays(-1);

            return user;
        }

    }
}