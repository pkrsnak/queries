--total miles
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'miles_total' KPI_TYPE,
         '2019-10-12' DATE_VALUE,  --need end date, not weekid
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         crh.SITEID KEY_VALUE,
         sum(crh.DISTANCE) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     TRANSPORT.T_TMS_COM_ROUTE_HISTORY crh
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on crh.SITEID = dx.SWAT_ID
WHERE    crh.ROUTE_END_TIME between '2019-10-06' and '2019-10-12'
AND      crh.STATUS = 'COMPLETE'
GROUP BY dx.ENTERPRISE_KEY, crh.SITEID
;


--planned miles
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'miles_planned' KPI_TYPE,
         '2019-10-12' DATE_VALUE,  --need end date, not weekid
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         crh.SITEID KEY_VALUE,
         sum(crh.ROUTED_DISTANCE_PLAN) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     TRANSPORT.T_TMS_COM_ROUTE_HISTORY crh
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on crh.SITEID = dx.SWAT_ID
WHERE    crh.ROUTE_END_TIME between '2019-10-06' and '2019-10-12'
AND      crh.STATUS = 'COMPLETE'
GROUP BY dx.ENTERPRISE_KEY, crh.SITEID
;

--total routes
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'routes_total' KPI_TYPE,
         '2019-10-12' DATE_VALUE,  --need end date, not weekid
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         crh.SITEID KEY_VALUE,
         count(distinct crh.ROUTEID) DATA_VALUE, -- add departure time to make unique?
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     TRANSPORT.T_TMS_COM_ROUTE_HISTORY crh
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on crh.SITEID = dx.SWAT_ID
WHERE    crh.ROUTE_END_TIME between '2019-10-06' and '2019-10-12'
AND      crh.STATUS = 'COMPLETE'
GROUP BY dx.ENTERPRISE_KEY, crh.SITEID
;

--late routes
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'routes_late_dock_out' KPI_TYPE,
         '2019-10-12' DATE_VALUE,  --need end date, not weekid
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         crh.SITEID KEY_VALUE,
         count(distinct crh.ROUTEID) DATA_VALUE,  -- add departure time to make unique?
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     TRANSPORT.T_TMS_COM_ROUTE_HISTORY crh
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on crh.SITEID = dx.SWAT_ID
WHERE    crh.ROUTE_END_TIME between '2019-10-06' and '2019-10-12'
AND      crh.DEPART_TIME > crh.DISPATCHED_DEPARTTIME_PLAN
AND      crh.STATUS = 'COMPLETE'
AND      crh.STOP_NUMBER = 0
GROUP BY dx.ENTERPRISE_KEY, crh.SITEID
;

--total cube
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'cube_total' KPI_TYPE,
         '2019-10-12' DATE_VALUE,  --need end date, not weekid
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         crh.SITEID KEY_VALUE,           --CR and RC still used as drophook location
         sum(crh.ROUTED_CUBE) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     TRANSPORT.T_TMS_COM_ROUTE_HISTORY crh
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on crh.SITEID = dx.SWAT_ID
WHERE    crh.ROUTE_END_TIME between '2019-10-06' and '2019-10-12'
AND      crh.STATUS = 'COMPLETE'
GROUP BY dx.ENTERPRISE_KEY, crh.SITEID
;

/*
--total drive time
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'driver_drive_time' KPI_TYPE,
         '2019-10-12' DATE_VALUE,  --need end date, not weekid
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         crh.SITEID KEY_VALUE,
         round(sum(crh.drive_time_minutes),2) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     (SELECT SITEID, ROUTEID, STOP_NUMBER, ROUTED_STOPNUMBER_PLAN, ARRIVE_TIME, DEPART_TIME, CUSTOMER_TIMEZONE_OFFSET, PREVIOUS_DEPART_TIME, value((hour((ARRIVE_TIME + CUSTOMER_TIMEZONE_OFFSET hour) - (PREVIOUS_DEPART_TIME + PREVIOUS_CUST_TZ_OFFSET hour)) * 60) + minute((ARRIVE_TIME + CUSTOMER_TIMEZONE_OFFSET hour) - (PREVIOUS_DEPART_TIME + PREVIOUS_CUST_TZ_OFFSET hour)) + decimal(second((ARRIVE_TIME + CUSTOMER_TIMEZONE_OFFSET hour) - (PREVIOUS_DEPART_TIME + PREVIOUS_CUST_TZ_OFFSET hour))) / 60, 0) drive_time_minutes FROM (SELECT SITEID, ROUTEID, STOP_NUMBER, ROUTED_STOPNUMBER_PLAN, ARRIVE_TIME, DEPART_TIME, CUSTOMER_TIMEZONE_OFFSET, STATUS, LAG(DEPART_TIME) OVER (PARTITION BY SITEID, ROUTEID ORDER BY SITEID, ROUTEID, STOP_NUMBER) PREVIOUS_DEPART_TIME, LAG(CUSTOMER_TIMEZONE_OFFSET) OVER (PARTITION BY SITEID, ROUTEID ORDER BY SITEID, ROUTEID, STOP_NUMBER) PREVIOUS_CUST_TZ_OFFSET FROM TRANSPORT.T_TMS_COM_ROUTE_HISTORY WHERE ROUTE_END_TIME between '2019-10-06' and '2019-10-12' AND STATUS = 'COMPLETE')) crh
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on crh.SITEID = dx.SWAT_ID
GROUP BY dx.ENTERPRISE_KEY, crh.SITEID
;

*/

