SELECT   shd.FACILITYID,
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.CUSTOMER_NBR_STND,
         shd.ITEM_NBR_HS,
         shd.ITEM_DESCRIPTION,
         shd.FINAL_SELL_AMT CREDIT_AMT,
         oshd.BILLING_DATE orig_billing_date,
         oshd.INVOICE_NBR orig_invoice_nbr,
         oshd.QTY_SOLD orig_qty_sold,
         oshd.QTY_SCRATCHED orig_qty_scratched,
         oshd.FINAL_SELL_AMT orig_final_sell,
         ((oshd.QTY_SOLD - oshd.QTY_SCRATCHED) * oshd.FINAL_SELL_AMT) orig_invoice_amt,
         (((oshd.QTY_SOLD - oshd.QTY_SCRATCHED) * oshd.FINAL_SELL_AMT) + shd.FINAL_SELL_AMT) credit_variance
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.T_WHSE_SALES_HISTORY_DTL oshd on shd.FACILITYID = oshd.FACILITYID and shd.CUSTOMER_NO_FULL = oshd.CUSTOMER_NO_FULL and oshd.INVOICE_NBR = shd.ORIGINIAL_INV_NBR and shd.ITEM_NBR_HS = oshd.ITEM_NBR_HS
WHERE    shd.BILLING_DATE = current date
AND      shd.ORDER_TYPE = 'CR'
AND      shd.FACILITYID = '058'
AND      oshd.BILLING_DATE between current date - 30 days and current date
AND      shd.INVOICE_NBR <> shd.ORIGINIAL_INV_NBR
AND      (((((oshd.QTY_SOLD - oshd.QTY_SCRATCHED) * oshd.FINAL_SELL_AMT) + shd.FINAL_SELL_AMT) < -.05)
     OR  ((((oshd.QTY_SOLD - oshd.QTY_SCRATCHED) * oshd.FINAL_SELL_AMT) + shd.FINAL_SELL_AMT) > .05));

SELECT   shd.FACILITYID,
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.CUSTOMER_NO_FULL,
         shd.CUSTOMER_NBR_STND,
         shd.ITEM_NBR_HS,
         shd.ITEM_DESCRIPTION,
         shd.QTY_SOLD,
         shd.QTY_SCRATCHED,
         shd.FINAL_SELL_AMT,
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
WHERE    shd.BILLING_DATE = '2019-05-28'
AND      shd.INVOICE_NBR = 2309400
AND      shd.FACILITYID = '058'
;
