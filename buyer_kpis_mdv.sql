
--slotted items by buyer
--source:  mdvods

----Comments

SELECT   'buyer' SCORECARD_TYPE,
         'slotted_items' KPI_TYPE,
         'NEED WEEK_END_DATE' DATE_VALUE,  --need to run on Saturday week end date (then plug that value in DATE_VALUE)
         3 DIVISION_ID,
--         FACILITYID FACILITY_ID,
         buyer_id KEY_VALUE,
         count(*) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     whmgr.mdv_item
WHERE   slot_id is not null
AND      slot_id <> ''
GROUP BY buyer_id 
;

--cases ordered by buyer
--source:  eisdw01
SELECT   'buyer' SCORECARD_TYPE,
         'cases_ordered' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         i.BUYER_ID KEY_VALUE,
--         sum(sls.SHIP_QTY) DATA_VALUE,
         sum(sls.ORDER_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) 
WHERE    fw.end_dt = '10-05-2019'  --sales_catgy_code???? est vs final
GROUP BY fw.end_dt, i.buyer_id
;

--cases shipped by buyer
--source:  eisdw01
SELECT   'buyer' SCORECARD_TYPE,
         'cases_shipped' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         i.BUYER_ID KEY_VALUE,
         sum(sls.SHIP_QTY) DATA_VALUE,
--         sum(sls.ORDER_QTY) DATA_VALUE1,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) 
WHERE    fw.end_dt = '10-05-2019'  --sales_catgy_code???? est vs final
GROUP BY fw.end_dt, i.buyer_id
;




--cases out by buyer
--source:  eisdw01
SELECT   'buyer' SCORECARD_TYPE,
         'cases_out' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         i.BUYER_ID KEY_VALUE,
--         sls.ship_error_cd,
         sum(sls.ORDER_QTY - sls.SHIP_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) 
WHERE    fw.end_dt = '10-05-2019'
  AND    sls.ship_error_cd in ('NEW', 'OOS', 'TMP')  --sales_catgy_code???? est vs final
GROUP BY fw.end_dt, i.buyer_id 
;

--cases shipped (promo) by buyer
--source:  eisdw01

--cases ordered (promo) by buyer
--source:  eisdw01

--sales by buyer
--source:  eisdw01
SELECT   'buyer' SCORECARD_TYPE,
         'sales' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         i.BUYER_ID KEY_VALUE,
--         sls.ship_error_cd,
         sum(sls.tot_order_line_amt) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) 
WHERE    fw.end_dt = '10-05-2019'
  AND    sls.ship_error_cd in ('NEW', 'OOS', 'TMP')  --sales_catgy_code???? est vs final
GROUP BY fw.end_dt, i.buyer_id 
;


--starting inventory
--source:  CRM

--see fd file



--ending inventory
--source:  CRM

--see fd file
