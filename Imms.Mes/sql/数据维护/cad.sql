
/* 
   根据PO号 删除所导入的CAD的相关数据
*/
set @po_no = 'PO0000000005';

-- 删除生产bom
delete from bom
where bom_order_id = (
  select bom_order_id from production_order 
		  where order_no=@po_no
);

-- delete from bom_order 
-- where record_id in( 
--    select bom_order_id from production_order 
-- 	  where order_no=@po_no
-- );

-- 删除领料BOM
delete from bom
where bom_order_id in(
   select picking_bom_order_id from picking_order 
				where production_order_id in(
					select production_order_id from production_order 
							where order_no=@po_no
				)			 
);

delete from bom_order
where record_id in(
   select picking_bom_order_id 
	     from picking_order 
				where production_order_id in(
					select production_order_id from production_order 
							where order_no=@po_no
				)			 
);

-- 删除领料单
delete from picking_order_item
where picking_order_id in(
  select record_id 
	 from picking_order
	where production_order_id in(
			select production_order_id from production_order 
					where order_no=@po_no
		)
);

delete from picking_order
where production_order_id in(
  select production_order_id from production_order 
		  where order_no=@po_no
);

-- 删除裁剪单
delete from media
where record_id in( 
   select media_id from cutting_marker
		where cutting_order_id in(
			select record_id from cutting_order
					where production_order_id in(
						select production_order_id from production_order 
								where order_no=@po_no
					)	
		)
);

delete from media
where record_id in( 
   select marker_file_id from cutting_marker
		where cutting_order_id in(
			select record_id from cutting_order
					where production_order_id in(
						select production_order_id from production_order 
								where order_no=@po_no
					)	
		)
);


delete from cutting_order_size
where cutting_order_id in(
	select record_id from cutting_order
			where production_order_id in(
				select production_order_id from production_order 
						where order_no=@po_no
			)	
);

delete from cutting_marker
where cutting_order_id in(
    select record_id from cutting_order
		where production_order_id in(
			select production_order_id from production_order 
					where order_no=@po_no
		)	
);

delete from cutting_order_spread_ply
where cutting_order_id in(
    select record_id from cutting_order
		where production_order_id in(
			select record_id from production_order 
					where order_no=@po_no
		)	
);

delete from cutting_order
		where production_order_id in(
			select production_order_id from production_order 
					where order_no=@po_no
		);	
		
-- 删除pattern image
delete from media
where record_id in( 
   select media_id from production_order_pattern_relation
    where production_order_id in(
			select production_order_id from production_order 
					where order_no=@po_no
		)
);

delete from production_order_pattern_relation
		where production_order_id in(
			select production_order_id from production_order 
					where order_no=@po_no
);	

-- 删除质检
delete from quality_check_detail
where quality_check_id in (
   select record_id from quality_check
		where production_order_id in(
			select production_order_id from production_order 
			 where order_no=@po_no
		)
);


delete from quality_check
where production_order_id in(
  select production_order_id from production_order 
	 where order_no=@po_no
);

-- 更新PO的状态


-- -------------------------------------------------------------------------------------------------------------