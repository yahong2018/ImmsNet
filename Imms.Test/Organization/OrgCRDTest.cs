using System;
using Imms.Mes.MasterData;
using Microsoft.EntityFrameworkCore;


namespace Imms.Test
{
    public class OrgCRDTest
    {
        static OrgCRDTest()
        {
            GlobalConstants.DbContextFactory = new Imms.Mes.ImmsDbContextFactory();
        }
        protected DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();


        public void CreatePlantTest()
        {
            dbContext.Set<Plant>().Add(this.CreatePlant());
            Console.WriteLine($"Changed data is :{dbContext.SaveChanges()}");
        }

        private WorkLine CreateHangLine()
        {
            WorkLine result = new WorkLine();
            result.LineCode = "A.04.00";
            result.LineName = "上裁片线";
            result.LineDistance = 0;
            result.SequenceNo = 0;
            result.RotateDirection = GlobalConstants.DIRECTION_ROTATE_ANTI_CLOCK_WISE;

            result.Children.Add(this.CreateWorkStation(1, "A.04.00.001", "上", "上裁片1"));

            return result;
        }

        private WorkLine Create1stLine()
        {
            WorkLine result = new WorkLine();
            result.LineCode = "A.04.01";
            result.LineName = "PL01";
            result.LineDistance = 5;
            result.SequenceNo = 1;
            result.RotateDirection = GlobalConstants.DIRECTION_ROTATE_ANTI_CLOCK_WISE;

            result.Children.Add(this.CreateWorkStation(1, "A.04.01.001", "四"));
            result.Children.Add(this.CreateWorkStation(2, "A.04.01.002", "四"));
            result.Children.Add(this.CreateWorkStation(3, "A.04.01.003", "冚"));
            result.Children.Add(this.CreateWorkStation(4, "A.04.01.004", "平"));
            result.Children.Add(this.CreateWorkStation(5, "A.04.01.005", "平"));
            result.Children.Add(this.CreateWorkStation(6, "A.04.01.006", "平"));
            result.Children.Add(this.CreateWorkStation(7, "A.04.01.007", "平",isAvailable:false));
            result.Children.Add(this.CreateWorkStation(8, "A.04.01.008", "查"));

            return result;
        }


        private WorkLine Create2ndLine()
        {
            WorkLine result = new WorkLine();
            result.LineCode = "A.04.02";
            result.LineName = "PL02";
            result.LineDistance = 5;
            result.SequenceNo = 2;
            result.RotateDirection = GlobalConstants.DIRECTION_ROTATE_ANTI_CLOCK_WISE;

            result.Children.Add(this.CreateWorkStation(9, "A.04.02.009", "平"));
            result.Children.Add(this.CreateWorkStation(10, "A.04.02.010", "平"));
            result.Children.Add(this.CreateWorkStation(11, "A.04.02.011", "平"));
            result.Children.Add(this.CreateWorkStation(12, "A.04.02.012", "平"));
            result.Children.Add(this.CreateWorkStation(13, "A.04.02.013", "中"));
            result.Children.Add(this.CreateWorkStation(14, "A.04.02.014", "平"));
            result.Children.Add(this.CreateWorkStation(15, "A.04.02.015", "刀"));
            result.Children.Add(this.CreateWorkStation(16, "A.04.02.016", "平"));

            return result;
        }

        private WorkLine Create3rdLine()
        {
            WorkLine result = new WorkLine();
            result.LineCode = "A.04.03";
            result.LineName = "PL03";
            result.LineDistance = 5;
            result.SequenceNo = 3;
            result.RotateDirection = GlobalConstants.DIRECTION_ROTATE_ANTI_CLOCK_WISE;

            result.Children.Add(this.CreateWorkStation(17, "A.04.03.017", "平"));
            result.Children.Add(this.CreateWorkStation(18, "A.04.03.018", "平", isAvailable: false));
            result.Children.Add(this.CreateWorkStation(19, "A.04.03.019", "平", isAvailable: false));
            result.Children.Add(this.CreateWorkStation(20, "A.04.03.020", "平"));
            result.Children.Add(this.CreateWorkStation(21, "A.04.03.021", "平"));
            result.Children.Add(this.CreateWorkStation(22, "A.04.03.022", "平"));
            result.Children.Add(this.CreateWorkStation(23, "A.04.03.023", "平"));
            result.Children.Add(this.CreateWorkStation(24, "A.04.03.024", "平"));

            return result;
        }

