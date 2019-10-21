--------------------------------------------------Food Distribution-------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--slotted items by buyer
--source:  CRM
SELECT   'SLOTTED_ITEMS' KPI_TYPE,
         'NEED WEEK_END_DATE' DATE_VALUE,
         1 ENTERPRISE_ID,
         FACILITYID FACILITY_ID,
         BUYER_NBR BUYER_ID,
         count(*) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    PURCH_STATUS not in ('D', 'Z')
AND      CURRENT_LOCATION is not null
AND      CURRENT_LOCATION <> ''
GROUP BY FACILITYID, BUYER_NBR
;

--cases shipped by buyer
--source:  Netezza
SELECT   'CASES_SHIPPED' KPI_TYPE,
         a14.end_dt DATE_VALUE,
         1 ENTERPRISE_ID,
         a11.FACILITY_ID FACILITY_ID,
         a12.BUYER_ID BUYER_ID,
         sum(a11.SHIP_CASE_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     DC_WHSE_SHIP_DTL a11 
         join DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR) 
         join fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    (a14.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy')
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900))
GROUP BY a14.end_dt, a11.FACILITY_ID, a12.BUYER_ID
;

--cases outed by buyer
--source:  Netezza
SELECT   'CASES_OUT' KPI_TYPE,
         a14.end_dt DATE_VALUE,
         1 ENTERPRISE_ID,
         a11.FACILITY_ID FACILITY_ID,
         a12.BUYER_ID BUYER_ID,
         sum(a11.NOT_SHIP_CASE_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WH_OWNER.DC_BILL_ERROR_DTL a11 
         join WH_OWNER.DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR) 
         join WH_OWNER.fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join WH_OWNER.fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
         left outer join WH_OWNER.SHIP_ERROR a15 on (a11.SHIP_ERROR_CD = a15.SHIP_ERROR_CD) 
WHERE    (a14.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy')
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900)
     AND (a11.SHIP_ERROR_CD = 'MK'))
OR       (a14.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy')
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900)
     AND a15.SHIP_ERROR_GRP_CD not in (6))
GROUP BY a14.end_dt, a11.FACILITY_ID, a12.BUYER_ID
;

--promo fillrate (pure fillrate for items on oi / rpa)

--?????????????????????????????


--sales by buyer
--source:  Netezza
SELECT   'SALES' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         1 ENTERPRISE_ID,
         sh.FACILITY_ID FACILITY_ID,
         sh.BUYER_ID BUYER_ID,
         sum(sh.TOTAL_SALES_AMT) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WH_OWNER.DC_SALES_HST sh 
         join WH_OWNER.fiscal_day fd on (sh.TRANSACTION_DATE = fd.SALES_DT) 
         join WH_OWNER.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy')
     AND sh.FACILITY_ID not in (16)
group by fw.end_dt,
         sh.FACILITY_ID,
         sh.BUYER_ID
;

--starting inventory
--source:  CRM
SELECT   'STARTING_INVENTORY' KPI_TYPE,
         lh.LAYER_FILE_DTE DATE_VALUE,
         1 ENTERPRISE_ID,
         lh.FACILITYID FACILITY_ID,
         lh.BUYER_NBR BUYER_ID,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD = 'R' then lh.SHIPPING_CASE_WEIGHT else 1 end))) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
WHERE    LAYER_FILE_DTE = date('2019-10-05') - 7 days
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.BUYER_NBR
;




--ending inventory
--source:  CRM
SELECT   'ENDING_INVENTORY' KPI_TYPE,
         lh.LAYER_FILE_DTE DATE_VALUE,
         1 ENTERPRISE_ID,
         lh.FACILITYID FACILITY_ID,
         lh.BUYER_NBR BUYER_ID,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD = 'R' then lh.SHIPPING_CASE_WEIGHT else 1 end))) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
WHERE    LAYER_FILE_DTE = '2019-10-05'
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.BUYER_NBR
;


--excess inventory       ------------------------INCOMPLETE---------------------------
--source:  CRM
SELECT   'EXCESS_INVENTORY' KPI_TYPE,
         lh.LAYER_FILE_DTE DATE_VALUE,
         1 ENTERPRISE_ID,
         lh.FACILITYID FACILITY_ID,
         lh.BUYER_NBR BUYER_ID,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD = 'R' then lh.SHIPPING_CASE_WEIGHT else 1 end))) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
WHERE    LAYER_FILE_DTE = '2019-10-05'
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.BUYER_NBR
;


--po lines
--source:  CRM
SELECT   'PO_LINES' KPI_TYPE,
         '2019-10-05' DATE_VALUE,
         1 ENTERPRISE_ID,
         i.FACILITYID FACILITY_ID,
         pod.BUYER_NBR,
         count(*) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_PO_DTL pod inner join CRMADMIN.T_WHSE_ITEM i on pod.ITEM_FAC = i.BICEPS_DC and pod.ITEM_NBR = i.ITEM_NBR
WHERE    pod.DATE_ORDERED between '2019-09-29' and '2019-10-05'
GROUP BY i.FACILITYID, pod.BUYER_NBR
;


--turns
--source:  CALC from above

;


--aged inventory
--source:  CRM
;

--at risk inventory
--source:  CRM



--------------------------------------------------         MDV     -------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
