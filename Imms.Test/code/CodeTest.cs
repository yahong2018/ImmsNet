using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Collections.Generic;
using Imms.Data.Domain;
using Imms.Mes.MasterData;
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
        public void TestPlanCode()
        {
            Console.WriteLine("Equipment Type...");
            foreach (EquipmentType code in dbContext.Set<EquipmentType>())
            {
                Console.WriteLine(code);
            }

            Console.WriteLine("Material Type...");

            foreach (MaterialType materialType in dbContext.Set<MaterialType>())
            {
                Console.WriteLine(materialType);
            }
        }
    }
}