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
              when dwl.LOCATION_CD = '6929' then '029' --case when dwl.DEPT_ID in ('1479', '1476', '1472') then '090' else '029' end 
              when dwl.LOCATION_CD = '6933' then '033' --case when dwl.DEPT_ID in ('1492', '1496', '1480') then '080' else '033' end
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
         dwl.DEPT_ID, hd.S_GL_DEPT_ID, hd.S_GL_DEPT_ID_DESC, 
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
AND      hd.S_GL_DEPT_ID in ('8100', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
--AND    hl.exec_rollup_cd = 'DIST'
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
              when dwl.LOCATION_CD = '6929' then '029' --case when dwl.DEPT_ID in ('1479', '1476', '1472') then '090' else '029' end 
              when dwl.LOCATION_CD = '6933' then '033' --case when dwl.DEPT_ID in ('1492', '1496', '1480') then '080' else '033' end
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
AND      hd.S_GL_DEPT_ID in ('8100', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
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
              when dwl.LOCATION_CD = '6929' then '029' --case when dwl.DEPT_ID in ('1479', '1476', '1472') then '090' else '029' end 
              when dwl.LOCATION_CD = '6933' then '033' --case when dwl.DEPT_ID in ('1492', '1496', '1480') then '080' else '033' end
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
AND      hd.S_GL_DEPT_ID in ('8100', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
) lbr
where FACILITY_ID <> '999'
group by 3, 4, 5
;

/*
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
              when dwl.LOCATION_CD = '6929' then '029' --case when dwl.DEPT_ID in ('1479', '1476', '1472') then '090' else '029' end 
              when dwl.LOCATION_CD = '6933' then '033' --case when dwl.DEPT_ID in ('1492', '1496', '1480') then '080' else '033' end
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
         dwl.DEPT_ID, hd.S_GL_DEPT_ID, hd.S_GL_DEPT_ID_DESC, 
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
AND      hd.S_GL_DEPT_ID in ('8100', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
AND      hj.JOB_CD in ('3849', '3846', '0057', '5203', '5352')
) lbr
where FACILITY_ID <> '999'
group by 3, 4, 5
;
*/

--pshrdw
--total headcount
SELECT   'distribution' SCORECARD_TYPE,
         'headcount_total' KPI_TYPE,
         hc.fiscal_day_dt DATE_VALUE,  --need end date, not weekid
         hc.DIVISION_ID,
         hc.FACILITY_ID KEY_VALUE,
         count(hc.empl_id) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
SELECT   ea.fiscal_day_dt,
         case when loc.division_cd = 'MDV' then 3 else case when loc.region_cd in ('BRT', 'CAITO') then 4 else 2 end end division_id,
         case 
              when loc.LOCATION_CD = '2007' then '008' 
              when loc.LOCATION_CD = '2016' then '016' 
              when loc.LOCATION_CD = '2037' then '003' 
              when loc.LOCATION_CD = '2038' then '003' 
              when loc.LOCATION_CD = '2040' then '040' 
              when loc.LOCATION_CD = '2052' then '002' 
              when loc.LOCATION_CD = '2054' then '054' 
              when loc.LOCATION_CD = '2058' then '058' 
              when loc.LOCATION_CD = '2067' then '067' 
              when loc.LOCATION_CD = '2071' then '071' 
              when loc.LOCATION_CD = '2115' then '115' 
              when loc.LOCATION_CD = '2165' then '165' 
              when loc.LOCATION_CD = '2170' then '170' 
              when loc.LOCATION_CD = '2185' then '185' 
              when loc.LOCATION_CD = '2915' then '015' 
              when loc.LOCATION_CD = '2917' then '061' 
              when loc.LOCATION_CD = 'GGM' then '001' 
              when loc.LOCATION_CD = 'GGR' then '001' 
              when loc.LOCATION_CD = 'GPR' then '001' 
              when loc.LOCATION_CD = 'VSPT' then '001' 
              when loc.LOCATION_CD = '6922' then '069' 
              when loc.LOCATION_CD = '6924' then '070' 
              when loc.LOCATION_CD = '6927' then '027' 
              when loc.LOCATION_CD = '6929' then '029' --case when loc.DEPT_ID in ('1479', '1476', '1472') then '090' else '029' end 
              when loc.LOCATION_CD = '6933' then '033' --case when loc.DEPT_ID in ('1492', '1496', '1480') then '080' else '033' end
              when loc.LOCATION_CD = '6938' then '038' 
              when loc.LOCATION_CD = '6939' then '039' 
              when loc.LOCATION_CD = 'S6924' then '070' 
              else '999' 
         end facility_id,
         ea.empl_id,
--         ea.position_key,
--         ea.job_code_key,
--         ea.job_title_nm,
         ea.job_function_cd,
         ea.job_family_cd,
--         ea.supervisor_id,
         ea.location_key,
         ea.dept_key,
         ea.gl_dept_id,
         ea.business_unit_id,
         ea.operating_unit_key,
         ea.empl_type_cd,
         ea.termination_dt,
         ea.service_dt,
         ea.day_employed_qty
FROM     whmgr.hr_day_empl_hst ea 
         inner join whmgr.hr_location loc on ea.location_key = loc.location_key
         inner join whmgr.hr_department dept on ea.dept_key = dept.dept_key
WHERE    ea.fiscal_day_dt = '12-14-2019'
AND      ea.gl_dept_id in ('8100', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
) hc
where hc.FACILITY_ID <> '999'
group by 3, 4, 5
;

--pshrdw
--termed headcount
SELECT   'distribution' SCORECARD_TYPE,
         'headcount_termed' KPI_TYPE,
         max(tc.fiscal_day_dt) DATE_VALUE,  --need end date, not MAX function
         tc.DIVISION_ID,
         tc.FACILITY_ID KEY_VALUE,
         count(tc.empl_id) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
SELECT   eah.fiscal_day_dt,
         case when loc.division_cd = 'MDV' then 3 else case when loc.region_cd in ('BRT', 'CAITO') then 4 else 2 end end division_id,
         case 
              when loc.LOCATION_CD = '2007' then '008' 
              when loc.LOCATION_CD = '2016' then '016' 
              when loc.LOCATION_CD = '2037' then '003' 
              when loc.LOCATION_CD = '2038' then '003' 
              when loc.LOCATION_CD = '2040' then '040' 
              when loc.LOCATION_CD = '2052' then '002' 
              when loc.LOCATION_CD = '2054' then '054' 
              when loc.LOCATION_CD = '2058' then '058' 
              when loc.LOCATION_CD = '2067' then '067' 
              when loc.LOCATION_CD = '2071' then '071' 
              when loc.LOCATION_CD = '2115' then '115' 
              when loc.LOCATION_CD = '2165' then '165' 
              when loc.LOCATION_CD = '2170' then '170' 
              when loc.LOCATION_CD = '2185' then '185' 
              when loc.LOCATION_CD = '2915' then '015' 
              when loc.LOCATION_CD = '2917' then '061' 
              when loc.LOCATION_CD = 'GGM' then '001' 
              when loc.LOCATION_CD = 'GGR' then '001' 
              when loc.LOCATION_CD = 'GPR' then '001' 
              when loc.LOCATION_CD = 'VSPT' then '001' 
              when loc.LOCATION_CD = '6922' then '069' 
              when loc.LOCATION_CD = '6924' then '070' 
              when loc.LOCATION_CD = '6927' then '027' 
              when loc.LOCATION_CD = '6929' then '029' --case when loc.DEPT_ID in ('1479', '1476', '1472') then '090' else '029' end 
              when loc.LOCATION_CD = '6933' then '033' --case when loc.DEPT_ID in ('1492', '1496', '1480') then '080' else '033' end
              when loc.LOCATION_CD = '6938' then '038' 
              when loc.LOCATION_CD = '6939' then '039' 
              when loc.LOCATION_CD = 'S6924' then '070' 
              else '999' 
         end facility_id,
         eah.empl_id,
         eah.action_cd,
         eah.action_reason_cd,
         eah.status_flg,
         eah.position_key,
         eah.job_code_key, loc.loc_shrt_desc,
         eah.location_key,
         loc.location_cd,
         loc.location_desc,
         eah.dept_key,
         eah.gl_dept_id,
         eah.business_unit_id,
         eah.operating_unit_key,
         eah.day_employed_qty,
         eah.empl_type_cd
FROM     whmgr.hr_dy_empl_act_hst eah 
         inner join whmgr.hr_location loc on eah.location_key = loc.location_key
         inner join whmgr.hr_department dept on eah.dept_key = dept.dept_key
WHERE    eah.fiscal_day_dt between '12-08-2019' and '12-14-2019'
AND      eah.status_flg = 'Y'
AND      eah.gl_dept_id in ('8100', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
) tc
where tc.FACILITY_ID <> '999'
group by  4, 5  --needs fixing once DATE_KEY is fixed
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


--cases shipped by facility
--source:  datawhse02
SELECT   'distribution' SCORECARD_TYPE,
         'cases_shipped' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         2 DIVISION_ID,
         wsd.FACILITY_ID KEY_VALUE,
--         i.BUYER_ID KEY_VALUE,
         sum(wsd.SHIP_CASE_QTY) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_WHSE_SHIP_DTL wsd 
         join WHMGR.DC_ITEM i on (wsd.FACILITY_ID = i.FACILITY_ID and wsd.ITEM_NBR = i.ITEM_NBR)
         join WHMGR.dc_customer cust on (cust.facility_id = wsd.facility_id and cust.customer_nbr = wsd.customer_nbr and cust.corporation_id not in (634001, 248561)) 
         join WHMGR.fiscal_day fd on (wsd.TRANSACTION_DATE = fd.SALES_DT) 
         join WHMGR.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    (fw.end_dt = '10-05-2019'  --To_Date('10/05/2019', 'mm/dd/yyyy')  --need to determine prior week Saturday date
     AND wsd.FACILITY_ID not in (16)
     AND wsd.COMMODITY_CODE not in (900))
GROUP BY fw.end_dt, 
         wsd.FACILITY_ID
;

--total abs value inventory adjustments by facility
--source:  datawhse02
SELECT   'distribution' SCORECARD_TYPE,
         'inventory_adjust_total' KPI_TYPE,
         max(fia.invtry_adj_date) DATE_VALUE, --need week end date for prior week
         2 DIVISION_ID,
         fia.facility_id KEY_VALUE,
         sum(abs(fia.ext_layer_cost_amt)) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     whmgr.dc_d_fac_invctrl_adj fia
WHERE    fia.ext_layer_cost_amt <> 0
AND      fia.invtry_adj_date between '12-08-2019' and '12-14-2019' --need to determine prior week start - end
group by fia.facility_id

union all

SELECT   'distribution' SCORECARD_TYPE,
         'inventory_adjust_total' KPI_TYPE,
         max(mia.invtry_adj_date) DATE_VALUE, --need week end date for prior week
         2 DIVISION_ID,
         mia.facility_id KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     whmgr.mdv_d_fac_invctrl_adj mia
WHERE    mia.ext_layer_cost_amt <> 0
AND      mia.invtry_adj_date between '12-08-2019' and '12-14-2019' --need to determine prior week start - end
and      mia.facility_id in (80, 90)
group by mia.facility_id

union all

SELECT   'distribution' SCORECARD_TYPE,
         'inventory_adjust_total' KPI_TYPE,
         max(mia.invtry_adj_date) DATE_VALUE, --need week end date for prior week
         3 DIVISION_ID,
         mia.facility_id KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     whmgr.mdv_d_fac_invctrl_adj mia
WHERE    mia.ext_layer_cost_amt <> 0
AND      mia.invtry_adj_date between '12-08-2019' and '12-14-2019' --need to determine prior week start - end
and      mia.facility_id not in (80, 90)
group by mia.facility_id
;

--warehouse damage abs value inventory adjustments by facility
--source:  datawhse02
SELECT   'distribution' SCORECARD_TYPE,
         'inventory_adjust_whse_dmg' KPI_TYPE,
         max(fia.invtry_adj_date) DATE_VALUE, --need week end date for prior week
         2 DIVISION_ID,
         fia.facility_id KEY_VALUE,
         sum(abs(fia.ext_layer_cost_amt)) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     whmgr.dc_d_fac_invctrl_adj fia
WHERE    fia.ext_layer_cost_amt <> 0
AND      fia.invtry_adj_date between '12-08-2019' and '12-14-2019' --need to determine prior week start - end
AND      fia.invtry_adjust_cd in ('WD')
group by fia.facility_id

union all

SELECT   'distribution' SCORECARD_TYPE,
         'inventory_adjust_whse_dmg' KPI_TYPE,
         max(mia.invtry_adj_date) DATE_VALUE, --need week end date for prior week
         2 DIVISION_ID,
         mia.facility_id KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     whmgr.mdv_d_fac_invctrl_adj mia
WHERE    mia.ext_layer_cost_amt <> 0
AND      mia.invtry_adj_date between '12-08-2019' and '12-14-2019' --need to determine prior week start - end
and      mia.facility_id in (80, 90)
AND      mia.invtry_adjust_cd in ('WD')
group by mia.facility_id

union all

SELECT   'distribution' SCORECARD_TYPE,
         'inventory_adjust_whse_dmg' KPI_TYPE,
         max(mia.invtry_adj_date) DATE_VALUE,
         3 DIVISION_ID,
         mia.facility_id KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) DATA_VALUE, --need week end date for prior week
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     whmgr.mdv_d_fac_invctrl_adj mia
WHERE    mia.ext_layer_cost_amt <> 0
AND      mia.invtry_adj_date between '12-08-2019' and '12-14-2019' --need to determine prior week start - end
and      mia.facility_id not in (80, 90)
AND      mia.invtry_adjust_cd in ('WD')
group by mia.facility_id
;


--warehouse total slots available by facility
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'slots_total' KPI_TYPE,
--         WEEK_END_DT DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         iloc.FACILITYID KEY_VALUE,
         sum(CASE_COUNT) KPI_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_EXE_ILOC iloc 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on iloc.FACILITYID = dx.SWAT_ID
--WHERE    WEEK_END_DT = '2020-01-08'
GROUP BY dx.ENTERPRISE_KEY, iloc.FACILITYID
;

--warehouse selection slots available by facility
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'slots_selection' KPI_TYPE,
--         WEEK_END_DT DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         iloc.FACILITYID KEY_VALUE,
         sum(CASE_COUNT) KPI_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_EXE_ILOC iloc 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on iloc.FACILITYID = dx.SWAT_ID
WHERE    iloc.ISTA_ID = 'A'
AND      iloc.ICAT_ID = 'S'
--AND      WEEK_END_DT = '2020-01-08'
GROUP BY dx.ENTERPRISE_KEY, iloc.FACILITYID
;

--warehouse reserve slots available by facility
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'slots_reserve' KPI_TYPE,
--         WEEK_END_DT DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         iloc.FACILITYID KEY_VALUE,
         sum(CASE_COUNT) KPI_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_EXE_ILOC iloc 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on iloc.FACILITYID = dx.SWAT_ID
WHERE    iloc.ISTA_ID = 'A'
AND      iloc.ICAT_ID = 'R'
--AND      WEEK_END_DT = '2020-01-08'
GROUP BY dx.ENTERPRISE_KEY, iloc.FACILITYID
;

--warehouse all other expenses by facility
--source:  entods
SELECT   'distribution' SCORECARD_TYPE,
         'expenses_whse_all' KPI_TYPE,
         x.per_wk_id DATE_VALUE,
         2 DIVISION_ID, 
         x.facility_id , 
         x.data_value, 
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
SELECT   fas.per_wk_id,
         case 
              when fas.facility_name = 'St_Cloud' then '008' 
              when fas.facility_name = 'Fargo' then '003' 
              when fas.facility_name = 'Omaha_Combined' then '040' 
              when fas.facility_name = 'NF_SF_Combined' then '002' 
              when fas.facility_name = 'Lima' then '058' 
              when fas.facility_name = 'Belle_Cigs' then '067' 
              when fas.facility_name = 'Belle' then '071' 
              when fas.facility_name = 'Lumberton_Combined' then '015' 
              when fas.facility_name = 'Bluefield' then '061' 
              when fas.facility_name = 'GR' then '001' 
              when fas.facility_name = 'San_Antonio' then '090' 
              when fas.facility_name = 'Columbus' then '080' 
              else '999' 
         end facility_id,
         fas.act_all_other_amt * 1000 DATA_VALUE
FROM     whmgr.dc_wk_fcst_act_stg fas
where fas.per_wk_id = 201941
) x
where x.facility_id <> '999'
;

