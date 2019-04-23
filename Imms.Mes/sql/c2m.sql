
--
-- 编码种子配置
--
create table code_seed(
  record_id                bigint auto_increment        not null,
  seed_no                  varchar(50)                  not null,
  seed_name                varchar(50)                  not null,
  initial_value            int                          not null,
  prefix                   varchar(10)                  not null,
  postfix                  varchar(10)                  not null,
  total_length             int                          not null,

  primary key (record_id),
  index idx_code_seed_0(seed_no)
);

insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('Imms.Mes.MasterData.BomOrder','bom单号',1,'BOM','',12);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('Imms.Mes.Stitch.ProductionOrder','生产计划单号',1,'PO','',12);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('Imms.Mes.Stich.OperationRoutingOrder','工艺路线单号',1,'ORO','',12);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('piking_schedule_no','领料计划单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('piking_order_no','领料单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('cutting_order_no','裁剪单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('work_order_no','作业单号',1,'','',10);



/*
   平面编码：比如“单位”、“民族”,“设备类别”       
*/
create table plan_code  (
  record_id                          bigint auto_increment          not null ,
  code_type                          varchar(128)                   not null,        -- 编码类型
  code_no                            varchar(10)                    not null,         -- 编码
  code_name                          varchar(30)                    not null,         -- 名称
  description                        varchar(250)                   null,            -- 描述

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id),
  index idx_plan_code_01(code_no) ,
  index idx_plan_code_02(code_name),
  index idx_plan_code_03(code_type)
);


/*
tree_code：树形编码
    “缺陷代码”、“物料类别”、“颜色”  
*/

create table tree_code  (
  record_id                          bigint auto_increment          not null,
  code_type                          varchar(128)                   not null,        -- 编码类型
  code_no                            varchar(10)                    not null,        -- 编码
  code_name                          varchar(30)                    not null,         -- 名称
  description                        varchar(250)                   null,            -- 描述
  parent_id                          bigint                         not null default 0, -- 上级  

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,
  index idx_tree_code_01(code_no) ,
  index idx_tree_code_02(code_name) ,
  index idx_tree_code_03(parent_id),
  index idx_tree_code_04(code_type)      
);

--
-- 生产组织单元
--
create table work_organization_unit  (
  record_id                bigint auto_increment           not null,
  organization_type        varchar(128)                    not null,  -- 生产组织单元类别：工厂,工作中心,生产线,工位
  organization_code        varchar(50)                     not null,
  organization_name        varchar(50)                     not null,
  sequence_no              int                             not null default 1, -- 顺序号
  description              varchar(250)                    null ,  
  parent_organization_id   bigint                          not null,  -- 上级生产单元，顶级为0

  cost_price_ratio         double(8,4)                     not null default 1, -- 提成比例

  main_orbit_length        int                             not null default 0, -- 主轨长度(工作中心专用)：以工位间隔为单位  
  rotate_direction         int                             not null default 0, -- 旋转方向:0.顺时针  1.逆时针
  
  line_distance            int                             not null default 0, -- 相对前一产线的间隔(生产线专用)

  work_station_type        varchar(50)                     not null default '', -- 工作中心类型
  machine_type_id          bigint                          not null default 0,  -- 机器类型
  is_on_line               bit                             not null default 1,  -- 是否在线
  operator_id              bigint                          not null default 0,  -- 当前操作员
  is_available             bit                             not null default 1,  -- 是否可用
  wip_max                  int                             not null default 0,  -- 最大WIP数
  wip_current              int                             not null default 0,  -- 当前WIP数
  wip_in_transit           int                             not null default 0,  -- 在途WIP数
  direction                int                             not null default 0,  -- 方向:0.左边   1.右边
  
  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,  
  index idx_work_organization_unit_01(organization_code),
  index idx_work_organization_unit_02(organization_type),
  index idx_work_organization_unit_03(parent_organization_id)
);

--
-- 操作员
--
create table operator  (
  record_id                  bigint    auto_increment       not null,
  user_id                    bigint       not null,
  organization_id            bigint       not null,
  supervisor_id              bigint       not null,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,
  index idx_operator_01(user_id) ,
  index idx_operator_02(organization_id) ,
  index idx_operator_03(supervisor_id)
);

--
-- 设备
--
create table equipment
(
    record_id                bigint   auto_increment        not null,
    equipment_no             varchar(20)                    not null,
    equipment_name           varchar(50)                    not null,
    description              varchar(500)                   not null,
    status                   int                            not null,
    equipment_type_id        bigint                         not null,
    work_station_id          bigint                         not null,

    primary key(record_id),
    index idx_equipment_01(record_id),
    index idx_equipment_02(equipment_no),
    index idx_equipment_03(equipment_type_id),
    index idx_equipment_04(work_station_id),
    index idx_equipment_05(status)
);


--
-- 物料
--
create table material
(
  record_id            bigint     auto_increment     not null,
  material_no          varchar(20)                   not null, -- 物料号
  material_name        varchar(50)                   not null, -- 物料名称
  material_type_id     bigint                        not null, -- 物料类型
  unit                 varchar(20)                   not null default '', -- 单位
  width                decimal(10, 4)                null,     -- 幅宽
  weight               decimal(10, 4)                null,     -- 纺织克重
  price                decimal(10, 2)                null,     -- 价格
  color                varchar(20)                   null,     -- 颜色
  description          varchar(250)                  null,     -- 物料描述

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id),
  index idx_material_01 (material_no),
  index idx_material_02 (material_name),
  index idx_material_03 (material_type_id)
) ;

