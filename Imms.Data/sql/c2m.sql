
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

/*
   平面编码：比如“单位”、“民族”       
*/
CREATE TABLE plan_code  (
  record_id                          BIGINT AUTO_INCREMENT       NOT NULL ,
  code_type                          int                            NOT NULL,        -- 编码类型
  code_no                            varchar(10)                    NOT NULL         -- 编码
  code_name                          varchar(30)                    NOT NULL         -- 名称
  code_description                   varchar(250)                   NULL,            -- 描述

  PRIMARY KEY (record_id),
  INDEX IDX_PLAN_CODE_01(code_no) ,
  INDEX IDX_PLAN_CODE_02(code_name)
);


/*
tree_code：树形编码
     “尺码”、“缺陷代码”、“设备类别”、“物料类别”、“颜色”  
*/

CREATE TABLE tree_code  (
  record_id                          BIGINT AUTO_INCREMENT          NOT NULL,
  code_type                          int                            NOT NULL,        -- 编码类型
  code_no                            varchar(10)                    NOT NULL         -- 编码
  code_name                          varchar(30)                    NOT NULL         -- 名称
  code_description                   varchar(250)                   NULL,            -- 描述
  parent_id                          bigint                         NOT NULL,        -- 上级
  code_no_path                       varchar(110)                   NOT NULL,        -- 最大层级为10级，中间以'\'隔开
  code_name_path                     varchar(330)                   NOT NULL,

  PRIMARY KEY (record_id) ,
  INDEX IDX_TREE_CODE_01(size_code) ,
  INDEX IDX_TREE_CODE_02(size_name) ,
  INDEX IDX_TREE_CODE_03(parent_size_id)
);


insert into tree_code (code_type, code,name, description, parent_id, code_path, name_path ) VALUES (0,'SZ', '尺码', NULL, 0,'SZ','尺码');
insert into tree_code (code_type, code,name, description, parent_id, code_path, name_path ) VALUES (1,'DFECT', '缺陷代码', NULL, 0,'DEFECT','缺陷代码');
insert into tree_code (code_type, code,name, description, parent_id, code_path, name_path ) VALUES (2,'EQUIPMENT', '设备类别', NULL, 0,'EQUIPMENT','设备类别');
insert into tree_code (code_type, code,name, description, parent_id, code_path, name_path ) VALUES (3,'MATERIAL', '物料类别', NULL, 0,'MATERIAL','物料类别');

insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('BOM_ORDER_NO','Bom单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('PRODUCTION_ORDER_NO','生产计划单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('PIKING_SCHEDULE_NO','领料计划单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('PIKING_ORDER_NO','领料单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('CUTTING_ORDER_NO','裁剪单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('WORK_ORDER_NO','作业单号',1,'','',10);
insert into code_seed (seed_no,seed_name,initial_value,prefix,postfix ,total_length) values('OPERATION_ROUTING_ORDER_NO','工艺路线单号',1,'','',10)


--
-- 生产组织单元
--
CREATE TABLE work_organization_unit  (
  record_id                BIGINT AUTO_INCREMENT           NOT NULL,
  organization_type        int                             NOT NULL,  -- 生产组织单元类别：  0 工厂  1 工作中心   2 生产线   3 工位
  organization_code        varchar(10)                     NOT NULL,
  organization_name        varchar(50)                     NOT NULL,
  description              varchar(250)                    NULL ,
  parameters               varchar(3000)                   NULL,      -- 参数
  parent_oganization_id    bigint                          NOT NULL,  -- 上级生产单元，顶级为0
  
  PRIMARY KEY (record_id) ,
  INDEX IDX_WORK_STATION_01(work_station_no) ,
  INDEX IDX_WORK_STATION_02(plant_id) ,
  INDEX IDX_WORK_STATION_03(work_center_id)
);

--
-- 操作员
--
CREATE TABLE operator  (
  record_id                  bigint    auto_increment       NOT NULL,
  user_id                    bigint       NOT NULL,
  organization_id            bigint       NOT NULL,
  supervisor_id              bigint       NOT NULL,

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATOR_01(user_id) ,
  INDEX IDX_OPERATOR_02(organization_id) ,
  INDEX IDX_OPERATOR_03(supervisor_id)
) COMMENT = '操作员';


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

  PRIMARY KEY (record_id),
  INDEX IDX_MATERIAL_01 (material_no),
  INDEX IDX_MATERIAL_02 (material_name),
  INDEX IDX_MATERIAL_03 (material_type_id),
  INDEX IDX_MATERIAL_04 (material_size_id)
) ;

--
--  物料清单_单头
--
CREATE TABLE bom_order
(
  record_id         bigint   auto_increment                     NOT NULL,
  bom_order_no      varchar(25)                                 NOT NULL  , -- Bom 单号
  bom_order_type    int                                         NOT NULL  , -- 基准BOM
    -- COMMENT 'PART: "部件BOM", STANDARD: "基准BOM", ORDER: "订单BOM", DESIGN: "设计BOM",  MANUFACTURE: "生产BOM",  WORK: "作业BOM"',
  material_id       bigint                                      NOT NULL     

  PRIMARY KEY (record_id),
  INDEX IDX_BOM_ORDER_01 (bom_order_no),
  INDEX IDX_BOM_ORDER_02 (bom_order_type)
)

--
-- 物料清单_单身
--
CREATE TABLE bom
(
  record_id                        bigint   auto_increment    NOT NULL,
  bom_order_id                     bigint                     NOT NULL,  
  component_material_id            bigint                     NOT NULL -- 子件物料Id
  component_abstract_material_id   bigint                     NULL     -- 子件抽象物料Id
  component_qty                    float(8,2)                 NOT NULL -- 子件用量
  component_unit_id                int                        NOT NULL -- 子件单位
  component_material_no_path       varchar(130)               NOT NULL,
  component_material_name_path     varchar(330)               NOT Null,
-- component_material_match_rule_id bigint                     NULL -- 子件匹配规则
  is_fabric                        bit                        NULL -- 是否主面料
  parent_bom_id                    bigint                     NULL -- 上级BOM id

  PRIMARY KEY (record_id),
  INDEX IDX_BOM_01 (component_material_id),
  INDEX IDX_BOM_02 (component_abstract_material_id),
  INDEX IDX_BOM_03 (parent_bom_id),  
  INDEX IDX_BOM_05 (bom_order_id)
);


CREATE TABLE operation  (
  record_id                        bigint auto_increment         NOT NULL,
  operation_no                     varchar(20)                   NOT NULL,
  operation_name                   varchar(120)                  NOT NULL ,
  standard_operation_procedure     varchar(200)                  NULL ,
  machine_type_id                  bigint                        NULL ,
  standard_time                    double(8,4)                   NULL ,
  standard_price                   double(8,4)                   NULL ,
  part_type                        varchar(12)                   NULL ,
  section_type                     varchar(12)                   NULL ,
  section_name                     varchar(30)                   NULL ,
  is_outsource                     bit                           NOT NULL ,
  qa_procedure                     varchar(1000)                 NULL ,
  quality_requirement              varchar(1000)                 NULL ,
  skill_level                      tinyint                       NULL ,

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATION_01(operation_no) ,
  INDEX IDX_OPERATION_02(machine_type_id)
) ;


CREATE TABLE operator_capability  (
  record_id                        bigint   auto_increment       NOT NULL,
  operator_id                      bigint                        NULL,
  operation_id                     bigint                        NOT NULL,
  skill_level                      tinyint                        NULL,
  
  PRIMARY KEY (record_id),
  INDEX IDX_OPERATOR_CAPABILITY_01(OPERATOR_ID),
  INDEX IDX_OPERATOR_CAPABILITY_02(OPERATION_ID)
); 


CREATE TABLE operation_routing_order  (
  record_id                        bigint   auto_increment      NOT NULL,
  operation_routing_order_no       varchar(10)                  NOT NULL ,
  operation_routing_order_type     int                          NOT NULL , --0:物料工艺路线,1:生产订单工艺路线,2:作业单工艺路线
  material_id                      bigint                       NOT NULL , 

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATION_ROUTING_ORDER_01(operation_routing_order_no),
  INDEX IDX_OPERATION_ROUTING_ORDER_02(ref_id)
) ;


CREATE TABLE operation_routing  (
  record_id                       bigint  auto_increment            NOT NULL,
  operation_routing_order_id      bigint              NOT NULL,             -- 工艺路线单主键  
  operation_id                    bigint              NOT NULL,             -- 工艺  
  sequence_no                     int                 NOT NULL ,            -- 工序顺序
  pre_routing_id                  bigint              NULL,                 -- 依赖关系-上道工序
  
  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATION_ROUTING_01(operation_id) ,
  INDEX IDX_OPERATION_ROUTING_02(operation_routing_order_id) ,
  INDEX IDX_OPERATION_ROUTING_03(operator_id) ,
  INDEX IDX_OPERATION_ROUTING_04(actual_station_id) ,
  INDEX IDX_OPERATION_ROUTING_05(pre_operation_id) ,
  INDEX IDX_OPERATION_ROUTING_06(pre_routing_id)
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
  actual_station_id               bigint              NULL ,                -- 操作工位

  scrap_qty                       int                 NULL DEFAULT 0 ,      -- 报废数量
  complete_qty                    int                 NULL DEFAULT 0 ,      -- 完工数量

  start_time                      datetime            NULL  ,               -- 进站时间
  complete_time                   datetime            NULL  ,               -- 出站时间  

  operation_routing_status        tinyint             NOT NULL,             -- 0.已计划	  1.已开始  	2.已完成
  
  create_by                       bigint              not null,
  create_date                     datetime            not null,
  update_by                       bigint              null,
  update_date                     datetime            null,
  optlock                         int                 not null default 0,

  primary key(record_id),  
);


create table schedule_order(
  record_id                       bigint       auto_increment        not null,
  
  schedule_no                     varchar(12)                        not null,
  requirement_order_no            varchar(12)                        not null,
  priority                        tinyint                            not null,
    
  plan_id                         bigint                             not null,  
  work_center_id                  bigint                             not null,  
  fg_material_id                  bigint                             not null,
    
  qty_planned                     int                                not null,
  qty_actual                      int                                null,
  
  date_required_delivery          datetime                           not null,
  date_plan_start                 datetime                           not null,
  date_plan_end                   datetime                           not null,
  date_actual_start               datetime                           null,
  date_actual_end                 datetime                           null,
  
  order_status                    tinyint                            not null,

  raw_data                        varchar(3000)                      not null, -- 原始数据

  create_by                       bigint                             not null,
  create_date                     datetime                           not null,
  update_by                       bigint                             null,
  update_date                     datetime                           null,
  optlock                         int                                not null default 0,

  primary key (record_id),
  index idx_schedule_order_01(schedule_no),
  index idx_schedule_order_02(requirement_order_no),
  index idx_schedule_order_03(production_order_no),
  index idx_schedule_order_04(fg_material_no),
  index idx_schedule_order_05(date_required_delivery),
  index idx_schedule_order_06(date_plan_start),
  index idx_schedule_order_07(date_plan_end),
  index idx_schedule_order_08(order_status)
)comment '生产排程';


create table production_order  (
  record_id                   bigint    auto_increment          not null,  
  requirement_order_id        bigint            not null,
  schedule_order_id           bigint            null,      --排程编号, 生产计划可以没有排程
  production_order_no         varchar(12)       not null,
  production_order_status     int               not null   default 0,
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

  required_delivery_date      datetime          null ,
  planned_start_date          datetime          null ,
  planned_end_date            datetime          null ,
  actual_start_date           datetime          null ,
  actual_end_date             datetime          null ,    
  
  create_by                   bigint            not null,
  create_date                 datetime          not null,
  update_by                   bigint            null,
  update_date                 datetime          null,
  optlock                     int               not null default 0,

  primary key (record_id)
) comment = '生产订单';

create table order_size  (
  record_id                    bigint  auto_increment  not null ,
  order_id                     bigint                  not null,
  ref_record_type              int                     not null,
  size_id                      bigint                  not null,
  size_code                    varchar(10)             not null,
  qyt_planned                  int                     null,

  create_by                    bigint                  not null,
  create_date                  datetime                not null,
  update_by                    bigint                  null,
  update_date                  datetime                null,
  optlock                      int                     not null default 0,

  primary key (record_id),
  index idx_order_size_01(order_id),
  index idx_order_size_02(ref_record_type)
) comment = '订单尺码明细';


create table order_measure  (
  record_id                    bigint   auto_increment  not null,
  order_id                     bigint                   not null ,
  ref_record_type              int                      not null,
  body_no                      varchar(20)              not null ,
  measure_data                 int                      not null ,

  create_by                    bigint                   not null,
  create_date                  datetime                 not null,
  update_by                    bigint                   null,
  update_date                  datetime                 null,
  optlock                      int                      not null default 0,

  primary key (record_id) ,
  index idx_order_measure_01(order_id),
  index idx_order_measure_02(ref_record_type)
) comment = '量体数据';


create table material_picking_schedule  (
  record_id                            bigint auto_increment        not null,
  material_picking_order_no            varchar(30)                  not null,
  production_order_id                  bigint                       not null,
  material_picking_order_type          int                          not null ,
  planned_picking_date                 datetime                     not null ,
  actual_picking_date                  datetime                     null ,
  operator_id                          bigint                       null ,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  optlock                              int                          not null default 0,

  primary key (record_id) ,
  index idx_material_picking_schedule_01(material_picking_order_no) ,
  index idx_material_picking_schedule_02(production_order_id)
) comment = '领料计划';

create table material_picking_schedule_bom  (
  record_id                            bigint                       not null auto_increment,
  material_picking_order_id            bigint                       not null,
  component_material_id                bigint                       not null,
  qty                                  double(8,2)                  not null,
  component_material_uom_id            bigint                       null,
  picked_qty                           double(8,2)                  not null,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  optlock                              int                          not null default 0,

  primary key (record_id) ,
  index idx_material_picking_schedule_bom_01(component_material_id) ,
  index idx_material_picking_schedule_bom_02(material_picking_order_id)
) comment = '领料计划物料清单';


create table material_picking_order  (
  record_id                            bigint                       not null auto_increment,
  material_picking_schedule_id         bigint                       not null,
  picking_status                       int                          not null,
  container_no                         varchar(64)                  not null,

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  optlock                              int                          not null default 0,

  primary key (record_id) ,
  index idx_material_picking_order_01(container_no) ,
  index idx_material_picking_order_02(material_picking_schedule_id)
) comment = '领料单';


create table material_picking_order_detail  (
  record_id                            bigint                       not null  auto_increment,
  material_picking_order_id            bigint                       not null       comment '领料单明细主键',
  material_id                          bigint                       null           comment '物料号',
  picked_qty                           double                       null           comment '领用量',

  create_by                            bigint                       not null,
  create_date                          datetime                     not null,
  update_by                            bigint                       null,
  update_date                          datetime                     null,
  optlock                              int                          not null default 0,

  primary key (id) ,
  index idx_material_picking_order_detail_01(material_picking_order_id) ,
  index idx_material_picking_order_detail_02(material_id)
) comment = '领料明细';

create table cutting_order  (
  id                          bigint(20)          not null auto_increment,
  cutting_order_no            varchar(64)         null                 comment '裁剪单号',
  line_no                     int(11)             null                 comment '行项目',
  production_order_id         bigint(20)          not null             comment '生产订单主键',
  cutting_table_no            varchar(64)         null                 comment '床次',
  status                      varchar(10)         null                 comment '状态',
  container_no                varchar(64)         null                 comment '裁剪单容器',
  planned_qty                 int(11)             not null   default 0 comment '计划数量',
  finished_qty                int(11)             not null   default 0 comment '实际完工数量',
  fg_material_id              varchar(64)         null                 comment '成品物料号',
  fabric_material_type        varchar(64)         null                 comment '面料类型',
  fabric_material_id          varchar(64)         null                 comment '面料物料主键',
  plies                       int(11)             null                 comment '层数',
  width                       double              null                 comment '幅宽',
  length                      double              null                 comment '长度',
  cutting_efficiency          double              null                 comment '利用率',
  work_station_id             bigint(20)          null                 comment '裁剪工位',
  planned_cutting_date        datetime(0)         null                 comment '计划领料时间',
  actual_cutting_date         datetime(0)         null                 comment '实际领料时间',
  planned_end_date            datetime(0)         null                 comment '计划完成时间',
  actual_end_date             datetime(0)         null                 comment '实际完成时间',
  hanging_station_id          bigint(20)          null                 comment '上吊挂工位',

  created_by                  varchar(20)         not null,
  created_date                datetime(0)         not null,
  last_modified_by            varchar(20)         not null,
  last_modified_date          datetime(0)         not null,

  primary key (id),
  index idx_cutting_order_01(cutting_order_no),
  index idx_cutting_order_02(production_order_id),
  index idx_cutting_order_03(work_station_id)
)comment = '裁剪单' ;

create table cutting_order_size  (
  id                          bigint(20)          not null        auto_increment,
  cutting_order_id            bigint(20)          not null        comment '裁剪单主键',
  line_no                     int(11)             null            comment '行项目',
  size                        varchar(10)         null            comment '尺码',
  layer_qty                   int(11)             null            comment '单层配比数量',
  planned_qty                 int(11)             null            comment '计划裁剪数量',
  actual_qty                  int(11)             null            comment '实际裁剪数量',
  created_work_order_qty      int(11)             null            comment '已创建作业单数量',

  primary key (id),
  index idx_cutting_order_size_01(cutting_order_id)
)comment = '裁剪单尺码明细';



create table production_cutting_plan  (
  id                          bigint(20)        not null auto_increment,
  production_cutting_plan_no  varchar(64)       not null,
  production_order_id         bigint(20)        not null,
  line_no                     int(11)           null     comment '行项目',
  cutting_table_no            varchar(64)       null ,
  size                        varchar(10)       null ,
  status                      varchar(10)       null ,
  cutting_qty                 int(11)           null ,
  fg_material_id              varchar(64)       null ,
  fabric_material_type        varchar(64)       null ,
  fabric_material_no          varchar(64)       null ,
  plies                       int(11)           null     comment '层数',
  width                       double            null ,
  length                      double            null ,
  cutting_efficiency          double            null ,

  primary key (id) ,
  index idx_pro_cutting_plan_01(production_cutting_plan_no) ,
  index idx_pro_cutting_plan_02(production_order_id)
) comment = '生产裁剪排料计划';

create table production_cutting_size  (
  id                          bigint(20)        not null auto_increment,
  production_cutting_plan_id  bigint(20)        not null,
  line_no                     int(11)           null     comment '行项目',
  cutting_table_no            varchar(64)       null ,
  size                        varchar(10)       null ,
  layer_qty                   int(11)           null ,
  planned_qty                 int(11)           null ,
  actual_qty                  int(11)           null ,

  primary key (id) ,
  index idx_pro_cutting_size_01(production_cutting_plan_id)
) comment = '生产裁剪排料尺码';


create table cutting_marker  (
  id                          bigint(20)         not null auto_increment,
  cutting_order_id            bigint(20)         not null,
  line_no                     int(11)            null                   comment '行项目',
  media_id                    bigint(20)         null,
  remark                      varchar(64)        null,
  marker_file_id              bigint(20)         null,
  primary key (id),
  index idx_cutting_marker_01(cutting_order_id),
  index idx_cutting_marker_02(media_id)
) comment = '生产裁剪排料图' ;

create table production_work_order  (
  id                         bigint(20)         not null auto_increment,
  line_no                    int(11)            null       comment '行项目',
  production_work_order_no   varchar(64)        not null,
  production_order_id        bigint(20)         not null,
  bom_order_id               bigint(20)         null       comment '物料清单主键',
  operation_routing_order_id bigint(20)         null       comment '工序单主键',
  cutting_order_id           bigint(20)         null       comment '裁剪单主键',
  size                       varchar(10)        null       comment '尺码',
  status                     varchar(10)        null       comment '已创建	created  已开工	started  已完工	finished',
  planned_start_date         datetime(0)        null ,
  planned_end_date           datetime(0)        null ,
  actual_start_date          datetime(0)        null ,
  actual_end_date            datetime(0)        null ,
  container_no               varchar(64)        null       comment '衣架号',
  if_syn_finish_status       tinyint(1)         not null default 0     comment '同步完成状态',

  created_by varchar(20) not null,
  created_date datetime(0) not null,
  last_modified_by varchar(20) not null,
  last_modified_date datetime(0) not null,

  primary key (id) ,
  index idx_pro_work_order_01(production_work_order_no) ,
  index idx_pro_work_order_02(production_order_id) ,
  index idx_pro_work_order_03(bom_order_id) ,
  index idx_pro_work_order_04(operation_routing_order_id) ,
  index idx_pro_work_order_05(cutting_order_id)
) comment = '生产作业单';




--CREATE TABLE `operator_check_in`  (
--  `id`                         bigint(20)         NOT NULL AUTO_INCREMENT,
--  `operator_id`                bigint(20)         NOT NULL           COMMENT '操作员主键',
--  `work_station_id`            bigint(20)         NOT NULL           COMMENT '工位主键',
--  `check_in_time`              datetime(0)        NULL   COMMENT '入岗时间',
--  `check_out_time`             datetime(0)        NULL   COMMENT '出岗时间',
--  `status`                     varchar(10)        NULL   COMMENT '状态',

--  PRIMARY KEY (`id`) ,
--  INDEX `IDX_OPERATOR_CHECK_IN_01`(`operator_id`) ,
--  INDEX `IDX_OPERATOR_CHECK_IN_02`(`work_station_id`)
--) COMMENT = '操作员入岗';

---- ----------

--CREATE TABLE `quality_check`  (
--  `id`                         bigint(20)          NOT NULL AUTO_INCREMENT,
--  `production_order_id`        bigint(20)          NULL ,
--  `size_no`                    varchar(20)         NULL ,
--  `name`                       varchar(20)         NULL ,

--  PRIMARY KEY (`id`) 
--) ;

--CREATE TABLE `quality_check_detail`  (
--  `id`                         bigint(20) NOT NULL AUTO_INCREMENT,
--  `quality_check_id`           bigint(20)         NULL ,
--  `component_no`               varchar(10)        NULL ,
--  `component_name`             varchar(20)        NULL ,
--  `value`                      varchar(20)        NULL ,

--  PRIMARY KEY (`id`) 
--);

--CREATE TABLE `quality_issue`  (
--  `id`                        bigint(20)          NOT NULL AUTO_INCREMENT,
--  `issue_order_id`            bigint(20)          NOT NULL               COMMENT '单据主键',
--  `line_no`                   int(11)             NULL       COMMENT '行项目',
--  `operation_routing_id`      bigint(20)          NOT NULL               COMMENT '工艺工序主键',
--  `workstation_id`            bigint(20)          NOT NULL               COMMENT '工位主键',
--  `operator_id`               bigint(20)          NOT NULL               COMMENT '操作员主键',
--  `machine_id`                bigint(20)          NOT NULL               COMMENT '操作设备主键',
--  `defect_id`                 bigint(20)          NULL       COMMENT '不合格原因主键',
--  `section_type`              varchar(10)         NULL       COMMENT '质量问题工段类型 (裁剪阶段	cutting、缝制阶段	stitching)',
--  `correction_id`             bigint(20)          NULL       COMMENT '处理方式主键',
--  `if_repaired`               tinyint(1)          NULL DEFAULT 0         COMMENT '是否修复 n:未修复 y:已修复',
--  `remark`                    varchar(100)        NULL       COMMENT '质量备注',

--  `created_date` datetime(0) NOT NULL,
--  `created_by` varchar(20) NOT NULL,
--  `last_modified_date` datetime(0) NULL ,
--  `last_modified_by` varchar(20) NULL ,

--  PRIMARY KEY (`id`) ,
--  INDEX `IDX_QUALITY_ISSUE_01`(`issue_order_id`) ,
--  INDEX `IDX_QUALITY_ISSUE_02`(`operation_routing_id`) ,
--  INDEX `IDX_QUALITY_ISSUE_03`(`workstation_id`) ,
--  INDEX `IDX_QUALITY_ISSUE_04`(`operator_id`) ,
--  INDEX `IDX_QUALITY_ISSUE_05`(`machine_id`) ,
--  INDEX `IDX_QUALITY_ISSUE_06`(`defect_id`) ,
--  INDEX `IDX_QUALITY_ISSUE_07`(`correction_id`) 
--) COMMENT = '质量问题记录';


---- ---------------------------------------------------------------------------------------------------------------------


--CREATE TABLE `request_warehousing`  (
--  `id`                        bigint(20)           NOT NULL AUTO_INCREMENT,
--  `request_no`                varchar(30)          NOT NULL             COMMENT '单据编号',
--  `finish_date`               datetime(0)          NULL     COMMENT '生产完成日期',
--  `sale_order_no`             varchar(64)          NOT NULL             COMMENT '销售订单编号',
--  `description`               varchar(1000)        NULL     COMMENT '备注',
--  `is_storage`                tinyint(1)           NOT NULL DEFAULT 0   COMMENT '是否入库',
--  `created_date`              timestamp(0)         NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',

--  PRIMARY KEY (`id`) ,
--  INDEX `IDX_RE_WAREHOUSING_01`(`request_no`) ,
--  INDEX `IDX_RE_WAREHOUSING_02`(`sale_order_no`) 
--)  COMMENT = '商品进货单';

--CREATE TABLE `request_warehousing_entry`  (
--  `id`                       bigint(20)             NOT NULL AUTO_INCREMENT,
--  `request_warehouing_id`    bigint(20)             NOT NULL              COMMENT '入库申请ID',
--  `material_no`              varchar(30)            NULL      COMMENT '产品编码',
--  `material_name`            varchar(30)            NULL      COMMENT '商品名称',
--  `color_no`                 varchar(30)            NULL      COMMENT '颜色代码',
--  `color_name`               varchar(30)            NULL      COMMENT '颜色名称',
--  `size_no`                  varchar(30)            NULL      COMMENT '尺寸代码',
--  `size_name`                varchar(30)            NULL      COMMENT '尺寸名称',
--  `count`                    int(11)                NULL      COMMENT '数量',

--  PRIMARY KEY (`id`) ,
--  INDEX `IDX_RE_WAREHOUSING_ENTRY_01`(`request_warehouing_id`) 
--) COMMENT = '商品进货单明细';

--CREATE TABLE `sequence`  (
--  `sequence_key`             varchar(64)          NOT NULL,
--  `sequence_value`           bigint(20)           NOT NULL,

--  PRIMARY KEY (`sequence_key`) ,
--  INDEX `IDX_SEQ_01`(`sequence_key`) 
--) COMMENT = 'ID序列';






--CREATE TABLE `interface_log_visualization`  (
--  `id`                         bigint(20)             NOT NULL        AUTO_INCREMENT,
--  `chart_type`                 varchar(20)            NOT NULL                COMMENT '图表类型',
--  `chart_code`                 varchar(20)            NOT NULL                COMMENT '图表编码',
--  `chart_series_name`          varchar(20)            NOT NULL                COMMENT '图表数据-类型',
--  `chart_data_key`             varchar(64)            NOT NULL                COMMENT '图表数据-键',
--  `chart_data_value`           varchar(64)            NOT NULL                COMMENT '图表数据-值',

--  `created_by`                 varchar(20)            NOT NULL                COMMENT '创建人',
--  `created_date`               datetime(0)            NOT NULL                COMMENT '创建日期',
--  `last_modified_by`           varchar(20)            NOT NULL                COMMENT '修改人',
--  `last_modified_date`         datetime(0)            NOT NULL                COMMENT '修改日期',
--  PRIMARY KEY (`id`)
--) COMMENT = '可视化接口日志';

---- ----------------------------
---- Function structure for nextval
---- ----------------------------
--DROP FUNCTION IF EXISTS `nextval`;
--delimiter ;;
--CREATE FUNCTION `nextval`(str VARCHAR(20))
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