--warehouse contract labor by facility
--source:  entods
SELECT   'distribution' SCORECARD_TYPE,
         'labor_contract_dollars' KPI_TYPE,
         x.per_wk_id DATE_VALUE,
         2 DIVISION_ID, 
         x.facility_id , 
         x.data_value, 
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
SELECT   fas.per_wk_id,
         case 
              when fas.facility_name = 'St_Cloud' then '008' 
              when fas.facility_name = 'Fargo' then '003' 
              when fas.facility_name = 'Omaha_Combined' then '040' 
              when fas.facility_name = 'NF_SF_Combined' then '002' 
              when fas.facility_name = 'Lima' then '058' 
              when fas.facility_name = 'Belle_Cigs' then '067' 
              when fas.facility_name = 'Belle' then '071' 
              when fas.facility_name = 'Lumberton_Combined' then '015' 
              when fas.facility_name = 'Bluefield' then '061' 
              when fas.facility_name = 'GR' then '001' 
              when fas.facility_name = 'San_Antonio' then '090' 
              when fas.facility_name = 'Columbus' then '080' 
              else '999' 
         end facility_id,
         fas.act_cntrct_lbr_amt * 1000 DATA_VALUE
FROM     whmgr.dc_wk_fcst_act_stg fas
where fas.per_wk_id = 201941
) x
where x.facility_id <> '999'
;

