--netezza
--total labor hours
SELECT   'distribution' SCORECARD_TYPE,
         'labor_total_hours' KPI_TYPE,
         FISCAL_WEEK_ID DATE_VALUE,  --need end date, not weekid
         DIVISION_ID,
--         FACILITYID FACILITY_ID,
         FACILITY_ID KEY_VALUE,
         sum(HRS_QTY) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY

from (

SELECT   dwl.FISCAL_WEEK_ID,
         case when hl.S_DIVISION_CD = 'MDV' then 3 else case when hl.S_REGION_CD in ('BRT', 'CAITO') then 4 else 2 end end division_id,
         case 
              when dwl.LOCATION_CD = '2007' then '008' 
              when dwl.LOCATION_CD = '2016' then '016' 
              when dwl.LOCATION_CD = '2037' then '003' 
              when dwl.LOCATION_CD = '2038' then '003' 
              when dwl.LOCATION_CD = '2040' then '040' 
              when dwl.LOCATION_CD = '2052' then '002' 
              when dwl.LOCATION_CD = '2054' then '054' 
              when dwl.LOCATION_CD = '2058' then '058' 
              when dwl.LOCATION_CD = '2067' then '067' 
              when dwl.LOCATION_CD = '2071' then '071' 
              when dwl.LOCATION_CD = '2115' then '115' 
              when dwl.LOCATION_CD = '2165' then '165' 
              when dwl.LOCATION_CD = '2170' then '170' 
              when dwl.LOCATION_CD = '2185' then '185' 
              when dwl.LOCATION_CD = '2915' then '015' 
              when dwl.LOCATION_CD = '2917' then '061' 
              when dwl.LOCATION_CD = 'GGM' then '001' 
              when dwl.LOCATION_CD = 'GGR' then '001' 
              when dwl.LOCATION_CD = 'GPR' then '001' 
              when dwl.LOCATION_CD = 'VSPT' then '001' 
              when dwl.LOCATION_CD = '6922' then '069' 
              when dwl.LOCATION_CD = '6924' then '070' 
              when dwl.LOCATION_CD = '6927' then '027' 
              when dwl.LOCATION_CD = '6929' then case when dwl.DEPT_ID in ('1479', '1476', '1472') then '090' else '029' end 
              when dwl.LOCATION_CD = '6933' then case when dwl.DEPT_ID in ('1492', '1496', '1480') then '080' else '033' end
              when dwl.LOCATION_CD = '6938' then '038' 
              when dwl.LOCATION_CD = '6939' then '039' 
              when dwl.LOCATION_CD = 'S6924' then '070' 
              else '999' 
         end facility_id,
         hd.OPERATING_UNIT_CD,
--         ou.OP_UNIT_DESC,
         dwl.LOCATION_CD,
         hl.LOCATION_DESC,
         hl.S_DIVISION_CD,
         hl.S_REGION_CD,
         hl.S_DISTRICT_CD,
         hl.S_BANNER_CD,
         dwl.DEPT_ID,
         hd.DEPT_DESC,
         dwl.EARNINGS_CD,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         hj.JOB_CD_DESC, 
         case when dwl.OVERTIME_HRS_QTY <> 0 then 'OT' else 'RG' end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
--         inner join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD 
--         inner join wh_owner.PS_HR_OPER_UNIT ou on hd.OPERATING_UNIT_CD = ou.OPERATING_UNIT_CD
WHERE    FISCAL_WEEK_ID = 201949
) lbr
where FACILITY_ID <> '999'
group by 3, 4, 5
;

--netezza
--total labor hours
SELECT   'distribution' SCORECARD_TYPE,
         'labor_total_dollars' KPI_TYPE,
         FISCAL_WEEK_ID DATE_VALUE,  --need end date, not weekid
         DIVISION_ID,
--         FACILITYID FACILITY_ID,
         FACILITY_ID KEY_VALUE,
         sum(EARNINGS_AMT) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY

from (

SELECT   dwl.FISCAL_WEEK_ID,
         case when hl.S_DIVISION_CD = 'MDV' then 3 else case when hl.S_REGION_CD in ('BRT', 'CAITO') then 4 else 2 end end division_id,
         case 
              when dwl.LOCATION_CD = '2007' then '008' 
              when dwl.LOCATION_CD = '2016' then '016' 
              when dwl.LOCATION_CD = '2037' then '003' 
              when dwl.LOCATION_CD = '2038' then '003' 
              when dwl.LOCATION_CD = '2040' then '040' 
              when dwl.LOCATION_CD = '2052' then '002' 
              when dwl.LOCATION_CD = '2054' then '054' 
              when dwl.LOCATION_CD = '2058' then '058' 
              when dwl.LOCATION_CD = '2067' then '067' 
              when dwl.LOCATION_CD = '2071' then '071' 
              when dwl.LOCATION_CD = '2115' then '115' 
              when dwl.LOCATION_CD = '2165' then '165' 
              when dwl.LOCATION_CD = '2170' then '170' 
              when dwl.LOCATION_CD = '2185' then '185' 
              when dwl.LOCATION_CD = '2915' then '015' 
              when dwl.LOCATION_CD = '2917' then '061' 
              when dwl.LOCATION_CD = 'GGM' then '001' 
              when dwl.LOCATION_CD = 'GGR' then '001' 
              when dwl.LOCATION_CD = 'GPR' then '001' 
              when dwl.LOCATION_CD = 'VSPT' then '001' 
              when dwl.LOCATION_CD = '6922' then '069' 
              when dwl.LOCATION_CD = '6924' then '070' 
              when dwl.LOCATION_CD = '6927' then '027' 
              when dwl.LOCATION_CD = '6929' then case when dwl.DEPT_ID in ('1479', '1476', '1472') then '090' else '029' end 
              when dwl.LOCATION_CD = '6933' then case when dwl.DEPT_ID in ('1492', '1496', '1480') then '080' else '033' end
              when dwl.LOCATION_CD = '6938' then '038' 
              when dwl.LOCATION_CD = '6939' then '039' 
              when dwl.LOCATION_CD = 'S6924' then '070' 
              else '999' 
         end facility_id,
         hd.OPERATING_UNIT_CD,
--         ou.OP_UNIT_DESC,
         dwl.LOCATION_CD,
         hl.LOCATION_DESC,
         hl.S_DIVISION_CD,
         hl.S_REGION_CD,
         hl.S_DISTRICT_CD,
         hl.S_BANNER_CD,
         dwl.DEPT_ID,
         hd.DEPT_DESC,
         dwl.EARNINGS_CD,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         hj.JOB_CD_DESC, 
         case when dwl.OVERTIME_HRS_QTY <> 0 then 'OT' else 'RG' end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
--         inner join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD 
--         inner join wh_owner.PS_HR_OPER_UNIT ou on hd.OPERATING_UNIT_CD = ou.OPERATING_UNIT_CD
WHERE    FISCAL_WEEK_ID = 201949
) lbr
where FACILITY_ID <> '999'
group by 3, 4, 5
;

--netezza
--total overtime hours
SELECT   'distribution' SCORECARD_TYPE,
         'labor_overtime_hours' KPI_TYPE,
         FISCAL_WEEK_ID DATE_VALUE,  --need end date, not weekid
         DIVISION_ID,
--         FACILITYID FACILITY_ID,
         FACILITY_ID KEY_VALUE,
         sum(OVERTIME_HRS_QTY) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY

