--potential view for MDV:
SELECT   dwl.FISCAL_WEEK_ID KPI_DATE,
         3 division_id,
         case
              when dwl.LOCATION_CD = '6922' then '069'
              when dwl.LOCATION_CD = '6924' then '070'
              when dwl.LOCATION_CD = '6927' then '027'
              when dwl.LOCATION_CD = '6929' then '029'
              when dwl.LOCATION_CD = '6933' then '033'
              when dwl.LOCATION_CD = '6938' then '038'
              when dwl.LOCATION_CD = '6939' then '039'
              when dwl.LOCATION_CD = 'S6924' then '070'
              else '999'
         end facility_id,
         hd.OPERATING_UNIT_CD,
         dwl.LOCATION_CD,
         hl.LOCATION_DESC,
         hl.S_DIVISION_CD,
         hl.S_REGION_CD,
         hl.S_DISTRICT_CD,
         hl.S_BANNER_CD,
         dwl.DEPT_ID,
         hd.DEPT_DESC, rt.METRIC_INFO_CD, rt.LABOR_TYPE_CD,
         hd.S_GL_DEPT_ID,
         hd.S_GL_DEPT_ID_DESC,
         dwl.EARNINGS_CD,
         he.EARNINGS_DESC, epx.PAY_TYPE_CD,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         hj.JOB_CD_DESC,
         case
              when dwl.OVERTIME_HRS_QTY <> 0 then 'OT'
              else 'RG'
         end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         dwl.OVERTIME_HRS_QTY
FROM     WH_OWNER.DCLBR_WK_LOC dwl
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
         inner join WH_OWNER.EARN_PAY_TYPE_XREF epx on epx.EARNINGS_CD = dwl.EARNINGS_CD
         inner join WH_OWNER.MDV_RPT_TREE rt on rt.DEPT_ID = dwl.DEPT_ID
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID --AND dwl.FISCAL_WEEK_ID between 202001 and 202025 
WHERE    (hd.S_GL_DEPT_ID in ('8100')
--     AND dwl.PAY_GROUP_CD <> 'MSN'
--     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.EARNINGS_CD not in ('AAB', 'AIP', 'BON', 'CCR', 'DTP', 'DVD', 'MVG', 'NET', 'RST', 'SHO', 'WCI', 'FRG')
     AND hd.OPERATING_UNIT_CD not in ('606905', '606909')
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924'))
;

--exclude reimbursement for everyone
--exclude benefits for everyone except supervisors

--columbus & SA exclude supervisor wages
   --202920 = DG supervisors, exclude from Columbus, add to Columbus DG
   --202921 = DG supervisors, exclude fron San Antonio, add to San Antonio DG

--DG Allocation
--   Allocate non-supervisors based cases sold in the departments
--   capture supervisors from payroll
;

--netezza
--total labor dollars
SELECT   'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         'labor_total_dollars' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         KPI_DATE,
         FACILITY_ID KPI_KEY_VALUE,
--         WORKER_TYPE,
         sum(KPI_DATA_VALUE_TOT_DOLLARS) KPI_DATA_VALUE_TOT_DOLLARS,
         sum(KPI_DATA_VALUE_TOT_HOURS) KPI_DATA_VALUE_TOT_HOURS,
         sum(KPI_DATA_VALUE_OT_HOURS) KPI_DATA_VALUE_OT_HOURS
from (
--total labor dollars
SELECT   'HOURLY' WORKER_TYPE,
         KPI_DATE,
         DIVISION_ID,
         FACILITY_ID,
         round(EARNINGS_TOT * (spt_cases / tot_cases), 2) KPI_DATA_VALUE_TOT_DOLLARS,
         round(TOTAL_HRS * (spt_cases / tot_cases), 2) KPI_DATA_VALUE_TOT_HOURS,
         round(OVERTIME_HRS_TOT * (spt_cases / tot_cases), 2) KPI_DATA_VALUE_OT_HOURS
from (
--hourly labor with shipped cases for allocation
select labor.KPI_DATE , labor.DIVISION_ID , labor.FACILITY_ID , labor.EARNINGS_TOT , labor.HRS_TOT , labor.OVERTIME_HRS_TOT , labor.TOTAL_HRS , case when cases.TOTAL_CASES is null then 1 else cases.TOTAL_CASES end tot_cases , case when cases.SPLIT_CASES is null then 1 else cases.SPLIT_CASES end spt_cases
from (
--hourly labor pre DG allocation
select KPI_DATE, division_id, facility_id, sum(EARNINGS_AMT) EARNINGS_TOT, sum(HRS_QTY) HRS_TOT, sum(OVERTIME_HRS_QTY) OVERTIME_HRS_TOT, sum(HRS_QTY + OVERTIME_HRS_QTY) TOTAL_HRS
from (
--standard MDV
SELECT   dwl.KPI_DATE,
         dwl.DIVISION_ID,
         dwl.FACILITY_ID,
         dwl.OPERATING_UNIT_CD,
         dwl.LOCATION_CD,
         dwl.LOCATION_DESC,
         dwl.S_DIVISION_CD,
         dwl.S_REGION_CD,
         dwl.S_DISTRICT_CD,
         dwl.S_BANNER_CD,
         dwl.DEPT_ID,
         dwl.DEPT_DESC,
         dwl.METRIC_INFO_CD,
         dwl.LABOR_TYPE_CD,
         dwl.S_GL_DEPT_ID,
         dwl.S_GL_DEPT_ID_DESC,
         dwl.EARNINGS_CD,
         dwl.EARNINGS_DESC,
         dwl.PAY_TYPE_CD,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         dwl.JOB_CD_DESC,
         dwl.OVERTIME,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         dwl.OVERTIME_HRS_QTY
FROM     WH_OWNER.KPI_MDV_WK_LBR_VW dwl
WHERE    dwl.KPI_DATE = 202029
AND      dwl.PAY_GROUP_CD <> 'MSN'
AND      dwl.PAY_TYPE_CD not in ('Benefit', 'Reimburse')
 
union all
 
--san antonio - columbus food dist
SELECT   dwl.KPI_DATE,
         2 DIVISION_ID,
         case 
              when dwl.LOCATION_CD = '6929' then '090' 
              when dwl.LOCATION_CD = '6933' then '080' 
              else '999' 
         end facility_id,
         dwl.OPERATING_UNIT_CD,
         dwl.LOCATION_CD,
         dwl.LOCATION_DESC,
         dwl.S_DIVISION_CD,
         dwl.S_REGION_CD,
         dwl.S_DISTRICT_CD,
         dwl.S_BANNER_CD,
         dwl.DEPT_ID,
         dwl.DEPT_DESC,
         dwl.METRIC_INFO_CD,
         dwl.LABOR_TYPE_CD,
         dwl.S_GL_DEPT_ID,
         dwl.S_GL_DEPT_ID_DESC,
         dwl.EARNINGS_CD,
         dwl.EARNINGS_DESC,
         dwl.PAY_TYPE_CD,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         dwl.JOB_CD_DESC,
         dwl.OVERTIME,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         dwl.OVERTIME_HRS_QTY
FROM     WH_OWNER.KPI_MDV_WK_LBR_VW dwl
WHERE    dwl.KPI_DATE = 202029
AND      dwl.PAY_GROUP_CD <> 'MSN'
AND      dwl.PAY_TYPE_CD not in ('Benefit', 'Reimburse')
AND      dwl.LOCATION_CD in ('6929', '6933')
) lbr
group by 1, 2, 3
) labor
--capture cases shipped for dg allocation
left outer join
 
(
SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 29 else 33 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD not in (80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     WH_OWNER.MDV_WHSE_SHIP_DTL msd
         join WH_OWNER.fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT)
         join WH_OWNER.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) AND fd.FISCAL_WEEK_ID = 202029
WHERE     msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1
 
union all
 
SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 90 else 80 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD in (80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     WH_OWNER.MDV_WHSE_SHIP_DTL msd
         join WH_OWNER.fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT)
         join WH_OWNER.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) AND fd.FISCAL_WEEK_ID = 202029
WHERE    msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1
) cases
on labor.FACILITY_ID = cases.FACILITYID
) x

