
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
  is_outsource                     tinyint(1)                    NULL ,
  qa_procedure                     varchar(1000)                 NULL ,
  requirement                      varchar(1000)                 NULL ,
  skill_level                      varchar(10)                   NULL ,

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATION_01(operation_no) ,
  INDEX IDX_OPERATION_02(machine_type_id)
) ;


CREATE TABLE operator_capability  (
  record_id                        bigint   auto_increment       NOT NULL,
  operator_id                      bigint                        NULL,
  operation_id                     bigint                        NOT NULL,
  skill_level                      varchar(10)                   NULL,
  
  PRIMARY KEY (record_id),
  INDEX IDX_CAPABILITY_01(operator_id),
  INDEX IDX_CAPABILITY_02(operation_id)
); 


CREATE TABLE operation_routing_order  (
  record_id                        bigint   auto_increment      NOT NULL,
  operation_routing_order_no       varchar(10)                  NOT NULL ,
  operation_routing_order_type     int                          NOT NULL , --0:物料工艺路线,1:生产订单工艺路线,2:作业单工艺路线
  ref_id                           bigint                       NOT NULL , --引用单号：物料号/生产订单号/作业单号'

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATION_ROUTING_ORDER_01(operation_routing_order_no),
  INDEX IDX_OPERATION_ROUTING_ORDER_02(ref_id)
) ;


CREATE TABLE operation_routing  (
  record_id                       bigint  auto_increment            NOT NULL,
  operation_routing_status        tinyint             NOT NULL,             -- 0.已计划	  1.已开始  	2.已完成
  operation_id                    bigint              NOT NULL,             -- 工艺
  operation_routing_order_id      bigint              NOT NULL,             -- 工艺路线单主键  
  qa_procedure                    varchar(250)        NULL,                 -- 品质说明
  standard_price                  double(8,4)         NOT NULL,             -- 标准单价
  section_type                    varchar(12)         NULL,                 -- 所属工段
  machine_type_id                 bigint              NULL,                 -- 机器类型    
  standard_time                   float(8,4)          NULL,                 -- 标准时间    
  sop_file_path                   varchar(255)        NULL ,  
  required_level                  varchar(10)         NULL,                 -- 需要工艺等级  
  sequence_no                     int                 NOT NULL ,            -- 工序顺序  
  pre_routing_id                  bigint              NULL,                 -- 依赖关系-上道工序    
  is_outsource                    bit                 NOT NULL ,
  
  operator_id                     bigint              NULL,                 -- 操作员主键
  actual_station_id               bigint              NULL ,
  actual_time                     float(8,4)          NULL ,
  scrap_qty                       int                 NULL DEFAULT 0 ,      -- 报废数量
  complete_qty                    int                 NULL DEFAULT 0 ,      -- 完工数量
  pull_in_time                    datetime            NULL  ,               -- 进站时间
  pull_out_time                   datetime            NULL  ,               -- 出站时间

  PRIMARY KEY (record_id) ,
  INDEX IDX_OPERATION_ROUTING_01(operation_id) ,
  INDEX IDX_OPERATION_ROUTING_02(operation_routing_order_id) ,
  INDEX IDX_OPERATION_ROUTING_03(operator_id) ,
  INDEX IDX_OPERATION_ROUTING_04(actual_station_id) ,
  INDEX IDX_OPERATION_ROUTING_05(pre_operation_id) ,
  INDEX IDX_OPERATION_ROUTING_06(pre_routing_id)
) COMMENT = '工艺路线';
