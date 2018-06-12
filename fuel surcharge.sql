SELECT   shd.FACILITYID,
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.CUSTOMER_NO,
         shd.STORE_CITY,
         SUM(CASE WHEN SHD.OUT_REASON_CODE IN ('004', '011') THEN 0 ELSE (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END) TOT_QTY_SHIPPED,
         SUM(case when shd.ITEM_NBR_HS = '0099903' then shd.FINAL_SELL_AMT else 0 end) fuel_surcharge_amt,
         SUM(shd.FUEL_CHRGE_AMT) ext_fuel_chrge_amt,
         SUM(shd.FREIGHT_AMT * (CASE WHEN SHD.OUT_REASON_CODE IN ('004', '011') THEN 0 ELSE (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END)) ext_freight_amt,
         SUM(shd.FREIGHT_AMT_2) ext_freight_amt_2,
         SUM(shd.FREIGHT_FEE) ext_freight_fee,
         SUM(shd.CASE_CUBE * (CASE WHEN SHD.OUT_REASON_CODE IN ('004', '011') THEN 0 ELSE (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END)) ext_cube,
         SUM(shd.EXT_RANDOM_WGT)ext_random_weight,
         SUM(case when shd.RANDOM_WGT_FLG = 'R' then shd.RANDOM_WGT * (CASE WHEN SHD.OUT_REASON_CODE IN ('004', '011') THEN 0 ELSE (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END) else shd.SHIP_CASE_WGT * (CASE WHEN SHD.OUT_REASON_CODE IN ('004', '011') THEN 0 ELSE (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END) END) ext_net_weight
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd
WHERE    shd.BILLING_DATE between '2005-12-31' and '2007-12-29'
AND      shd.FACILITYID = '063'
AND      shd.CUSTOMER_NO = '4041'
--and      shd.INVOICE_NBR = 271252
and      shd.ORDER_SOURCE not in ('I')
--AND      ITEM_NBR_HS = '0099903'
group by shd.FACILITYID,
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.CUSTOMER_NO,
         shd.STORE_CITY;
         
         
select shd.FACILITYID,
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.CUSTOMER_NO,
         shd.STORE_CITY,
		 SHD.OUT_REASON_CODE,
		 SHD.ORDER_TYPE,
		 shd.QTY_ORDERED,
		 shd.QTY_ADJUSTED,
		 shd.QTY_SUBBED,
		 SHD.QTY_SOLD,
		 SHD.QTY_SCRATCHED,
		 shd.ITEM_NBR_HS,
		 shd.FINAL_SELL_AMT,
		 shd.FUEL_CHRGE_AMT,
         shd.FREIGHT_AMT,
         shd.FREIGHT_AMT_2,
         shd.FREIGHT_FEE,
         shd.CASE_CUBE,
         shd.RANDOM_WGT_FLG,
         shd.RANDOM_WGT,
         shd.SHIP_CASE_WGT
from crmadmin.t_whse_sales_history_dtl shd
where shd.INVOICE_NBR = 271252
  and shd.CUSTOMER_NO = '4041'
  and shd.facilityid = '063'
  and shd.ORDER_SOURCE not in ('I')
  