--
--  物料清单_单头
--
create table bom_order
(
  record_id         bigint   auto_increment                     not null,
  order_no          varchar(12)                                 not null  , -- bom 单号
  order_status      int                                         not null,

  bom_order_type    int                                         not null  , -- 基准bom
  material_id       bigint                                      not null,     

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id),
  index idx_bom_order_01 (order_no),
  index idx_bom_order_02 (order_status),
  index idx_bom_order_03 (material_id)
);

--
-- 物料清单_单身
--
create table bom
(
  record_id                        bigint   auto_increment    not null,
  bom_order_id                     bigint                     not null,  
  component_material_id            bigint                     not null, -- 子件物料id
  component_abstract_material_id   bigint                     null,     -- 子件抽象物料id
  qty_component                    float(8,2)                 not null, -- 子件用量
  component_unit                   varchar(20)                not null default '', -- 子件单位 
  is_main_fabric                   bit                        not null, -- 是否主面料
  parent_bom_id                    bigint                     null,     -- 上级bom id

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id),
  index idx_bom_01 (component_material_id),
  index idx_bom_02 (component_abstract_material_id),
  index idx_bom_03 (parent_bom_id),  
  index idx_bom_04 (bom_order_id)
);

--
-- 工艺
--
create table operation  (
  record_id                        bigint auto_increment         not null,
 
  operation_no                     varchar(20)                   not null,
  description                      varchar(3000)                  not null ,
  machine_type_id                  bigint                        not null ,
  standard_time                    double(8,4)                   null,     -- 标准工时
  standard_price                   double(8,4)                   null,     -- 标准单价
  section_type                     varchar(12)                   null ,     -- 工段编号
  section_name                     varchar(30)                   null ,     -- 工段名称
  is_outsource                     bit                           not null , -- 是否外协
  qa_procedure                     varchar(1000)                 null ,   -- 品质说明
  requirement                      varchar(1000)                 null ,   -- 工艺要求
  required_level                   varchar(10)                   null ,   -- 工艺等级

  -- sopfiles    sop文件
  -- videofiles  工艺视频文件

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,
  index idx_operation_01(operation_no) ,
  index idx_operation_02(machine_type_id)
) ;


create table operation_media
(
  record_id           bigint     not null auto_increment,
  media_id            bigint     not null,  
  opertation_id       bigint     not null,
  media_type          int        not null,   -- 0. soap文件  1.工艺视频文件

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key(record_id),
  index idx_operation_media_0(media_id),
  index idx_operation_media_1(opertation_id)
);


--
-- 工艺技能要求
--
create table operator_capability  (
  record_id                        bigint   auto_increment       not null,
  operator_id                      bigint                        not null,
  operation_id                     bigint                        not null,
  skill_level                      tinyint                       not null,
  
  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id),
  index idx_operator_capability_01(operator_id),
  index idx_operator_capability_02(operation_id)
); 

