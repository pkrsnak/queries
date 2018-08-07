SELECT   sales_hist.facilityid,
         sales_hist.invoice_nbr,
         sales_hist.billing_date,
         sales_hist.delivery_date,
         sales_hist.order_type,
         sales_hist.cust_corp_nbr,
         sales_hist.customer_nbr_corp,
         sales_hist.customer_no,
         sales_hist.customer_no_full,
         sales_hist.territory_no,
         sales_hist.facilityid_ship,
         sales_hist.item_nbr,
         sales_hist.item_nbr_cd,
         sales_hist.item_nbr_hs,
         sales_hist.item_dept,
         sales_hist.buyer_nbr,
         sales_hist.qty_ordered,
         sales_hist.qty_adjusted,
         sales_hist.qty_sold,
         sales_hist.qty_subbed,
         sales_hist.qty_scratched,
         sales_hist.out_reason_code,
         sales_hist.fuel_chrge_amt as fuel_chrge_amt,
         sales_hist.deal_amt as deal_amt,
         sales_hist.ad_allow_amt as ad_allow_amt,
         sales_hist.layer_ext_cost as layer_ext_cost,
         sales_hist.retail_price as retail_price,
         sales_hist.random_wgt as random_wgt,
         sales_hist.ship_case_wgt as ship_case_wgt,
         sales_hist.vendor_nbr,
         case sales_hist.platform_type 
              when 'LEGACY' then sales_hist.leakage_amt 
              else sales_hist.leaker_amt_calc 
         end leakage_amt,
         sales_hist.freight_amt as freight_amt,
         sales_hist.booking_nbr,
         sales_hist.mrkup_dllrs_per_ship_unt as mrkup_dllrs_per_ship_unt,
         sales_hist.final_sell_amt as final_sell_amt,
         sales_hist.lbl_case_chrge as lbl_case_chrge,
         sales_hist.price_adjustment as price_adjustment,
         other_excise_tax_01 + other_excise_tax_02 + other_excise_tax_03 + city_excise_tax + state_excise_tax + county_excise_tax as excise_tax,
         other_sales_tax_01 + other_sales_tax_03 + other_sales_tax_02 as other_sales_tax,
         item_lvl_mrkup_amt_02 as item_lvl_mrkup_amt_02,
         sales_hist.retail_zone,
         sales_hist.store_pack,
         sales_hist.gl_account,
         lawson_acct.lawson_account,
         lawson_acct.lawson_dept,
         sales_hist.whol_sales_cd,
         sales_hist.no_chrge_itm_cde,
         sales_hist.order_source,
         sales_hist.record_id,
         sales_hist.invoice_counter,
         sales_hist.mrkup_spread_flg,
         sales_hist.usds_flg,
         sales_hist.prvt_lbl_flg,
         sales_hist.random_wgt_flg,
         division.region,
         sales_hist.qty_sold - sales_hist.qty_scratched qty_shipped,
         sales_hist.qty_sold - sales_hist.qty_scratched qty_for_extension,
         ( sales_hist.final_sell_amt - (case when sales_hist.admin_alloc_flg = 'Y' Then 0 else sales_hist.lbl_case_chrge end) - sales_hist.price_adjustment - sales_hist.city_excise_tax - sales_hist.other_excise_tax_01 - sales_hist.other_excise_tax_02 - sales_hist.other_excise_tax_03 - sales_hist.county_excise_tax - sales_hist.state_excise_tax + case sales_hist.platform_type when 'LEGACY' then sales_hist.leakage_amt else sales_hist.leaker_amt_calc end + sales_hist.item_lvl_mrkup_amt_02 - case sales_hist.platform_type when 'LEGACY' then freight_amt + mrkup_dllrs_per_ship_unt else case when sales_hist.mrkup_spread_flg in ('1', '2') then sales_hist.mrkup_dllrs_per_ship_unt else 0 end - case when sales_hist.mrkup_spread_flg in ('2') then sales_hist.freight_amt else 0 end end) net_price_amt,
         sales_hist.mrkup_dllrs_per_ship_unt as mrkup,
         case 
              when srp_units = 0 then 1 
              when srp_units = null then 1 
              else srp_units 
         end srp_units,
         sales_hist.platform_type,
         sales_hist.credit_reason_cde
FROM     crmadmin.v_whse_sales_history_dtl sales_hist 
         inner join CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN lawson_acct on (sales_hist.whol_sales_cd = lawson_acct.whol_sales_cd and sales_hist.territory_no = lawson_acct.territory_no and sales_hist.facilityid = lawson_acct.facilityid) 
         inner join crmadmin.t_whse_div_xref division on division.swat_id = sales_hist.facilityid
WHERE    lawson_acct.business_segment = '2'
AND      lawson_acct.lawson_account in ('50000','50002','50005','50007','50040','50047','53010','54500')
AND      record_id NOT IN ('2', '3', '4',' 5', '6', '7', '8')
AND      sales_hist.no_chrge_itm_cde not in ('*')
AND      usds_flg = 'U'
AND      sales_hist.FACILITYID = '071'
AND      billing_date between '2017-12-31' and '2018-01-27';