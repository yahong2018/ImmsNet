
--
-- 编码种子配置
--
CREATE TABLE code_seed(
  record_id                BIGINT AUTO_INCREMENT        NOT NULL,
  seed_no                  varchar(50)                  NOT NULL,
  seed_name                varchar(50)                  NOT NULL,
  initial_value            int                          NOT NULL,
  prefix                   varchar(10)                  NOT NULL,
  postfix                  varchar(10)                  NOT NULL,
  total_length             int                          NOT NULL,

  PRIMARY KEY (record_id),
  index IDX_CODE_SEED_0(seed_no)
);

insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('BOM_ORDER_NO','Bom单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('PRODUCTION_ORDER_NO','生产计划单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('PIKING_SCHEDULE_NO','领料计划单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('PIKING_ORDER_NO','领料单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('CUTTING_ORDER_NO','裁剪单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('WORK_ORDER_NO','作业单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('OPERATION_ROUTING_ORDER_NO','工艺路线单号',1,'','',10);


/*
   平面编码：比如“单位”、“民族”       
*/
CREATE TABLE plan_code  (
  record_id                          BIGINT AUTO_INCREMENT          NOT NULL ,
  code_type                          int                            NOT NULL,        -- 编码类型
  code_no                            varchar(10)                    NOT NULL,         -- 编码
  code_name                          varchar(30)                    NOT NULL,         -- 名称
  description                        varchar(250)                   NULL,            -- 描述

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id),
  INDEX IDX_PLAN_CODE_01(code_no) ,
  INDEX IDX_PLAN_CODE_02(code_name),
  INDEX IDX_PLAN_CODE_03(code_type)
);


/*
tree_code：树形编码
     “尺码”、“缺陷代码”、“设备类别”、“物料类别”、“颜色”  
*/

CREATE TABLE tree_code  (
  record_id                          BIGINT AUTO_INCREMENT          NOT NULL,
  code_type                          int                            NOT NULL,        -- 编码类型
  code_no                            varchar(10)                    NOT NULL,         -- 编码
  code_name                          varchar(30)                    NOT NULL,         -- 名称
  description                        varchar(250)                   NULL,            -- 描述

  parent_id                          bigint                         NOT NULL default 0,        -- 上级
  code_no_path                       varchar(110)                   NOT NULL,        -- 最大层级为10级，中间以'\'隔开
  code_name_path                     varchar(330)                   NOT NULL,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id) ,
  INDEX IDX_TREE_CODE_01(code_no) ,
  INDEX IDX_TREE_CODE_02(code_name) ,
  INDEX IDX_TREE_CODE_03(parent_id),
  INDEX IDX_TREE_CODE_04(code_type)
);

insert into tree_code (code_type, code_no,code_name, description, parent_id, code_no_path, code_name_path,create_by,create_date ) VALUES (0,'SZ','尺码', NULL, 0,'SZ','尺码',1,SYSDATE());
insert into tree_code (code_type, code_no,code_name, description, parent_id, code_no_path, code_name_path,create_by,create_date ) VALUES (1,'DFECT', '缺陷代码', NULL, 0,'DEFECT','缺陷代码',1,SYSDATE());
insert into tree_code (code_type, code_no,code_name, description, parent_id, code_no_path, code_name_path,create_by,create_date ) VALUES (2,'EQUIPMENT', '设备类别', NULL, 0,'EQUIPMENT','设备类别',1,SYSDATE());
insert into tree_code (code_type, code_no,code_name, description, parent_id, code_no_path, code_name_path,create_by,create_date ) VALUES (3,'MATERIAL', '物料类别', NULL, 0,'MATERIAL','物料类别',1,SYSDATE());

--
-- 生产组织单元
--
CREATE TABLE work_organization_unit  (
  record_id                BIGINT AUTO_INCREMENT           NOT NULL,
  organization_type        varchar(128)                    NOT NULL,  -- 生产组织单元类别：工厂,工作中心,生产线,工位
  organization_code        varchar(10)                     NOT NULL,
  organization_name        varchar(50)                     NOT NULL,
  description              varchar(250)                    NULL ,
  parameters               varchar(3000)                   NULL,      -- 参数
  parent_organization_id   bigint                          NOT NULL,  -- 上级生产单元，顶级为0

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id) ,  
  INDEX IDX_WORK_ORGANIZATION_UNIT_01(organization_code) 
);

