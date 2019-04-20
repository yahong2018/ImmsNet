using System;
using Imms.Data;
using Imms.Mes.Cutting;
using Imms.Mes.Exchange;
using Microsoft.EntityFrameworkCore;
using Xunit;
using Xunit.Abstractions;

namespace Imms.Test.Cutting
{
    public class CuttingTest : BaseTestClass
    {
        public CuttingTest(ITestOutputHelper output)
        {
            this.Output = output;
        }

        [Fact]
        public void CuttingFinishedTest()
        {
            //string fileName = @"D:\projects\zhxh\ImmsNet\Imms.Test\Cutting\cutting_report.json";
            string fileName = @"D:\projects\zhxh\ImmsNet\Imms.Test\Cutting\cutting_report_list.json";
            CutingReportDTO[] cuttingReports = fileName.LoadBeanFromFile<CutingReportDTO[]>();
            foreach(CutingReportDTO dto in cuttingReports)
            {
                CuttingApi cuttingApi = new CuttingApi();
                cuttingApi.CuttingFinished(dto);
            }            
        }

        [Fact]
        public void GetCuttingOrderToStartTest()
        {
            CuttingApi cuttingApi = new CuttingApi();
            string[] cuttingOrders = new string[] { "CUT000000021", "CUT000000022", "CUT000000023", "CUT000000024" };
            string operatorCode = "C00001";
            string workStationNo = "A.03.01";
            foreach (string cuttingOrderNo in cuttingOrders)
            {
                 cuttingApi.StartCutting(cuttingOrderNo, operatorCode, workStationNo);
            }
        }

        [Fact]
        public void CuttingOrderFirstTest()
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                foreach (CuttingOrder cuttingOrder in dbContext.Set<CuttingOrder>())
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
