using System;
using Imms.Data;
using Imms.Mes.Cutting;
using Imms.Mes.Exchange;
using Microsoft.EntityFrameworkCore;
using Xunit;
using Xunit.Abstractions;

namespace Imms.Test.Cutting
{
    public class CuttingTest:BaseTestClass
    {
        public CuttingTest(ITestOutputHelper output)
        {
            this.Output = output;
        }

        

        [Fact]
        public void CuttingOrderFirstTest()
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                foreach(CuttingOrder cuttingOrder in dbContext.Set<CuttingOrder>())
                {
                    this.Output.WriteLine(cuttingOrder.ToJson());
                }
            });
        }

        [Fact]
        public void CuttingOrderSizeFirstTest()
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                foreach (CuttingOrderSize cuttingOrderSize in dbContext.Set<CuttingOrderSize>())
                {
                    this.Output.WriteLine(cuttingOrderSize.ToJson());
                }
            });
        }

        [Fact]
        public void CuttingMarkerFirstTest()
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                foreach (CuttingMarker cuttingMarker in dbContext.Set<CuttingMarker>())
                {
                    this.Output.WriteLine(cuttingMarker.ToJson());
                }
            });
        }

        [Fact]
        public void CuttingCuttingOrderSpreadPlyFirstTest()
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                foreach (CuttingOrderSpreadPly cuttingOrderSpreadPly in dbContext.Set<CuttingOrderSpreadPly>())
                {
                    this.Output.WriteLine(cuttingOrderSpreadPly.ToJson());
                }
            });
        }

    }
}