--
-- 操作员
--
CREATE TABLE operator  (
  record_id                  bigint    auto_increment       NOT NULL,
  user_id                    bigint       NOT NULL,
  organization_id            bigint       NOT NULL,
  supervisor_id              bigint       NOT NULL,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                            int                          not null default 0,

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATOR_01(user_id) ,
  INDEX IDX_OPERATOR_02(organization_id) ,
  INDEX IDX_OPERATOR_03(supervisor_id)
);


--
-- 物料
--
CREATE TABLE material
(
  record_id            bigint     auto_increment     NOT NULL,
  material_no          varchar(12)                   NOT NULL, -- 物料号
  material_name        varchar(30)                   NOT NULL, -- 物料名称
  material_type_id     bigint                        NOT NULL, -- 物料类型
  unit_id              bigint                        NOT NULL, -- 单位
  width                decimal(10, 4)                NULL,     -- 幅宽
  weight               decimal(10, 4)                NULL,     -- 纺织克重
  size_id              bigint                        NULL,     -- 尺码
  price                decimal(10, 2)                NULL,     -- 价格
  color                varchar(20)                   NULL,     -- 颜色
  description          varchar(250)                  NULL,     -- 物料描述

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id),
  INDEX IDX_MATERIAL_01 (material_no),
  INDEX IDX_MATERIAL_02 (material_name),
  INDEX IDX_MATERIAL_03 (material_type_id),
  INDEX IDX_MATERIAL_04 (size_id)
) ;

--
--  物料清单_单头
--
CREATE TABLE bom_order
(
  record_id         bigint   auto_increment                     NOT NULL,
  order_no          varchar(12)                                 NOT NULL  , -- Bom 单号
  order_status      int                                         not null,

  bom_order_type    int                                         NOT NULL  , -- 基准BOM
    -- ,-- PART: "部件BOM", STANDARD: "基准BOM", ORDER: "订单BOM", DESIGN: "设计BOM",  MANUFACTURE: "生产BOM",  WORK: "作业BOM"
  material_id       bigint                                      NOT NULL,     

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id),
  INDEX IDX_BOM_ORDER_01 (order_no),
  INDEX IDX_BOM_ORDER_02 (order_status),
  INDEX IDX_BOM_ORDER_03 (material_id)
);

--
-- 物料清单_单身
--
CREATE TABLE bom
(
  record_id                        bigint   auto_increment    NOT NULL,
  bom_order_id                     bigint                     NOT NULL,  
  component_material_id            bigint                     NOT NULL, -- 子件物料Id
  component_abstract_material_id   bigint                     NULL,     -- 子件抽象物料Id
  component_qty                    float(8,2)                 NOT NULL, -- 子件用量
  component_unit_id                int                        NOT NULL, -- 子件单位
  component_material_no_path       varchar(130)               NOT NULL,
  component_material_name_path     varchar(330)               NOT Null,
  is_fabric                        bit                        NOT NULL, -- 是否主面料
  parent_bom_id                    bigint                     NOT NULL, -- 上级BOM id

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id),
  INDEX IDX_BOM_01 (component_material_id),
  INDEX IDX_BOM_02 (component_abstract_material_id),
  INDEX IDX_BOM_03 (parent_bom_id),  
  INDEX IDX_BOM_04 (bom_order_id)
);


CREATE TABLE operation  (
  record_id                        bigint auto_increment         NOT NULL,
  operation_no                     varchar(20)                   NOT NULL,
  operation_name                   varchar(120)                  NOT NULL ,
  standard_operation_procedure     varchar(200)                  NULL ,
  machine_type_id                  bigint                        NOT NULL ,
  standard_time                    double(8,4)                   NULL ,
  standard_price                   double(8,4)                   NULL ,
  part_type                        varchar(12)                   NULL ,
  section_type                     varchar(12)                   NULL ,
  section_name                     varchar(30)                   NULL ,
  is_outsource                     bit                           NOT NULL ,
  qa_procedure                     varchar(1000)                 NULL ,
  quality_requirement              varchar(1000)                 NULL ,
  skill_level                      tinyint                       NULL ,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATION_01(operation_no) ,
  INDEX IDX_OPERATION_02(machine_type_id)
) ;


