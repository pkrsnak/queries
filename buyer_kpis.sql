--------------------------------------------------Food Distribution-------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--testing extract

SELECT   kd.SCORECARD_TYPE,
         kd.ENTERPRISE_ID,
         kd.KPI_TYPE,
         kd.DATA_GRANULARITY,
         kd.TIME_GRANULARITY,
         kd.KPI_DATE,
         kd.KPI_KEY_VALUE,
         b.LAST_NAME,
         b.FIRST_NAME,
         kd.KPI_DATA_VALUE
FROM     KPIADMIN.T_KPI_DETAIL kd 
         left join CRMADMIN.V_WEB_BUYER b on kd.KPI_KEY_VALUE = b.BUYER_NBR
and kd.TIME_GRANULARITY = 'W'
;


--------------------------------------------------Food Distribution-------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--slotted items by buyer
--source:  CRM

----Comments

SELECT   'buyer' SCORECARD_TYPE,
         'slotted_items' KPI_TYPE,
         'NEED WEEK_END_DATE' DATE_VALUE,  --need to run on Saturday week end date (then plug that value in DATE_VALUE)
         2 DIVISION_ID,
--         FACILITYID FACILITY_ID,
         BUYER_NBR KEY_VALUE,
         count(*) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    PURCH_STATUS not in ('D', 'Z')
AND      CURRENT_LOCATION is not null
AND      CURRENT_LOCATION <> ''
GROUP BY --FACILITYID, 
         BUYER_NBR
;

--cases shipped by buyer
--source:  datawhse02
SELECT   'buyer' SCORECARD_TYPE,
         'cases_shipped' KPI_TYPE,
         a14.end_dt DATE_VALUE,
         2 DIVISION_ID,
--         a11.FACILITY_ID FACILITY_ID,
         a12.BUYER_ID KEY_VALUE,
         sum(a11.SHIP_CASE_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_WHSE_SHIP_DTL a11 
         join WHMGR.DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR)
         join WHMGR.dc_customer cust on (cust.facility_id = a11.facility_id and cust.customer_nbr = a11.customer_nbr and cust.corporation_id not in (634001, 248561)) 
         join WHMGR.fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join WHMGR.fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    (a14.end_dt = '10-05-2019'  --To_Date('10/05/2019', 'mm/dd/yyyy')  --need to determine prior week Saturday date
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900))
GROUP BY a14.end_dt, 
--         a11.FACILITY_ID, 
         a12.BUYER_ID
;

--cases ordered by buyer
--source:  datawhse02
SELECT   'buyer' SCORECARD_TYPE,
         'cases_ordered' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         2 DIVISION_ID,
--         dsh.FACILITY_ID FACILITY_ID,
         dsh.BUYER_ID KEY_VALUE,
         sum(dsh.ordered_qty) DATA_VALUE,
--         sum(dsh.adjusted_qty) DATA_VALUE2,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.dc_sales_hst dsh 
         join WHMGR.DC_ITEM di on (dsh.FACILITY_ID = di.FACILITY_ID and dsh.ITEM_NBR = di.ITEM_NBR) 
         join WHMGR.dc_customer cust on (cust.facility_id = dsh.facility_id and cust.customer_nbr = dsh.customer_nbr and cust.corporation_id not in (634001, 248561)) 
         join WHMGR.fiscal_day fd on (dsh.TRANSACTION_DATE = fd.SALES_DT) 
         join WHMGR.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    (fw.end_dt = '11-02-2019'  --To_Date('10/05/2019', 'mm/dd/yyyy')  --need to determine prior week Saturday date
     AND dsh.FACILITY_ID not in (16)
     AND dsh.COMMODITY_CODE not in (900))
GROUP BY fw.end_dt, 
--         dsh.FACILITY_ID, 
         dsh.BUYER_ID
;