--warehouse els actual minutes by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         'els_actuals' KPI_TYPE,
--         x.per_wk_id DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         FACILITYID KEY_VALUE, 
         round(sum(final_std_tim), 2) data_value,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
SELECT   FACILITYID,
         ASGT_ID,
         ASTA_ID,
         ASSOC_ID,
         end_dtim,
         start_dtim,
         suspend_tim,
         walk_tim,
         wgt_tim,
         ftg_adj_tim,
         wgt_adj_tim,
         dly_adj_tim,
         (end_dtim - start_dtim) std_tim,
         ((hour(end_dtim - start_dtim) * 60) + minute(end_dtim - start_dtim) + (decimal(second(end_dtim - start_dtim)) / 60)) std_tim,
         value(hour(suspend_tim) * 60 + minute(SUSPEND_TIM) + (decimal(second(SUSPEND_TIM)) / 60), 0) suspend_time,
         value(hour(walk_tim) * 60 + minute(walk_tim) + (decimal(second(walk_tim)) / 60), 0) walk_time,
         value(hour(wgt_tim) * 60 + minute(wgt_tim) + (decimal(second(wgt_tim)) / 60), 0) wgt_time,
         value(hour(ftg_adj_tim) * 60 + minute(ftg_adj_tim) + (decimal(second(ftg_adj_tim)) / 60), 0) ftg_adj_time,
         value(hour(wgt_adj_tim) * 60 + minute(wgt_adj_tim) + (decimal(second(wgt_adj_tim)) / 60), 0) wgt_adj_time,
         value(hour(dly_adj_tim) * 60 + minute(dly_adj_tim) + (decimal(second(dly_adj_tim)) / 60), 0) dly_adj_time,
         ((hour(end_dtim - start_dtim) * 60) + minute(end_dtim - start_dtim) + (decimal(second(end_dtim - start_dtim)) / 60)) - value(hour(suspend_tim) * 60 + minute(SUSPEND_TIM) + (decimal(second(SUSPEND_TIM)) / 60), 0) - value(hour(walk_tim) * 60 + minute(walk_tim) + (decimal(second(walk_tim)) / 60), 0) - value(hour(wgt_tim) * 60 + minute(wgt_tim) + (decimal(second(wgt_tim)) / 60), 0) - value(hour(ftg_adj_tim) * 60 + minute(ftg_adj_tim) + (decimal(second(ftg_adj_tim)) / 60), 0) - value(hour(wgt_adj_tim) * 60 + minute(wgt_adj_tim) + (decimal(second(wgt_adj_tim)) / 60), 0) - value(hour(dly_adj_tim) * 60 + minute(dly_adj_tim) + (decimal(second(dly_adj_tim)) / 60), 0) final_std_tim
