using System;
using Microsoft.EntityFrameworkCore;
using Xunit.Abstractions;

namespace Imms.Test.Cutting
{
    public class CuttingTest:BaseTestClass
    {
        public CuttingTest(ITestOutputHelper output)
        {
            this.Output = output;
        }

        public void CadDeserializeTest()
        {
            string fileName = "";
        }
    }
}
