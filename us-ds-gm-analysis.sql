SELECT   shd.FACILITYID,
         dx.DIV_NAME, fc.FISCAL_PERIOD, 
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.CUSTOMER_NBR_STND,
         c.NAME,
         sum(shd.QTY_SOLD - shd.QTY_SCRATCHED) qty_shipped,
         sum(case when shd.FACILITYID = shd.FACILITYID_SHIP then shd.QTY_SOLD - shd.QTY_SCRATCHED else 0 end) qty_shipped_ds,
         sum(case when shd.FACILITYID <> shd.FACILITYID_SHIP then shd.QTY_SOLD - shd.QTY_SCRATCHED else 0 end) qty_shipped_us,
         0 qty_shipped_gm
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on shd.FACILITYID = dx.SWAT_ID 
         inner join CRMADMIN.V_FISCAL_CALENDAR fc on fc.DATE_KEY = shd.BILLING_DATE 
         inner join CRMADMIN.T_WHSE_CUST c on shd.FACILITYID = c.FACILITYID and shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL
WHERE    fc.FISCAL_PERIOD between 202101 and 202105
AND      shd.FACILITYID not in ('002', '071', '016', '061', '066', '067', '085', '054')
AND      (shd.QTY_SOLD - shd.QTY_SCRATCHED) >= 0
and shd.NO_CHRGE_ITM_CDE not in '*'
GROUP BY shd.FACILITYID, dx.DIV_NAME, fc.FISCAL_PERIOD, shd.INVOICE_NBR, shd.BILLING_DATE, 
         shd.CUSTOMER_NBR_STND, c.NAME

union all
--must do '054'
SELECT   cf.FACILITYID,
         dx.DIV_NAME, fc.FISCAL_PERIOD, 
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.CUSTOMER_NBR_STND,
         c.NAME,
         sum(shd.QTY_SOLD - shd.QTY_SCRATCHED) qty_shipped,
         0 qty_shipped_ds,
         0 qty_shipped_us,
         sum(shd.QTY_SOLD - shd.QTY_SCRATCHED) qty_shipped_gm
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.V_FISCAL_CALENDAR fc on fc.DATE_KEY = shd.BILLING_DATE 
         inner join CRMADMIN.T_WHSE_CUST c on shd.FACILITYID = c.FACILITYID and shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC cf on cf.CUSTOMER_NBR_STND = shd.CUSTOMER_NBR_STND and cf.FACILITYID_PRIMARY = 'Y'
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cf.FACILITYID = dx.SWAT_ID 
WHERE    fc.FISCAL_PERIOD between 202101 and 202105
AND      shd.FACILITYID = ('054')
AND      (shd.QTY_SOLD - shd.QTY_SCRATCHED) >= 0
and shd.NO_CHRGE_ITM_CDE not in '*'
GROUP BY cf.FACILITYID, dx.DIV_NAME, fc.FISCAL_PERIOD, shd.INVOICE_NBR, shd.BILLING_DATE, 
         shd.CUSTOMER_NBR_STND, c.NAME
;