--
-- 工艺路线_单头
--
create table operation_routing_order  (
  record_id                        bigint   auto_increment      not null,
  order_no                         varchar(12)                  not null ,
  order_status                     int                          not null,

  order_type                       int                          not null , -- 0:物料工艺路线,1:生产订单工艺路线,2:作业单工艺路线
  material_id                      bigint                       not null , 

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,
  index idx_operation_routing_order_01(order_no),
  index idx_operation_routing_order_02(material_id)
) ;

--
-- 工艺路线_单身
--

create table operation_routing  (
  record_id                       bigint  auto_increment            not null,
  operation_routing_order_id      bigint              not null,             -- 工艺路线单主键  
  operation_id                    bigint              not null,             -- 工艺  
	next_operation_id               bigint              null,
  next_operation_no               varchar(20)         null ,                -- 下道工序
  next_routing_id                 bigint              null,                 -- 

  operation_no                     varchar(20)                   not null,
  description                      varchar(3000)                 not null ,
  machine_type_id                  bigint                        not null ,
  standard_time                    double(8,4)                   null,     -- 标准工时
  standard_price                   double(8,4)                   null,     -- 标准单价
  section_type                     varchar(12)                   null ,     -- 工段编号
  section_name                     varchar(30)                   null ,     -- 工段名称
  is_outsource                     bit                           not null , -- 是否外协
  qa_procedure                     varchar(1000)                 null ,   -- 品质说明
  requirement                      varchar(1000)                 null ,   -- 工艺要求
  required_level                   varchar(10)                   null ,   -- 工艺等级  
  
  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,
  index idx_operation_routing_01(operation_id) ,
  index idx_operation_routing_02(operation_routing_order_id) ,  
  index idx_operation_routing_03(next_routing_id)
);

-- --
-- -- 需求订单
-- --
-- create table requirement_order  (
--    record_id                       bigint    auto_increment                     not null,
--    order_no                        varchar(12)           not null  ,             -- 需求订单号
--    order_status                    int                   not null  ,             -- 状态
--    order_type                      int                   not null  ,             -- 需求订单类型
   
--    priority                        int                   not null  ,             -- 优先级
--    work_center_id                  bigint                not null  ,             -- 工作中心主键
--    fg_material_id                  bigint                not null  ,             -- 物料号
--    planned_qty                     int                   not null  ,             -- 计划生产数量
--    required_delivery_date          datetime              not null  ,             -- 需求交期
--    sale_order_no                   varchar(64)           null ,                  -- 销售订单号
--    repeat_type                     int                   not null default 0,     -- 重复类型:0.首单 1.返单 2.补单

--   create_by                            bigint                       not null,
--   create_date                          datetime                     not null,
--   update_by                            bigint                       null,
--   update_date                          datetime                     null,
--   opt_flag                             int                          not null default 0,

--    primary key (record_id) ,
--    index idx_requirement_order_01(order_no) ,
--    index idx_requirement_order_02(work_center_id)
--  ) ;

-- --
-- -- 生产排程
-- --
-- create table schedule_order(
--   record_id                       bigint       auto_increment        not null,
  
--   order_no                        varchar(12)                        not null,
--   order_status                    int                                not null,

--   requirement_order_id            bigint                             null,
--   priority                        tinyint                            not null,
    
--   plan_id                         bigint                             not null,  
--   work_center_id                  bigint                             not null,  
--   fg_material_id                  bigint                             not null,
    
--   qty_planned                     int                                not null,
--   qty_actual                      int                                null,
  
--   date_plan_start                 datetime                           not null,
--   date_plan_end                   datetime                           not null,
--   date_actual_start               datetime                           null,
--   date_actual_end                 datetime                           null,
  
--   create_by                       bigint                             not null,
--   create_date                     datetime                           not null,
--   update_by                       bigint                             null,
--   update_date                     datetime                           null,
--   opt_flag                        int                                not null default 0,

--   primary key (record_id),
--   index idx_schedule_order_01(order_no),
--   index idx_schedule_order_02(requirement_order_id),
--   index idx_schedule_order_03(fg_material_id),
--   index idx_schedule_order_04(order_status)
-- );


