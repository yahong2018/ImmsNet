using System;
using System.Linq;
using System.Collections.Generic;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Domain;
using System.Text;

namespace Imms.Mes.Exchange
{
    public class FromCad : IThirdPartDataPullLogic
    {
        public string[] ExchangeRules
        {
            get { return new string[] { GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__CAD_2_MES }; }
            set => throw new System.NotImplementedException();
        }

        public SortedDictionary<string, Type> DTOTypes => new SortedDictionary<string, Type>(){
                    {GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__CAD_2_MES,typeof(ProductionOrderTailerDTO)}
            };

        public SortedDictionary<string, ThirdPartDataPullProcessHandler> Handlers => new SortedDictionary<string, ThirdPartDataPullProcessHandler>()
            {
                {GlobalConstants.DATA_EXCHANGE_RULE__PRODUCITON_ORDER__CAD_2_MES,this.ImportOrderTailer}
            };

        public void ImportOrderTailer(object objDTO)
        {
            ProductionOrderTailerDTO dto = (ProductionOrderTailerDTO)objDTO;
            ProductionOrder productionOrder = CommonDAO.AssureExistsByFilter<ProductionOrder>(x => x.OrderNo == dto.ProductionOrderNo);
            if (dto.MaterialMarkers != null)
            {
                this.ValidateMaterialMarkers(dto.MaterialMarkers);
                this.ValidateCuttingTable(dto.MaterialMarkers);
            }
        }

        private void ValidateMaterialMarkers(MaterialMarkerDTO[] materialMarkers)
        {
            var groups = materialMarkers.GroupBy(x => x.MaterialNo).Where(x => x.Count() > 1).ToArray();
            if (groups.Length > 0)
            {
                StringBuilder log = new StringBuilder("物料编号重复:");
                foreach (IGrouping<int, CuttingTableDTO> group in groups)
                {
                    log.Append($"MaterialNo:{group.Key}的数量为{group.Count()},");
                }
                log.Remove(log.Length - 1, 1);

                throw new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_REPEATED, log.ToString());
            }            
        }


        private void ValidateCuttingTable(MaterialMarkerDTO[] materialMarkers)
        {
            foreach (MaterialMarkerDTO marker in materialMarkers)
            {
                if (marker.CuttingTables == null)
                {
                    continue;
                }

                var groups = marker.CuttingTables.GroupBy(x => x.Index).Where(x => x.Count() > 1).ToArray();
                if (groups.Length > 0)
                {
                    StringBuilder log = new StringBuilder("床次重复:");
                    foreach (IGrouping<int, CuttingTableDTO> group in groups)
                    {
                        log.Append($"index:{group.Key}的数量为{group.Count()},");
                    }
                    log.Remove(log.Length - 1, 1);

                    throw new BusinessException(GlobalConstants.EXCEPTION_CODE_DATA_REPEATED, log.ToString());
                }
            }
        }
    }

    public class ProductionOrderTailerDTO
    {
        public string ProductionOrderNo { get; set; }
        public string MaterialNo { get; set; }
        public ComponentUsageDTO[] ComponentUsages { get; set; }
        public MaterialMarkerDTO[] MaterialMarkers { get; set; }
        public ProductionOrderSizeDTO[] Sizes { get; set; }
        public PatternImageDTO[] PatternImages { get; set; }
        public HemDTO[] Hems { get; set; }
    }

    public class ComponentUsageDTO
    {
        public string ComponentNo { get; set; }
        public double Qty { get; set; }
    }

    public class MaterialMarkerDTO
    {
        public string MaterialNo { get; set; }
        public string MaterialType { get; set; }

        public CuttingTableDTO[] CuttingTables { get; set; }
    }

    public class CuttingTableDTO
    {
        public int Index { get; set; }
        public int Plies { get; set; }
        public double Width { get; set; }
        public int Packages { get; set; }
        public int CutPartsCount { get; set; }
        public string CutImageUrl { get; set; }
        public string CutFileUrl { get; set; }
        public string CutFileName { get; set; }

        public CuttingOrderSizeDTO[] Sizes { get; set; }
        public CuttingOrderSpreadPliesDTO[] SpreadPlies { get; set; }
        public CuttingOrderSizeDTO[] TotalSizes { get; set; }
    }

    public class CuttingOrderSizeDTO
    {
        public string Size { get; set; }
        public int Qty { get; set; }
    }

    public class CuttingOrderSpreadPliesDTO
    {
        public double Length { get; set; }
        public int Plies { get; set; }
    }

    public class ProductionOrderSizeDTO
    {
        public string SizeNo { get; set; }
        public string SizeName { get; set; }
        public ProductionOrderSizeDetailDTO[] Details { get; set; }
    }

    public class ProductionOrderSizeDetailDTO
    {
        public string ComponentNo { get; set; }
        public string ComponentName { get; set; }
        public double Value { get; set; }
    }

    public class PatternImageDTO
    {
        public string MaterialNo { get; set; }
        public string PartternImageUrl { get; set; }
    }

    public class HemDTO
    {
        public string SizeNo { get; set; }
        public string SizeName { get; set; }
        public ProductionOrderSizeDetailDTO[] Details { get; set; }
    }
}