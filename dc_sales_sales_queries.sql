--standard line items
SELECT   'sales' as rec_type,
         shd.FACILITYID,
         shd.billing_date, 
         shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
         shd.whol_sales_cd,
         x.lawson_account,
         shd.order_source,
         sum((SHD.qty_sold - SHD.qty_scratched)) AS qty,
         sum(shd.qty_adjusted) AS adj_order_qty,
         sum((SHD.qty_sold - SHD.qty_scratched) * 
             (( SHD.final_sell_amt - SHD.lbl_case_chrge - SHD.fuel_chrge_amt - SHD.price_adjustment - 
                SHD.city_excise_tax - SHD.other_excise_tax_01 - SHD.other_excise_tax_02 - 
                SHD.other_excise_tax_03 - SHD.county_excise_tax - SHD.state_excise_tax + SHD.leakage_amt + 
                SHD.item_lvl_mrkup_amt_02 ) 
              - (case dc.REGION when 'MIDWEST' then (SHD.freight_amt + SHD.mrkup_dllrs_per_ship_unt) 
                                else (CASE WHEN SHD.mrkup_spread_flg IN ( '1', '2' ) 
                                           THEN SHD.mrkup_dllrs_per_ship_unt 
                                           ELSE 0 END ) 
                                   + (CASE WHEN SHD.mrkup_spread_flg IN ('2') 
                                           THEN SHD.freight_amt 
                                           ELSE 0 END ) 
                 END ))) AS PURE_SALES_AMOUNT,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.mrkup_dllrs_per_ship_unt) as mrkup,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.ITEM_LVL_MRKUP_AMT_02) as arda,
         sum((SHD.qty_sold - SHD.qty_scratched) * (SHD.city_excise_tax + SHD.other_excise_tax_01 + SHD.other_excise_tax_02 + 
                SHD.other_excise_tax_03 + SHD.county_excise_tax + SHD.state_excise_tax)) tax,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.lbl_case_chrge) as admin,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.price_adjustment) as price_adjust,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.fuel_chrge_amt) as fuel_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.freight_amt) as freight_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.AD_ALLOW_AMT) as rpa,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.leakage_amt) as leakage
FROM     crmadmin.v_whse_sales_history_dtl shd 
         INNER JOIN crmadmin.V_WHSE_LAWSON_ACCT_TO_WSC_TN x ON shd.whol_sales_cd = x.whol_sales_cd AND shd.territory_no = x.territory_no AND shd.facilityid = x.facilityid 
         INNER JOIN crmadmin.t_whse_div_xref dc ON dc.swat_id = shd.facilityid
WHERE  x.business_segment = '2'
  --AND d1.date_key = '#bDate#' 
  and shd.BILLING_DATE between '2015-08-16' and '2015-09-12'
  and shd.FACILITYID in ('003', '005', '008', '015', '040', '054', '058', '059', '061', '062', '066')
--  AND invoice_nbr = 1825931 
--  AND shd.facilityid = '058' 
  AND x.lawson_account IN ( '301000', '331000', '349500') 
  and shd.NO_CHRGE_ITM_CDE not in ('*')
  --AND shd.territory_no NOT IN ( 29, 39, 46, 49, 58, 59, 69, 70 ) 
  AND SHD.record_id NOT IN ('2', '3', '4', '6', '7', '8') 
GROUP  BY 'sales',
          shd.FACILITYID,
          shd.billing_date, 
          shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
          shd.whol_sales_cd, 
          x.lawson_account, 
          shd.order_source
