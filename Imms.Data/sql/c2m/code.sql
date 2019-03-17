drop table code_seed;
drop table size;
drop table defect_code;
drop table machine_type;
drop table material_type;
drop table uom;

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


