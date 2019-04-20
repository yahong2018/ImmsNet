using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Cutting;
using Imms.Mes.Organization;
using Imms.Mes.Material;
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
        protected StitchLogic()
        {
            this.StichWorkStationFinder = new DefaultStichOperationRoutingWorkStationFinder();
        }

        public static readonly StitchLogic Instance = new StitchLogic();

        //
        //获取某个工位所需要的作业单及其当前工序（工艺）  
        //
        public ProductionWorkOrderRouting[] GetWorkStationRoutings(WorkStation WorkStation)
        {
            return CommonDAO.GetAllByFilter<ProductionWorkOrderRouting>(x =>
                  x.WorkStationId == WorkStation.RecordId
                  && x.TimeFinished != null
            ).ToArray();
        }

        //
        //生产订单报工
        //
        public void ProductionOrderReport(ProductionOrder productionOrder)
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                this.ProductionOrderReport(productionOrder, dbContext);
                dbContext.SaveChanges();
            });
        }

        public void SetProductionOrderRouting(ProductionOrder productionOrder, OperationRoutingOrder routingOrder, OperationRouting[] operationRoutings)
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                routingOrder.Routings.AddRange(operationRoutings);
                dbContext.Set<OperationRoutingOrder>().Add(routingOrder);

                productionOrder.PlusOrderStatus(GlobalConstants.STATUS_PRODUCTION_ORDER_ROUTING_READY); //生产工艺已准备
                productionOrder.RoutingOrder = routingOrder;

                GlobalConstants.ModifyEntityStatus<ProductionOrder>(productionOrder, dbContext);
                dbContext.SaveChanges();
            });
        }


        //
        //缝制作业单报工
        //
        public void ProductionWorkOrderReport(ProductionWorkOrder workOrder)
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                this.WorkOrderReport(workOrder, dbContext);
                dbContext.SaveChanges();
            });
        }


        private void ProductionOrderReport(ProductionOrder productionOrder, DbContext dbContext)
        {
            if (productionOrder.QtyFinished == productionOrder.QtyActual)
            {
                productionOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
            }
            GlobalConstants.ModifyEntityStatus<ProductionOrder>(productionOrder, dbContext);
        }

        private void WorkOrderReport(ProductionWorkOrder workOrder, DbContext dbContext)
        {
            workOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
            workOrder.TimeEndActual = DateTime.Now;
            GlobalConstants.ModifyEntityStatus<ProductionWorkOrder>(workOrder, dbContext);
        }

        //
        //作业单工艺报工
        //
        public void WorkOrderRoutingReport(ProductionWorkOrderRouting workOrderRouting)
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                workOrderRouting.TimeFinished = DateTime.Now;

                //如果是最后一道工序则该作业单完成，否则派工到下一道工序
                OperationRouting currentRouting = dbContext.Set<OperationRouting>().Where(x => x.RecordId == workOrderRouting.OperationRoutingId).Include(x => x.NextRouting).Single();
                bool isLastRouting = (currentRouting.NextRouting == null);
                if (isLastRouting)
                {
                    ProductionWorkOrder workOrder = dbContext.Set<ProductionWorkOrder>()
                       .Where(x => x.RecordId == workOrderRouting.ProductionWorkOrderId)
                       .Single();
                    this.WorkOrderReport(workOrder, dbContext);

                    //修改生PO的完成数量和状态
                    ProductionOrder productionOrder = dbContext.Set<ProductionOrder>().Where(x => x.RecordId == workOrder.ProductionOrderId).Single();
                    productionOrder.QtyFinished += workOrderRouting.QtyFinished;
                    this.ProductionOrderReport(productionOrder, dbContext);
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

                GlobalConstants.ModifyEntityStatus<ProductionWorkOrderRouting>(workOrderRouting, dbContext);
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
                lock (SingletonDataService.Instance)
                {
                    //找到下一个工位
                    StichOperationRoutingWorkStationFinderParameter parameter = new StichOperationRoutingWorkStationFinderParameter();
                    parameter.PrevWorkOrderRouting = prevWorkOrderRouting;
                    parameter.CurrentWorkOrderRouting = currentWorkOrderRouting;
                    parameter.DbContext = dbContext;
                    WorkStation currentWorkStation = this.StichWorkStationFinder.FindWorkStation(parameter);
                    if (currentWorkStation == null)
                    {
                        return;
                    }

                    //派工                    
                    currentWorkOrderRouting.QtyPlanned = prevWorkOrderRouting.QtyFinished;  //本工位的计划数量，为前工序的完工数量
                    currentWorkOrderRouting.TimeScheduled = DateTime.Now;
                    currentWorkOrderRouting.WorkStationId = currentWorkStation.RecordId;

                    //修改工位的在途WIP
                    currentWorkStation.WipInTransit += currentWorkOrderRouting.QtyPlanned;

                    //数据保存
                    GlobalConstants.ModifyEntityStatus<ProductionWorkOrderRouting>(currentWorkOrderRouting, dbContext);
                    GlobalConstants.ModifyEntityStatus<WorkStation>(currentWorkStation, dbContext);
                    dbContext.SaveChanges();
                }
            });
        }

        //
        //生成缝制作业单
        //
        public ProductionWorkOrder[] CreateStitchWorkOrder(CuttingOrder cuttingOrder)
        {
            ProductionWorkOrder[] result = null;
            CommonDAO.UseDbContext(dbContext =>
            {
                //获取主面料
                long materialId = dbContext.Set<Bom>().Where(x =>
                   x.IsMainFabric &&
                   (dbContext.Set<PickingOrder>()
                       .Where(p => p.RecordId == cuttingOrder.PickingOrderId)
                       .Select(p => p.PickingBomOrderId)
                       .Contains(x.BomOrderId))
                ).Select(b => b.ComponentMaterialId)
                .Single();

                if (cuttingOrder == null
                        || cuttingOrder.OrderStatus != GlobalConstants.STATUS_ORDER_FINISHED
                        || cuttingOrder.CuttingTableNo == GlobalConstants.TYPE_MATERIAL_KT //KT床次   
                        || cuttingOrder.QtyActual <= 0
                        || cuttingOrder.FabricMaterialId != materialId  //非主面料
                    )
                {
                    return;
                }
                result = this.CreateProducitonWorkOrders(cuttingOrder, dbContext);
                dbContext.SaveChanges();
            });

            return result;
        }

        protected internal ProductionWorkOrder[] CreateProducitonWorkOrders(CuttingOrder cuttingOrder, DbContext dbContext)
        {
            bool alReadyCreated = dbContext.Set<ProductionWorkOrder>().Where(x => x.CuttingOrderId == cuttingOrder.RecordId).Count() > 0;
            if (alReadyCreated)
            {
                return null;
            }

            List<ProductionWorkOrder> productionWorkOrders = new List<ProductionWorkOrder>();
            ProductionOrder productionOrder = dbContext.Set<ProductionOrder>()
              .Where(x => x.RecordId == cuttingOrder.ProductionOrderId)
              .Include(x => x.RoutingOrder).ThenInclude(x => x.Routings)
              .Single();

            //获取领料的Bom
            long bomOrderId = dbContext.Set<PickingOrder>()
              .Where(x => x.RecordId == cuttingOrder.PickingOrderId)
              .Select(x => x.PickingBomOrderId)
              .Single();
            var pickingBoms = dbContext.Set<Bom>().Where(x => x.BomOrderId == bomOrderId);

            foreach (CuttingOrderSize orderSize in cuttingOrder.Sizes)
            {
                for (int j = 0; j < orderSize.QtyFinished; j++)
                {
                    //创建作业单
                    ProductionWorkOrder productionWorkOrder = this.CreateProductionWorkOrder(cuttingOrder, orderSize);
                    productionWorkOrder.ProductionOrder = productionOrder;
                    productionWorkOrders.Add(productionWorkOrder);

                    //创建缝制BOM
                    BomOrder bomOrder = this.CreateWorkOrderBom(cuttingOrder, pickingBoms);  //生成BOM
                    dbContext.Set<BomOrder>().Add(bomOrder);

                    //创建缝制工艺报工单
                    ProductionWorkOrderRouting[] workOrderRoutings = this.CreateWorkOrderRoutings(productionOrder.RoutingOrder.Routings);
                    foreach (ProductionWorkOrderRouting routing in workOrderRoutings)
                    {
                        routing.ProductionWorkOrder = productionWorkOrder;
                        dbContext.Set<ProductionWorkOrderRouting>().Add(routing);
                    }
                    dbContext.Set<ProductionWorkOrder>().Add(productionWorkOrder);
                }
            }

            return productionWorkOrders.ToArray();
        }

        private ProductionWorkOrder CreateProductionWorkOrder(CuttingOrder cuttingOrder, CuttingOrderSize orderSize)
        {
            return new ProductionWorkOrder
            {
                CuttingOrderId = cuttingOrder.RecordId,
                Size = orderSize.Size,
                OrderStatus = GlobalConstants.STATUS_ORDER_INITIATE,
            };
        }

        private BomOrder CreateWorkOrderBom(CuttingOrder cuttingOrder, IQueryable<Bom> boms)
        {
            BomOrder bomOrder = new BomOrder
            {
                BomOrderType = GlobalConstants.TYPE_BOM_ORDER_PRODUCTION_ORDER,
                MaterialId = cuttingOrder.FgMaterialId,
                OrderStatus = GlobalConstants.STATUS_DOCUMENT_NORMAL
            };

            foreach (Bom bom in boms)
            {
                bom.BomOrderId = 0;
                bom.BomOrder = bomOrder;
                bom.QtyComponent = (cuttingOrder.QtyPlanned / bom.QtyComponent) * cuttingOrder.QtyActual;

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
                workOrderRouting.QtyPlanned = 1; //单件流：数量为1，大扎流，则是一扎的件数
                workOrderRoutings[i] = workOrderRouting;
                workOrderRouting.OperationRoutingId = operationRouting.RecordId;
            }

            return workOrderRoutings;
        }

        public IWorkStationFinder StichWorkStationFinder { get; set; }
    }

    public interface IWorkStationDistanceComputor
    {
        int ComputeWorkStationDispatchDistance(WorkStation a, WorkStation b);
    }

    public class StichOperationRoutingWorkStationFinderParameter : IWrokStationFinderParameter
    {
        public ProductionWorkOrderRouting PrevWorkOrderRouting { get; set; }
        public ProductionWorkOrderRouting CurrentWorkOrderRouting { get; set; }
        public DbContext DbContext { get; set; }
    }

    public class DefaultStichOperationRoutingWorkStationFinder : IWorkStationFinder
    {
        public DefaultStichOperationRoutingWorkStationFinder()
        {
            this.WorkStationDistanceComputor = new SingleMainOrbitOneDirectionDistanceComputor();
        }

        public WorkStation FindWorkStation(IWrokStationFinderParameter imputParameter)
        {
            StichOperationRoutingWorkStationFinderParameter parameter = imputParameter as StichOperationRoutingWorkStationFinderParameter;
            ProductionWorkOrderRouting prevWorkOrderRouting = parameter.PrevWorkOrderRouting;
            ProductionWorkOrderRouting currentWorkOrderRouting = parameter.CurrentWorkOrderRouting;
            DbContext dbContext = parameter.DbContext;

            WorkStation prevWorkStation = SingletonDataService.Instance.WorkStations.Single(x => x.RecordId == prevWorkOrderRouting.WorkStationId);
            OperationRouting operationRouting = dbContext.Set<OperationRouting>().Single(x => x.RecordId == currentWorkOrderRouting.OperationRoutingId);

            var workStationWrapper = (
                from w in SingletonDataService.Instance.WorkStations
                join c in SingletonDataService.Instance.OperatorCapabilities on w.OperatorId equals c.OperatorId
                where w.IsOnLine        //工位已联线
                     && w.IsAvailable   //工位可用
                     && w.MachineTypeId == operationRouting.MachineTypeId  //机器类型匹配
                     && (w.WipCurrent + w.WipInTransit) < w.WipMax         //WIP
                     && c.OperationId == operationRouting.OperationId      //工艺
                                                                           // && c.SkillLevel >= operationRouting.RequiredLevel     //技能等级                        
                select new
                {
                    WorkStation = w,
                    // SkillLevel = c.SkillLevel,
                    Distance = this.WorkStationDistanceComputor.ComputeWorkStationDispatchDistance(prevWorkStation, w)
                }
            ).OrderBy(x => x.Distance)    //距离最短
            .OrderBy(x => x.WorkStation.WipInTransit + x.WorkStation.WipCurrent) //WIP最小
                                                                                 // .OrderByDescending(x => x.SkillLevel)   //技能最高
            .OrderBy(x => x.WorkStation.RecordId)   // 编号最小
            .FirstOrDefault();

            if (workStationWrapper == null)
            {
                return null;
            }
            return workStationWrapper.WorkStation;
        }

        public IWorkStationDistanceComputor WorkStationDistanceComputor { get; set; }
    }


    public class SingleMainOrbitOneDirectionDistanceComputor : IWorkStationDistanceComputor
    {
        //
        //计算两个工位之间的派工距离:单主轨、单向行驶
        //
        public int ComputeWorkStationDispatchDistance(WorkStation a, WorkStation b)
        {
            WorkLine lineA = SingletonDataService.Instance.ProudctionLines.Single(x => x.RecordId == a.ParentOrganizationId);
            WorkLine lineB = SingletonDataService.Instance.ProudctionLines.Single(x => x.RecordId == b.ParentOrganizationId);
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
            int workStationCount = SingletonDataService.Instance.WorkStations.Count(x => x.ParentOrganizationId == lineA.RecordId);
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
    }
}