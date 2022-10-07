--netezza
--total labor dollars
SELECT   'distribution' SCORECARD_TYPE,
         DIVISION_ID AS DIVISION_ID,
         'labor_total_dollars' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) KPI_DATE,
         FACILITY_ID KPI_KEY_VALUE,
         sum(KPI_DATA_VALUE_TOT_DOLLARS) KPI_DATA_VALUE
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
select labor.KPI_DATE , labor.DIVISION_ID , labor.FACILITY_ID , labor.EARNINGS_TOT , labor.HRS_TOT , labor.OVERTIME_HRS_TOT , labor.TOTAL_HRS ,
case when cases.TOTAL_CASES is null then 1 else cases.TOTAL_CASES end tot_cases , case when cases.SPLIT_CASES is null then 1 else cases.SPLIT_CASES end spt_cases
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
WHERE    dwl.KPI_DATE IN (SELECT FISCAL_WEEK_ID FROM WH_OWNER.FISCAL_WEEK WHERE date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) BETWEEN START_DT AND END_DT)
AND      dwl.PAY_GROUP_CD NOT IN ('MSN','CTH','Bi-Weekly')
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
WHERE    dwl.KPI_DATE IN (SELECT FISCAL_WEEK_ID FROM WH_OWNER.FISCAL_WEEK WHERE date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) BETWEEN START_DT AND END_DT)
AND      dwl.PAY_GROUP_CD NOT IN ('MSN','CTH','Bi-Weekly')
AND      dwl.PAY_TYPE_CD not in ('Benefit', 'Reimburse')
AND      dwl.LOCATION_CD in ('6929', '6933')

union all

--columbus - dollar tree
SELECT   dwl.KPI_DATE,
         2 DIVISION_ID,
         case
              when dwl.LOCATION_CD = '6933' then '079'
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
WHERE    dwl.KPI_DATE IN (SELECT FISCAL_WEEK_ID FROM WH_OWNER.FISCAL_WEEK WHERE date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) BETWEEN START_DT AND END_DT)
AND      dwl.PAY_GROUP_CD NOT IN ('MSN','CTH','Bi-Weekly')
AND      dwl.PAY_TYPE_CD not in ('Benefit', 'Reimburse')
AND      dwl.LOCATION_CD in ('6929', '6933')

) lbr
group by 1, 2, 3
) labor
--capture cases shipped for dg allocation
left outer join



(
--main facility totals
SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 29 else 33 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD not in (80, 90, 74) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     WH_OWNER.MDV_WHSE_SHIP_DTL msd
         join WH_OWNER.fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT)
         join WH_OWNER.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) AND fd.FISCAL_WEEK_ID IN (SELECT FISCAL_WEEK_ID FROM WH_OWNER.FISCAL_WEEK WHERE date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) BETWEEN START_DT AND END_DT)
WHERE     msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90, 74)
GROUP BY 1



union all


--san antonio DG vs. total
SELECT   case
                       when msd.DEPT_CD in (87, 89, 84, 88, 90) then 90
--                       when msd.DEPT_CD in (74) then 79
                       else 99 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD in (74, 80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     WH_OWNER.MDV_WHSE_SHIP_DTL msd
         join WH_OWNER.fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT)
         join WH_OWNER.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) AND fd.FISCAL_WEEK_ID IN (SELECT FISCAL_WEEK_ID FROM WH_OWNER.FISCAL_WEEK WHERE date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) BETWEEN START_DT AND END_DT)
WHERE    msd.DEPT_CD in (87, 89, 84, 88, 90)
GROUP BY 1

union all

--columbus dollar tree vs. total
SELECT   case 
     when msd.DEPT_CD in (77, 79, 78, 80, 74) then 79 
     else 99 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD in (74) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     WH_OWNER.MDV_WHSE_SHIP_DTL msd 
         join WH_OWNER.fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT) 
         join WH_OWNER.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) AND fd.FISCAL_WEEK_ID IN (SELECT FISCAL_WEEK_ID FROM WH_OWNER.FISCAL_WEEK WHERE date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) BETWEEN START_DT AND END_DT)
WHERE    msd.DEPT_CD in (77, 79, 78, 80, 74)
GROUP BY 1

union all

--columbus dollar general vs. total
SELECT   case 
     when msd.DEPT_CD in (77, 79, 78, 80, 74) then 80 
     else 99 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD in (80) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     WH_OWNER.MDV_WHSE_SHIP_DTL msd 
         join WH_OWNER.fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT) 
         join WH_OWNER.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) AND fd.FISCAL_WEEK_ID IN (SELECT FISCAL_WEEK_ID FROM WH_OWNER.FISCAL_WEEK WHERE date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) BETWEEN START_DT AND END_DT)
WHERE    msd.DEPT_CD in (77, 79, 78, 80, 74)
GROUP BY 1


) cases
on labor.FACILITY_ID = cases.FACILITYID
) x



union all



--salary labor
SELECT   'SALARY' WORKER_TYPE,
         dwl.KPI_DATE - 1 KPI_DATE,
         case
              when dwl.OPERATING_UNIT_CD = '202920' then 2
              when dwl.OPERATING_UNIT_CD = '202921' then 2
              when dwl.OPERATING_UNIT_CD = '202933' then 2
              else dwl.DIVISION_ID
         end DIVISION_ID,
         case
              when dwl.OPERATING_UNIT_CD = '202920' then '080'
              when dwl.OPERATING_UNIT_CD = '202921' then '090'
              when dwl.OPERATING_UNIT_CD = '202933' then '079'
              else dwl.FACILITY_ID
         end facility_id,
         sum(dwl.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum((dwl.HRS_QTY + dwl.OVERTIME_HRS_QTY) / 2) TOTAL_HRS,
         sum(dwl.OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT
FROM     WH_OWNER.KPI_MDV_WK_LBR_VW dwl
--INNER JOIN WH_OWNER.FISCAL_WEEK FW ON dw1.KPI_DATE = FW.FISCAL_WEEK_ID
WHERE    dwl.KPI_DATE >= (SELECT FISCAL_WEEK_ID FROM WH_OWNER.FISCAL_WEEK WHERE date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) BETWEEN START_DT AND END_DT) and dwl.KPI_DATE <= (SELECT FISCAL_WEEK_ID + 1
FROM WH_OWNER.FISCAL_WEEK WHERE date('2022-09-14') - (date_part('dow', date '2022-09-14')- 0) BETWEEN START_DT AND END_DT)
AND      dwl.PAY_GROUP_CD IN ('MSN','Bi-Weekly')
AND      dwl.PAY_TYPE_CD not in ('Reimburse')
AND      dwl.OPERATING_UNIT_CD not in ('606905', '606909', '606906', '606907')
GROUP BY 1, 2, 3, 4
) y
group by 1,2,3,4,5,6,7 --,8
;

