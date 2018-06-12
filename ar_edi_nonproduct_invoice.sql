SELECT   shd.FACILITYID,
         shd.CUSTOMER_NO_FULL,
         c.NAME,
         shd.WHOL_SALES_CD,
         shd.INVOICE_NBR,
         wsc.WSC_DESCRIPTION,
         shd.BILLING_DATE,
         shd.NO_CHRGE_ITM_CDE, sum(shd.QTY_SOLD) qty, 
         sum(shd.FINAL_SELL_AMT) sales_amt
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.T_WHSE_WSC wsc on shd.WHOL_SALES_CD = wsc.WHOL_SALES_CD 
         inner join CRMADMIN.T_WHSE_CUST c on shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL and shd.FACILITYID = c.FACILITYID
WHERE    BILLING_DATE > '2016-01-01'
--AND      shd.FACILITYID = '058'
AND      shd.ORDER_TYPE in ('OO', 'OR')
AND      shd.EDI_SEND_DATE is not null
AND      shd.WHOL_SALES_CD <> '000'
GROUP BY shd.FACILITYID, shd.CUSTOMER_NO_FULL, c.NAME, shd.WHOL_SALES_CD, 
         shd.INVOICE_NBR, wsc.WSC_DESCRIPTION, shd.BILLING_DATE, 
         shd.NO_CHRGE_ITM_CDE
;




SELECT   shd.FACILITYID,
         shd.CUSTOMER_NO_FULL,
         c.NAME,
         shd.WHOL_SALES_CD, shd.ITEM_NBR, shd.ITEM_DESCRIPTION, shd.OUT_REASON_CODE,
         shd.INVOICE_NBR,
         wsc.WSC_DESCRIPTION,
         shd.BILLING_DATE,
         shd.NO_CHRGE_ITM_CDE, 
         shd.QTY_SOLD,
         shd.FINAL_SELL_AMT
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.T_WHSE_WSC wsc on shd.WHOL_SALES_CD = wsc.WHOL_SALES_CD 
         inner join CRMADMIN.T_WHSE_CUST c on shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL and shd.FACILITYID = c.FACILITYID
WHERE    BILLING_DATE > '2016-07-01'
AND      shd.FACILITYID = '058'
AND      EDI_SEND_DATE is not null
and shd.INVOICE_NBR = 1961344
--AND      shd.WHOL_SALES_CD = '000'
--GROUP BY shd.FACILITYID, shd.CUSTOMER_NO_FULL, c.NAME, shd.WHOL_SALES_CD, 
--         shd.INVOICE_NBR, wsc.WSC_DESCRIPTION, shd.BILLING_DATE, 
--         shd.NO_CHRGE_ITM_CDE