CREATE TABLE operator_capability  (
  record_id                        bigint   auto_increment       NOT NULL,
  operator_id                      bigint                        NOT NULL,
  operation_id                     bigint                        NOT NULL,
  skill_level                      tinyint                       NOT NULL,
  
  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id),
  INDEX IDX_OPERATOR_CAPABILITY_01(operator_id),
  INDEX IDX_OPERATOR_CAPABILITY_02(operation_id)
); 

--
-- 工艺路线_单头
--
CREATE TABLE operation_routing_order  (
  record_id                        bigint   auto_increment      NOT NULL,
  order_no                         varchar(12)                  NOT NULL ,
  order_status                     int                          not null,

  order_type                       int                          NOT NULL , -- 0:物料工艺路线,1:生产订单工艺路线,2:作业单工艺路线
  material_id                      bigint                       NOT NULL , 

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATION_ROUTING_ORDER_01(order_no),
  INDEX IDX_OPERATION_ROUTING_ORDER_02(material_id)
) ;

--
-- 工艺路线_单身
--
CREATE TABLE operation_routing  (
  record_id                       bigint  auto_increment            NOT NULL,
  operation_routing_order_id      bigint              NOT NULL,             -- 工艺路线单主键  
  operation_id                    bigint              NOT NULL,             -- 工艺  
  sequence_no                     int                 NOT NULL ,            -- 工序顺序
  pre_routing_id                  bigint              NULL,                 -- 依赖关系-上道工序
  
  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATION_ROUTING_01(operation_id) ,
  INDEX IDX_OPERATION_ROUTING_02(operation_routing_order_id) ,  
  INDEX IDX_OPERATION_ROUTING_03(pre_routing_id)
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

  requirement_order_no        varchar(12)       null,
  schedule_order_no           varchar(12)       null, 
  
  fg_material_id              bigint            not null, -- 成品物料
  priority                    tinyint           not null,
  work_center_id              bigint            null , 
  planned_qty                 int               null ,  

  routing_order_id            bigint            null , -- 生产工艺
  bom_order_id                bigint            null,  -- BOM

  finished_qty                int               null ,
  second_quality_qty          int               null , -- 次品数量
  defect_qty                  int               null ,
  actual_qty                  int               null ,

  planned_start_date          datetime          not null ,
  planned_end_date            datetime          not null ,
  actual_start_date           datetime          null ,
  actual_end_date             datetime          null ,    
  
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
  size_id                      bigint                  not null,
  size_code                    varchar(10)             not null,
  qyt_planned                  int                     null,

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


--
-- 领料计划
-- 
create table material_picking_schedule  (
  record_id                            bigint auto_increment        not null,
  order_no                             varchar(12)                  not null,
  order_status                         int                          not null,

  production_order_id                  bigint                       not null,  
    
  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,
  index idx_material_picking_schedule_01(order_no) ,
  index idx_material_picking_schedule_02(production_order_id)
) ;

--
-- 领料计划物料清单
--
create table material_picking_schedule_bom  (
  record_id                            bigint                       not null auto_increment,
  material_picking_order_id            bigint                       not null,
  component_material_id                bigint                       not null,
  qty                                  double(8,2)                  not null,
  component_material_unit_id           bigint                       null,
  picked_qty                           double(8,2)                  not null,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,
  index idx_material_picking_schedule_bom_01(component_material_id) ,
  index idx_material_picking_schedule_bom_02(material_picking_order_id)
) ;

--
-- 领料单
--
create table material_picking_order  (
  record_id                            bigint                       not null auto_increment,
  order_no                             varchar(12)                  not null,
  order_status                         int                          not null,

  picking_schedule_id                  bigint                       not null,
  
  container_no                         varchar(64)                  not null,
  operator_id                          bigint                       not null,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                             int                          not null default 0,

  primary key (record_id) ,
  index idx_material_picking_order_01(order_no) ,
  index idx_material_picking_order_02(container_no) ,
  index idx_material_picking_order_03(operator_id) ,
  index idx_material_picking_order_04(picking_schedule_id)
) ;

--
-- 领料明细
--
create table material_picking_order_detail  (
  record_id                            bigint                       not null  auto_increment,
  material_picking_order_id            bigint                       not null       ,-- 领料单明细主键
  material_id                          bigint                       null           ,-- 物料号
  picked_qty                           double(10,4)                 null           ,-- 领用量

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                              int                          not null default 0,

  primary key (record_id) ,
  index idx_material_picking_order_detail_01(material_picking_order_id) ,
  index idx_material_picking_order_detail_02(material_id)
);

--
-- 裁剪单
--
create table cutting_order  (
  record_id                   bigint              not null auto_increment,
  order_no                    varchar(12)         not null             ,-- 裁剪单号  
  order_status                int                 not null             ,-- 状态

  production_order_id         bigint              not null             ,-- 生产订单主键
  cutting_table_no            varchar(64)         null                 ,-- 床次  
  container_no                varchar(64)         null                 ,-- 裁剪单容器
  planned_qty                 int                 not null   default 0 ,-- 计划数量  
  fg_material_id              varchar(64)         not null                 ,-- 成品物料号
  fabric_material_type        varchar(64)         not null                 ,-- 面料类型
  fabric_material_id          bigint              not null                 ,-- 面料物料主键
  plies                       int                 not null                 ,-- 层数
  width                       double(8,4)         not null                 ,-- 幅宽
  length                      double(8,4)         not null                 ,-- 长度
  cutting_efficiency          double(7,4)         not null                 ,-- 利用率

  work_station_id             bigint              null                  ,-- 裁剪工位

  planned_cutting_date        datetime            not null                 ,-- 计划裁剪时间  
  planned_end_date            datetime            not null                 ,-- 计划完成时间

  actual_cutting_date         datetime(0)         null                 ,-- 实际裁剪时间
  actual_end_date             datetime(0)         null                 ,-- 实际完成时间
  finished_qty                int                 not null   default 0 ,-- 实际完工数量
  operator_id                 bigint              null,                 -- 裁剪人

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                              int                          not null default 0,

  primary key (record_id),
  index idx_cutting_order_01(order_no),
  index idx_cutting_order_02(production_order_id),
  index idx_cutting_order_03(work_station_id),
  index idx_cutting_order_04(container_no)  
) ;

--
-- 裁剪单尺码明细
--
create table cutting_order_size  (
  record_id                   bigint              not null        auto_increment,
  cutting_order_id            bigint              not null ,   -- 裁剪单主键  
  size                        varchar(10)         null,        -- 尺码
  layer_qty                   int                 null,        -- 单层配比数量
  planned_qty                 int                 null,        -- 计划裁剪数量
  actual_qty                  int                 null,        -- 实际裁剪数量
  created_work_order_qty      int                 null,        -- 已创建作业单数量

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

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  opt_flag                              int                          not null default 0,

  primary key (record_id),
  index idx_cutting_marker_01(cutting_order_id),
  index idx_cutting_marker_02(media_id)
) ;

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
  size_id                    bigint             not null,-- 尺码
  
  planned_start_date         datetime           not null ,
  planned_end_date           datetime           not null ,

  actual_start_date          datetime           null ,
  actual_end_date            datetime           null ,

  syn_finish_status          tinyint              not null default 0     ,-- 同步完成状态

  create_by                   bigint              not null,
  create_date                 datetime            not null,
  update_by                   bigint              null,
  update_date                 datetime            null,
  opt_flag                     int                 not null default 0,

  primary key (record_id) ,
  index idx_pro_work_order_01(order_no) ,
  index idx_pro_work_order_02(production_order_id) ,
  index idx_pro_work_order_03(planned_start_date) ,
  index idx_pro_work_order_04(planned_end_date)
);

