using Imms.Mes.Exchange;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using Xunit;
using Xunit.Abstractions;

namespace Imms.Test.Routing
{
    public class GstTest : BaseTestClass
    {
        public GstTest(ITestOutputHelper Output)
        {
            this.Output = Output;
        }

        [Fact]
        public void GstParseTest()
        {
            string fileName = @"D:\projects\zhxh\ImmsNet\Imms.Doc\GST_PURE_DATA.json";
            ProductionOrderRoutingDTO dto = fileName.LoadBeanFromFile<ProductionOrderRoutingDTO>();
            this.Output.WriteLine(dto.ToJson());
        }       

        [Fact]
        public void ImportProducitonOrderRoutingTest(){           
            string fileName = @"D:\projects\zhxh\ImmsNet\Imms.Doc\GST_PURE_DATA.json";
            ProductionOrderRoutingDTO dto = fileName.LoadBeanFromFile<ProductionOrderRoutingDTO>();

            FromGst gstImportLogic = new FromGst();
            gstImportLogic.ImportProducitonOrderRouting(dto);
        }
    }
}