--;
union all
--swat markup-only non-standard
SELECT   'markup' as rec_type,
         shd.FACILITYID,
         shd.billing_date,
         shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
         shd.whol_sales_cd,
         lawson_account,
         order_source,
         sum((SHD.qty_sold - SHD.qty_scratched)) AS qty,
         sum(shd.qty_adjusted) AS adj_order_qty,
         sum(0) AS PURE_SALES_AMOUNT,
         sum(SHD.FINAL_SELL_AMT) as mrkup,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.ITEM_LVL_MRKUP_AMT_02) as arda,
         sum((SHD.qty_sold - SHD.qty_scratched) * (SHD.city_excise_tax + SHD.other_excise_tax_01 + SHD.other_excise_tax_02 + 
                SHD.other_excise_tax_03 + SHD.county_excise_tax + SHD.state_excise_tax)) tax,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.lbl_case_chrge) as admin,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.price_adjustment) as price_adjust,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.fuel_chrge_amt) as fuel_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.freight_amt) as freight_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.AD_ALLOW_AMT) as rpa,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.leakage_amt) as leakage
FROM     crmadmin.v_whse_sales_history_dtl shd 
         INNER JOIN crmadmin.V_WHSE_LAWSON_ACCT_TO_SPLIT_GL_WSC_TN x ON shd.whol_sales_cd = x.whol_sales_cd AND shd.territory_no = x.territory_no AND shd.facilityid = x.facilityid 
         INNER JOIN crmadmin.t_whse_div_xref dc ON dc.swat_id = shd.facilityid
WHERE  x.business_segment = '2'
  and shd.BILLING_DATE between '2015-08-16' and '2015-09-12'
--  and shd.BILLING_DATE = '2015-09-11'
  --AND invoice_nbr = 1825931 
  AND shd.facilityid in ('058', '059', '066', '061', '062', '015') 
  AND x.lawson_account IN ('999710') 
  AND shd.ORDER_SOURCE not in ('I')
--  and shd.RECORD_ID not in ('2') --or shd.RECORD_ID is not null) (need to deal with nulls in 058, 059) why only there?
--  and shd.NO_CHRGE_ITM_CDE not in ('*')
  --AND shd.territory_no NOT IN ( 29, 39, 46, 49, 58, 59, 69, 70 ) 
  --AND SHD.record_id NOT IN ( '8', '2' ) 
GROUP  BY 'markup',
          shd.FACILITYID,
          shd.billing_date, 
          shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
          shd.whol_sales_cd, 
          x.lawson_account, 
          shd.order_source
--;
union all
--mw markup only non-standard line items
SELECT   'markup' as rec_type,
         shd.FACILITYID,
         shd.billing_date,
         shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
         shd.whol_sales_cd,
         lawson_account,
         order_source,
         sum((SHD.qty_sold - SHD.qty_scratched)) AS qty,
         sum(shd.qty_adjusted) AS adj_order_qty,
         sum(0) AS PURE_SALES_AMOUNT,
         sum(SHD.FINAL_SELL_AMT) as mrkup,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.ITEM_LVL_MRKUP_AMT_02) as arda,
         sum((SHD.qty_sold - SHD.qty_scratched) * (SHD.city_excise_tax + SHD.other_excise_tax_01 + SHD.other_excise_tax_02 + 
                SHD.other_excise_tax_03 + SHD.county_excise_tax + SHD.state_excise_tax)) tax,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.lbl_case_chrge) as admin,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.price_adjustment) as price_adjust,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.fuel_chrge_amt) as fuel_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.freight_amt) as freight_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.AD_ALLOW_AMT) as rpa,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.leakage_amt) as leakage
FROM     crmadmin.v_whse_sales_history_dtl shd 
         INNER JOIN crmadmin.V_WHSE_LAWSON_ACCT_TO_SPLIT_GL_WSC_TN x ON shd.whol_sales_cd = x.whol_sales_cd AND shd.territory_no = x.territory_no AND shd.facilityid = x.facilityid 
         INNER JOIN crmadmin.t_whse_div_xref dc ON dc.swat_id = shd.facilityid
WHERE  x.business_segment = '2'
  and shd.BILLING_DATE between '2015-08-16' and '2015-09-12'
--  and shd.BILLING_DATE = '2015-09-11'
  --AND invoice_nbr = 1825931 
  AND shd.facilityid not in ('058', '059', '066', '061', '062', '015') 
  AND x.lawson_account IN ('999710') 
