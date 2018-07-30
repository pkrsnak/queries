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