--
-- 生产作业单工艺路线
--
CREATE TABLE production_work_order_routing
(
  record_id                       bigint  auto_increment            NOT NULL,
  operation_routing_order_id      bigint              NOT NULL,             -- 工艺路线单主键  
  production_work_order_id        bigint              NOT NULL,
  operation_routing_id            bigint              NOT NULL,  

  operator_id                     bigint              NULL,                 -- 操作员
  work_station_id                 bigint              NULL ,                -- 操作工位

  scrap_qty                       int                 NULL DEFAULT 0 ,      -- 报废数量
  complete_qty                    int                 NULL DEFAULT 0 ,      -- 完工数量

  start_time                      datetime            NULL  ,               -- 进站时间
  complete_time                   datetime            NULL  ,               -- 出站时间  

  order_status                    int                 NOT NULL,            
  
  create_by                       bigint              not null,
  create_date                     datetime            not null,
  update_by                       bigint              null,
  update_date                     datetime            null,
  opt_flag                         int                 not null default 0,

  primary key(record_id),
  index idx_production_work_order_routing_01(operation_routing_order_id) ,
  index idx_production_work_order_routing_02(order_status)   
);

--
-- 工位登录记录 
--
CREATE TABLE workstation_check_in  (
  record_id                  bigint         NOT NULL AUTO_INCREMENT,
  work_station_id            bigint         NOT NULL ,
  operator_id                bigint         NOT NULL ,  
  check_in_time              datetime       NULL,-- 入岗时间
  check_out_time             datetime       NULL,-- 出岗时间
  
  PRIMARY KEY (record_id) ,
  INDEX IDX_workstation_check_in_01(operator_id) ,
  INDEX IDX_workstation_check_in_02(work_station_id)
) ;