--
-- 生产订单
--
create table production_order  (
  record_id                   bigint    auto_increment          not null,  
  order_no                    varchar(12)       not null,
  order_status                int               not null   default 0,
  order_type                  int               not null,

  requirement_order_no        varchar(12)       null,
  schedule_order_no           varchar(12)       null, 
  
  fg_material_id              bigint            not null, -- 成品物料
  priority                    tinyint           not null,
  work_center_id              bigint            null , 
  
  routing_order_id            bigint            null , -- 生产工艺
  bom_order_id                bigint            null,  -- bom

  qty_planned                 int               null ,  
  qty_finished                int               not null default 0,
  qty_second_quality          int               not null default 0, -- 次品数量
  qty_defect                  int               not null default 0,
  qty_actual                  int               not null default 0,

  time_start_planned          datetime          not null ,
  time_end_planned            datetime          not null ,
  time_start_actual           datetime          null ,
  time_end_actual             datetime          null ,    
  
  create_by                   bigint            not null,
  create_date                 datetime          not null,
  update_by                   bigint            null,
  update_date                 datetime          null,
  opt_flag                    int               not null default 0,

  primary key (record_id),
  index idx_production_order_01(order_no),
  index idx_production_order_02(requirement_order_no),
  index idx_production_order_03(schedule_order_no),
  index idx_production_order_04(fg_material_id),
  index idx_production_order_05(order_status)
);

--
-- 订单尺码明细
--
create table production_order_size  (
  record_id                    bigint  auto_increment  not null ,
  production_order_id          bigint                  not null,  
  size                         varchar(20)             not null,
  qyt_planned                  int                     not null,

  create_by                    bigint                  not null,
  create_date                  datetime                not null,
  update_by                    bigint                  null,
  update_date                  datetime                null,
  opt_flag                     int                     not null default 0,

  primary key (record_id),
  index idx_order_size_01(production_order_id)  
) ;

--
-- 订单量体数据
--
create table production_order_measure  (
  record_id                    bigint   auto_increment  not null,
  production_order_id          bigint                   not null ,  
  body_no                      varchar(20)              not null ,
  measure_data                 varchar(10)              not null ,
  garment_size                 varchar(10)              not null , 

  create_by                    bigint                   not null,
  create_date                  datetime                 not null,
  update_by                    bigint                   null,
  update_date                  datetime                 null,
  opt_flag                     int                      not null default 0,

  primary key (record_id) ,
  index idx_order_measure_01(production_order_id)  
);


create table production_order_pattern_relation(
  record_id                    bigint                   not null auto_increment,
  production_order_id          bigint                   not null,
  material_id                  bigint                   not null,
  media_id                     bigint                   not null,

  create_by                    bigint                   not null,
  create_date                  datetime                 not null,
  update_by                    bigint                   null,
  update_date                  datetime                 null,
  opt_flag                     int                      not null default 0,

  primary key (record_id) ,
  index idx_production_order_pattern_relation_01(production_order_id),
  index idx_production_order_pattern_relation_02(material_id),    
  index idx_production_order_pattern_relation_03(media_id)
)

--
-- 领料单
--
create table picking_order  (
  record_id                            bigint                       not null auto_increment,
  order_no                             varchar(12)                  not null,
  order_status                         int                          not null,

  production_order_id                  long                         not null,
  order_type                           int                          not null, -- 单据类型： 裁剪领料单/缝制领料单
  priority                             int                          not null,
  picking_bom_order_id                 bigint                       not null,    
  container_no                         varchar(64)                  not null,
  operator_id                          bigint                       not null,

  time_start_planned                   datetime                     not null,
  time_end_planned                     datetime                     not null,

  time_start_actual                    datetime                     null,
  time_end_actual                      datetime                     null,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,
  index idx_picking_order_01(order_no) ,
  index idx_picking_order_02(container_no) ,
  index idx_picking_order_03(operator_id),
  index idx_picking_order_04(picking_bom_order_id)
) ;

--
-- 领料明细
--
create table picking_order_item  (
  record_id                            bigint                       not null  auto_increment,
  picking_order_id                     bigint                       not null, -- 领料单主键
  bom_id                               bigint                       null, -- Bom的Id
  picked_qty                           double(10,4)                 null, -- 领用量

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                              int                          not null default 0,

  primary key (record_id) ,
  index idx_picking_order_item_01(picking_order_id) ,
  index idx_picking_order_item_02(bom_id)
);

