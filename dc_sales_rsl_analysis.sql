SELECT   shd.ORIGIN_ID,
         shd.FACILITYID,
         shd.SALES_TYPE_CD,
--         shd.TERRITORY_NO,
--         shd.WHOL_SALES_CD,
         shd.LAWSON_DEPT,
         sum(shd.SHIPPED_QTY) qty_shipped,
         sum(shd.EXT_FUEL_CHRGE_AMT) ext_fuel,
         sum(shd.EXT_FREIGHT_AMT) ext_freight,
         sum(shd.EXT_ARDA_AMT) ext_arda,
         sum(shd.EXT_ITEM_LVL_MRKUP_AMT_02) ext_q,
         sum(shd.EXT_LBL_CASE_CHRGE) ext_admin_fee,
         sum(shd.EXT_CUST_FEE_AMT) ext_cust_fee,
         sum(shd.EXT_EXCISE_TAX) ext_excise_tax,
         sum(shd.EXT_LEAKAGE_AMT) ext_leak_amt,
         sum(shd.EXT_NET_PRICE_AMT) ext_net_price,
         sum(shd.EXT_PURE_SELL) ext_pure_sell,
         sum(shd.EXT_REFLECT_AMT) ext_reflect_amt,
         sum(shd.EXT_PROMO_ALLW_AMT) ext_pa_amt,
         sum(shd.EXT_WHSE_SALES_AMT) ext_sales
FROM     CRMADMIN.T_WHSE_SALES_HST_DC_TEST shd 
         left outer join CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN axr on shd.FACILITYID = axr.FACILITYID and shd.TERRITORY_NO = axr.TERRITORY_NO and shd.WHOL_SALES_CD = axr.WHOL_SALES_CD
WHERE    shd.TRANSACTION_DATE between '10-01-2017' and '10-07-2017'
and shd.TERRITORY_NO in (21, 27, 31)
GROUP BY shd.ORIGIN_ID, 
         shd.FACILITYID, shd.SALES_TYPE_CD, 
--         shd.TERRITORY_NO, 
--         shd.WHOL_SALES_CD, 
         shd.LAWSON_DEPT
;