--SQL Statements:
--create table ZZMD00 as
;
SELECT   bed.FACILITY_ID,
         i.BUYER_ID, a15.dept_key, --se.SHIP_ERROR_GRP_CD,bed.SHIP_ERROR_CD, bed.commodity_code,
         sum(bed.NOT_SHIP_CASE_QTY) buyer_outs
FROM     DC_BILL_ERROR_DTL bed 
         join DC_ITEM i on (bed.FACILITY_ID = i.FACILITY_ID and bed.ITEM_NBR = i.ITEM_NBR) 
         join MDSE_CLASS a13 on (i.MDSE_CLASS_KEY = a13.MDSE_CLASS_KEY) 
         join mdse_catgy a14 on (a13.mdse_catgy_key = a14.mdse_catgy_key) 
         join mdse_group a15 on (a14.mdse_grp_key = a15.mdse_grp_key) 
         inner join eisdw01@dss_prd_tcp:whmgr.ship_error se on (bed.SHIP_ERROR_CD = se.SHIP_ERROR_CD) 
         inner join fiscal_day fd on (bed.TRANSACTION_DATE = fd.SALES_DT) 
         inner join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
         inner join whmgr.dc_customer c on (bed.facility_id = c.facility_id and bed.customer_nbr = c.customer_nbr and c.corporation_id <> 634001)
WHERE    ((fw.end_dt = '12-07-2019')
     AND bed.FACILITY_ID in (1, 3, 8, 15, 40, 54, 58, 61, 66, 67, 71, 80, 90)
     AND bed.FACILITY_ID not in (16)
     AND bed.COMMODITY_CODE not in (900)
     AND se.SHIP_ERROR_GRP_CD in (1)
--     AND bed.SHIP_ERROR_CD = 'MK'
)
GROUP BY bed.FACILITY_ID, i.BUYER_ID, a15.dept_key --, se.SHIP_ERROR_GRP_CD,bed.SHIP_ERROR_CD, bed.commodity_code
;


--create table ZZSP02 as
SELECT   wsd.FACILITY_ID,
         i.BUYER_ID, a15.dept_key, wsd.commodity_code,
         sum(wsd.SHIP_CASE_QTY) SHIP_CASE_QTY
FROM     DC_WHSE_SHIP_DTL wsd 
         inner join DC_ITEM i on (wsd.FACILITY_ID = i.FACILITY_ID and wsd.ITEM_NBR = i.ITEM_NBR) 
         join MDSE_CLASS a13 on (i.MDSE_CLASS_KEY = a13.MDSE_CLASS_KEY) 
         join mdse_catgy a14 on (a13.mdse_catgy_key = a14.mdse_catgy_key) 
         join mdse_group a15 on (a14.mdse_grp_key = a15.mdse_grp_key) 
         inner join fiscal_day a16 on (wsd.TRANSACTION_DATE = a16.SALES_DT) 
         inner join fiscal_week a17 on (a16.FISCAL_WEEK_ID = a17.FISCAL_WEEK_ID)
         inner join whmgr.dc_customer c on (wsd.facility_id = c.facility_id and wsd.customer_nbr = c.customer_nbr and c.corporation_id <> 634001)
WHERE    (a17.end_dt = '12-07-2019'
     AND wsd.FACILITY_ID in (1, 3, 8, 15, 40, 54, 58, 61, 66, 67, 71, 80, 90)
     AND wsd.FACILITY_ID not in (16)
     AND wsd.COMMODITY_CODE not in (900))
GROUP BY wsd.FACILITY_ID, i.BUYER_ID, a15.dept_key, wsd.commodity_code
;


select * from eisdw01@dss_prd_tcp:whmgr.ship_error
;


--cases ordered by buyer
--source:  datawhse02

select SCORECARD_TYPE, DIVISION_ID, 'cases_ordered' KPI_TYPE, DATA_GRANULARITY, TIME_GRANULARITY, KPI_DATE, KPI_KEY_VALUE, sum(KPI_DATA_VALUE) KPI_DATA_VALUE
from
(
SELECT   'buyer' SCORECARD_TYPE,
         2 DIVISION_ID,
--         'cases_out' KPI_TYPE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         a14.END_DT KPI_DATE,
         Trim(a12.BUYER_ID) AS KPI_KEY_VALUE,
         sum(a11.NOT_SHIP_CASE_QTY) KPI_DATA_VALUE
FROM     whmgr.DC_BILL_ERROR_DTL a11 
         join whmgr.DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR) 
        join whmgr.dc_customer cust on (cust.facility_id = a11.facility_id and cust.customer_nbr = a11.customer_nbr and cust.corporation_id not in (634001)) 
         join whmgr.fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join whmgr.fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
         left outer join eisdw01@dss_prd_tcp:SHIP_ERROR a15 on (a11.SHIP_ERROR_CD = a15.SHIP_ERROR_CD) 
WHERE    (a14.END_DT = DATE('12/08/2019') - (WEEKDAY(DATE('12/08/2019')) + 1) UNITS DAY --need to determine prior week Saturday date
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900)
     AND a15.SHIP_ERROR_GRP_CD not in (6))
GROUP BY a14.end_dt, a12.BUYER_ID
ORDER BY a14.end_dt, a12.BUYER_ID

union all

--cases shipped by buyer
--source:  datawhse02
SELECT   'buyer' SCORECARD_TYPE,
         2 DIVISION_ID,
--         'cases_shipped' KPI_TYPE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         a14.END_DT KPI_DATE,
         Trim(a12.BUYER_ID) AS KPI_KEY_VALUE,
         sum(a11.SHIP_CASE_QTY) KPI_DATA_VALUE
FROM     whmgr.DC_WHSE_SHIP_DTL a11 
         join whmgr.DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR) 
         join whmgr .dc_customer cust on (cust.facility_id = a11.facility_id and cust.customer_nbr = a11.customer_nbr and cust.corporation_id not in (634001)) 
         join whmgr.fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join whmgr.fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE   a14.END_DT = DATE('12/08/2019') - (WEEKDAY(DATE('12/08/2019')) + 1) UNITS DAY  --need to determine prior week Saturday date
AND a11.FACILITY_ID not in (16)
AND a11.COMMODITY_CODE not in (900)
GROUP BY a14.END_DT, a12.BUYER_ID
--ORDER BY a14.END_DT, a12.BUYER_ID
)
group by 1,2,4,5,6,7
;

--Cases Outed – 

--cases outed by buyer
--source:  datawhse02
SELECT   'buyer' SCORECARD_TYPE,
         2 DIVISION_ID,
         'cases_out' KPI_TYPE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         a14.END_DT KPI_DATE,
         Trim(a12.BUYER_ID) AS KPI_KEY_VALUE,
         sum(a11.NOT_SHIP_CASE_QTY) KPI_DATA_VALUE
FROM     whmgr.DC_BILL_ERROR_DTL a11 
         join whmgr.DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR) 
        join whmgr.dc_customer cust on (cust.facility_id = a11.facility_id and cust.customer_nbr = a11.customer_nbr and cust.corporation_id not in (634001)) 
         join whmgr.fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join whmgr.fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
         left outer join eisdw01@dss_prd_tcp:SHIP_ERROR a15 on (a11.SHIP_ERROR_CD = a15.SHIP_ERROR_CD) 
WHERE    (a14.END_DT = '12-07-2019' --need to determine prior week Saturday date
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900)
     AND a15.SHIP_ERROR_GRP_CD in (1))
GROUP BY a14.end_dt, a12.BUYER_ID
ORDER BY a14.end_dt, a12.BUYER_ID
;