--
-- 裁剪单
--
create table cutting_order  (
  record_id                   bigint              not null auto_increment,
  order_no                    varchar(12)         not null             ,-- 裁剪单号  
  order_status                int                 not null             ,-- 状态

  picking_order_id            bigint              not null,             -- 对应的领料单号
  production_order_id         bigint              not null             ,-- 生产订单主键
  cutting_table_no            varchar(64)         null                 ,-- 床次  
  container_no                varchar(64)         null                 ,-- 裁剪单容器  
  fg_material_id              varchar(64)         not null                 ,-- 成品物料号  
  fabric_material_id          bigint              not null                 ,-- 面料物料主键
  plies                       int                 not null                 ,-- 层数
  width                       double(8,4)         not null                 ,-- 幅宽
  length                      double(8,4)         not null                 ,-- 长度
  cutting_efficiency          double(7,4)         not null                 ,-- 利用率

  work_station_id             bigint              null                     ,-- 裁剪工位
  
  qty_planned                 int                 not null   default 0     ,-- 计划数量  
  time_start_planned          datetime            null                 ,-- 计划开工时间  
  time_end_planned            datetime            null                 ,-- 计划完成时间

  time_start_actual           datetime            null                   ,-- 实际开工时间
  time_end_actual             datetime            null                   ,-- 实际完成时间
  qty_actual                  int                 not null   default 0   , -- 实际数量
  qty_finished                int                 not null   default 0   ,-- 完工数量
  operator_id                 bigint              null,                   -- 裁剪人

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                              int                          not null default 0,

  primary key (record_id),
  index idx_cutting_order_01(order_no),
  index idx_cutting_order_02(production_order_id),
  index idx_cutting_order_03(work_station_id),
  index idx_cutting_order_04(container_no),
  index idx_cutting_order_05(picking_order_id)  
) ;

--
-- 裁剪单尺码明细
--
create table cutting_order_size  (
  record_id                   bigint              not null        auto_increment,
  cutting_order_id            bigint              not null ,   -- 裁剪单主键  
  size                        varchar(10)         null,        -- 尺码
  qty_layer                   int                 null,        -- 单层配比数量
  qty_planned                 int                 null,        -- 计划数量
  qty_finished                int                 null,        -- 完工数量
  -- created_work_order_qty      int                 null,        -- 已创建作业单数量

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                              int                          not null default 0,

  primary key (record_id),
  index idx_cutting_order_size_01(cutting_order_id)
);

--
-- 生产裁剪排料图
-- 
create table cutting_marker  (
  record_id                   bigint             not null auto_increment,
  cutting_order_id            bigint             not null,  
  media_id                    bigint             null,
  remark                      varchar(255)       null,
  marker_file_id              bigint             null,

  create_by                   bigint             not null,
  create_date                 datetime           not null,
  update_by                   bigint             null,
  update_date                 datetime           null,
  opt_flag                    int                not null default 0,

  primary key (record_id),
  index idx_cutting_marker_01(cutting_order_id),
  index idx_cutting_marker_02(media_id)
) ;

--
-- 裁剪拉布层数
--
create table cutting_order_spread_ply
(
  record_id                 bigint                not null auto_increment,
  cutting_order_id          bigint                not null,
  length                    double(8,2)           not null, -- 拉布长度
  plies                     int                   not null, -- 层数

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                              int                         not null default 0,

  primary key(record_id),
  index idx_cutting_order_spread_ply_01(cutting_order_id)
);

create table quality_check
(
  record_id              bigint                 not null auto_increment,
  production_order_id    bigint                 not null,
  size_no                varchar(50)            not null,
  size_name              varchar(50)            not null,

  create_by              bigint                       not null,
  create_date            datetime                     not null,
  update_by              bigint                       null,
  update_date            datetime                     null,
  opt_flag               int                         not null default 0,

  primary key(record_id),
  index idx_quality_check_01(production_order_id)	
);

create table quality_check_detail
(
    record_id              bigint                 not null auto_increment,
	quality_check_id       bigint                 not null,
	component_no           varchar(50)            not null,
	component_name         varchar(50)            not null,
	standard_value         varchar(50)            not null,

    create_by              bigint                       not null,
    create_date            datetime                     not null,
    update_by              bigint                       null,
    update_date            datetime                     null,
    opt_flag               int                          not null default 0,

    primary key(record_id),
    index idx_quality_check_detail_01(quality_check_id)	
);


