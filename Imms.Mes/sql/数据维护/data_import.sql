
--
-- 导入组织架构
--


--
-- 导入设备类型
--
insert into plan_code(code_type,code_no,code_name,description,create_by,create_date)
  select 'EQUIPMENT_TYPE',machine_type_no,name,description,1,sysdate() from c2m.machine_type;

--
-- 导入物料类型
--
insert into plan_code(code_type,code_no,code_name,description,create_by,create_date)
   select 'MATERIAL_TYPE',material_type_no,name,description,1,sysdate()
	  from c2m.material_type;

--
-- 导入物料
--

insert into material(material_no,      
  material_name,    
  material_type_id, 
  unit,             
  width,            
  weight,           
  price ,           
  color,            
  description,
  create_by,
  create_date
) 
 select m.material_no,SUBSTR(m.name,1,50) as name,p.record_id as material_type_id,
       ifnull(m.unit,'') as unit,
       ROUND(m.width,4) as width,
			 round(m.weight,4) as weight,
			 round(m.price,2) as price,
			 m.color,
			 m.description,
			 1,
			 sysdate()
 from c2m.material m  
       join c2m.material_type t  on m.material_type_id = t.id 
		 	 join plan_code p on p.code_no = t.material_type_no
 where m.material_no is not null 
   and m.material_no not in(
	    select material_no from material
)

 --
 -- 导入bom
 --
insert into bom(bom_order_id,component_material_id,component_abstract_material_id,qty_component,component_unit,parent_bom_id,is_main_fabric,create_by,create_date)
select 1 as bom_order_Id, 
       mc.record_id as component_material_id,			
			 ma.record_id as component_abstract_material_id,
			 qty,
			 component_material_uom,
			 parent_id,
			 if_main_fabric,
			1,
		SYSDATE()
from c2m.bom b1 left join c2m.material mc1 on b1.component_material_id = mc1.id  join material mc on mc1.material_no = mc.material_no 
                left join c2m.material ma1 on b1.component_abstract_material_id = ma1.id  left join material ma on ma1.material_no = ma.material_no
where b1.bom_order_id = 109542
;

-- 
--  如果是生产BOM，则还需要更新用量到最原始的状态
--
update bom b0 join (
	select mc.record_id as component_material_id,			
				 ma.record_id as component_abstract_material_id,
				 qty,
				 component_material_uom,
				 parent_id,
				 if_main_fabric
	from c2m.bom b1 left join c2m.material mc1 on b1.component_material_id = mc1.id  join material mc on mc1.material_no = mc.material_no 
									left join c2m.material ma1 on b1.component_abstract_material_id = ma1.id  left join material ma on ma1.material_no = ma.material_no
	where b1.bom_order_id = 109329
) b1 on b0.component_material_id = b1.component_material_id
set b0.qty_component = b1.qty
where b0.bom_order_id = 1
;

--
-- 导入工艺
--
insert into operation(operation_no,description,machine_type_id,standard_time,standard_price,section_type,section_name,is_outsource,qa_procedure,requirement,required_level,create_by,create_date)
select o.operation_no,
       o.description,
			 mt.record_id,
			 ROUND(o.standard_time, 4),
			 ROUND(o.standard_price,4),
			 o.section_type,
			 o.section_name,
			 o.if_outsource,
			 o.qa_procedure,
			 o.requirement,
			 o.level,
			 1,
			 SYSDATE()
from c2m.operation o join c2m.machine_type mt1 on o.machine_type_id = mt1.id join plan_code mt on mt1.machine_type_no = mt.code_no
where o.operation_no not in(
   select operation_no from operation
);

/*
 select * from material
 where record_id = 16;
   
 select * from c2m.material
 where material_no='SMCS001001';
   
 select * from c2m.production_order 
 where fg_material_id = 1405;
   
 select co.cutting_order_no,
        co.cutting_table_no,
 			 co.fabric_material_id,			 
 		   co.fabric_material_type,
 			 m.name as material_name,
 			 m.material_type_id,
 			 t.material_type_no,			 
 			 t.name as material_type_name			 
 from  c2m.cutting_order co  join c2m.material_type t on co.fabric_material_type = t.id
 													 join c2m.material m on co.fabric_material_id = m.id
 where production_order_id = 5683
 ;
   
 select * from c2m.bom where bom_order_id =106712;
 */


SELECT * from operation
where operation_no in('T0001',
'SWLYCU004','SWLYCU005','SWLYOH001','SWLYOH002','SWLYOH003','SWLYLN004',
'SWYFAS005','SWLYAS026','SWLYAS027','SWLYAS028','SWLYAS029','SWLYAS030',
'SWLYAS031','SWLYAS032','SWLYAS033','SMCSAS044','SMCSAS033','SWLYAS034',
'SWLYAS035','SWLYAS036','SWLYAS037',''
);

--
-- 导入设备
--
insert into equipment(equipment_no,equipment_name,description,status,equipment_type_id,work_station_id)
select m.machine_no,m.name,m.description,0 as status,t1.record_id as equipment_type_id,0 as work_station_id
from c2m.machine m  join c2m.machine_type t on m.machine_type_id = t.id join plan_code t1 on t.machine_type_no = t1.code_no
;


-- 导入能力

insert into imms_net.operator_capability(operator_id,operation_id,skill_level,create_by,create_date)
SELECT op1.record_Id as operator_id,o1.record_id as operation_id,1,1,SYSDATE()
FROM `capability` c join operation o  on c.operation_id = o.id
                    join operator op on c.operator_id = op.id  
									 join sec_user u on op.user_id = u.id
									 join imms_net.system_user u1 on u.user_no = u1.user_code
									  join imms_net.operator op1 on op1.user_id = u1.record_id
										join imms_net.operation o1 on o.operation_no = o1.operation_no


select * from operator_capability where operation_id in(
6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
,6575
,6493
,6501
,6466
);