--  AND shd.ORDER_SOURCE not in ('I')
--  and shd.RECORD_ID not in ('2') --or shd.RECORD_ID is not null) (need to deal with nulls in 058, 059) why only there?
--  and shd.NO_CHRGE_ITM_CDE not in ('*')
  --AND shd.territory_no NOT IN ( 29, 39, 46, 49, 58, 59, 69, 70 ) 
  AND SHD.record_id IN ( '6' ) 
GROUP  BY 'markup',
          shd.FACILITYID,
          shd.billing_date, 
          shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
          shd.whol_sales_cd, 
          x.lawson_account, 
          shd.order_source

union all
--ARDA (works for Lima)
SELECT   'arda' as rec_type,
         shd.FACILITYID,
         shd.billing_date,
         shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
         shd.whol_sales_cd,
         lawson_account,
         order_source,
         sum(0) AS qty,
         sum(0) AS adj_order_qty,
         sum(0) AS PURE_SALES_AMOUNT,
         sum(0) as mrkup,
         sum(shd.FINAL_SELL_AMT) as arda,
         sum((SHD.qty_sold - SHD.qty_scratched) * (SHD.city_excise_tax + SHD.other_excise_tax_01 + SHD.other_excise_tax_02 + 
                SHD.other_excise_tax_03 + SHD.county_excise_tax + SHD.state_excise_tax)) tax,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.lbl_case_chrge) as admin,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.price_adjustment) as price_adjust,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.fuel_chrge_amt) as fuel_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.freight_amt) as freight_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.AD_ALLOW_AMT) as rpa,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.leakage_amt) as leakage
FROM     crmadmin.v_whse_sales_history_dtl shd 
         INNER JOIN crmadmin.V_WHSE_LAWSON_ACCT_TO_WSC_TN x ON shd.whol_sales_cd = x.whol_sales_cd AND shd.territory_no = x.territory_no AND shd.facilityid = x.facilityid 
         INNER JOIN crmadmin.t_whse_div_xref dc ON dc.swat_id = shd.facilityid
WHERE    shd.BILLING_DATE between '2015-08-16' and '2015-09-12'
AND      shd.facilityid in ('058', '059', '066', '061', '062', '015')
AND      shd.CREDIT_REASON_CDE = '19'
GROUP BY 'arda', 
         shd.FACILITYID, 
         shd.billing_date,           
         shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
         shd.whol_sales_cd, 
         x.lawson_account, 
         shd.order_source
union all
--mid-west manual invoices non-markup
SELECT   'manual' as rec_type,
         shd.FACILITYID,
         shd.billing_date,
         shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
         shd.whol_sales_cd,
         lawson_account,
         order_source,
         sum((SHD.qty_sold - SHD.qty_scratched)) AS qty,
         sum(shd.qty_adjusted) AS adj_order_qty,
         sum(SHD.FINAL_SELL_AMT) AS PURE_SALES_AMOUNT,
         sum(shd.MRKUP_DLLRS_PER_SHIP_UNT) as mrkup,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.ITEM_LVL_MRKUP_AMT_02) as arda,
         sum((SHD.qty_sold - SHD.qty_scratched) * (SHD.city_excise_tax + SHD.other_excise_tax_01 + SHD.other_excise_tax_02 + 
                SHD.other_excise_tax_03 + SHD.county_excise_tax + SHD.state_excise_tax)) tax,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.lbl_case_chrge) as admin,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.price_adjustment) as price_adjust,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.fuel_chrge_amt) as fuel_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.freight_amt) as freight_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.AD_ALLOW_AMT) as rpa,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.leakage_amt) as leakage
FROM     crmadmin.v_whse_sales_history_dtl shd 
         INNER JOIN crmadmin.V_WHSE_LAWSON_ACCT_TO_WSC_TN x ON shd.whol_sales_cd = x.whol_sales_cd AND shd.territory_no = x.territory_no AND shd.facilityid = x.facilityid 
         INNER JOIN crmadmin.t_whse_div_xref dc ON dc.swat_id = shd.facilityid