--
-- 生产作业单
--
create table production_work_order  (
  record_id                  bigint             not null auto_increment,  
  order_no                   varchar(12)        not null,
  order_status               int                not null  ,

  production_order_id        bigint             not null,
  bom_order_id               bigint             not null,
  operation_routing_order_id bigint             not null,
  cutting_order_id           bigint             not null,
  size                       varchar(20)        not null,-- 尺码

  qty_planned                int                not null,
  qty_finished               int                null,
  
  time_start_planned         datetime           not null ,
  time_end_planned           datetime           not null ,
  time_start_actual          datetime           null ,
  time_end_actual            datetime           null ,

  create_by                   bigint            not null,
  create_date                 datetime          not null,
  update_by                   bigint            null,
  update_date                 datetime          null,
  opt_flag                    int               not null default 0,

  primary key (record_id) ,
  index idx_pro_work_order_01(order_no) ,
  index idx_pro_work_order_02(production_order_id) ,
  index idx_pro_work_order_03(time_start_planned) ,
  index idx_pro_work_order_04(time_end_planned)
);

--
-- 生产作业单工艺路线
--
create table production_work_order_routing
(
  record_id                       bigint  auto_increment            not null,  
  production_work_order_id        bigint              not null,             -- 所属作业单
  operation_routing_id            bigint              not null,             -- 所属工艺

  operator_id                     bigint              null,                 -- 操作员
  work_station_id                 bigint              null ,                -- 操作工位

  qty_scrap                       int                 null default 0 ,      -- 报废数量
  qty_planned                     int                 null default 0 ,      -- 完工数量
  qty_finished                    int                 null default 0 ,      -- 完工数量

  time_started                    datetime            null  ,               -- 开始时间
  time_finished                   datetime            null  ,               -- 完工时间
  time_scheduled                  datetime            null  ,               -- 派工时间
  
  time_pushed_in                  datetime            null  ,               -- 进站时间
  time_pushed_out                 datetime            null  ,               -- 进站时间
  
  create_by                       bigint              not null,
  create_date                     datetime            not null,
  update_by                       bigint              null,
  update_date                     datetime            null,
  opt_flag                        int                 not null default 0,

  primary key(record_id),
  index idx_production_work_order_routing_01(production_work_order_id),
  index idx_production_work_order_routing_02(operation_routing_id),
  index idx_production_work_order_routing_03(work_station_id),
  index idx_production_work_order_routing_04(operator_id)
);

--
-- 工位登录记录 
--
create table workstation_check_in  (
  record_id                  bigint         not null auto_increment,
  work_station_id            bigint         not null ,
  operator_id                bigint         not null ,  
  check_in_time              datetime       null,-- 入岗时间
  check_out_time             datetime       null,-- 出岗时间
  
  primary key (record_id) ,
  index idx_workstation_check_in_01(operator_id) ,
  index idx_workstation_check_in_02(work_station_id)
) ;

create table media  (
  record_id                      bigint  auto_increment            not null,
  media_format                   varchar(50)        not null,   
  media_url                      varchar(255)        not null,
  media_name                     varchar(100)        not null,
  media_size                     int                 not null,
  description                    varchar(250)        null ,

  create_by                       bigint              not null,
  create_date                     datetime            not null,
  update_by                       bigint              null,
  update_date                     datetime            null,
  opt_flag                        int                 not null default 0,  

  primary key (record_id),
  index idx_media_0 (media_name)  
);

create table media_belong(
  record_id                      bigint  auto_increment            not null,
  media_id                       bigint                            not null,   
  belong_to_id                   bigint                            not null,
  belong_to_record_type          int                               not null,
  media_type                     varchar(50)                       not null,

  create_by                       bigint              not null,
  create_date                     datetime            not null,
  update_by                       bigint              null,
  update_date                     datetime            null,
  opt_flag                        int                 not null default 0,  

  primary key (record_id),
  index idx_media_belong_0 (media_id),  
  index idx_media_belong_1 (belong_to_id),
  index idx_media_belong_2 (belong_to_record_type)
);