CREATE TABLE media  (
  record_id                      bigint  auto_increment            NOT NULL,
  media_type                     int                  NOT NULL, 
  belong_to_id                   bigint               NOT NULL,
  media_url                      varchar(255)        NOT NULL,
  media_name                     varchar(100)        NOT NULL,
  media_size                     int                 NOT NULL,
  description                    varchar(250)        NULL ,

  create_by                       bigint              not null,
  create_date                     datetime            not null,
  update_by                       bigint              null,
  update_date                     datetime            null,
  opt_flag                        int                 not null default 0,  

  PRIMARY KEY (record_id),
  INDEX IDX_MEDIA_0 (media_name),
  INDEX IDX_MEDIA_1 (belong_to_id)
);



/* 
CREATE TABLE quality_check  (
  record_id                  bigint              NOT NULL AUTO_INCREMENT,
  production_order_id        bigint              not NULL ,
  size_id                    bigint              not NULL ,  
  operator_id                bigint              not null,
  check_time                 datetime            not null,

  create_by                       bigint              not null,
  create_date                     datetime            not null,
  update_by                       bigint              null,
  update_date                     datetime            null,
  optlock                         int                 not null default 0,  

  PRIMARY KEY (id) 
) ;

CREATE TABLE quality_check_detail  (
  record_id                  bigint  NOT NULL AUTO_INCREMENT,
  quality_check_id           bigint             not NULL ,
  component_no               varchar(10)        NULL ,
  component_name             varchar(20)        NULL ,
  check_value                varchar(20)        NULL ,

  PRIMARY KEY (id) 
);

CREATE TABLE quality_issue  (
  id                        bigint(20)          NOT NULL AUTO_INCREMENT,
  issue_order_id            bigint(20)          NOT NULL               ,-- 单据主键  
  operation_routing_id      bigint(20)          NOT NULL               ,-- 工艺工序主键
  workstation_id            bigint(20)          NOT NULL               ,-- 工位主键
  operator_id               bigint(20)          NOT NULL               ,-- 操作员主键
  machine_id                bigint(20)          NOT NULL               ,-- 操作设备主键
  defect_id                 bigint(20)          NULL       ,-- 不合格原因主键
  section_type              varchar(10)         NULL       ,-- 质量问题工段类型 (裁剪阶段	cutting、缝制阶段	stitching)
  correction_id             bigint(20)          NULL       ,-- 处理方式主键
  if_repaired               tinyint(1)          NULL DEFAULT 0         ,-- 是否修复 n:未修复 y:已修复
  remark                    varchar(100)        NULL       ,-- 质量备注
  created_date datetime(0) NOT NULL,
  created_by varchar(20) NOT NULL,
  last_modified_date datetime(0) NULL ,
  last_modified_by varchar(20) NULL ,

  PRIMARY KEY (id) ,
  INDEX IDX_QUALITY_ISSUE_01(issue_order_id) ,
  INDEX IDX_QUALITY_ISSUE_02(operation_routing_id) ,
  INDEX IDX_QUALITY_ISSUE_03(workstation_id) ,
  INDEX IDX_QUALITY_ISSUE_04(operator_id) ,
  INDEX IDX_QUALITY_ISSUE_05(machine_id) ,
  INDEX IDX_QUALITY_ISSUE_06(defect_id) ,
  INDEX IDX_QUALITY_ISSUE_07(correction_id) 
) COMMENT = '质量问题记录'; */