from (

SELECT   dwl.FISCAL_WEEK_ID,
         case when hl.S_DIVISION_CD = 'MDV' then 3 else case when hl.S_REGION_CD in ('BRT', 'CAITO') then 4 else 2 end end division_id,
         case 
              when dwl.LOCATION_CD = '2007' then '008' 
              when dwl.LOCATION_CD = '2016' then '016' 
              when dwl.LOCATION_CD = '2037' then '003' 
              when dwl.LOCATION_CD = '2038' then '003' 
              when dwl.LOCATION_CD = '2040' then '040' 
              when dwl.LOCATION_CD = '2052' then '002' 
              when dwl.LOCATION_CD = '2054' then '054' 
              when dwl.LOCATION_CD = '2058' then '058' 
              when dwl.LOCATION_CD = '2067' then '067' 
              when dwl.LOCATION_CD = '2071' then '071' 
              when dwl.LOCATION_CD = '2115' then '115' 
              when dwl.LOCATION_CD = '2165' then '165' 
              when dwl.LOCATION_CD = '2170' then '170' 
              when dwl.LOCATION_CD = '2185' then '185' 
              when dwl.LOCATION_CD = '2915' then '015' 
              when dwl.LOCATION_CD = '2917' then '061' 
              when dwl.LOCATION_CD = 'GGM' then '001' 
              when dwl.LOCATION_CD = 'GGR' then '001' 
              when dwl.LOCATION_CD = 'GPR' then '001' 
              when dwl.LOCATION_CD = 'VSPT' then '001' 
              when dwl.LOCATION_CD = '6922' then '069' 
              when dwl.LOCATION_CD = '6924' then '070' 
              when dwl.LOCATION_CD = '6927' then '027' 
              when dwl.LOCATION_CD = '6929' then case when dwl.DEPT_ID in ('1479', '1476', '1472') then '090' else '029' end 
              when dwl.LOCATION_CD = '6933' then case when dwl.DEPT_ID in ('1492', '1496', '1480') then '080' else '033' end
              when dwl.LOCATION_CD = '6938' then '038' 
              when dwl.LOCATION_CD = '6939' then '039' 
              when dwl.LOCATION_CD = 'S6924' then '070' 
              else '999' 
         end facility_id,
         hd.OPERATING_UNIT_CD,
--         ou.OP_UNIT_DESC,
         dwl.LOCATION_CD,
         hl.LOCATION_DESC,
         hl.S_DIVISION_CD,
         hl.S_REGION_CD,
         hl.S_DISTRICT_CD,
         hl.S_BANNER_CD,
         dwl.DEPT_ID,
         hd.DEPT_DESC,
         dwl.EARNINGS_CD,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         hj.JOB_CD_DESC, 
         case when dwl.OVERTIME_HRS_QTY <> 0 then 'OT' else 'RG' end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
--         inner join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD 
--         inner join wh_owner.PS_HR_OPER_UNIT ou on hd.OPERATING_UNIT_CD = ou.OPERATING_UNIT_CD
WHERE    FISCAL_WEEK_ID = 201949
) lbr
where FACILITY_ID <> '999'
group by 3, 4, 5
;

--sales by facility - fd
--source:  datawhse02
SELECT   'distribution' SCORECARD_TYPE,
         'sales' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         2 DIVISION_ID,
         sh.facility_id KEY_VALUE,
         sum(sh.TOTAL_SALES_AMT) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_SALES_HST sh 
         join WHMGR.fiscal_day fd on (sh.TRANSACTION_DATE = fd.SALES_DT) 
         join WHMGR.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.end_dt = '12-07-2019' --need to determine prior week Saturday date
     AND sh.FACILITY_ID not in (16)
group by fw.end_dt,
--         sh.FACILITY_ID,
         sh.facility_id
;

--sales by facility - mdv 
--source:  eisdw01
SELECT   'distribution' SCORECARD_TYPE,
         'sales' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         sls.dept_cd KEY_VALUE,    -- NEED TO LOOK UP FACILITY ID BASED ON DEPT_CD
         sum(sls.tot_order_line_amt) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.end_dt = '12-07-2019'
GROUP BY fw.end_dt, sls.dept_cd
;

