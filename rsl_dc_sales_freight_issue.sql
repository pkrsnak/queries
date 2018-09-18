SELECT   *
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL
WHERE    FACILITYID = '008'
AND      INVOICE_NBR in (462273, 456694, 451080)
;


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
AND      billing_date between '2018-08-01' and '2018-09-05'