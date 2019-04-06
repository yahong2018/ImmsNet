using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Collections.Generic;
using Imms.Data.Domain;
using Xunit;

namespace Imms.Test
{
    public class CodeTest
    {
        static CodeTest()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
        }
        protected DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();

        [Fact]
        public void TestCodeSeed()
        {
            foreach (CodeSeed codeSeed in dbContext.Set<CodeSeed>())
            {
                Console.WriteLine(codeSeed);
            }
        }

        [Fact]
        public void TestTreeCode()
        {
            foreach (TreeCode tree in dbContext.Set<TreeCode>())
            {
                Console.WriteLine(tree);
            }
        }

        

        [Fact]
        public void TestPlanCode()
        {
            foreach (PlanCode code in dbContext.Set<PlanCode>())
            {
                Console.WriteLine(code);
            }
        }

        [Fact]
        public void TestMaterialUnit()
        {
            foreach (MaterialUnit unit in dbContext.Set<MaterialUnit>())
            {
                Console.WriteLine(unit);
            }
        }
    }
}