---- ---------------------------------------------------------------------------------------------------------------------


--CREATE TABLE request_warehousing  (
--  id                        bigint(20)           NOT NULL AUTO_INCREMENT,
--  request_no                varchar(30)          NOT NULL             ,-- 单据编号
--  finish_date               datetime(0)          NULL     ,-- 生产完成日期
--  sale_order_no             varchar(64)          NOT NULL             ,-- 销售订单编号
--  description               varchar(1000)        NULL     ,-- 备注
--  is_storage                tinyint(1)           NOT NULL DEFAULT 0   ,-- 是否入库
--  created_date              timestamp(0)         NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) ,-- 创建时间

--  PRIMARY KEY (id) ,
--  INDEX IDX_RE_WAREHOUSING_01(request_no) ,
--  INDEX IDX_RE_WAREHOUSING_02(sale_order_no) 
--)  COMMENT = '商品进货单';

--CREATE TABLE request_warehousing_entry  (
--  id                       bigint(20)             NOT NULL AUTO_INCREMENT,
--  request_warehouing_id    bigint(20)             NOT NULL              ,-- 入库申请ID
--  material_no              varchar(30)            NULL      ,-- 产品编码
--  material_name            varchar(30)            NULL      ,-- 商品名称
--  color_no                 varchar(30)            NULL      ,-- 颜色代码
--  color_name               varchar(30)            NULL      ,-- 颜色名称
--  size_no                  varchar(30)            NULL      ,-- 尺寸代码
--  size_name                varchar(30)            NULL      ,-- 尺寸名称
--  count                    int(11)                NULL      ,-- 数量

--  PRIMARY KEY (id) ,
--  INDEX IDX_RE_WAREHOUSING_ENTRY_01(request_warehouing_id) 
--) COMMENT = '商品进货单明细';

--CREATE TABLE sequence  (
--  sequence_key             varchar(64)          NOT NULL,
--  sequence_value           bigint(20)           NOT NULL,

--  PRIMARY KEY (sequence_key) ,
--  INDEX IDX_SEQ_01(sequence_key) 
--) COMMENT = 'ID序列';






--CREATE TABLE interface_log_visualization  (
--  id                         bigint(20)             NOT NULL        AUTO_INCREMENT,
--  chart_type                 varchar(20)            NOT NULL                ,-- 图表类型
--  chart_code                 varchar(20)            NOT NULL                ,-- 图表编码
--  chart_series_name          varchar(20)            NOT NULL                ,-- 图表数据-类型
--  chart_data_key             varchar(64)            NOT NULL                ,-- 图表数据-键
--  chart_data_value           varchar(64)            NOT NULL                ,-- 图表数据-值

--  created_by                 varchar(20)            NOT NULL                ,-- 创建人
--  created_date               datetime(0)            NOT NULL                ,-- 创建日期
--  last_modified_by           varchar(20)            NOT NULL                ,-- 修改人
--  last_modified_date         datetime(0)            NOT NULL                ,-- 修改日期
--  PRIMARY KEY (id)
--) COMMENT = '可视化接口日志';

---- ----------------------------
---- Function structure for nextval
---- ----------------------------
--DROP FUNCTION IF EXISTS nextval;
--delimiter ;;
--CREATE FUNCTION nextval(str VARCHAR(20))
-- RETURNS int(11)
--BEGIN
--    DECLARE a INT;
--    SET a = (
--                  SELECT sequence_value
--      FROM sequence
--      WHERE sequence_key = str
--                );
--    IF a IS NULL
--    THEN
--      SET a = 0;
--      INSERT INTO sequence (sequence_key, sequence_value) VALUES (str, 1);
--    ELSE
--      UPDATE sequence
--      SET sequence_value = a + 1
--                  WHERE sequence_key = str;
--    END IF;
--    RETURN a + 1;
--  END
--;;
--delimiter ;