/*
Select ((select sum(not_ship_case_qty)
from dc_bill_error_dtl, dc_customer, dc_corporation
where  ship_error_cd not in ( '003', '004', '005', '006', '011', '013', '014',
'015', '018', '022', '024', '025', '026', '027', '028', '029', '041', '106',
'113', '121', '126', '141', 'DI', 'NA')
and transaction_date = '11/06/2019'
and dc_bill_error_dtl.facility_id = dc_customer.facility_id
and dc_bill_error_dtl.customer_nbr = dc_customer.customer_nbr
and dc_customer.corporation_id = dc_corporation.corporation_id
and dc_bill_error_dtl.facility_id not in (16, 2, 71)) +

((select sum(ship_case_qty)
from dc_whse_ship_dtl,dc_customer, dc_corporation
where dc_whse_ship_dtl.transaction_date = '11/06/2019'
and dc_whse_ship_dtl.facility_id = dc_customer.facility_id
and dc_whse_ship_dtl.customer_nbr = dc_customer.customer_nbr
and dc_customer.corporation_id = dc_corporation.corporation_id
and dc_whse_ship_dtl.facility_id not in (16, 2, 71)) -

(select sum(not_ship_case_qty)
from dc_bill_error_dtl, dc_customer, dc_corporation
where  ship_error_cd in ( 'MK')
and transaction_date = '11/06/2019'
and dc_bill_error_dtl.facility_id = dc_customer.facility_id
and dc_bill_error_dtl.customer_nbr = dc_customer.customer_nbr
and dc_customer.corporation_id = dc_corporation.corporation_id
and dc_bill_error_dtl.facility_id not in (16, 2, 71)))) as  cases_ordered
*/

--cases outed by buyer
--source:  datawhse02 & eisdw01
SELECT   'buyer' SCORECARD_TYPE,
         'cases_out' KPI_TYPE,
         a14.end_dt DATE_VALUE,
         2 DIVISION_ID,
--         a11.FACILITY_ID FACILITY_ID,
         a12.BUYER_ID KEY_VALUE,
         sum(a11.NOT_SHIP_CASE_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_BILL_ERROR_DTL a11 
         join WHMGR.DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR) 
         join WHMGR.dc_customer cust on (cust.facility_id = a11.facility_id and cust.customer_nbr = a11.customer_nbr and cust.corporation_id not in (634001, 248561)) 
         join WHMGR.fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join WHMGR.fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
         left outer join WHMGR.SHIP_ERROR a15 on (a11.SHIP_ERROR_CD = a15.SHIP_ERROR_CD) 
WHERE    (a14.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy')  --need to determine prior week Saturday date
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900)
     AND (a11.SHIP_ERROR_CD = 'MK'))
OR       (a14.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy') --need to determine prior week Saturday date
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900)
     AND a15.SHIP_ERROR_GRP_CD not in (6))
GROUP BY a14.end_dt, 
--         a11.FACILITY_ID, 
         a12.BUYER_ID
;

--promo fillrate (pure fillrate for items on oi / rpa)


