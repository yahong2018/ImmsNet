using System;
using System.Linq;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;

namespace Imms.Test
{
    public class AdminQueryTest
    {
        static AdminQueryTest()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
        }
        protected DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();        

        public void TestGetRoleUser()
        {
            var users = this.dbContext.Set<SystemUser>().Include(x => x.Roles).ThenInclude(x => x.Role);
            foreach (SystemUser user in users)
            {
                Console.WriteLine("The user  is:" + user.ToString());
                Console.WriteLine("It has roles");
                foreach (RoleUser roleUser in user.Roles)
                {
                    Console.WriteLine("role :" + roleUser.Role.ToString());
                }
            }
        }
        
        public void TestGetSystemProgram()
        {
            var programs = this.dbContext.Set<SystemProgram>().Where(x => x.Children.Count > 0).Include(x => x.Children).Include(x => x.Parent);
            foreach (SystemProgram program in programs)
            {
                Console.WriteLine($"Current program is: {program.ProgramCode},{program.ProgramName}");
                if (program.Children.Count > 0)
                {
                    Console.WriteLine("It's children are listed below:");
                    foreach (SystemProgram child in program.Children)
                    {
                        Console.WriteLine($"The child is: {child.ProgramCode},{child.ProgramName},the parent is :{child.Parent.ProgramCode}");
                    }
                }
                Console.WriteLine();
            }
        }
        
        public void TestGetPrivilege()
        {
            var rolePrivileges = this.dbContext.Set<RolePrivilege>().Include(x => x.Role).Include(x => x.PorgramPrivielge).ThenInclude(x => x.Program).ToList();
            foreach (SystemRole role in rolePrivileges.Select(x => x.Role).Distinct())
            {
                System.Console.WriteLine($"Role {role.RoleCode} has {role.Privileges.Count}'s privielges:");
                foreach (SystemProgram program in role.Privileges.Select(x => x.PorgramPrivielge.Program).Distinct())
                {
                    System.Console.WriteLine($"Program:{program.ProgramCode},{program.ProgramName}");
                    foreach (RolePrivilege privilege in role.Privileges.Where(x=>x.ProgramId == program.RecordId))
                    {
                        System.Console.WriteLine($"Privielge:{privilege.PorgramPrivielge.PrivilegeName}");
                    }
                    System.Console.WriteLine();
                }
                System.Console.WriteLine();
            }
        }
    }
}
