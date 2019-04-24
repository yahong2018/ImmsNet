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
        //获取作业单的当前工序
        //
        public ProductionWorkOrderRouting GetProductionWorkOrderCurrentRouting(string productionWorkOrderNo)
        {
            DbContext dbContext = GlobalConstants.DbContextFactory.GetContext();
            return dbContext.Set<ProductionWorkOrder>().Where(x => x.OrderNo == productionWorkOrderNo).Select(x => x.CurrentRouting).FirstOrDefault();
        }

        //
        //获取某个RFID卡相关的所有的生产作业订单的第一道工序（上裁片）
        //
        public ProductionWorkOrderRouting[] GetFirstRoutings(string containerNo)
        {
            ProductionWorkOrderRouting[] result = null;
            CommonDAO.UseDbContext(dbContext =>
            {
                result = dbContext.Set<ProductionWorkOrderRouting>().Where(x =>
                   (   //是属于本卡的作业单工艺
                       dbContext.Set<ProductionWorkOrder>().Where(p =>
                          dbContext.Set<CuttingOrder>().Where(c => c.ContainerNo == containerNo)
                          .Select(c => c.RecordId)
                          .Contains(p.CuttingOrderId)
                      ).Select(p => p.RecordId)
                      .Contains(x.ProductionWorkOrderId)
                  ) && (
                      x.OperationRouting.PrevOpreatons.Count() == 0   //是第一道工序
                  ) && (
                      x.TimeFinished == null   // 没有完成报工
                  )
                ).Include(x => x.OperationRouting)
                .OrderByDescending(x => x.CreateDate)
                .ToArray()
                ;
            });

            return result;
        }


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

                GlobalConstants.ModifyEntityStatus(productionOrder, dbContext);
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
            GlobalConstants.ModifyEntityStatus(productionOrder, dbContext);
        }

        private void WorkOrderReport(ProductionWorkOrder workOrder, DbContext dbContext)
        {
            workOrder.OrderStatus = GlobalConstants.STATUS_ORDER_FINISHED;
            workOrder.TimeEndActual = DateTime.Now;
            GlobalConstants.ModifyEntityStatus(workOrder, dbContext);
        }

        //
        //作业单工艺报工
        //
        public void WorkOrderRoutingReport(ProductionWorkOrderRouting workOrderRouting)
        {
            CommonDAO.UseDbContext(dbContext =>
            {
                workOrderRouting.TimeFinished = DateTime.Now;
                WorkStation workStation = dbContext.Set<WorkStation>().Single(x => x.RecordId == workOrderRouting.WorkStationId);
                if (workStation.WipCurrent >= workOrderRouting.QtyFinished)
                {
                    workStation.WipCurrent -= workOrderRouting.QtyFinished; //修改工位的WIP
                    GlobalConstants.ModifyEntityStatus(workStation, dbContext);
                }
                GlobalConstants.ModifyEntityStatus(workOrderRouting, dbContext);
                dbContext.SaveChanges();

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

                    dbContext.SaveChanges();
                }
                else
                {
                    ProductionWorkOrderRouting nextWorkOrderRouting = dbContext.Set<ProductionWorkOrderRouting>().Where(x =>
                        x.OperationRoutingId == currentRouting.NextRoutingId
                         && x.ProductionWorkOrderId == workOrderRouting.ProductionWorkOrderId
                    ).Single();

                    this.ScheduleWorkOrderRouting(workOrderRouting, nextWorkOrderRouting);

                    //
                    //ThreadPool.QueueUserWorkItem(this.ScheduleWorkOrderRouting,
                    //   new ProductionWorkOrderRouting[] { workOrderRouting, nextWorkOrderRouting },
                    //   false
                    //);
                    //
                }
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
                lock (StitchLogic.Instance)
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
                    currentWorkOrderRouting.ConatinerNo = prevWorkOrderRouting.ConatinerNo;  //记录下衣架号

                    //
                    //修改工位的WIP。因为目前没有实现进站、出站，所以直接使用WIP，以后要使用在途WIP+实际WIP来进行计算
                    //
                    currentWorkStation.WipCurrent += currentWorkOrderRouting.QtyPlanned;

                    //更新作业单的当前工序
                    ProductionWorkOrder workOrder = dbContext.Set<ProductionWorkOrder>()
                       .Where(x => x.RecordId == currentWorkOrderRouting.ProductionWorkOrderId)
                       .Single();
                    workOrder.CurrentRoutingId = currentWorkOrderRouting.RecordId;

                    //数据保存
                    GlobalConstants.ModifyEntityStatus(currentWorkOrderRouting, dbContext);
                    GlobalConstants.ModifyEntityStatus(currentWorkStation, dbContext);
                    GlobalConstants.ModifyEntityStatus(workOrder, dbContext);
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
                    productionWorkOrder.QtyPlanned = 1; //单件流，默认为1
                    productionWorkOrder.OperationRoutingOrderId = productionOrder.RoutingOrderId.Value;
                    productionWorkOrders.Add(productionWorkOrder);

                    //创建缝制BOM
                    BomOrder bomOrder = this.CreateWorkOrderBom(cuttingOrder, pickingBoms);  //生成BOM
                    productionWorkOrder.WorkOrderBom = bomOrder;
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

        private BomOrder CreateWorkOrderBom(CuttingOrder cuttingOrder, IQueryable<Bom> pickingBoms)
        {
            BomOrder bomOrder = new BomOrder
            {
                BomOrderType = GlobalConstants.TYPE_BOM_ORDER_WORK_ORDER, //缝制作业单的BOM
                MaterialId = cuttingOrder.FgMaterialId,
                OrderStatus = GlobalConstants.STATUS_DOCUMENT_NORMAL
            };

            foreach (Bom pickingBom in pickingBoms)
            {
                Bom workOrderBom = new Bom();
                workOrderBom.Clone(pickingBom);
                workOrderBom.BomOrderId = 0;
                workOrderBom.QtyComponent = (pickingBom.QtyComponent / cuttingOrder.QtyPlanned);

                bomOrder.Boms.Add(workOrderBom);
            }

            return bomOrder;
        }

        private ProductionWorkOrderRouting[] CreateWorkOrderRoutings(List<OperationRouting> productionRoutings)
        {
            ProductionWorkOrderRouting[] workOrderRoutings = new ProductionWorkOrderRouting[productionRoutings.Count];
            for (int i = 0; i < productionRoutings.Count; i++)
            {
                ProductionWorkOrderRouting workOrderRouting = new ProductionWorkOrderRouting();
                workOrderRouting.QtyPlanned = 1; //单件流：数量为1，大扎流，则是一扎的件数
                workOrderRoutings[i] = workOrderRouting;
                workOrderRouting.OperationRoutingId = productionRoutings[i].RecordId;
            }

            return workOrderRoutings;
        }

        public IWorkStationFinder StichWorkStationFinder { get; set; }
    }

    public interface IWorkStationDistanceComputor
    {
        int ComputeWorkStationDispatchDistance(WorkStation a, WorkStation b, DbContext dbContext);
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

            WorkStation prevWorkStation = dbContext.Set<WorkStation>().Single(x => x.RecordId == prevWorkOrderRouting.WorkStationId);
            OperationRouting operationRouting = dbContext.Set<OperationRouting>().Single(x => x.RecordId == currentWorkOrderRouting.OperationRoutingId);

            var candidateWorkStaitons = (
                from w in dbContext.Set<WorkStation>()
                join c in dbContext.Set<OperatorCapability>() on w.OperatorId equals c.OperatorId
                where w.IsOnLine        //工位已联线
                     && w.IsAvailable   //工位可用
                     && w.MachineTypeId == operationRouting.MachineTypeId  //机器类型匹配
                     && w.WipMax > (w.WipCurrent + w.WipInTransit)        //WIP
                     && c.OperationId == operationRouting.OperationId      //工艺
                                                                           // && c.SkillLevel >= operationRouting.RequiredLevel     //技能等级                        
                select w
            )
            .OrderBy(x => x.WipInTransit + x.WipCurrent) //WIP最小
                                                         // .OrderByDescending(x => x.SkillLevel)   //技能最高  
            .ToList()
            ;

            var workStationWrapper = (from w in candidateWorkStaitons
                                      select new
                                      {
                                          WorkStation = w,
                                          Distance = this.WorkStationDistanceComputor.ComputeWorkStationDispatchDistance(prevWorkStation, w, dbContext)
                                      })
                                      .OrderBy(x => x.Distance)
                                      .OrderBy(x => x.WorkStation.WorkStationCode)   // 编号最小
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
        public int ComputeWorkStationDispatchDistance(WorkStation a, WorkStation b, DbContext dbContext)
        {
            WorkLine lineA = dbContext.Set<WorkLine>().Single(x => x.RecordId == a.ParentOrganizationId);
            WorkLine lineB = dbContext.Set<WorkLine>().Single(x => x.RecordId == b.ParentOrganizationId);

            int workStationCount = dbContext.Set<WorkStation>().Count(x => x.ParentOrganizationId == lineA.RecordId);
            if (a.ParentOrganizationId == b.ParentOrganizationId)
            {   //同产线
                return ComputeWorkStationDispatchDistance(a, b, workStationCount);
            }
            else
            {
                int lineDistance = dbContext.Set<WorkLine>().Where(x => x.SequenceNo > lineA.SequenceNo && x.SequenceNo <= lineB.SequenceNo).Sum(x => x.LineDistance);
                if (lineA.SequenceNo < lineB.SequenceNo) //不同产线：从小号产线往大号产线派工
                {
                    return lineDistance + this.ComputeWorkStationDispatchDistance(a, b, workStationCount);
                }
                else //不同产线：从大号产线往小号产线派工                    
                {
                    int mainOrbitLength = dbContext.Set<WorkCenter>().Where(x => x.RecordId == lineA.ParentOrganizationId).Select(x => x.MainOrbitLength).Single();
                    return (mainOrbitLength - lineDistance) + this.ComputeWorkStationDispatchDistance(a, b, workStationCount);
                }
            }
        }

        private int ComputeWorkStationDispatchDistance(WorkStation a, WorkStation b, int workStationCount)
        {
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
                return workStationCount - (b.SequenceNo - a.SequenceNo);
            }
        }
    }
}