--cases shipped (promo) by buyer
--source:  datawhse02
SELECT   'buyer' SCORECARD_TYPE,
         'cases_shipped_promo' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         2 DIVISION_ID,
         sh.FACILITY_ID FACILITY_ID,
         i.BUYER_ID KEY_VALUE,
         sum(sh.SHIPPED_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_SALES_HST sh 
         join WHMGR.DC_ITEM i on (sh.FACILITY_ID = i.FACILITY_ID and sh.ITEM_NBR = i.ITEM_NBR) 
         join WHMGR.dc_customer cust on (cust.facility_id = sh.facility_id and cust.customer_nbr = sh.customer_nbr and cust.corporation_id not in (634001, 248561)) 
         join WHMGR.fiscal_day fd on (sh.TRANSACTION_DATE = fd.SALES_DT) 
         join WHMGR.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    (fw.end_dt = '11-09-2019'  --need to determine prior week Saturday date
     AND sh.FACILITY_ID not in (16)
     AND sh.COMMODITY_CODE not in (900))
     AND (sh.ext_reflect_amt > 0 or sh.ext_promo_allw_amt > 0 or sh.PRESELL_NBR >0 )
GROUP BY fw.end_dt, 
         sh.FACILITY_ID, 
         i.BUYER_ID
;



--cases outed (promo) by buyer
--source:  datawhse02
SELECT   'buyer' SCORECARD_TYPE,
         'cases_ordered_promo' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         2 DIVISION_ID,
--         sh.FACILITY_ID FACILITY_ID,
         i.BUYER_ID KEY_VALUE,
         sum(sh.ORDERED_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_SALES_HST sh 
         join WHMGR.DC_ITEM i on (sh.FACILITY_ID = i.FACILITY_ID and sh.ITEM_NBR = i.ITEM_NBR) 
         join WHMGR.dc_customer cust on (cust.facility_id = sh.facility_id and cust.customer_nbr = sh.customer_nbr and cust.corporation_id not in (634001, 248561)) 
         join WHMGR.fiscal_day fd on (sh.TRANSACTION_DATE = fd.SALES_DT) 
         join WHMGR.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    (fw.end_dt = '10-05-2019'  --need to determine prior week Saturday date
     AND sh.FACILITY_ID not in (16)
     AND sh.COMMODITY_CODE not in (900))
     AND (sh.ext_reflect_amt > 0 or sh.ext_promo_allw_amt > 0 or sh.PRESELL_NBR >0 )
GROUP BY fw.end_dt, 
--         sh.FACILITY_ID, 
         i.BUYER_ID
;


--sales by buyer
--source:  datawhse02
SELECT   'buyer' SCORECARD_TYPE,
         'sales' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         2 DIVISION_ID,
--         sh.FACILITY_ID FACILITY_ID,
         sh.BUYER_ID KEY_VALUE,
         sum(sh.TOTAL_SALES_AMT) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_SALES_HST sh 
         join WHMGR.fiscal_day fd on (sh.TRANSACTION_DATE = fd.SALES_DT) 
         join WHMGR.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy') --need to determine prior week Saturday date
     AND sh.FACILITY_ID not in (16)
group by fw.end_dt,
--         sh.FACILITY_ID,
         sh.BUYER_ID
;

--starting inventory
--source:  CRM
SELECT   'buyer' SCORECARD_TYPE,
         'starting_inventory' KPI_TYPE,
         lh.LAYER_FILE_DTE DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
--         lh.FACILITYID FACILITY_ID,
         lh.BUYER_NBR KEY_VALUE,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD = 'R' then lh.SHIPPING_CASE_WEIGHT else 1 end))) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on lh.FACILITYID = dx.SWAT_ID
WHERE    LAYER_FILE_DTE = date('2019-10-05') - 7 days  --need to determine prior week Saturday date
GROUP BY lh.LAYER_FILE_DTE, 
         dx.ENTERPRISE_KEY,
         lh.BUYER_NBR
;




--ending inventory
--source:  CRM
SELECT   'buyer' SCORECARD_TYPE,
         'ending_inventory' KPI_TYPE,
         lh.LAYER_FILE_DTE DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
--         lh.FACILITYID FACILITY_ID,
         lh.BUYER_NBR KEY_VALUE,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD = 'R' then lh.SHIPPING_CASE_WEIGHT else 1 end))) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on lh.FACILITYID = dx.SWAT_ID
WHERE    LAYER_FILE_DTE = '2019-10-05'   --need to determine prior week Saturday date
GROUP BY lh.LAYER_FILE_DTE, 
         dx.ENTERPRISE_KEY,
         lh.BUYER_NBR
;


--po lines
--source:  CRM
SELECT   'buyer' SCORECARD_TYPE,
         'po_lines' KPI_TYPE,
         '2019-10-05' DATE_VALUE,   --need to run on Saturday week end date (then plug that value in DATE_VALUE)
         2 DIVISION_ID,