FROM     CRMADMIN.T_WHSE_EXE_AASSG
WHERE    rpt_dt between '2020-01-05' and '2020-01-11'
AND      asgt_id = 'S'
AND      asta_id = 'C'
AND      assoc_id is not null) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by dx.ENTERPRISE_KEY, x.FACILITYID
;


--warehouse els standard minutes by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         'els_standards' KPI_TYPE,
--         x.per_wk_id DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         x.FACILITYID KEY_VALUE,
         round(SUM(value(hour(std_tim) * 60 + minute(std_tim) + (decimal(second(std_tim)) / 60), 0)), 2) data_value,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_EXE_AASSG x 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
WHERE    x.rpt_dt between '2020-01-05' and '2020-01-11'
AND      x.asgt_id = 'S'
GROUP BY dx.ENTERPRISE_KEY, x.FACILITYID
;

--warehouse actual selection hours by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         'labor_selector_hours' KPI_TYPE,
--         x.per_wk_id DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         FACILITYID KEY_VALUE, 
         round(sum(final_std_tim)/ 60, 2) data_value,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
SELECT   FACILITYID,
         ASGT_ID,
         ASTA_ID,
         ASSOC_ID,
         end_dtim,
         start_dtim,
         suspend_tim,
         walk_tim,
         wgt_tim,
         ftg_adj_tim,
         wgt_adj_tim,
         dly_adj_tim,
         (end_dtim - start_dtim) std_tim,
         ((hour(end_dtim - start_dtim) * 60) + minute(end_dtim - start_dtim) + (decimal(second(end_dtim - start_dtim)) / 60)) std_tim,
         value(hour(suspend_tim) * 60 + minute(SUSPEND_TIM) + (decimal(second(SUSPEND_TIM)) / 60), 0) suspend_time,
         value(hour(walk_tim) * 60 + minute(walk_tim) + (decimal(second(walk_tim)) / 60), 0) walk_time,
         value(hour(wgt_tim) * 60 + minute(wgt_tim) + (decimal(second(wgt_tim)) / 60), 0) wgt_time,
         value(hour(ftg_adj_tim) * 60 + minute(ftg_adj_tim) + (decimal(second(ftg_adj_tim)) / 60), 0) ftg_adj_time,
         value(hour(wgt_adj_tim) * 60 + minute(wgt_adj_tim) + (decimal(second(wgt_adj_tim)) / 60), 0) wgt_adj_time,
         value(hour(dly_adj_tim) * 60 + minute(dly_adj_tim) + (decimal(second(dly_adj_tim)) / 60), 0) dly_adj_time,
         ((hour(end_dtim - start_dtim) * 60) + minute(end_dtim - start_dtim) + (decimal(second(end_dtim - start_dtim)) / 60)) - value(hour(suspend_tim) * 60 + minute(SUSPEND_TIM) + (decimal(second(SUSPEND_TIM)) / 60), 0) - value(hour(walk_tim) * 60 + minute(walk_tim) + (decimal(second(walk_tim)) / 60), 0) - value(hour(wgt_tim) * 60 + minute(wgt_tim) + (decimal(second(wgt_tim)) / 60), 0) - value(hour(ftg_adj_tim) * 60 + minute(ftg_adj_tim) + (decimal(second(ftg_adj_tim)) / 60), 0) - value(hour(wgt_adj_tim) * 60 + minute(wgt_adj_tim) + (decimal(second(wgt_adj_tim)) / 60), 0) - value(hour(dly_adj_tim) * 60 + minute(dly_adj_tim) + (decimal(second(dly_adj_tim)) / 60), 0) final_std_tim
