using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Cutting;
using Imms.Mes.MasterData;
using Imms.Mes.Picking;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace Imms.Mes.Stitch
{
    //
    //功能：
    //   生成缝制作业单(作业单、作业单BOM、缝制报工单）
    //   获取某个工位所需要的作业单及其当前工序（工艺）  
    //   作业单工艺报工   
    //   派工
    //    
    public class StitchLogic
    {
        //
        //获取某个工位所需要的作业单及其当前工序（工艺）  
        //
        public ProductionWorkOrderRouting[] GetWorkStationRoutings(WorkStation WorkStation)
        {
            return CommonDAO.GetAllByFilter<ProductionWorkOrderRouting>(x =>
                  x.WorkStationId == WorkStation.RecordId
                  && x.OrderStatus == GlobalConstants.STATUS_ORDER_PLANNED
            ).ToArray();
        }

        //
        //作业单工艺报工
        //
        public void WorkOrderRoutingReport(ProductionWorkOrderRouting workOrderRouting)
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                workOrderRouting.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
                workOrderRouting.TimeFinished = DateTime.Now;

                EntityEntry<ProductionWorkOrderRouting> routingEntry = dbContext.Entry<ProductionWorkOrderRouting>(workOrderRouting);
                routingEntry.State = EntityState.Modified;

                ProductionWorkOrder workOrder = dbContext.Set<ProductionWorkOrder>()
                    .Where(x => x.RecordId == workOrderRouting.ProductionWorkOrderId)
                    .Single();
                //如果是最后一道工艺则报工，否则派工到下一(N)道工艺
                OperationRouting currentRouting = dbContext.Set<OperationRouting>().Where(x => x.RecordId == workOrderRouting.OperationRoutingId).Include(x => x.NextRouting).Single();
                bool isLastRouting = (currentRouting.NextRouting == null);
                if (isLastRouting)
                {
                    workOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
                    workOrder.TimeActualEnd = DateTime.Now;
                    EntityEntry<ProductionWorkOrder> workOrderEntry = dbContext.Entry<ProductionWorkOrder>(workOrder);
                    workOrderEntry.State = EntityState.Modified;
                }
                else
                {
                    ProductionWorkOrderRouting nextWorkOrderRouting = dbContext.Set<ProductionWorkOrderRouting>().Where(x =>
                        x.OperationRoutingId == currentRouting.NextRoutingId
                         && x.ProductionWorkOrderId == workOrderRouting.ProductionWorkOrderId
                    ).Single();
                    ThreadPool.QueueUserWorkItem<ProductionWorkOrderRouting[]>(this.ScheduleWorkOrderRouting,
                       new ProductionWorkOrderRouting[] { workOrderRouting, nextWorkOrderRouting },
                       false
                    );
                }

                dbContext.SaveChanges();
            });
        }

        private void ScheduleWorkOrderRouting(ProductionWorkOrderRouting[] workOrderRoutings)
        {
            ProductionWorkOrderRouting currentWorkOrderRouting = workOrderRoutings[0];
            ProductionWorkOrderRouting nextWorkOrderRouting = workOrderRoutings[1];
            this.ScheduleWorkOrderRouting(currentWorkOrderRouting, nextWorkOrderRouting);
        }

        //
        //派工
        //
        public void ScheduleWorkOrderRouting(ProductionWorkOrderRouting prevWorkOrderRouting, ProductionWorkOrderRouting currentWorkOrderRouting)
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                WorkStation prevWorkStation = SingletonDataService.Instance.WorkStations.Where(x => x.RecordId == prevWorkOrderRouting.WorkStationId).Single();
                OperationRouting operationRouting = dbContext.Set<OperationRouting>().Where(x => x.RecordId == currentWorkOrderRouting.OperationRoutingId).Single();
                lock (SingletonDataService.Instance)
                {
                    var workStationWrapper = (
                        from w in SingletonDataService.Instance.WorkStations
                        join c in SingletonDataService.Instance.OperatorCapabilities on w.OperatorId equals c.OperatorId
                        where w.IsOnLine        //工位已联线
                             && w.IsAvailable   //工位可用
                             && w.MachineTypeId == operationRouting.MachineTypeId  //机器类型匹配
                             && (w.WipCurrent + w.WipInTransit) < w.WipMax         //WIP
                             && c.OperationId == operationRouting.OperationId      //工艺
                             && c.SkillLevel >= operationRouting.RequiredLevel     //技能等级                        
                        select new
                        {
                            WorkStation = w,
                            SkillLevel = c.SkillLevel,
                            Distance = this.ComputeWorkStationDispatchDistance(prevWorkStation, w)
                        }
                    ).OrderBy(x => x.Distance)    //距离最短
                    .OrderBy(x => x.WorkStation.WipInTransit + x.WorkStation.WipCurrent) //WIP最小
                    .OrderByDescending(x => x.SkillLevel)   //技能最高
                    .OrderBy(x => x.WorkStation.RecordId)   // 编号最小
                    .FirstOrDefault();

                    if (workStationWrapper == null)
                    {
                        return;
                    }

                    //进行派工
                    WorkStation currentWorkStation = workStationWrapper.WorkStation;
                    currentWorkStation.WipInTransit += 1;
                    SingletonDataService.Instance.UpdateWorkStation(currentWorkStation, dbContext);

                    currentWorkOrderRouting.OrderStatus = GlobalConstants.STATUS_ORDER_PLANNED;
                    currentWorkOrderRouting.TimeScheduled = DateTime.Now;
                    currentWorkOrderRouting.WorkStationId = currentWorkStation.RecordId;
                    EntityEntry<ProductionWorkOrderRouting> workRorderRoutingEntry = dbContext.Entry(currentWorkOrderRouting);
                    workRorderRoutingEntry.State = EntityState.Modified;

                    dbContext.SaveChanges();
                }
            });
        }

        //
        //计算两个工位之间的派工距离:单主轨、单向行驶
        //
        public int ComputeWorkStationDispatchDistance(WorkStation a, WorkStation b)
        {
            WorkLine lineA = SingletonDataService.Instance.ProudctionLines.Where(x => x.RecordId == a.ParentOrganizationId).Single();
            WorkLine lineB = SingletonDataService.Instance.ProudctionLines.Where(x => x.RecordId == b.ParentOrganizationId).Single();
            if (a.ParentOrganizationId == b.ParentOrganizationId)
            {   //同产线
                return ComputeWorkStationDispatchDistance(lineA, a, b);
            }
            else
            {
                int lineDistance = SingletonDataService.Instance.ProudctionLines.Where(x => x.SequenceNo > lineA.SequenceNo && x.SequenceNo <= lineB.SequenceNo).Sum(x => x.LineDistance);
                if (lineA.SequenceNo < lineB.SequenceNo) //不同产线：从小号产线往大号产线派工
                {
                    return lineDistance + this.ComputeWorkStationDispatchDistance(lineA, a, b);
                }
                else //不同产线：从大号产线往小号产线派工                    
                {
                    int mainOrbitLength = SingletonDataService.Instance.WorkCenters.Where(x => x.RecordId == lineA.ParentOrganizationId).Select(x => x.MainOrbitLength).Single();
                    return (mainOrbitLength - lineDistance) + this.ComputeWorkStationDispatchDistance(lineA, a, b);
                }
            }
        }

        private int ComputeWorkStationDispatchDistance(WorkLine lineA, WorkStation a, WorkStation b)
        {
            int workStationCount = SingletonDataService.Instance.WorkStations.Where(x => x.ParentOrganizationId == lineA.RecordId).Count();
            if (a.SequenceNo < b.SequenceNo)
            {
                if (a.ParentOrganizationId == b.ParentOrganizationId)
                {
                    return b.SequenceNo - a.SequenceNo;
                }
                else
                {
                    return workStationCount + (b.SequenceNo - a.SequenceNo);
                }
            }
            else
            {
                if (a.ParentOrganizationId == b.ParentOrganizationId)
                {
                    workStationCount += workStationCount; //单向行驶，同产线要多转半圈
                }
                return workStationCount - (b.SequenceNo - a.SequenceNo);
            }
        }

        //
        //生成缝制作业单
        //
        public ProductionWorkOrder[] CreateStitchWorkOrder(CuttingOrder cuttingOrder)
        {
            //裁剪完成，安排缝制作业单
            if (cuttingOrder == null
                || cuttingOrder.OrderStatus != GlobalConstants.STATUS_ORDER_FINISHED
                || cuttingOrder.CuttingTableNo == GlobalConstants.TYPE_MATERIAL_KT //KT床次   
                || cuttingOrder.QtyActual <= 0
                || cuttingOrder.FabricMaterialId != cuttingOrder.FgMaterialId  //非主面料
            )
            {
                return null;
            }

            ProductionWorkOrder[] result = null;
            CommonDAO.UseDbContext(dbContext =>
            {
                bool alReadyCreated = dbContext.Set<ProductionWorkOrder>().Where(x => x.CuttingOrderId == cuttingOrder.RecordId).Count() > 0;
                if (alReadyCreated)
                {
                    return;
                }

                ProductionOrder productionOrder = dbContext.Set<ProductionOrder>()
                   .Where(x => x.RecordId == cuttingOrder.ProductionOrderId)
                   .Include(x => x.RoutingOrder).ThenInclude(x => x.Routings)
                   .Single();

                long bomOrderId = dbContext.Set<PickingOrder>()
                  .Where(x => x.RecordId == cuttingOrder.PickingOrderId)
                  .Select(x => x.PickingBomOrderId)
                  .Single();
                var pickingBoms = dbContext.Set<Bom>().Where(x => x.BomOrderId == bomOrderId);

                result = new ProductionWorkOrder[cuttingOrder.QtyActual];
                for (int i = 0; i < cuttingOrder.Sizes.Count; i++)
                {
                    CuttingOrderSize orderSize = cuttingOrder.Sizes[i];
                    //创建作业单
                    ProductionWorkOrder productionWorkOrder = this.CreateProductionWorkOrder(cuttingOrder, productionOrder, orderSize);
                    result[i] = productionWorkOrder;

                    //创建缝制BOM
                    BomOrder bomOrder = this.CreateWorkOrderBom(productionOrder, cuttingOrder, pickingBoms);  //生成BOM
                    dbContext.Set<BomOrder>().Add(bomOrder);

                    //创建缝制工艺报工单
                    ProductionWorkOrderRouting[] workOrderRoutings = this.CreateWorkOrderRoutings(productionOrder.RoutingOrder.Routings);
                    foreach (ProductionWorkOrderRouting routing in workOrderRoutings)
                    {
                        routing.ProductionWorkOrder = productionWorkOrder;
                        dbContext.Set<ProductionWorkOrderRouting>().Add(routing);
                    }
                    dbContext.Set<ProductionWorkOrder>().Add(productionWorkOrder);

                    dbContext.SaveChanges();
                }
            });

            return result;
        }

        private ProductionWorkOrder CreateProductionWorkOrder(CuttingOrder cuttingOrder, ProductionOrder productionOrder, CuttingOrderSize orderSize)
        {
            ProductionWorkOrder productionWorkOrder = new ProductionWorkOrder();
            productionWorkOrder.CuttingOrderId = cuttingOrder.RecordId;
            productionWorkOrder.Size = orderSize.Size;
            productionWorkOrder.OrderStatus = GlobalConstants.STATUS_ORDER_INITIATE;
            productionWorkOrder.ProductionOrderId = productionOrder.RecordId;
            return productionWorkOrder;
        }

        private BomOrder CreateWorkOrderBom(ProductionOrder productionOrder, CuttingOrder cuttingOrder, IQueryable<Bom> boms)
        {
            BomOrder bomOrder = new BomOrder
            {
                BomOrderType = GlobalConstants.TYPE_BOM_ORDER_PRODUCTION_ORDER,
                MaterialId = cuttingOrder.FgMaterialId,
                OrderStatus = GlobalConstants.STATUS_BOM_ORDER_NORMAL
            };

            foreach (Bom bom in boms)
            {
                bom.BomOrderId = 0;
                bom.BomOrder = bomOrder;
                bom.QtyComponent = (productionOrder.QtyPlanned / bom.QtyComponent) * cuttingOrder.QtyActual;

                bomOrder.Boms.Add(bom);
            }

            return bomOrder;
        }

        private ProductionWorkOrderRouting[] CreateWorkOrderRoutings(List<OperationRouting> routings)
        {
            ProductionWorkOrderRouting[] workOrderRoutings = new ProductionWorkOrderRouting[routings.Count];
            for (int i = 0; i < routings.Count; i++)
            {
                OperationRouting operationRouting = routings[i];
                ProductionWorkOrderRouting workOrderRouting = new ProductionWorkOrderRouting();
                workOrderRoutings[i] = workOrderRouting;
                workOrderRouting.OperationRoutingId = operationRouting.RecordId;
                workOrderRouting.OrderStatus = GlobalConstants.STATUS_ORDER_INITIATE;
            }

            return workOrderRoutings;
        }
    }
}