--         i.FACILITYID FACILITY_ID,
         pod.BUYER_NBR KEY_VALUE,
         COUNT(*) KEY_DATA,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_PO_DTL pod inner join CRMADMIN.T_WHSE_ITEM i on pod.ITEM_FAC = i.BICEPS_DC and pod.ITEM_NBR = i.ITEM_NBR
WHERE    pod.DATE_ORDERED between '2019-09-29' and '2019-10-05'  
GROUP BY --i.FACILITYID, 
         pod.BUYER_NBR
;


--excess inventory  
--source:  CRM
SELECT   'buyer' SCORECARD_TYPE,
         'excess_inventory' KPI_TYPE,
         'week ending date' DATE_VALUE,
         2 DIVISION_ID,
         kif.BUYER_NBR KEY_VALUE, --sum(kif.INVENTORY_TOTAL * kif.LIST_COST) total_inventory,
         sum(max(kif.INVENTORY_TURN - max(kif.MAX_INVENTORY_CASES, (kif.MFG_MIN_ORDER_QTY + kif.SAFETY_STOCK)),0) * kif.LIST_COST) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     KPIADMIN.V_KPI_ITEM_FACTORS kif
where kif.INVENTORY_TOTAL > 0
GROUP BY kif.BUYER_NBR
;



--turns
--source:  CALC from above

;

--po exceptions
--run daily
SELECT   'buyer' SCORECARD_TYPE,
         'po_exceptions' KPI_TYPE,
         DATE_ORDERED DATE_VALUE,
         2 DIVISION_ID,
         BUYER_NBR KEY_VALUE,
         sum( case when (EXCESS_CHECK + CODE_DATE_CHECK + I_O_CHECK) > 0 then 1 else 0 end) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'D' TIME_GRANULARITY
FROM     KPIADMIN.V_KPI_PO_EXCEPTIONS
WHERE    DATE_ORDERED = current date - 1 day
GROUP BY BUYER_NBR, DATE_ORDERED
;

--po exceptions
--accumulate weekly
SELECT   SCORECARD_TYPE,
         ENTERPRISE_ID,
         'po_exceptions' KPI_TYPE,
         '2019-11-02' KPI_DATE, --week end date (always Saturday)
         KPI_KEY_VALUE,
         sum(KPI_DATA_VALUE) KPI_DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     KPIADMIN.T_KPI_DETAIL
WHERE    SCORECARD_TYPE = 'buyer'
--AND      ENTERPRISE_ID = 1
AND      KPI_TYPE = 'po_exceptions'
AND      DATA_GRANULARITY = 'B'
AND      TIME_GRANULARITY = 'D'
AND      KPI_DATE between '2019-10-27' and '2019-11-02' --always prior week Sunday to Saturday
GROUP BY SCORECARD_TYPE, ENTERPRISE_ID, KPI_TYPE, KPI_KEY_VALUE
;

--aged inventory
--source:  CRM
SELECT   'buyer' SCORECARD_TYPE,
         'aged_inventory' KPI_TYPE,
         lh.LAYER_FILE_DTE DATE_VALUE,
         2 DIVISION_ID,
--         lh.FACILITYID FACILITY_ID,
         lh.BUYER_NBR KEY_VALUE,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD = 'R' then lh.SHIPPING_CASE_WEIGHT else 1 end))) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
WHERE    LAYER_FILE_DTE = '2019-11-02'   --need to determine prior week Saturday date
  AND    lh.PO_RECEIPT_DTE <= date('2019-11-02') - 120 days
GROUP BY lh.LAYER_FILE_DTE, 
--         lh.FACILITYID, 
         lh.BUYER_NBR
;

--at risk inventory
--source:  CRM
;


--goals load
--load once per week after all buyer KPIs are loaded
SELECT   g.SCORECARD_TYPE,
         g.ENTERPRISE_ID,
         g.KPI_TYPE,
         g.DATA_GRANULARITY,
         g.TIME_GRANULARITY,
         '2019-11-02' KPI_DATE_VALUE, 
         b.KPI_KEY_VALUE,
         g.KPI_DATA_VALUE