FROM     CRMADMIN.T_WHSE_EXE_AASSG
WHERE    rpt_dt between '2020-01-05' and '2020-01-11'
AND      asgt_id = 'S'
AND      asta_id = 'C'
AND      assoc_id is not null) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by dx.ENTERPRISE_KEY, x.FACILITYID
;



--warehouse cases selected by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         'cases_selected' KPI_TYPE,
--         x.per_wk_id DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         FACILITYID KEY_VALUE, 
         sum(cases_selected) data_value,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
select FACILITYID, SUM(prod_qty / unit_ship_cse) cases_selected
from CRMADMIN.T_WHSE_EXE_ASELD aseld
where (FACILITYID, assg_id) in 
(select aassg.FACILITYID, aassg.assg_id from CRMADMIN.T_WHSE_EXE_AASSG aassg
where aassg.FACILITYID = aseld.FACILITYID and aassg.phys_whse_id = aseld.phys_whse_id
and aassg.assg_id = aseld.assg_id
and rpt_dt between '2020-01-05' and '2020-01-11')
group by FACILITYID
union
select FACILITYID, SUM(prod_qty / unit_ship_cse) cases_selected
from CRMADMIN.T_WHSE_EXE_ASELH aselh
where (FACILITYID, assg_id) in (select aassg.FACILITYID, aassg.assg_id from CRMADMIN.T_WHSE_EXE_AASSG aassg
where aassg.FACILITYID = aselh.FACILITYID and aassg.phys_whse_id = aselh.phys_whse_id
and aassg.assg_id = aselh.assg_id
and rpt_dt between '2020-01-05' and '2020-01-11')
group by FACILITYID
) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by dx.ENTERPRISE_KEY, x.FACILITYID
;

