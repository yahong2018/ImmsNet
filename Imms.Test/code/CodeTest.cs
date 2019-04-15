using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Collections.Generic;
using Imms.Data.Domain;
using Imms.Mes.MasterData;
using Xunit;
using Xunit.Abstractions;

namespace Imms.Test
{
    public class CodeTest: BaseTestClass
    {   
        public CodeTest(ITestOutputHelper output)
        {
            this.Output = output;
        }

        [Fact]
        public void TestCodeSeed()
        {
            foreach (CodeSeed codeSeed in dbContext.Set<CodeSeed>())
            {
               System.Console.WriteLine(codeSeed.ToString());              
            }
        }

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