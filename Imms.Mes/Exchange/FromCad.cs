using System;
using System.Linq;
using System.Collections.Generic;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Domain;
using System.Text;
using Microsoft.EntityFrameworkCore;

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
            //Material[] materials = new Material[dto.MaterialMarkers.Length];
            if (dto.MaterialMarkers != null)
            {
                this.ValidateMaterialMarkers(dto.MaterialMarkers);
            }
            Bom[] boms = this.GetUpdatedBom(dto, productionOrder);

        }

        private void CreateCuttingOrder(ProductionOrderTailerDTO dto, ProductionOrder productionOrder,
              List<CuttingOrder> cuttingOrders,List<Media> medias,
              List<CuttingMarker> cuttingMarkers,List<CuttingOrderSize> cuttingOrderSizes,
              List<CuttingOrderSpreadPly> cuttingOrderSpreadPlies)
        {
            var cuttingTables = dto.MaterialMarkers.SelectMany(x => x.CuttingTables, (x, y) => new { x.MaterialNo, x.MaterialType, CuttingTable = y });
            foreach (var item in cuttingTables)
            {
                CuttingOrder cuttingOrder = new CuttingOrder();
                cuttingOrders.Add(cuttingOrder);

                cuttingOrder.ProductionOrderId = productionOrder.RecordId;
                cuttingOrder.CuttingTableNo = item.CuttingTable.Index;
                cuttingOrder.Plies = item.CuttingTable.Plies;
                cuttingOrder.Length = item.CuttingTable.Length;
                cuttingOrder.Width = item.CuttingTable.Width;
                if (productionOrder.OrderType == GlobalConstants.PRODUCTION_ORDER_TYPE_STANDARD)
                {
                    cuttingOrder.PlannedQty = item.CuttingTable.TotalSizes.Sum(x => x.Qty);
                }
                else
                {
                    cuttingOrder.PlannedQty = item.CuttingTable.Packages;
                }

                cuttingOrder.FgMaterialId = productionOrder.FgMaterialId;
                cuttingOrder.FabricMaterialType = item.MaterialType;

                Material material = CommonDAO.AssureExistsByFilter<Material>(x => x.MaterialNo == item.MaterialNo);
                cuttingOrder.FabricMaterialId = material.RecordId;

                cuttingOrder.CuttingEfficiency = 0.99;
            }
        }

        private CuttingOrder ConvertCuttingOrder(){

        }

        private Bom[] GetUpdatedBom(ProductionOrderTailerDTO dto, ProductionOrder productionOrder)
        {
            //
            //1.更新主料
            //2.更新辅料
            //
            using (DbContext dbContext = GlobalConstants.DbContextFactory.GetContext())
            {
                var boms = (from b in dbContext.Set<Bom>()
                            join m in dbContext.Set<Material>() on b.ComponentMaterialId equals m.RecordId
                            where b.BomOrderId == productionOrder.BomOrderId
                            select new
                            {
                                InnerBom = b,
                                m.MaterialNo
                            }
                    );
                //
                //主料：返回的物料编码如果在生产BOM里面有的话就直接更新，如果没有的话就根据返回的物料找它的子件，用量更新在子件上（抽象BOM）。
                //
                foreach (ComponentUsageDTO usage in dto.ComponentUsages)
                {
                    var theBom = boms.Where(x => x.MaterialNo == usage.ComponentNo).FirstOrDefault();
                    if (theBom != null)
                    {
                        theBom.InnerBom.ComponentQty = usage.Qty;
                    }
                    else
                    {
                        var boms_1 = (
                            from bm in dbContext.Set<Bom>()
                            join bo in dbContext.Set<BomOrder>() on bm.BomOrderId equals bo.RecordId
                            join mp in dbContext.Set<Material>() on bo.MaterialId equals mp.RecordId
                            where mp.MaterialNo == usage.ComponentNo
                            select new
                            {
                                InnerBom = bm,
                                mp.MaterialNo
                            }
                        ).ToArray();

                        var boms_2 = (from a in boms join b in boms_1 on a.MaterialNo equals b.MaterialNo select a);
                        foreach (var bom in boms_2)
                        {
                            bom.InnerBom.ComponentQty = usage.Qty;
                        }
                    }
                }
                //
                //主料：更新工艺变量
                //
                var details = dto.Hems.SelectMany(x => x.Details);
                foreach (var detail in details)
                {
                    var bom_1 = (from b in boms where b.MaterialNo == detail.ComponentNo select b);
                    foreach (var b in bom_1)
                    {
                        b.InnerBom.ComponentQty = detail.Value;
                    }
                }

                //
                //更新辅料：根据主料每个尺码的总计划裁剪数量
                //
                int cuttingQty = 0;
                string mainFabricCode = dbContext.Set<Material>()
                              .Where(m => m.RecordId == (
                                   boms.Where(b => b.InnerBom.IsMainFabric)
                                   .Select(b => b.InnerBom.ComponentMaterialId)
                                   .First()
                               ))
                               .Select(m => m.MaterialNo)
                               .First();
                if (productionOrder.OrderType == GlobalConstants.PRODUCTION_ORDER_TYPE_STANDARD && mainFabricCode != GlobalConstants.MATERIAL_TYPE_KT)
                {
                    cuttingQty = dto.MaterialMarkers.Where(x => x.MaterialNo == mainFabricCode)
                         .Select(x => x.CuttingTables)
                         .First()
                         .Sum(x => x.TotalSizes.Sum(y => y.Qty));
                }

                var accessories = (from b in boms where !(dto.ComponentUsages.Select(c => c.ComponentNo).Contains(b.MaterialNo)) select b);
                //var accessories = boms.Where(x =>   dto.ComponentUsages.Select(c=>c.ComponentNo));
                //(from m in dto.ComponentUsages where m.ComponentNo == x.MaterialNo select m).Count() == 0
                foreach (var b in accessories)
                {
                    b.InnerBom.ComponentQty *= ((cuttingQty == 0) ? productionOrder.PlannedQty : cuttingQty);
                }
                return boms.Select(x => x.InnerBom).ToArray();
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

            this.ValidateCuttingTable(materialMarkers);
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
        //
        //注意：CAD返回的只是面料的用量，辅料的用量需要根据层数、件数来计算
        //
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
        public string Index { get; set; }
        public int Plies { get; set; }
        public double Length { get; set; }
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