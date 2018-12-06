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
         sales_hist.buyer_nbr, sales_hist.CUST_OVRRDE_RTL_DEPT,
         sales_hist.out_reason_code,
         sales_hist.vendor_nbr,
         sales_hist.booking_nbr,
         sales_hist.final_sell_amt as final_sell_amt,
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
         sales_hist.platform_type,
         sales_hist.credit_reason_cde
FROM     crmadmin.v_whse_sales_history_dtl sales_hist 
         inner join ( select FACILITYID, WHOL_SALES_CD, TERRITORY_NO, lawson_account, lawson_dept from CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN where business_segment = '2' and lawson_account not in ('50000','50005','50007','50040','50047','53010','54500') and (FACILITYID, WHOL_SALES_CD, TERRITORY_NO) not in (select FACILITYID, WHOL_SALES_CD, TERRITORY_NO from CRMADMIN.V_WHSE_LAWSON_ACCT_TO_SPLIT_GL_WSC_TN where business_segment = '2' and SPLIT_GL_ACCOUNT = '95520' ) ) lawson_acct on (sales_hist.whol_sales_cd = lawson_acct.whol_sales_cd and sales_hist.territory_no = lawson_acct.territory_no and sales_hist.facilityid = lawson_acct.facilityid) 
         inner join crmadmin.t_whse_div_xref division on division.swat_id = sales_hist.facilityid
WHERE    sales_hist.whol_sales_cd = '031'
AND      usds_flg = 'D'
AND      sales_hist.ORDER_TYPE in ('OO', 'OR')
AND      sales_hist.final_sell_amt <> 0
AND      billing_date between '2018-08-25' and current date
;


SELECT   FACILITYID, WHOLESALE_DEPT_ID, CUSTOMER_NBR_STND, MRKUP_SPREAD_FLG, ORDER_TYPE_CD, 
         ORIGIN_ID,
         TRANSACTION_DATE,
         INVOICE_NBR,
         sum(EXT_FREIGHT_AMT) freight
FROM     CRMADMIN.T_WHSE_SALES_HST_DC
WHERE    TRANSACTION_DATE >= '2018-07-01'
--WHERE    TRANSACTION_DATE = '2018-05-30'
AND      FACILITYID in ('003') --, '058')
--AND      ORIGIN_ID = 'CRM-FRGT'
--AND      ORIGIN_ID = 'CRM-SI'
AND TERRITORY_NO in (21, 27, 31)
--and CUSTOMER_NBR_STND = 3103
and not (ORIGIN_ID = 'CRM-FRGT' and ORDER_TYPE_CD not in ('OO', 'OR'))
GROUP BY FACILITYID, WHOLESALE_DEPT_ID, CUSTOMER_NBR_STND, MRKUP_SPREAD_FLG, ORDER_TYPE_CD, ORIGIN_ID, TRANSACTION_DATE, INVOICE_NBR
HAVING   sum(EXT_FREIGHT_AMT) <> 0
;

SELECT   FACILITYID,
         TRANSACTION_DATE,
         count(*) num_rows
FROM     CRMADMIN.T_WHSE_SALES_HST_DC
WHERE    PLATFORM_TYPE = 'SWAT'
AND      ORIGIN_ID = 'CRM-FRGT'
AND      ORDER_TYPE_CD not in ('OO', 'OR')
group by FACILITYID,
         TRANSACTION_DATE
         
;


Select * from whmgr.dc_sales_hst where transaction_date between '01-01-2017' and '06-30-2018' and origin_id = 'CRM-FRGT' and ORDER_TYPE_CD not in ('OO', 'OR')
;

--delete...dw02
Select count(*) from whmgr.dc_sales_hst where transaction_date between '05-14-2018' and '06-30-2018' and ORIGIN_ID = 'CRM-FRGT' and ORDER_TYPE_CD not in ('OO', 'OR') and facility_id = 5 
;

delete from whmgr.dc_sales_hst where transaction_date between '01-31-2018' and '06-30-2018' and ORIGIN_ID = 'CRM-FRGT' and ORDER_TYPE_CD not in ('OO', 'OR') --and facility_id = 5
;

commit;

--delete...netezza
delete from wh_owner.dc_sales_hst where transaction_date between '01-31-2018' and '06-30-2018' and ORIGIN_ID = 'CRM-FRGT' and ORDER_TYPE_CD not in ('OO', 'OR') --and facility_id = 5
;

commit;

--delete...crm
delete from CRMADMIN.T_WHSE_SALES_HST_DC where TRANSACTION_DATE between '2018-01-31' and '2018-07-18' and ORIGIN_ID = 'CRM-FRGT' and ORDER_TYPE_CD not in ('OO', 'OR')
and PLATFORM_TYPE = 'SWAT' ;

commit;


