using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Cutting;
using Imms.Mes.Domain;
using Imms.Mes.MasterData;
using Imms.Mes.Picking;
using Imms.Mes.Production;
using Imms.Mes.Quality;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Transactions;

namespace Imms.Mes.Exchange
{
    public class FromCad : IThirdPartDataPullLogic
    {
        public PickingLogic PickingLogic { get; set; }

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
            }

            CommonDAO.UseDbContext((dbContext) =>
            {
                PickingOrder pickingOrder = this.CreatePickingOrder(dto, productionOrder, dbContext);
                List<CuttingOrder> cuttingOrders = this.AddCuttingOrders(dto, productionOrder, dbContext);
                foreach (CuttingOrder cuttingOrder in cuttingOrders)
                {
                    cuttingOrder.PickingOrder = pickingOrder;
                }

                this.AddQualityChecks(dto, productionOrder);
                this.AddPatternRelations(dto, productionOrder);
                this.UpdateProducitonData(productionOrder, dbContext);

                dbContext.SaveChanges();                
            });
        }

        private void UpdateProducitonData(ProductionOrder productionOrder, DbContext dbContext)
        {
            EntityEntry<ProductionOrder> entry = dbContext.Attach<ProductionOrder>(productionOrder);
            productionOrder.OrderStatus = GlobalConstants.STATUS_PRODUCTION_ORDER_TECH_ALL_READY;
            entry.State = EntityState.Modified;
        }

        private void AddPatternRelations(ProductionOrderTailerDTO dto, ProductionOrder productionOrder)
        {
            List<ProductionOrderPatternRelation> patternRelations = this.ImportPartterImage(dto);
            productionOrder.PatternImages.AddRange(patternRelations);
        }

        private void AddQualityChecks(ProductionOrderTailerDTO dto, ProductionOrder productionOrder)
        {
            List<QualityCheck> qualityChecks = this.CreateQualityChecks(dto, productionOrder);
            foreach (QualityCheck check in qualityChecks)
            {
                productionOrder.QualityChecks.Add(check);
            }
        }

        private List<CuttingOrder> AddCuttingOrders(ProductionOrderTailerDTO dto, ProductionOrder productionOrder, DbContext dbContext)
        {
            List<CuttingOrder> cuttingOrders = this.CreateCuttingOrders(dto, productionOrder);
            foreach (CuttingOrder cuttingOrder in cuttingOrders)
            {
                dbContext.Set<CuttingOrder>().Add(cuttingOrder);
            }
            return cuttingOrders;
        }

        private PickingOrder CreatePickingOrder(ProductionOrderTailerDTO dto, ProductionOrder productionOrder, DbContext dbContext)
        {
            List<Bom> boms = this.GetMaterialPickingBoms(dto, productionOrder);
            BomOrder pickingBomOrder = PickingLogic.CreatePickingBomOrder(productionOrder, boms);
            dbContext.Set<BomOrder>().Add(pickingBomOrder);

            PickingOrder pickingOrder = PickingLogic.CreatePickingOrder(productionOrder, pickingBomOrder);
            dbContext.Set<PickingOrder>().Add(pickingOrder);

            return pickingOrder;
        }

        private List<ProductionOrderPatternRelation> ImportPartterImage(ProductionOrderTailerDTO dto)
        {
            List<ProductionOrderPatternRelation> result = new List<ProductionOrderPatternRelation>();
            foreach (PatternImageDTO partternImage in dto.PatternImages)
            {
                Media media = new Media();
                media.MediaUrl = partternImage.PartternImageUrl;
                string[] segs = partternImage.PartternImageUrl.Split(new string[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                media.MediaName = segs[segs.Length - 1];
                media.MediaFormat = GlobalConstants.MIME_MEDIA_FORMAT_JPEG;
                media.Description = "物料纸样多媒体";

                ProductionOrderPatternRelation patternRelation = new ProductionOrderPatternRelation();
                Material material = CommonDAO.AssureExistsByFilter<Material>(x => x.MaterialNo == partternImage.MaterialNo);
                patternRelation.MaterialId = material.RecordId;
                patternRelation.Media = media;

                result.Add(patternRelation);
            }

            return result;
        }

        private List<QualityCheck> CreateQualityChecks(ProductionOrderTailerDTO dto, ProductionOrder productionOrder)
        {
            List<QualityCheck> result = new List<QualityCheck>();
            foreach (ProductionOrderSizeDTO orderSize in dto.Sizes)
            {
                QualityCheck qualityCheck = new QualityCheck();
                result.Add(qualityCheck);

                qualityCheck.ProductionOrder = productionOrder;
                qualityCheck.SizeNo = orderSize.SizeNo;
                qualityCheck.SizeName = orderSize.SizeName;

                foreach (ProductionOrderSizeDetailDTO detail in orderSize.Details)
                {
                    QualityCheckDetail checkDetail = new QualityCheckDetail();
                    checkDetail.QualityCheckId = qualityCheck.RecordId;
                    checkDetail.ComponentNo = detail.ComponentNo;
                    checkDetail.ComponentName = detail.ComponentName;
                    checkDetail.StandardValue = detail.Value;

                    qualityCheck.Details.Add(checkDetail);
                }
            }
            return result;
        }

        private List<CuttingOrder> CreateCuttingOrders(ProductionOrderTailerDTO dto, ProductionOrder productionOrder)
        {
            List<CuttingOrder> result = new List<CuttingOrder>();

            foreach (MaterialMarkerDTO materialMarker in dto.MaterialMarkers)
            {
                foreach (CuttingTableDTO cuttingTable in materialMarker.CuttingTables)
                {
                    CuttingOrder cuttingOrder = ConvertCuttingOrder(productionOrder, materialMarker, cuttingTable);
                    CuttingMarker cuttingMarker = ConvertCuttingTable(cuttingTable, cuttingOrder);

                    ConvertCuttingOrderSizes(cuttingTable, cuttingOrder);
                    ConvertCuttingOrderSpreadSplies(cuttingTable, cuttingOrder);

                    result.Add(cuttingOrder);
                }
            }
            return result;
        }

        private static void ConvertCuttingOrderSpreadSplies(CuttingTableDTO cuttingTable, CuttingOrder cuttingOrder)
        {
            if (cuttingTable.SpreadPlies != null)
            {
                foreach (CuttingOrderSpreadPliesDTO plies in cuttingTable.SpreadPlies)
                {
                    CuttingOrderSpreadPly spreadPly = new CuttingOrderSpreadPly();
                    spreadPly.CuttingOrder = cuttingOrder;
                    spreadPly.Length = plies.Length;
                    spreadPly.Plies = plies.Plies;

                    cuttingOrder.SpreadPlies.Add(spreadPly);
                }
            }
        }

        private static void ConvertCuttingOrderSizes(CuttingTableDTO cuttingTable, CuttingOrder cuttingOrder)
        {
            CuttingOrderSizeDTO[] cuttingOrderSizes = cuttingTable.Sizes;
            if (cuttingOrder.ProductionOrder.OrderType == GlobalConstants.TYPE_PRODUCTION_ORDER_STANDARD)
            {
                cuttingOrderSizes = cuttingTable.TotalSizes;
            }
            if (cuttingOrderSizes != null)
            {
                foreach (CuttingOrderSizeDTO size in cuttingOrderSizes)
                {
                    CuttingOrderSize cuttingOrderSize = new CuttingOrderSize();
                    cuttingOrderSize.CuttingOrder = cuttingOrder;
                    cuttingOrderSize.QtyPlanned = size.Qty;
                    cuttingOrderSize.Size = size.Size;
                    cuttingOrderSize.QtyLayer = 1;
                    cuttingOrderSize.QtyActual = 0;

                    cuttingOrder.Sizes.Add(cuttingOrderSize);
                }
            }
        }

        private static CuttingMarker ConvertCuttingTable(CuttingTableDTO cuttingTable, CuttingOrder cuttingOrder)
        {
            Media mediaImage = ConvertImageMedia(cuttingTable);
            Media mediaCutFile = ConvertCutMedia(cuttingTable);

            CuttingMarker cuttingMarker = new CuttingMarker();
            cuttingMarker.CuttingOrder = cuttingOrder;
            cuttingMarker.Remark = cuttingTable.CutFileName;
            cuttingMarker.Media = mediaImage;
            cuttingMarker.MarkFile = mediaCutFile;

            return cuttingMarker;
        }

        private static Media ConvertCutMedia(CuttingTableDTO cuttingTable)
        {
            Media cut = new Media();
            cut.MediaName = cuttingTable.CutFileName;
            cut.MediaUrl = cuttingTable.CutFileUrl;
            cut.MediaFormat = GlobalConstants.MIME_MEDIA_FORMAT_JPEG;
            cut.Description = "裁剪技术文件";

            return cut;
        }

        private static Media ConvertImageMedia(CuttingTableDTO cuttingTable)
        {
            Media media = new Media();
            media.MediaName = cuttingTable.CutFileName;
            media.MediaUrl = cuttingTable.CutImageUrl;
            media.MediaFormat = GlobalConstants.MIME_MEDIA_FORMAT_JPEG;
            media.Description = "裁剪技术文件多媒体";

            return media;
        }

        private static CuttingOrder ConvertCuttingOrder(ProductionOrder productionOrder, MaterialMarkerDTO materialMarker, CuttingTableDTO cuttingTable)
        {
            CuttingOrder cuttingOrder = new CuttingOrder
            {
                ProductionOrder = productionOrder,
                CuttingTableNo = cuttingTable.Index,
                Plies = cuttingTable.Plies,
                Length = cuttingTable.Length,
                Width = cuttingTable.Width,
                FgMaterialId = productionOrder.FgMaterialId,
                FabricMaterialType = materialMarker.MaterialType,
                OrderStatus = GlobalConstants.STATUS_ORDER_INITIATE, //初始状态，还没有计划
            };
            if (productionOrder.OrderType == GlobalConstants.TYPE_PRODUCTION_ORDER_STANDARD)
            {
                cuttingOrder.QtyPlanned = cuttingTable.TotalSizes.Sum(x => x.Qty);
            }
            else
            {
                cuttingOrder.QtyPlanned = cuttingTable.Packages;
            }
            Material material = CommonDAO.AssureExistsByFilter<Material>(x => x.MaterialNo == materialMarker.MaterialNo);
            cuttingOrder.FabricMaterialId = material.RecordId;
            cuttingOrder.CuttingEfficiency = 0.99;

            return cuttingOrder;
        }

        private List<Bom> GetMaterialPickingBoms(ProductionOrderTailerDTO dto, ProductionOrder productionOrder)
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
                int cuttingQty = productionOrder.QtyPlanned;
                string mainFabricCode = dbContext.Set<Material>()
                              .Where(m => m.RecordId == (
                                   boms.Where(b => b.InnerBom.IsMainFabric)
                                   .Select(b => b.InnerBom.ComponentMaterialId)
                                   .First()
                               ))
                               .Select(m => m.MaterialNo)
                               .First();
                if (productionOrder.OrderType == GlobalConstants.TYPE_PRODUCTION_ORDER_STANDARD && mainFabricCode != GlobalConstants.TYPE_MATERIAL_KT)
                {
                    cuttingQty = dto.MaterialMarkers.Where(x => x.MaterialNo == mainFabricCode)
                         .Select(x => x.CuttingTables)
                         .Single()
                         .Sum(x => x.TotalSizes.Sum(y => y.Qty));
                }

                var accessories = (from b in boms where !(dto.ComponentUsages.Select(c => c.ComponentNo).Contains(b.MaterialNo)) select b);
                //var accessories = boms.Where(x =>   dto.ComponentUsages.Select(c=>c.ComponentNo));
                //(from m in dto.ComponentUsages where m.ComponentNo == x.MaterialNo select m).Count() == 0
                foreach (var b in accessories)
                {
                    b.InnerBom.ComponentQty *= cuttingQty;
                }

                return boms.Select(x => x.InnerBom).ToList();
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