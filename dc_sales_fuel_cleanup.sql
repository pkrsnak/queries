--FUEL--------------------------------------------------------------------------------------
Select count(*) from CRMADMIN.T_WHSE_SALES_HST_DC
where ORIGIN_ID = 'CRM-FUEL'
and TRANSACTION_DATE between '2018-05-03' and '2018-06-30'
;


SELECT   FACILITYID, sum(EXT_FUEL_CHRGE_AMT) fuel , sum(EXT_LBL_CASE_CHRGE) admin
FROM     CRMADMIN.T_WHSE_SALES_HST_DC
WHERE    TRANSACTION_DATE between '2018-05-03' and '2018-06-30'
group by FACILITYID 
;

SELECT   *
FROM     CRMADMIN.T_WHSE_SALES_HST_DC
WHERE    TRANSACTION_DATE between '2018-05-03' and '2018-06-30'
and FACILITYID = '005' and EXT_FUEL_CHRGE_AMT <> 0 
;

Select facility_id, sum(ext_fuel_chrge_amt) fuel, sum(ext_admin_fee_amt) admin
from whmgr.sb_dc_sales_hst
where transaction_date  between '05-03-2018' and '06-30-2018'
group by facility_id
;

--fuel
select 
sales_hist.facilityid,
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
0 qty_ordered,
0 qty_adjusted,
0 qty_sold,
0 qty_subbed,
0 qty_scratched,
sales_hist.out_reason_code,
0 fuel_chrge_amt,
0 deal_amt,
0 ad_allow_amt,
0 layer_ext_cost,
0 retail_price,
0 random_wgt,
0 ship_case_wgt,
sales_hist.vendor_nbr,
0 leakage_amt,
0 freight_amt,
sales_hist.booking_nbr, 	
0 mrkup_dllrs_per_ship_unt,
sales_hist.final_sell_amt as final_sell_amt,
0 lbl_case_chrge,
0 price_adjustment,
0 excise_tax,
0 other_sales_tax,
0 item_lvl_mrkup_amt_02,
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
0 qty_shipped,
0 qty_for_extension,
0 net_price_amt,
0 as mrkup,
0 srp_units,
sales_hist.platform_type,
sales_hist.credit_reason_cde
from 
crmadmin.v_whse_sales_history_dtl sales_hist
inner join  
(
 select FACILITYID, WHOL_SALES_CD,  TERRITORY_NO, lawson_account, lawson_dept 
 from CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN
 where 
  business_segment = '2' 
-- and lawson_account not in ('50000', '54500', '50007', '50005', '50040', '50047')
-- take all fuel stored on regular invoices and manual
  and (FACILITYID, WHOL_SALES_CD,  TERRITORY_NO) not in 
	(select FACILITYID, WHOL_SALES_CD,  TERRITORY_NO 
	from
	CRMADMIN.V_WHSE_LAWSON_ACCT_TO_SPLIT_GL_WSC_TN
                 where business_segment = '2'
                 and SPLIT_GL_ACCOUNT = '95520'
	)
) lawson_acct 
     on 
     (sales_hist.whol_sales_cd = lawson_acct.whol_sales_cd 
      and sales_hist.territory_no = lawson_acct.territory_no 
      and sales_hist.facilityid = lawson_acct.facilityid) 
inner join crmadmin.t_whse_div_xref division 
     on division.swat_id = sales_hist.facilityid 
where sales_hist.billing_date between '2018-05-03' and '2018-06-30'
 and sales_hist.usds_flg = 'D'
-- Fuel GL account from PSFS
 and sales_hist.whol_sales_cd = '101' 
-- Fuel code from SWAT team
-- Get add-on lines and manual
 and sales_hist.final_sell_amt <> 0
 --and trim(division.region) <> 'MIDWEST'
 and sales_hist.PLATFORM_TYPE = 'SWAT'
;


--ADMIN FEE------------------------------------------------------------------------------------------------
Select count(*) from CRMADMIN.T_WHSE_SALES_HST_DC
where ORIGIN_ID = 'CRM-ADMN'
and TRANSACTION_DATE between '2018-05-03' and '2018-06-30'
;

--validate start
SELECT   FACILITYID, sum(EXT_FUEL_CHRGE_AMT) fuel , sum(EXT_LBL_CASE_CHRGE) admin
FROM     CRMADMIN.T_WHSE_SALES_HST_DC
WHERE    (facilityid = '005' and TRANSACTION_DATE between '2018-05-13' and '2018-06-30')
   OR    (facilityid <> '005' and TRANSACTION_DATE between '2018-05-03' and '2018-06-30')
