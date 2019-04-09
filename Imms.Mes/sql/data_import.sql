
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
 where m.material_no is not null;

 --
 -- 导入bom
 --
insert into bom(bom_order_id,component_material_id,component_abstract_material_id,qty_component,component_unit,parent_bom_id,is_main_fabric,create_by,create_date)
select 2 as bom_order_Id, 
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
where b1.bom_order_id = 106712
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
;