--netezza
--total trans labor dollars
SELECT   'distribution' SCORECARD_TYPE,
         'labor_trans_total_dollars' KPI_TYPE,
         FISCAL_WEEK_ID DATE_VALUE,  --need end date, not weekid
         DIVISION_ID,
--         FACILITYID FACILITY_ID,
         FACILITY_ID KEY_VALUE,
         sum(EARNINGS_TOT) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY

from (
select FISCAL_WEEK_ID, division_id, facility_id, sum(EARNINGS_AMT) EARNINGS_TOT, sum(HRS_QTY) HRS_TOT, sum(OVERTIME_HRS_QTY) OVERTIME_HRS_TOT, sum(HRS_QTY + OVERTIME_HRS_QTY) TOTAL_HRS
from (

SELECT   dwl.FISCAL_WEEK_ID,
         case 
              when hl.S_DIVISION_CD = 'MDV' then 3 
              else case 
                        when hl.S_REGION_CD in ('BRT', 'CAITO') then 4 
                        else 2 
                   end 
         end division_id,
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
              when dwl.LOCATION_CD = '2071' and dwl.DEPT_ID in ('1103', '1115', '1116', '1117', '1118', '1119', '1140', '1434', '1436') then '066' 
              when dwl.LOCATION_CD = '2071' and dwl.DEPT_ID not in ('1103', '1115', '1116', '1117', '1118', '1119', '1140', '1434', '1436') then '071' 
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
         hd.DEPT_DESC,
         hd.S_GL_DEPT_ID,
         hd.S_GL_DEPT_ID_DESC,
         dwl.EARNINGS_CD,
         he.EARNINGS_DESC,
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
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
--where FISCAL_WEEK_ID between 202001 and 202014;

WHERE    (hd.S_GL_DEPT_ID in ('8120', '8130', '8530')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY')
     AND hd.DEPT_ID in ('0174', '0607', '0610', '0668', '0669', '0671', '0672', '0767', '0824', '0825', '0973', '1141')
     AND dwl.EARNINGS_CD in ('035' ,'040' ,'050' ,'100' ,'35O' , 'AAB', 'DRV', 'FLS' ,'FNL' , 'FRB', 'FRG' ,'HLH' ,'HLS' ,'HLX' ,'HPN' ,'HXP' ,'INC' ,'IND' ,'JRY' ,'MIL', 'MOP' ,'MTG' ,'NET' ,'NPO' ,'NPR' ,'OT1' ,'PER' ,'PHS' ,'PIO' ,'PIP' ,'PPH' ,'PPX' ,'RAD' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'SDS' ,'SIC', 'SKH' ,'SKP' ,'SKS' ,'SKT' ,'SST' ,'TAD' ,'TRA', 'TRN' ,'TRP' ,'VAB' ,'VAC' ,'VAP' ,'VAS' ,'VAT' ,'VBP' ,'VBS' ,'VBY')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT') 
     AND FISCAL_WEEK_ID = 202013)
OR       (hd.S_GL_DEPT_ID in ('8120', '8130', '8530')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY')
     AND hd.DEPT_ID not in ('0174', '0607', '0610', '0668', '0669', '0671', '0672', '0767', '0824', '0825', '0973', '1141')
     AND dwl.EARNINGS_CD in ('015' ,'025' ,'030' ,'035' ,'040' ,'050' ,'100' ,'15O' ,'1OT' ,'25O' ,'35O' ,'40O', 'AAB', 'DRV' ,'FAV' ,'FLD' ,'FPD' ,'FPO' , 'FRB', 'FRZ' ,'GAR' ,'GRO' ,'GRV' ,'HLH' ,'HXO' ,'HXP' ,'ICV' ,'INC', 'MIL' ,'LPD' ,'LPO' ,'LPY' ,'LSC' ,'LSI' ,'MID' ,'MIN' ,'MIO' ,'MTG' ,'NET' ,'NPD' ,'NPO' ,'NPR' ,'OAD' ,'OLA' ,'OT1' ,'OT2' ,'PIO' ,'PIP' ,'RAD' ,'RBN' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'TAD' ,'TRA','TRP' , 'TRN')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
     AND FISCAL_WEEK_ID = 202013)
--;
) lbr
group by 1, 2, 3

union all

--salary labor
SELECT   202013 fiscal_week,
         2 division_id,
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
              else '999' 
         end facility_id,
         sum(dwl.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum(dwl.HRS_QTY / 2) HRS_TOT,
         sum(dwl.OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT,
         sum((dwl.HRS_QTY + dwl.OVERTIME_HRS_QTY) / 2) TOTAL_HRS
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8120', '8130', '8530')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY')
     AND dwl.LOCATION_CD in ('2007' ,'2016' ,'2037' ,'2038' ,'2040' ,'2052' ,'2054' ,'2058' ,'2067' ,'2071' ,'2115' ,'2165' ,'2170' ,'2185' ,'2915' ,'2917' ,'GGM' ,'GGR' ,'GPR' ,'VSPT' )
     AND FISCAL_WEEK_ID between 202012 and 202013)
GROUP BY 2, 3
) x
group by 3, 4, 5
;

