--non-fresh
SELECT   AL1.srp_upc_key,
         AL1.upc_cd,
         AL1.item_code,
         AL1.distrb_cntr_code,
         AL1.retail_item_dsc,
         AL1.item_brand_id,
         AL1.dept_key,
         AL1.mdse_grp_key,
         AL1.mdse_catgy_key,
         AL1.mdse_class_key,
         AL1.size_msr,
         AL1.size_uom_cd,
         AL1.ship_unit_cd,
         AL1.in_out_flg,
         AL1.preprice_amt,
         AL1.preprice_qty,
         AL1.availability_date,
         AL1.state_code,
         AL1.puf_id,
         AL1.puf_value,
         AL1.create_user_id,
         AL1.create_tmsp,
         AL1.update_user_id,
         AL1.update_tmsp,
         AL1.audit_source_id,
         AL1.audit_source_tmsp,
         AL2.item_code,
         AL2.price_type_cd,
         AL2.price_strategy_cd,
         AL2.unit_cost_amt,
         AL2.item_price_amt,
         AL2.sell_unit_qty,
         AL3.distrb_cntr_name,
         AL2.effective_tmsp,
         AL2.expiration_tmsp,
         AL4.unit_cost_amt
FROM     dbo.srp_upc AL1,
         dbo.rtl_suggested_prc AL2,
         dbo.srp_distribution_center AL3,
         dbo.srp_upc_cost AL4
WHERE    (AL1.upc_cd=AL2.upc_cd
     AND AL1.distrb_cntr_code=AL2.distrb_cntr_code
     AND AL1.distrb_cntr_code=AL3.distrb_cntr_code
     AND AL2.upc_cd=AL4.upc_cd
     AND AL2.distrb_cntr_code=AL4.distrb_cntr_code)
AND      (((NOT AL1.in_out_flg='Y')
        AND AL2.price_status_cd='ACTIVE'
        AND AL1.distrb_cntr_code='008'
        AND (AL2.effective_tmsp <= GETDATE ()
            AND (AL2.expiration_tmsp IS NULL
                OR  AL2.expiration_tmsp >= GETDATE ()))
        AND (AL4.expiration_tmsp >= GETDATE ()
            AND AL4.effective_tmsp <= GETDATE ()
            OR  AL4.expiration_tmsp IS NULL)))
;


--fresh
SELECT   AL1.srp_upc_key,
         AL1.upc_cd,
         AL1.item_code,
         AL1.distrb_cntr_code,
         AL1.retail_item_dsc,
         AL1.item_brand_id,
         AL1.dept_key,
         AL1.mdse_grp_key,
         AL1.mdse_catgy_key,
         AL1.mdse_class_key,
         AL1.size_msr,
         AL1.size_uom_cd,
         AL1.ship_unit_cd,
         AL1.in_out_flg,
         AL1.preprice_amt,
         AL1.preprice_qty,
         AL1.availability_date,
         AL1.state_code,
         AL1.puf_id,
         AL1.puf_value,
         AL1.create_user_id,
         AL1.create_tmsp,
         AL1.update_user_id,
         AL1.update_tmsp,
         AL1.audit_source_id,
         AL1.audit_source_tmsp,
         AL2.item_code,
         AL2.price_type_cd,
         AL2.price_strategy_cd,
         AL2.unit_cost_amt,
         AL2.item_price_amt,
         AL2.sell_unit_qty,
         AL3.distrb_cntr_name,
         AL2.effective_tmsp,
         AL2.expiration_tmsp,
         AL4.unit_cost_amt
FROM     dbo.srp_upc AL1,
         dbo.rtl_suggested_prc AL2,
         dbo.srp_distribution_center AL3,
         dbo.srp_upc_cost AL4
WHERE    (AL1.upc_cd=AL2.upc_cd
     AND AL1.distrb_cntr_code=AL2.distrb_cntr_code
     AND AL1.distrb_cntr_code=AL3.distrb_cntr_code
     AND AL2.upc_cd=AL4.upc_cd
     AND AL2.distrb_cntr_code=AL4.distrb_cntr_code)
AND      (((NOT AL1.in_out_flg='Y')
        AND AL2.price_status_cd='ACTIVE'
        AND AL1.distrb_cntr_code='008'
        AND (AL2.effective_tmsp <= GETDATE ()
            AND (AL2.expiration_tmsp IS NULL
                OR  AL2.expiration_tmsp >= GETDATE ()))
        AND (AL4.expiration_tmsp >= GETDATE ()
            AND AL4.effective_tmsp <= GETDATE ()
            OR  AL4.expiration_tmsp IS NULL)))
;