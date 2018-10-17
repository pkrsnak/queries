--affected invoices?
SELECT   FACILITYID,
         INVOICE_NBR,
         BILLING_DATE,
         CUSTOMER_NBR_STND,
         sum(qty_shipped) tot_qty_shipped,
         sum(line_item_mkup) tot_line_item_mkup,
         sum(invoice_markup) tot_invoice_markup,
         sum(sales) tot_sales
from (

SELECT   FACILITYID,
         INVOICE_NBR,
         BILLING_DATE,
         CUSTOMER_NBR_STND,
         sum(QTY_SOLD - QTY_SCRATCHED) qty_shipped,
         sum((QTY_SOLD - QTY_SCRATCHED) * MRKUP_DLLRS_PER_SHIP_UNT) line_item_mkup,
         0 invoice_markup,
         sum((QTY_SOLD - QTY_SCRATCHED) * FINAL_SELL_AMT) sales
FROM     CRMADMIN.V_WHSE_SALES_HISTORY_DTL
WHERE    BILLING_DATE between '2017-08-20' and current date
--AND      TERRITORY_NO in (21, 27, 31)
AND      FACILITYID = '008'
AND      ITEM_DEPT = '035'
AND      NO_CHRGE_ITM_CDE <> '*'
GROUP BY FACILITYID, INVOICE_NBR, BILLING_DATE, CUSTOMER_NBR_STND
union all
SELECT   FACILITYID,
         INVOICE_NBR,
         BILLING_DATE,
         CUSTOMER_NBR_STND,
         0 qty_shipped,
         0 line_item_mkup,
         FINAL_SELL_AMT invoice_markup,
         0 sales
FROM     crmadmin.v_whse_sales_history_dtl
WHERE    BILLING_DATE between '2017-08-20' and current date
--AND      TERRITORY_NO in (21, 27, 31)
AND      FACILITYID = '008'
AND      (no_chrge_itm_cde = '*'
     AND order_source = 'I'
     AND item_description = 'ICE CREAM MARKUP')
)

group by FACILITYID,
         INVOICE_NBR,
         BILLING_DATE,
         CUSTOMER_NBR_STND
having sum(line_item_mkup) <> sum(invoice_markup)
;



SELECT   FACILITYID,
         INVOICE_NBR,
         BILLING_DATE,
         CUSTOMER_NO_FULL, WHOL_SALES_CD,
         ITEM_NBR_HS,
         ITEM_DESCRIPTION,
         QTY_ORDERED,
         QTY_ADJUSTED,
         QTY_SOLD,
         QTY_SUBBED,
         QTY_SCRATCHED,
         FINAL_SELL_AMT,
         MRKUP_DLLRS_PER_SHIP_UNT,
         ITEM_DEPT,
         ITEM_DEPT_HS
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL
WHERE    FACILITYID = '003'
and ITEM_NBR_HS = '0099908'
and TERRITORY_NO in (21, 27, 31)
--AND      INVOICE_NBR = 70208
--AND      BILLING_DATE = '2018-06-15'
AND      BILLING_DATE between '2018-06-17' and '2018-07-14'
and ITEM_DESCRIPTION = 'ICE CREAM MARKUP'
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
              else LEAKER_AMT_CALC 
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
         0 qty_shipped,
         0 qty_for_extension,
         0 net_price_amt,
         FINAL_SELL_AMT as mrkup,
         case 
              when srp_units = 0 then 1 
              when srp_units = null then 1 
              else srp_units 
         end srp_units,
         sales_hist.platform_type,
         sales_hist.credit_reason_cde
FROM     crmadmin.v_whse_sales_history_dtl sales_hist 
         inner join CRMADMIN.V_WHSE_LAWSON_ACCT_TO_SPLIT_GL_WSC_TN lawson_acct on (sales_hist.whol_sales_cd = lawson_acct.whol_sales_cd and sales_hist.territory_no = lawson_acct.territory_no and sales_hist.facilityid = lawson_acct.facilityid) 
         inner join crmadmin.t_whse_div_xref division on division.swat_id = sales_hist.facilityid
WHERE    lawson_acct.business_segment = '2'
AND      lawson_acct.SPLIT_GL_ACCOUNT in ('70230', '70240')
AND      (record_id = '6'
     OR  (no_chrge_itm_cde = '*'
        AND order_source = 'I'
        AND sales_hist.item_description = 'ICE CREAM MARKUP') )
AND      usds_flg = 'D'
--AND      billing_date between #FromDate# and #ToDate#
AND      billing_date between '2018-06-17' and '2018-07-14'