FROM     (SELECT   Distinct kd.KPI_KEY_VALUE,
                   kg.KPI_TYPE,
                   kd.ENTERPRISE_ID,
                   kd.SCORECARD_TYPE,
                   kd.DATA_GRANULARITY,
                   kd.TIME_GRANULARITY
          FROM     KPIADMIN.T_KPI_DETAIL kd,
                   KPIADMIN.T_KPI_GOALS kg
          WHERE    kd.ENTERPRISE_ID = 2
          AND      kd.SCORECARD_TYPE = 'buyer'
          AND      kd.DATA_GRANULARITY = 'B'
          AND      kd.TIME_GRANULARITY = 'W'
          AND      kd.KPI_DATE = '2019-11-02') b 
         inner join KPIADMIN.T_KPI_GOALS g on b.KPI_KEY_VALUE = g.KPI_KEY_VALUE and b.KPI_TYPE = g.KPI_TYPE and b.ENTERPRISE_ID = g.ENTERPRISE_ID and b.SCORECARD_TYPE = g.SCORECARD_TYPE and b.DATA_GRANULARITY = g.DATA_GRANULARITY and b.TIME_GRANULARITY = g.TIME_GRANULARITY

union all

SELECT   g.SCORECARD_TYPE,
         g.ENTERPRISE_ID,
         g.KPI_TYPE,
         g.DATA_GRANULARITY,
         g.TIME_GRANULARITY,
         '2019-11-02' KPI_DATE_VALUE, 
         b.KPI_KEY_VALUE,
         g.KPI_GOAL_VALUE
FROM     (SELECT   Distinct kd.KPI_KEY_VALUE,
                   kg.KPI_TYPE,
                   kd.ENTERPRISE_ID,
                   kd.SCORECARD_TYPE,
                   kd.DATA_GRANULARITY,
                   kd.TIME_GRANULARITY
          FROM     KPIADMIN.T_KPI_DETAIL kd,
                   KPIADMIN.T_KPI_GOALS kg
          WHERE    kd.ENTERPRISE_ID = 2
          AND      kd.SCORECARD_TYPE = 'buyer'
          AND      kd.DATA_GRANULARITY = 'B'
          AND      kd.TIME_GRANULARITY = 'W'
          AND      kd.KPI_DATE = '2019-11-02') b 
         inner join (SELECT   SCORECARD_TYPE,
         ENTERPRISE_ID,
         KPI_TYPE,
         DATA_GRANULARITY,
         TIME_GRANULARITY,
         round(avg(KPI_DATA_VALUE),3) KPI_GOAL_VALUE
from KPIADMIN.T_KPI_GOALS 
group by SCORECARD_TYPE,
         ENTERPRISE_ID,
         KPI_TYPE,
         DATA_GRANULARITY,
         TIME_GRANULARITY) g on  b.KPI_TYPE = g.KPI_TYPE and b.ENTERPRISE_ID = g.ENTERPRISE_ID and b.SCORECARD_TYPE = g.SCORECARD_TYPE and b.DATA_GRANULARITY = g.DATA_GRANULARITY and b.TIME_GRANULARITY = g.TIME_GRANULARITY
left join KPIADMIN.T_KPI_GOALS gb on b.KPI_KEY_VALUE = gb.KPI_KEY_VALUE and b.KPI_TYPE = gb.KPI_TYPE and b.ENTERPRISE_ID = gb.ENTERPRISE_ID and b.SCORECARD_TYPE = gb.SCORECARD_TYPE and b.DATA_GRANULARITY = gb.DATA_GRANULARITY and b.TIME_GRANULARITY = gb.TIME_GRANULARITY
where gb.KPI_KEY_VALUE is null
;

--------------------------------------------------         MDV     -------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