/* 

create table quality_issue  (
  id                        bigint(20)          not null auto_increment,
  issue_order_id            bigint(20)          not null               ,-- 单据主键  
  operation_routing_id      bigint(20)          not null               ,-- 工艺工序主键
  workstation_id            bigint(20)          not null               ,-- 工位主键
  operator_id               bigint(20)          not null               ,-- 操作员主键
  machine_id                bigint(20)          not null               ,-- 操作设备主键
  defect_id                 bigint(20)          null       ,-- 不合格原因主键
  section_type              varchar(10)         null       ,-- 质量问题工段类型 (裁剪阶段	cutting、缝制阶段	stitching)
  correction_id             bigint(20)          null       ,-- 处理方式主键
  if_repaired               tinyint(1)          null default 0         ,-- 是否修复 n:未修复 y:已修复
  remark                    varchar(100)        null       ,-- 质量备注
  created_date datetime(0) not null,
  created_by varchar(20) not null,
  last_modified_date datetime(0) null ,
  last_modified_by varchar(20) null ,

  primary key (id) ,
  index idx_quality_issue_01(issue_order_id) ,
  index idx_quality_issue_02(operation_routing_id) ,
  index idx_quality_issue_03(workstation_id) ,
  index idx_quality_issue_04(operator_id) ,
  index idx_quality_issue_05(machine_id) ,
  index idx_quality_issue_06(defect_id) ,
  index idx_quality_issue_07(correction_id) 
) comment = '质量问题记录'; */


---- ---------------------------------------------------------------------------------------------------------------------


--create table request_warehousing  (
--  id                        bigint(20)           not null auto_increment,
--  request_no                varchar(30)          not null             ,-- 单据编号
--  finish_date               datetime(0)          null     ,-- 生产完成日期
--  sale_order_no             varchar(64)          not null             ,-- 销售订单编号
--  description               varchar(1000)        null     ,-- 备注
--  is_storage                tinyint(1)           not null default 0   ,-- 是否入库
--  created_date              timestamp(0)         not null default current_timestamp(0) on update current_timestamp(0) ,-- 创建时间

--  primary key (id) ,
--  index idx_re_warehousing_01(request_no) ,
--  index idx_re_warehousing_02(sale_order_no) 
--)  comment = '商品进货单';

--create table request_warehousing_entry  (
--  id                       bigint(20)             not null auto_increment,
--  request_warehouing_id    bigint(20)             not null              ,-- 入库申请id
--  material_no              varchar(30)            null      ,-- 产品编码
--  material_name            varchar(30)            null      ,-- 商品名称
--  color_no                 varchar(30)            null      ,-- 颜色代码
--  color_name               varchar(30)            null      ,-- 颜色名称
--  size_no                  varchar(30)            null      ,-- 尺寸代码
--  size_name                varchar(30)            null      ,-- 尺寸名称
--  count                    int(11)                null      ,-- 数量

--  primary key (id) ,
--  index idx_re_warehousing_entry_01(request_warehouing_id) 
--) comment = '商品进货单明细';

--create table sequence  (
--  sequence_key             varchar(64)          not null,
--  sequence_value           bigint(20)           not null,

--  primary key (sequence_key) ,
--  index idx_seq_01(sequence_key) 
--) comment = 'id序列';






--create table interface_log_visualization  (
--  id                         bigint(20)             not null        auto_increment,
--  chart_type                 varchar(20)            not null                ,-- 图表类型
--  chart_code                 varchar(20)            not null                ,-- 图表编码
--  chart_series_name          varchar(20)            not null                ,-- 图表数据-类型
--  chart_data_key             varchar(64)            not null                ,-- 图表数据-键
--  chart_data_value           varchar(64)            not null                ,-- 图表数据-值

--  created_by                 varchar(20)            not null                ,-- 创建人
--  created_date               datetime(0)            not null                ,-- 创建日期
--  last_modified_by           varchar(20)            not null                ,-- 修改人
--  last_modified_date         datetime(0)            not null                ,-- 修改日期
--  primary key (id)
--) comment = '可视化接口日志';

---- ----------------------------
---- function structure for nextval
---- ----------------------------
--drop function if exists nextval;
--delimiter ;;
--create function nextval(str varchar(20))
-- returns int(11)
--begin
--    declare a int;
--    set a = (
--                  select sequence_value
--      from sequence
--      where sequence_key = str
--                );
--    if a is null
--    then
--      set a = 0;
--      insert into sequence (sequence_key, sequence_value) values (str, 1);
--    else
--      update sequence
--      set sequence_value = a + 1
--                  where sequence_key = str;
--    end if;
--    return a + 1;
--  end
--;;
--delimiter ;
