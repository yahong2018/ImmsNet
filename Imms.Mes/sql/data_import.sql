

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