group by FACILITYID 
;


SELECT   ORIGIN_ID, count(*)
FROM     CRMADMIN.T_WHSE_SALES_HST_DC
WHERE    TRANSACTION_DATE between '2018-05-13' and '2018-06-30'
and FACILITYID = '005' and EXT_LBL_CASE_CHRGE <> 0 
and ORIGIN_ID = 'CRM-SI'
group by ORIGIN_ID
;

--update CRM for Minot
update   CRMADMIN.T_WHSE_SALES_HST_DC set EXT_LBL_CASE_CHRGE = 0
WHERE    TRANSACTION_DATE between '2018-05-13' and '2018-06-30'
and FACILITYID = '005' and EXT_LBL_CASE_CHRGE <> 0 
and ORIGIN_ID = 'CRM-SI'
;
commit;

--validate datawhse02 for Minot
Select count(*) from whmgr.sb_dc_sales_hst
WHERE transaction_date between '05-13-2018' and '06-30-2018'
and facility_id = 5 and ext_admin_fee_amt <> 0 
and origin_id = 'CRM-SI'
;

--update datawhse02 for Minot
update   whmgr.sb_dc_sales_hst set ext_admin_fee_amt = 0
WHERE transaction_date between '05-13-2018' and '06-30-2018'
and facility_id = 5 and ext_admin_fee_amt <> 0 
and origin_id = 'CRM-SI'
;
commit;

--validate CRM for non-Minot
SELECT   ORIGIN_ID, count(*)
FROM     CRMADMIN.T_WHSE_SALES_HST_DC
WHERE    TRANSACTION_DATE between '2018-05-03' and '2018-06-30'
and FACILITYID in ('003', '008', '040', '054') and EXT_LBL_CASE_CHRGE <> 0 
and ORIGIN_ID = 'CRM-SI'
group by ORIGIN_ID
;

--update CRM for non-Minot
update   CRMADMIN.T_WHSE_SALES_HST_DC set EXT_LBL_CASE_CHRGE = 0
WHERE    TRANSACTION_DATE between '2018-05-03' and '2018-06-30'
and FACILITYID in ('003', '008', '040', '054') and EXT_LBL_CASE_CHRGE <> 0 
and ORIGIN_ID = 'CRM-SI'
;
commit;

--validate datawhse02 for non-Minot
Select count(*) from whmgr.sb_dc_sales_hst
WHERE transaction_date between '05-03-2018' and '06-30-2018'
and facility_id in (3, 8, 40, 54) and ext_admin_fee_amt <> 0 
and origin_id = 'CRM-SI'
;

--update datawhse02 for non-Minot
update   whmgr.sb_dc_sales_hst set ext_admin_fee_amt = 0
WHERE transaction_date between '05-03-2018' and '06-30-2018'
and facility_id in (3, 8, 40, 54) and ext_admin_fee_amt <> 0 
and origin_id = 'CRM-SI'
;
commit;


SELECT   *
FROM     CRMADMIN.T_WHSE_SALES_HST_DC
WHERE    TRANSACTION_DATE between '2018-05-03' and '2018-06-30'
and FACILITYID in ('003', '008', '040', '054') and EXT_LBL_CASE_CHRGE <> 0 
and ORIGIN_ID = 'CRM-NSI'
;

--validate $ for datawhse02
Select facility_id, sum(ext_fuel_chrge_amt) fuel, sum(ext_admin_fee_amt) admin
--from whmgr.dc_sales_hst
from whmgr.sb_dc_sales_hst
WHERE    (facility_id = '005' and TRANSACTION_DATE between '05-13-2018' and '06-30-2018')
   OR    (facility_id <> '005' and TRANSACTION_DATE between '05-03-2018' and '06-30-2018')
--where transaction_date  between '05-03-2018' and '06-30-2018'
group by facility_id
;