        private WorkLine Create4thLine()
        {
            WorkLine result = new WorkLine();
            result.LineCode = "A.04.04";
            result.LineName = "PL04";
            result.LineDistance = 5;
            result.SequenceNo = 4;
            result.RotateDirection = GlobalConstants.DIRECTION_ROTATE_ANTI_CLOCK_WISE;

            result.Children.Add(this.CreateWorkStation(25, "A.04.04.025", "三"));
            result.Children.Add(this.CreateWorkStation(26, "A.04.04.026", "平"));
            result.Children.Add(this.CreateWorkStation(27, "A.04.04.027", "平"));
            result.Children.Add(this.CreateWorkStation(28, "A.04.04.028", "平"));
            result.Children.Add(this.CreateWorkStation(29, "A.04.04.029", "平"));
            result.Children.Add(this.CreateWorkStation(30, "A.04.04.030", "平"));
            result.Children.Add(this.CreateWorkStation(31, "A.04.04.031", "平"));
            result.Children.Add(this.CreateWorkStation(32, "A.04.04.032", "平"));

            return result;
        }

        private WorkLine Create5thLine()
        {
            WorkLine result = new WorkLine();
            result.LineCode = "A.04.05";
            result.LineName = "PL05";
            result.LineDistance = 5;
            result.SequenceNo = 5;
            result.RotateDirection = GlobalConstants.DIRECTION_ROTATE_ANTI_CLOCK_WISE;

            result.Children.Add(this.CreateWorkStation(33, "A.04.05.033", "查"));
            result.Children.Add(this.CreateWorkStation(34, "A.04.05.034", "金"));
            result.Children.Add(this.CreateWorkStation(35, "A.04.05.035", "钉"));
            result.Children.Add(this.CreateWorkStation(36, "A.04.05.036", "钮"));
            result.Children.Add(this.CreateWorkStation(37, "A.04.05.037", "烫", "中烫1", wipMax: 10));
            result.Children.Add(this.CreateWorkStation(38, "A.04.05.038", "烫", "中烫2"));
            result.Children.Add(this.CreateWorkStation(39, "A.04.05.039", "枣"));
            result.Children.Add(this.CreateWorkStation(40, "A.04.05.040", "凤"));

            return result;
        }



        private WorkStation CreateWorkStation(int seq, string no, string name, string description = "", int wipMax = 3, bool isAvailable = true)
        {
            WorkStation result = new WorkStation();
            result.SequenceNo = seq;
            result.WorkStationType = GlobalConstants.TYPE_WORK_STATION_STITCHING;
            result.IsAvailable = isAvailable;
            result.IsOnLine = false;
            result.WorkStationCode = no;
            result.WorkStationName = name;
            result.MachineTypeId = 0;
            result.OperatorId = 0;
            result.Description = description;
            result.WipMax = wipMax;
            result.Direction = GlobalConstants.DIRECTON_RIGHT;

            if((seq % 2) ==0){
                result.Direction = GlobalConstants.DIRECTON_RIGHT;
            }
            return result;
        }

        private WorkCenter CreateStichWorkCenter()
        {
            WorkCenter result = new WorkCenter();
            result.WorkCenterCode = "A.04";
            result.WorkCenterName = "缝制车间";
            result.SequenceNo = 1;
            result.MainOrbitLength = 30;
            result.RotateDirection = GlobalConstants.DIRECTION_ROTATE_ANTI_CLOCK_WISE;

            result.Children.Add(this.CreateHangLine());
            result.Children.Add(this.Create1stLine());
            result.Children.Add(this.Create2ndLine());
            result.Children.Add(this.Create3rdLine());
            result.Children.Add(this.Create4thLine());
            result.Children.Add(this.Create5thLine());

            return result;
        }

        private WorkCenter CreateCuttingWorkCenter()
        {
            WorkCenter result = new WorkCenter();
            result.WorkCenterCode = "A.03";
            result.WorkCenterName = "裁剪车间";
            result.SequenceNo = 2;
            result.MainOrbitLength = 0;
            
            return result;
        }

        private Plant CreatePlant()
        {
            Plant plant = new Plant();
            plant.PlantCode = "A";
            plant.PlantName = "A厂";
            plant.Description = "T恤厂";
            plant.CostPriceRatio = 0.1000;
            plant.Children.Add(this.CreateStichWorkCenter());
            plant.Children.Add(this.CreateCuttingWorkCenter());

            return plant;
        }
    }
}