/*
select whse_id, lcat_id, lsta_id, "Freezer", count(*),
sum(case when sel_pos_hgt between 2 and 30 then 1 else 0 end) as s,
sum(case when sel_pos_hgt between 31 and 60 then 1 else 0 end) as m,     
sum(case when sel_pos_hgt between 61 and 90 then 1 else 0 end) as l,     
sum(case when sel_pos_hgt between 91 and 200 then 1 else 0 end) as xl,   
sum(case when sel_pos_hgt between 201 and 10000 then 1 else 0 end) as xxl
from iloc                                                                
where whse_id = 7                                                       
and lcat_id = "S"                                                        
and sel_pos_hgt > 1
and lsta_id = "F"                                                        
and ldes_id != "TR"                                                      
and ldes_id != "TP"
and ldes_id != "OS"      
and ldes_id != "FK"                                                      
and loc_id >= "FA00000"                                                
and Loc_id <= "FJZZZZZ"                                                 
GROUP BY whse_id, lcat_id, lsta_id, 4                                                                               
                                                                       
union                                                                    
select whse_id, lcat_id, lsta_id, "Freezer", count(*), 
sum(case when rsv_pos_hgt between 2 and 30 then 1 else 0 end) as s,      
sum(case when rsv_pos_hgt between 31 and 60 then 1 else 0 end) as m,     
sum(case when rsv_pos_hgt between 61 and 90 then 1 else 0 end) as l,     
sum(case when rsv_pos_hgt between 91 and 200 then 1 else 0 end) as xl,   
sum(case when rsv_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL
from iloc                                                                
where whse_id = 7       
and lcat_id = "R"  
and rsv_pos_hgt > 1                                                      
and lsta_id = "F"                                                        
and ldes_id != "TR"                                                      
and ldes_id != "TP"     
and ldes_id != "OS"                                                 
and ldes_id != "FK"                                                      
and loc_id >= "FA00000"                                                
and loc_id <= "FJZZZZZ"                                                
                                    
group by whse_id, lcat_id, lsta_id, 4                     

Union                                                                     
select whse_id, lcat_id, lsta_id, "Freezer", count(*),
sum(case when sel_pos_hgt between 2 and 30 then 1 else 0 end) as s,       
sum(case when sel_pos_hgt between 31 and 60 then 1 else 0 end) as m,      
sum(case when sel_pos_hgt between 61 and 90 then 1 else 0 end) as l,      
sum(case when sel_pos_hgt between 91 and 200 then 1 else 0 end) as xl,    
sum(case when sel_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL 
from iloc                                                                 
where whse_id = 7                                                        
and lcat_id = "S" 
and sel_pos_hgt > 1                                                        
and lsta_id = "A"                                                         
and ldes_id != "TR"                                                       
and ldes_id != "TP"   
and ldes_id != "OS"                                                    
and ldes_id != "FK"                                                       
and loc_id >= "FA00000"                                                 
and Loc_id <= "FJZZZZZ" 
group by whse_id, lcat_id, 3, 4                                       

union                                                                      
select whse_id, lcat_id, lsta_id, "Freezer", count(*),
sum(case when rsv_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when rsv_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when rsv_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when rsv_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when rsv_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 7                                                         
and lcat_id = "R"   
and rsv_pos_hgt > 1                                                       
and lsta_id = "A"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP"    
and ldes_id != "OS"                                                    
and ldes_id != "FK"                                                        
and loc_id >= "FA00000"                                                  
and loc_id <= "FJZZZZZ"
group by whse_id, lcat_id, lsta_id, 4



union
select whse_id, lcat_id, lsta_id, "IceCream", count(*), 
sum(case when sel_pos_hgt between 2 and 30 then 1 else 0 end) as s,
sum(case when sel_pos_hgt between 31 and 60 then 1 else 0 end) as m,     
sum(case when sel_pos_hgt between 61 and 90 then 1 else 0 end) as l,     
sum(case when sel_pos_hgt between 91 and 200 then 1 else 0 end) as xl,   
sum(case when sel_pos_hgt between 201 and 10000 then 1 else 0 end) as xxl
from iloc                                                                
where whse_id = 7                                                       
and lcat_id = "S"    
and sel_pos_hgt > 1                                                    
and lsta_id = "F"                                                        
and ldes_id != "TR"                                                      
and ldes_id != "TP"
and ldes_id != "OS"                                                      
and ldes_id != "FK"                                                      
and loc_id >= "FM00000"                                                
and loc_id <= "FNZZZZ"                                                 
GROUP BY whse_id, lcat_id, lsta_id, 4                                                                             
                                                                       
union                                                                    
select whse_id, lcat_id, lsta_id, "IceCream", count(*), 
sum(case when rsv_pos_hgt between 2 and 30 then 1 else 0 end) as s,      
sum(case when rsv_pos_hgt between 31 and 60 then 1 else 0 end) as m,     
sum(case when rsv_pos_hgt between 61 and 90 then 1 else 0 end) as l,     
sum(case when rsv_pos_hgt between 91 and 200 then 1 else 0 end) as xl,   
sum(case when rsv_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL
from iloc                                                                
where whse_id = 7                                                       
and lcat_id = "R"     
and rsv_pos_hgt > 1                                                   
and lsta_id = "F"                                                        
and ldes_id != "TR"                                                      
and ldes_id != "TP"   
and ldes_id != "OS"                                                   
and ldes_id != "FK"  
and loc_id >= "FM00000"                                                
and loc_id <= "FNZZZZZ"
group by whse_id, lcat_id, lsta_id, 4                       

Union                                                                     
select whse_id, lcat_id, lsta_id, "IceCream", count(*), 
sum(case when sel_pos_hgt between 2 and 30 then 1 else 0 end) as s,       
sum(case when sel_pos_hgt between 31 and 60 then 1 else 0 end) as m,      
sum(case when sel_pos_hgt between 61 and 90 then 1 else 0 end) as l,      
sum(case when sel_pos_hgt between 91 and 200 then 1 else 0 end) as xl,    
sum(case when sel_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL 
from iloc                                                                 
where whse_id = 7                                                        
and lcat_id = "S"    
and sel_pos_hgt > 1                                                     
and lsta_id = "A"                                                         
and ldes_id != "TR"                                                       
and ldes_id != "TP"   
and ldes_id != "OS"                                                    
and ldes_id != "FK"      
and loc_id >= "FM00000"                                                
and loc_id <= "FNZZZZZ"
group by whse_id, lcat_id, 3, 4                                         

union                                                                      
select whse_id, lcat_id, lsta_id, "IceCream", count(*), 
sum(case when rsv_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when rsv_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when rsv_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when rsv_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when rsv_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 7                                                         
and lcat_id = "R"      
and rsv_pos_hgt > 1                                                    
and lsta_id = "A"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP"
and ldes_id != "OS"                                                        
and ldes_id != "FK"                                                        
and loc_id >= "FM00000"
and loc_id <= "FNZZZZZ"
group by whse_id, lcat_id, lsta_id, 4



union                                                                      
select whse_id, lcat_id, lsta_id, "CHILL", count(*), 
sum(case when rsv_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when rsv_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when rsv_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when rsv_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when rsv_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 8                                                         
and lcat_id = "R"   
and rsv_pos_hgt > 1                                                       
and lsta_id = "A"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP"     
and ldes_id != "OS"                                                   
and ldes_id != "FK"
and loc_id >= "CA00000"
and loc_id <= "MZZZZZZ"
group by whse_id, lcat_id, lsta_id, 4

union                                                                      
select whse_id, lcat_id, lsta_id, "CHILL", count(*), 
sum(case when rsv_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when rsv_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when rsv_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when rsv_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when rsv_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 8                                                         
and lcat_id = "R" 
and rsv_pos_hgt > 1                                                         
and lsta_id = "F"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP"
and ldes_id != "OS"                                                        
and ldes_id != "FK"                                                        
and loc_id >= "CA00000"
and loc_id <= "MZZZZZZ"
group by whse_id, lcat_id, lsta_id, 4
                                            
union                                                                      
select whse_id, lcat_id, lsta_id, "CHILL", count(*), 
sum(case when sel_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when sel_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when sel_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when sel_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when sel_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 8                                                         
and lcat_id = "S"   
and sel_pos_hgt > 1                                                       
and lsta_id = "A"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP"  
and ldes_id != "OS"                                                      
and ldes_id != "FK"
and loc_id >= "CA00000"
and loc_id <= "MZZZZZZ"
group by whse_id, lcat_id, lsta_id, 4

union                                                                      
select whse_id, lcat_id, lsta_id, "CHILL", count(*), 
sum(case when sel_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when sel_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when sel_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when sel_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when sel_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 8  
and lcat_id = "S"         
and sel_pos_hgt > 1                                                 
and lsta_id = "F"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP"   
and ldes_id != "OS"                                                     
and ldes_id != "FK"
and loc_id >= "CA00000"
and loc_id <= "MZZZZZZ"
group by whse_id, lcat_id, lsta_id, 4



union                                                                      
select whse_id, lcat_id, lsta_id, "Cigarettes", count(*), 
sum(case when rsv_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when rsv_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when rsv_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when rsv_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when rsv_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 6
and lcat_id = "R"         
and rsv_pos_hgt > 1                                                 
and lsta_id = "A"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP"
and ldes_id != "OS"                                                        
and ldes_id != "FK"
group by whse_id, lcat_id, lsta_id, 4

union                                                                      
select whse_id, lcat_id, lsta_id, "Cigarettes", count(*), 
sum(case when sel_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when sel_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when sel_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when sel_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when sel_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 6
and lcat_id = "S" 
and sel_pos_hgt > 1                                                         
and lsta_id = "A"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP"    
and ldes_id != "OS"                                                    
and ldes_id != "FK"
group by whse_id, lcat_id, lsta_id, 4

union                                                                      
select whse_id, lcat_id, lsta_id, "Cigarettes", count(*), 
sum(case when rsv_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when rsv_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when rsv_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when rsv_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when rsv_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 6
and lcat_id = "R"       
and rsv_pos_hgt > 1                                                   
and lsta_id = "F"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP" 
and ldes_id != "OS"                                                       
and ldes_id != "FK"                                                        
group by whse_id, lcat_id, lsta_id, 4

union                                                                      
select whse_id, lcat_id, lsta_id, "Cigarettes", count(*), 
sum(case when sel_pos_hgt between 2 and 30 then 1 else 0 end) as s,        
sum(case when sel_pos_hgt between 31 and 60 then 1 else 0 end) as m,       
sum(case when sel_pos_hgt between 61 and 90 then 1 else 0 end) as l,       
sum(case when sel_pos_hgt between 91 and 200 then 1 else 0 end) as xl,     
sum(case when sel_pos_hgt between 201 and 10000 then 1 else 0 end) as XXL  
from iloc                                                                  
where whse_id = 6
and lcat_id = "S"     
and sel_pos_hgt > 1                                                     
and lsta_id = "F"                                                          
and ldes_id != "TR"                                                        
and ldes_id != "TP"   
and ldes_id != "OS"                                                     
and ldes_id != "FK"                                                        
group by whse_id, lcat_id, lsta_id, 4                                            
order by whse_id, 4, lcat_id, lsta_id
*/