WHERE  x.business_segment = '2'
  and shd.BILLING_DATE between '2015-08-16' and '2015-09-12'
--  and shd.BILLING_DATE = '2015-09-11'
  --AND invoice_nbr = 1825931 
  AND shd.facilityid not in ('058', '059', '066', '061', '062', '015') 
  AND x.lawson_account IN ( '301000', '331000', '349500') 
--  AND shd.ORDER_SOURCE not in ('I')
  and shd.RECORD_ID in ('6') --or shd.ORDER_SOURCE in ('D'))
-- and shd.ORDER_SOURCE in ('D')
--  and shd.ORDER_TYPE not in ('RG', 'BK', 'AD', 'FS', 'CA')
--  and shd.NO_CHRGE_ITM_CDE not in ('*')
  --AND shd.territory_no NOT IN ( 29, 39, 46, 49, 58, 59, 69, 70 ) 
  --AND SHD.record_id NOT IN ( '8', '2' ) 
GROUP  BY 'manual',
          shd.FACILITYID,
          shd.billing_date, 
          shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
          shd.whol_sales_cd, 
          lawson_account, 
          order_source
union all

--swat manual invoices non-markup
SELECT   'manual' as rec_type,
         shd.FACILITYID,
         shd.billing_date,
         shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
         shd.whol_sales_cd,
         lawson_account,
         order_source,
         sum((SHD.qty_sold - SHD.qty_scratched)) AS qty,
         sum(shd.qty_adjusted) AS adj_order_qty,
         sum(SHD.FINAL_SELL_AMT) AS PURE_SALES_AMOUNT,
         sum(shd.MRKUP_DLLRS_PER_SHIP_UNT) as mrkup,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.ITEM_LVL_MRKUP_AMT_02) as arda,
         sum((SHD.qty_sold - SHD.qty_scratched) * (SHD.city_excise_tax + SHD.other_excise_tax_01 + SHD.other_excise_tax_02 + 
                SHD.other_excise_tax_03 + SHD.county_excise_tax + SHD.state_excise_tax)) tax,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.lbl_case_chrge) as admin,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.price_adjustment) as price_adjust,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.fuel_chrge_amt) as fuel_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.freight_amt) as freight_charge,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.AD_ALLOW_AMT) as rpa,
         sum((SHD.qty_sold - SHD.qty_scratched) * SHD.leakage_amt) as leakage
FROM     crmadmin.v_whse_sales_history_dtl shd 
         INNER JOIN crmadmin.V_WHSE_LAWSON_ACCT_TO_WSC_TN x ON shd.whol_sales_cd = x.whol_sales_cd AND shd.territory_no = x.territory_no AND shd.facilityid = x.facilityid 
         INNER JOIN crmadmin.t_whse_div_xref dc ON dc.swat_id = shd.facilityid
WHERE  x.business_segment = '2'
  and shd.BILLING_DATE between '2015-08-16' and '2015-09-12'
--  and shd.BILLING_DATE = '2015-09-11'
  --AND invoice_nbr = 1825931 
  AND shd.facilityid in ('058', '059', '066', '061', '062', '015') 
  AND x.lawson_account IN ( '301000', '331000', '349500') 
--  AND shd.ORDER_SOURCE not in ('I')
--  and shd.RECORD_ID in ('6') --or shd.ORDER_SOURCE in ('D'))
-- and shd.ORDER_SOURCE in ('D')
  and shd.ORDER_TYPE not in ('RG', 'BK', 'AD', 'FS', 'CA')
--  and shd.NO_CHRGE_ITM_CDE not in ('*')
  AND shd.territory_no NOT IN ( 29, 39, 46, 49, 58, 59, 69, 70 ) 
  --AND SHD.record_id NOT IN ( '8', '2' ) 
GROUP  BY 'manual',
          shd.FACILITYID,
          shd.billing_date, 
          shd.no_chrge_itm_cde,  shd.RECORD_ID, shd.TERRITORY_NO, shd.ORDER_TYPE,
          shd.whol_sales_cd, 
          lawson_account, 
          order_source;