union all

--salary labor
SELECT   'SALARY' WORKER_TYPE,
         202029 KPI_DATE,
         case 
              when dwl.OPERATING_UNIT_CD = '202920' then 2 
              when dwl.OPERATING_UNIT_CD = '202921' then 2 
              else dwl.DIVISION_ID 
         end DIVISION_ID,
         case 
              when dwl.OPERATING_UNIT_CD = '202920' then '080' 
              when dwl.OPERATING_UNIT_CD = '202921' then '090' 
              else dwl.FACILITY_ID 
         end facility_id,
         sum(dwl.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum((dwl.HRS_QTY + dwl.OVERTIME_HRS_QTY) / 2) TOTAL_HRS,
         sum(dwl.OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT
FROM     WH_OWNER.KPI_MDV_WK_LBR_VW dwl
WHERE    dwl.KPI_DATE between 202029 and 202030
AND      dwl.PAY_GROUP_CD = 'MSN'
AND      dwl.PAY_TYPE_CD not in ('Reimburse')
GROUP BY 1, 2, 3, 4
) y
group by 1,2,3,4,5,6,7 --,8
;

/*  oolldd stuff
--netezza
--total labor dollars
SELECT   'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         'labor_total_dollars' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         KPI_DATE,
--         date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0) KPI_DATE,  --need end date, not weekid
         FACILITY_ID KPI_KEY_VALUE,
         round(EARNINGS_AMT * (spt_cases / tot_cases), 2) KPI_DATA_VALUE
 
 
from (
select labor.KPI_DATE , labor.DIVISION_ID , labor.FACILITY_ID , labor.EARNINGS_AMT , labor.HRS_QTY , labor.OVERTIME_HRS_QTY , labor.TOTAL_HRS_QTY , case when cases.TOTAL_CASES is null then 1 else cases.TOTAL_CASES end tot_cases , case when cases.SPLIT_CASES is null then 1 else cases.SPLIT_CASES end spt_cases
from (
select KPI_DATE, division_id, facility_id, sum(EARNINGS_TOT) EARNINGS_AMT, sum(HRS_TOT) HRS_QTY, sum(OVERTIME_HRS_TOT) OVERTIME_HRS_QTY, sum(TOTAL_HRS) TOTAL_HRS_QTY
from (
;


--hourly labor pre DG allocation
select KPI_DATE, division_id, facility_id, sum(EARNINGS_AMT) EARNINGS_TOT, sum(HRS_QTY) HRS_TOT, sum(OVERTIME_HRS_QTY) OVERTIME_HRS_TOT, sum(HRS_QTY + OVERTIME_HRS_QTY) TOTAL_HRS
from (
--standard MDV
SELECT   dwl.KPI_DATE,
         dwl.DIVISION_ID,
         dwl.FACILITY_ID,
         dwl.OPERATING_UNIT_CD,
         dwl.LOCATION_CD,
         dwl.LOCATION_DESC,
         dwl.S_DIVISION_CD,
         dwl.S_REGION_CD,
         dwl.S_DISTRICT_CD,
         dwl.S_BANNER_CD,
         dwl.DEPT_ID,
         dwl.DEPT_DESC,
         dwl.METRIC_INFO_CD,
         dwl.LABOR_TYPE_CD,
         dwl.S_GL_DEPT_ID,
         dwl.S_GL_DEPT_ID_DESC,
         dwl.EARNINGS_CD,
         dwl.EARNINGS_DESC,
         dwl.PAY_TYPE_CD,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         dwl.JOB_CD_DESC,
         dwl.OVERTIME,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         dwl.OVERTIME_HRS_QTY
FROM     WH_OWNER.plk_test_2 dwl
WHERE    dwl.KPI_DATE between 202001 and 202025
AND      dwl.PAY_GROUP_CD <> 'MSN'
AND      dwl.PAY_TYPE_CD not in ('Benefit', 'Reimburse')
 
union all
 
--san antonio - columbus food dist
SELECT   dwl.KPI_DATE,
         2 DIVISION_ID,
         case 
              when dwl.LOCATION_CD = '6929' then '090' 
              when dwl.LOCATION_CD = '6933' then '080' 
              else '999' 
         end facility_id,
         dwl.OPERATING_UNIT_CD,
         dwl.LOCATION_CD,
         dwl.LOCATION_DESC,
         dwl.S_DIVISION_CD,
         dwl.S_REGION_CD,
         dwl.S_DISTRICT_CD,
         dwl.S_BANNER_CD,
         dwl.DEPT_ID,
         dwl.DEPT_DESC,
         dwl.METRIC_INFO_CD,
         dwl.LABOR_TYPE_CD,
         dwl.S_GL_DEPT_ID,
         dwl.S_GL_DEPT_ID_DESC,
         dwl.EARNINGS_CD,
         dwl.EARNINGS_DESC,
         dwl.PAY_TYPE_CD,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         dwl.JOB_CD_DESC,
         dwl.OVERTIME,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         dwl.OVERTIME_HRS_QTY
FROM     WH_OWNER.plk_test_2 dwl
WHERE    dwl.KPI_DATE between 202001 and 202025
AND      dwl.PAY_GROUP_CD <> 'MSN'
AND      dwl.PAY_TYPE_CD not in ('Benefit', 'Reimburse')
AND      dwl.LOCATION_CD in ('6929', '6933')
) lbr
group by 1, 2, 3
; 
union all
;
--salary labor
SELECT   dwl.KPI_DATE,
         case
              when dwl.OPERATING_UNIT_CD = '202920' then 2
              when dwl.OPERATING_UNIT_CD = '202921' then 2
              else dwl.DIVISION_ID
         end DIVISION_ID,
         case
              when dwl.OPERATING_UNIT_CD = '202920' then '080'
              when dwl.OPERATING_UNIT_CD = '202921' then '090'
              else dwl.FACILITY_ID
         end facility_id,
         sum(dwl.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum(dwl.HRS_QTY / 2) HRS_TOT,
         sum(dwl.OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT,
         sum((dwl.HRS_QTY + dwl.OVERTIME_HRS_QTY) / 2) TOTAL_HRS
FROM     WH_OWNER.plk_test_2 dwl
WHERE    dwl.PAY_GROUP_CD = 'MSN'
group by 1,2,3
;
) x
group by 1,2,3) labor
 
left outer join
 
(
SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 33 else 29 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD not in (80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     WH_OWNER.MDV_WHSE_SHIP_DTL msd
         join WH_OWNER.fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT)
         join WH_OWNER.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) AND fd.FISCAL_WEEK_ID = 202001 --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
WHERE     msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1
 
union all
 
SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 90 else 80 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD in (80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     WH_OWNER.MDV_WHSE_SHIP_DTL msd
         join WH_OWNER.fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT)
         join WH_OWNER.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) AND fd.FISCAL_WEEK_ID = 202001 --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
WHERE    msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1
) cases
on labor.FACILITY_ID = cases.FACILITYID
) final
;
*/