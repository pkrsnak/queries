
--datawhse02
SELECT   facility_id,
         sum(total_sales_amt)
FROM     whmgr.dc_sales_hst
WHERE    transaction_date = '01-15-2018'
GROUP BY facility_id
;

--crm
SELECT   BILLING_DATE,
         FACILITYID,
         sum(QTY_SOLD - QTY_SCRATCHED),
         sum((QTY_SOLD - QTY_SCRATCHED) * FINAL_SELL_AMT)
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL
WHERE    BILLING_DATE = current date
GROUP BY BILLING_DATE, FACILITYID
;