--mdv trans total dollars
--netezza
--trans total dollars
SELECT   'distribution' SCORECARD_TYPE,
         'labor_trans_total_dollars' KPI_TYPE,
         FISCAL_WEEK_ID DATE_VALUE,  --need end date, not weekid
         DIVISION_ID,
         FACILITY_ID KEY_VALUE,
         round(EARNINGS_AMT * (spt_cases / tot_cases), 2) DATA_VALUE,
--         round(EARNINGS_AMT * (spt_cases / tot_cases), 2) EARNINGS_TOT, 
--         round(OVERTIME_HRS_QTY * (spt_cases / tot_cases), 2) OVERTIME_HRS_QTY, 
--         round(TOTAL_HRS_QTY * (spt_cases / tot_cases), 2) TOT_HRS_QTY,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
select labor.FISCAL_WEEK_ID , labor.DIVISION_ID , labor.FACILITY_ID , labor.EARNINGS_AMT , labor.HRS_QTY , labor.OVERTIME_HRS_QTY , labor.TOTAL_HRS_QTY , case when cases.TOTAL_CASES is null then 1 else cases.TOTAL_CASES end tot_cases , case when cases.SPLIT_CASES is null then 1 else cases.SPLIT_CASES end spt_cases
from (
select FISCAL_WEEK_ID, division_id, facility_id, sum(EARNINGS_TOT) EARNINGS_AMT, sum(HRS_TOT) HRS_QTY, sum(OVERTIME_HRS_TOT) OVERTIME_HRS_QTY, sum(TOTAL_HRS) TOTAL_HRS_QTY
from (
select FISCAL_WEEK_ID, division_id, facility_id, sum(EARNINGS_AMT) EARNINGS_TOT, sum(NI_HRS_QTY) HRS_TOT, sum(NI_OVERTIME_HRS_QTY) OVERTIME_HRS_TOT, sum(NI_HRS_QTY + NI_OVERTIME_HRS_QTY) TOTAL_HRS
from (

--hourly labor
SELECT   dwl.FISCAL_WEEK_ID,
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
         hd.DEPT_DESC,
         hd.S_GL_DEPT_ID,
         hd.S_GL_DEPT_ID_DESC,
         dwl.EARNINGS_CD,
         he.EARNINGS_DESC,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         hj.JOB_CD_DESC,
         case 
              when dwl.OVERTIME_HRS_QTY <> 0 then 'OT' 
              else 'RG' 
         end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         case 
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0 
              else dwl.HRS_QTY 
         end NI_HRS_QTY,
         case when dwl.DEPT_ID in ('0865', '0867', '0868', '0871', '0872', '0873', '0874', '0878', '0880', '0891', '0892', '0901', '0902', '0903', '0904', '0906', '0907', '0908', '0910', '0911', '0912', '0915', '0917', '0918', '0920', '0921', '0922', '0923', '0925', '0926', '0929', '0966', '0969', '0970', '0971', '1014', '1044', '1076', '1081', '1159', '1179', '1184', '1462', '1472', '1476', '1480') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case 
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0 
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
         case when dwl.DEPT_ID in ('0865', '0867', '0868', '0871', '0872', '0873', '0874', '0878', '0880', '0891', '0892', '0901', '0902', '0903', '0904', '0906', '0907', '0908', '0910', '0911', '0912', '0915', '0917', '0918', '0920', '0921', '0922', '0923', '0925', '0926', '0929', '0966', '0969', '0970', '0971', '1014', '1044', '1076', '1081', '1159', '1179', '1184', '1462', '1472', '1476', '1480') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8120', '8130', '8530')
     AND dwl.PAY_GROUP_CD <> 'MSN'
--     AND dwl.EARNINGS_CD in ('050', 'E25', 'F02', 'HXP', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MIC', 'MOT', 'MRG', 'N25', 'NET', 'OAD', 'OT1', 'PIP', 'RAD', 'REG', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID = 202013)

union all

SELECT   dwl.FISCAL_WEEK_ID,
         2 division_id,
         case 
              when dwl.LOCATION_CD = '6929' then '090' 
              when dwl.LOCATION_CD = '6933' then '080' 
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
         hd.DEPT_DESC,
         hd.S_GL_DEPT_ID,
         hd.S_GL_DEPT_ID_DESC,
         dwl.EARNINGS_CD,
         he.EARNINGS_DESC,
         dwl.PAY_GROUP_CD,
         dwl.JOB_CD,
         hj.JOB_CD_DESC,
         case 
              when dwl.OVERTIME_HRS_QTY <> 0 then 'OT' 
              else 'RG' 
         end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         case 
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0 
              else dwl.HRS_QTY 
         end NI_HRS_QTY,
         case when dwl.DEPT_ID in ('0865', '0867', '0868', '0871', '0872', '0873', '0874', '0878', '0880', '0891', '0892', '0901', '0902', '0903', '0904', '0906', '0907', '0908', '0910', '0911', '0912', '0915', '0917', '0918', '0920', '0921', '0922', '0923', '0925', '0926', '0929', '0966', '0969', '0970', '0971', '1014', '1044', '1076', '1081', '1159', '1179', '1184', '1462', '1472', '1476', '1480') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case 
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0 
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
         case when dwl.DEPT_ID in ('0865', '0867', '0868', '0871', '0872', '0873', '0874', '0878', '0880', '0891', '0892', '0901', '0902', '0903', '0904', '0906', '0907', '0908', '0910', '0911', '0912', '0915', '0917', '0918', '0920', '0921', '0922', '0923', '0925', '0926', '0929', '0966', '0969', '0970', '0971', '1014', '1044', '1076', '1081', '1159', '1179', '1184', '1462', '1472', '1476', '1480') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8120', '8130', '8530')
     AND dwl.PAY_GROUP_CD <> 'MSN'
--     AND dwl.EARNINGS_CD in ('050', 'E25', 'F02', 'HXP', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MIC', 'MOT', 'MRG', 'N25', 'NET', 'OAD', 'OT1', 'PIP', 'RAD', 'REG', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('6929', '6933')
     AND FISCAL_WEEK_ID = 202013)
) lbr
group by 1, 2, 3

union all

--salary labor
SELECT   202013 fiscal_week,
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
         sum(dwl.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum(dwl.HRS_QTY / 2) HRS_TOT,
         sum(dwl.OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT,
         sum((dwl.HRS_QTY + dwl.OVERTIME_HRS_QTY) / 2) TOTAL_HRS
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8120', '8130', '8530')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID between 202012 and 202013)
group by 2,3

union all

SELECT   202013 fiscal_week,
         2 division_id,
         case 
              when dwl.LOCATION_CD = '6929' then '090' 
              when dwl.LOCATION_CD = '6933' then '080' 
              else '999' 
         end facility_id,
         sum(dwl.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum(dwl.HRS_QTY / 2) HRS_TOT,
         sum(dwl.OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT,
         sum((dwl.HRS_QTY + dwl.OVERTIME_HRS_QTY) / 2) TOTAL_HRS
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8120', '8130', '8530')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6929', '6933')
     AND FISCAL_WEEK_ID between 202012 and 202013)
group by 2,3

) x
group by 1,2,3) labor

left outer join 

(
SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 33 else 29 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD not in (80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     MDV_WHSE_SHIP_DTL msd 
         join fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.FISCAL_WEEK_ID = 202013
AND      msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1

union all

SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 90 else 80 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD in (80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     MDV_WHSE_SHIP_DTL msd 
         join fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.FISCAL_WEEK_ID = 202013
AND      msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1
) cases
on labor.FACILITY_ID = cases.FACILITYID
) final
;

--warehouse transportation driver drive time by facility
--source:  entods
SELECT   'distribution' SCORECARD_TYPE,
         x.division_id DIVISION_ID,
         'driver_drive_time' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
--         DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY KPI_DATE,
         x.facility_id KPI_KEY_VALUE,
         x.data_value KPI_DATA_VALUE
from (
SELECT   fas.fiscal_week_id,
        division_id,
         facility_id,
         fas.??? DATA_VALUE
FROM     whmgr.kpi_wk_div_fcst fas
where fas.fiscal_week_id IN (select fiscal_week_id from whmgr.fiscal_week where end_dt = '04/04/2020')
) x
where x.facility_id <> '999'
;

--warehouse transportation driver on duty time by facility
--source:  entods
SELECT   'distribution' SCORECARD_TYPE,
         x.division_id DIVISION_ID,
         'driver_on_duty_time' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
--         DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY KPI_DATE,
         x.facility_id KPI_KEY_VALUE,
         x.data_value KPI_DATA_VALUE
from (
SELECT   fas.fiscal_week_id,
        division_id,
         facility_id,
         fas.??? DATA_VALUE
FROM     whmgr.kpi_wk_div_fcst fas
where fas.fiscal_week_id IN (select fiscal_week_id from whmgr.fiscal_week where end_dt = '04/04/2020')
) x
where x.facility_id <> '999'
;


--warehouse transportation expenses by facility
--source:  entods
SELECT   'distribution' SCORECARD_TYPE,
         x.division_id DIVISION_ID,
         'expenses_trans_all' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
--         DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY KPI_DATE,
         x.facility_id KPI_KEY_VALUE,
         x.data_value KPI_DATA_VALUE
from (
SELECT   fas.fiscal_week_id,
        division_id,
         facility_id,
         fas.estact_tot_trans_amt * 1000 DATA_VALUE
FROM     whmgr.kpi_wk_div_fcst fas
where fas.fiscal_week_id IN (select fiscal_week_id from whmgr.fiscal_week where end_dt = '02/15/2020')
) x
where x.facility_id <> '999'
;

--warehouse transportation expenses by facility
--source:  entods
SELECT   'distribution' SCORECARD_TYPE,
         x.division_id DIVISION_ID,
         'income_backhaul_fhc' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
--         DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY KPI_DATE,
         x.facility_id KPI_KEY_VALUE,
         x.data_value KPI_DATA_VALUE
from (
SELECT   fas.fiscal_week_id,
        division_id,
         facility_id,
         fas.estact_bckhl_inc_amt * 1000 DATA_VALUE
FROM     whmgr.kpi_wk_div_fcst fas
where fas.fiscal_week_id IN (select fiscal_week_id from whmgr.fiscal_week where end_dt = '02/15/2020')
) x
where x.facility_id <> '999'
;



--warehouse fleet maintenance expenses by facility
--source:  entods
SELECT   'distribution' SCORECARD_TYPE,
         x.division_id DIVISION_ID,
         'expense_fleet_maint' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
--         DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY KPI_DATE,
         x.facility_id KPI_KEY_VALUE,
         x.data_value KPI_DATA_VALUE
from (
SELECT   fas.fiscal_week_id,
         division_id,
         facility_id,
         fas.estact_fleet_maint_exp_amt * 1000 DATA_VALUE
FROM     whmgr.kpi_wk_div_fcst fas
where fas.fiscal_week_id IN (select fiscal_week_id from whmgr.fiscal_week where end_dt = '02/22/2020')
) x
where x.facility_id <> '999'
;





--warehouse leased miles by facility
--source:  entods
SELECT   'distribution' SCORECARD_TYPE,
         x.division_id DIVISION_ID,
         'miles_leased' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
--         DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY KPI_DATE,
         x.facility_id KPI_KEY_VALUE,
         x.data_value KPI_DATA_VALUE
from (
SELECT   fas.fiscal_week_id,
         division_id,
         facility_id,
         fas.estact_lse_carrier_mile_amt DATA_VALUE
FROM     whmgr.kpi_wk_div_fcst fas
where fas.fiscal_week_id IN (select fiscal_week_id from whmgr.fiscal_week where end_dt = '02/22/2020')
) x
where x.facility_id <> '999'
;