--cases shipped by facility - fd
--source:  datawhse02
SELECT   'distribution' SCORECARD_TYPE,
         'cases_shipped' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         2 DIVISION_ID,
         sh.facility_id KEY_VALUE,
         sum(sh.shipped_qty) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_SALES_HST sh 
         join WHMGR.fiscal_day fd on (sh.TRANSACTION_DATE = fd.SALES_DT) 
         join WHMGR.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.end_dt = '12-07-2019' --need to determine prior week Saturday date
     AND sh.FACILITY_ID not in (16)
group by fw.end_dt,
--         sh.FACILITY_ID,
         sh.facility_id
;


--cases shipped by facility - mdv 
--source:  eisdw01
SELECT   'distribution' SCORECARD_TYPE,
         'cases_shipped' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         sls.dept_cd KEY_VALUE,    -- NEED TO LOOK UP FACILITY ID BASED ON DEPT_CD
         sum(sls.ship_qty) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.end_dt = '12-07-2019'
GROUP BY fw.end_dt, sls.dept_cd
;

--ending inventory
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'ending_inventory' KPI_TYPE,
         lh.LAYER_FILE_DTE DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         lh.FACILITYID KEY_VALUE,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * case when dx.ENTERPRISE_KEY = 1 then (case when lh.RAND_WGT_CD = 'R' then lh.SHIPPING_CASE_WEIGHT else 1 end) else 1 end)) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on lh.FACILITYID = dx.SWAT_ID
WHERE    LAYER_FILE_DTE = '2019-12-07'   --need to determine prior week Saturday date
GROUP BY lh.LAYER_FILE_DTE, 
         dx.ENTERPRISE_KEY,
         lh.FACILITYID
;


--cases_received
--source:  entods
SELECT   'distribution' SCORECARD_TYPE,
         'cases_received' KPI_TYPE,
         date(receipt_dtim) DATE_VALUE,
         irctd.division_id DIVISION_ID, 
         irctd.facility_id KEY_VALUE,
--         irctd.prod_id,
--         i.root_item_desc,
--         irctd.prdd_id,
--         irctd.rcpt_id,
--         i.case_pack_qty,
--         sum(irctd.rct_qty) rcvd_qty,
         sum(irctd.rct_qty / i.case_pack_qty) DATA_VALUE,
--         sum(irctd.catch_wgt) rcvd_catch_weight
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     whmgr.ent_irctd irctd 
         inner join datawhse02@dss_prd_tcp:whmgr.dc_item i on irctd.facility_id = i.facility_id and irctd.prod_id = i.item_nbr
WHERE    date(receipt_dtim) = '10-28-2019'
GROUP BY 1, 2, 3, 4, 5, 7, 8
;

S_DIVISION_CD	LOCATION_CD
DISTR	2007
DISTR	2016
DISTR	2037
DISTR	2038
DISTR	2040
DISTR	2052
DISTR	2054
DISTR	2058
DISTR	2067
DISTR	2071
DISTR	2115
DISTR	2165
DISTR	2170
DISTR	2185
DISTR	2915
DISTR	2917
DISTR	GGM
DISTR	GGR
DISTR	GPR
DISTR	VSPT
MDV	6922
MDV	6924
MDV	6927
MDV	6929
MDV	6933
MDV	6938
MDV	6939
MDV	S6924


select distinct S_DIVISION_CD, LOCATION_CD from (
SELECT   dwl.FISCAL_WEEK_ID,
         hd.OPERATING_UNIT_CD,
--         ou.OP_UNIT_DESC,
         dwl.LOCATION_CD,
         hl.LOCATION_DESC,
         hl.S_DIVISION_CD,
         hl.S_REGION_CD,
         hl.S_DISTRICT_CD,
         hl.S_BANNER_CD,
         dwl.DEPT_ID,
         hd.DEPT_DESC,
         dwl.EARNINGS_CD,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         hj.JOB_CD_DESC,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
--         inner join wh_owner.PS_HR_OPER_UNIT ou on hd.OPERATING_UNIT_CD = ou.OPERATING_UNIT_CD
WHERE    FISCAL_WEEK_ID = 201949) x