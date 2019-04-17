using Imms.Mes.Exchange;
using Imms.Mes.Picking;
using System;
using System.Collections.Generic;
using System.Text;
using Xunit;
using Xunit.Abstractions;

namespace Imms.Test.Cutting
{
    public class CadTest:BaseTestClass
    {
        public CadTest(ITestOutputHelper ouptut)
        {
            this.Output = ouptut;
        }

        [Fact]
        public void CadDeserializeTest()
        {
            string fileName = @"D:\projects\zhxh\ImmsNet\Imms.Doc\CAD_PURE_DATA.json";
            ProductionOrderCuttingTechFileDTO dto = fileName.LoadBeanFromFile<ProductionOrderCuttingTechFileDTO>();
            Assert.NotNull(dto);
            this.Output.WriteLine(dto.ToJson());
        }

        [Fact]
        public void CadImportTest()
        {
            string fileName = @"D:\projects\zhxh\ImmsNet\Imms.Doc\CAD_PURE_DATA.json";
            ProductionOrderCuttingTechFileDTO dto = fileName.LoadBeanFromFile<ProductionOrderCuttingTechFileDTO>();

            FromCad fromCad = new FromCad
            {
                PickingLogic = PickingLogic.Instance
            };
            fromCad.ImportCuttingTechFile(dto);
        }

    }
}
