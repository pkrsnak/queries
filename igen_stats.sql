SELECT   year(BILLING_DATE) fiscal_year,
         facilityid,
         ITEM_DEPT,
         count(distinct CUSTOMER_NBR_STND) num_customers,
         count(distinct INVOICE_NBR || BILLING_DATE) num_invoices,
         count(distinct item_nbr_hs) num_items,
         count(*) num_rows
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL
WHERE    NO_CHRGE_ITM_CDE <> '*'
AND      FACILITYID in ('066', '067')
GROUP BY  year(billing_date), FACILITYID, item_dept