select 
sales_hist.facilityid,
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
0 qty_ordered,
0 qty_adjusted,
0 qty_sold,
0 qty_subbed,
0 qty_scratched,
sales_hist.out_reason_code,
0 fuel_chrge_amt,
0 deal_amt,
0 ad_allow_amt,
0 layer_ext_cost,
0 retail_price,
0 random_wgt,
0 ship_case_wgt,
sales_hist.vendor_nbr,
0 leakage_amt,
0 freight_amt,
sales_hist.booking_nbr, 	
0 mrkup_dllrs_per_ship_unt,
sales_hist.final_sell_amt as final_sell_amt,
0 lbl_case_chrge,
0 price_adjustment,
0 excise_tax,
0 other_sales_tax,
0 item_lvl_mrkup_amt_02,
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
0 qty_shipped,
0 qty_for_extension,
0 net_price_amt,
0 as mrkup,
0 srp_units,
sales_hist.platform_type,
sales_hist.credit_reason_cde
from 
crmadmin.v_whse_sales_history_dtl sales_hist
inner join CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN lawson_acct 
     on 
     (sales_hist.whol_sales_cd = lawson_acct.whol_sales_cd 
      and sales_hist.territory_no = lawson_acct.territory_no 
      and sales_hist.facilityid = lawson_acct.facilityid) 
inner join crmadmin.t_whse_div_xref division 
     on division.swat_id = sales_hist.facilityid 
left outer join etladmin.t_rtl_law_dept_xref rlxref 
    on division.platform_type = rlxref.platform_type and rlxref.rtl_dept = trim(sales_hist.cust_ovrrde_rtl_dept)
where lawson_acct.business_segment = '2'
 and usds_flg = 'D'
 and sales_hist.platform_type = 'SWAT'
 and sales_hist.NO_CHRGE_ITM_CDE = '*' 
 and sales_hist.ORDER_SOURCE = 'I'
 and sales_hist.ITEM_NBR_HS = '0099904'
-- Add-on invoice lines only (bottom of the regular SWAT invoice or manual invoice)
 and sales_hist.final_sell_amt <> 0
 and billing_date between '2018-05-03' and '2018-06-30'
 and trim(division.region) = 'MIDWEST'
;


SELECT TRANSACTION_DATE, INVOICE_DATE, DELIVERY_DATE, FACILITYID, FACILITYID_SHIP, CUSTOMER_NBR_STND, WHSE_CMDTY_ID, COMMODITY_CODE, BUYER_ID, VENDOR_NBR, ITEM_NBR_HS, MDSE_CLASS_KEY, INVOICE_NBR, PRESELL_NBR, ORDER_TYPE_CD, PRICE_ZONE_TYPE_CD, WHOL_SALES_CD, SALES_TYPE_CD, WHOLESALE_DEPT_ID, GL_ACCOUNT_NBR, ADV_BUYING_SYS_FLG, PRICING_EFF_DATE, SPECIAL_PRICE_FLG, ORDERED_QTY, ADJUSTED_QTY, SUBBED_QTY, SHIPPED_QTY, UNITS_LBS_WHSE_QTY, OUT_OF_STOCK_QTY, OUT_REASON_CD, EXT_RSU_CNT, EXT_MOVEMENT_WT, CASE_COST_AMT, EXT_CASE_COST_AMT, NET_COST_AMT, EXT_NET_COST_AMT, NET_PRICE_AMT, EXT_NET_PRICE_AMT, EXT_CUST_FEE_AMT, EXT_WHSE_SALES_AMT, EXT_LOST_SALES_AMT, EXT_RETAIL_AMT, EXT_FREIGHT_AMT, EXT_PALT_DISC_AMT, EXT_REFLECT_AMT, EXT_PROMO_ALLW_AMT, EXT_FUEL_CHRGE_AMT, EXT_LEAKAGE_AMT, EXT_CASH_DISC_AMT, EXT_PROFIT_AMT, EXT_FWD_PRICE_AMT, EXT_FWD_COST_AMT, EXT_ARDA_AMT, LOAD_BATCH_ID, ORIGIN_ID, PRVT_LBL_FLG, INVOICE_COUNTER, EXT_LBL_CASE_CHRGE, EXT_PRICE_ADJUSTMENT, EXT_EXCISE_TAX, EXT_CIG_TAX, CREDIT_REASON_CD
FROM #P_DB_CRM.Schema01#.T_WHSE_SALES_HST_DC 
WHERE 
TRANSACTION_DATE BETWEEN 
Case When '#P_DCSales.FromDate#' = 'Current Date' 
Then to_date(#P_DCSales.FromDate#,'yyyy-mm-dd')
Else to_date('#P_DCSales.FromDate#','yyyy-mm-dd')
End
AND 
Case When '#P_DCSales.ToDate#' = 'Current Date' 
Then to_date(#P_DCSales.ToDate#,'yyyy-mm-dd')
Else to_date('#P_DCSales.ToDate#','yyyy-mm-dd')
End
and ORIGIN_ID like 'FIX%'
;