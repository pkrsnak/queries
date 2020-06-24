--netezza
--labor_total_dollars food distribution
SELECT   'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         'labor_total_dollars' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY, 202023 kpi_date,
--         date(current date) - (date_part('dow', date current date) - 0) KPI_DATE,  --need end date, not weekid
         FACILITY_ID KPI_KEY_VALUE,
         sum(EARNINGS_TOT) KPI_DATA_VALUE_LTD, --labor_total_dollars
         sum(TOTAL_HRS) KPI_DATA_VALUE_LTH, --labor_total_hours
         sum(OVERTIME_HRS_TOT) KPI_DATA_VALUE_LTO --labor_overtime_hours
from 
(
--hourly food distribution labor
SELECT   hly.FISCAL_WEEK_ID,
         hly.division_id,
         hly.facility_id,
         sum(hly.EARNINGS_AMT) EARNINGS_TOT,
         sum(hly.NI_HRS_QTY) HRS_TOT,
         sum(hly.NI_OVERTIME_HRS_QTY) OVERTIME_HRS_TOT,
         sum((hly.NI_HRS_QTY + hly.NI_OVERTIME_HRS_QTY)) TOTAL_HRS
FROM     WH_OWNER.PLK_TEST1_VW hly
WHERE    hly.FISCAL_WEEK_ID = 202025
AND      hly.PAY_GROUP_CD not in ('SAL', 'SLY')
GROUP BY 1, 2, 3
union all
--salary labor
SELECT   202023 fiscal_week_id,
         sly.division_id, 
         sly.facility_id, 
         sum(sly.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum(sly.NI_HRS_QTY / 2) HRS_TOT,
         sum(sly.NI_OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT,
         sum((sly.NI_HRS_QTY + sly.NI_OVERTIME_HRS_QTY) / 2) TOTAL_HRS
FROM     WH_OWNER.PLK_TEST1_VW sly
WHERE    sly.FISCAL_WEEK_ID in (202024, 202025)
AND      sly.PAY_GROUP_CD in ('SAL', 'SLY')
GROUP BY 1, 2, 3
) lbr
group by 2, 6, 7
;


--netezza
--labor_total_dollars food distribution
SELECT   'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         'labor_total_dollars' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY, 202025 kpi_date,
--         date(current date) - (date_part('dow', date current date) - 0) KPI_DATE,  --need end date, not weekid
         FACILITY_ID KPI_KEY_VALUE,
         sum(EARNINGS_TOT) KPI_DATA_VALUE_LTD, --labor_total_dollars
         sum(TOTAL_HRS) KPI_DATA_VALUE_LTH, --labor_total_hours
         sum(OVERTIME_HRS_TOT) KPI_DATA_VALUE_LTO --labor_overtime_hours
from (

--hourly food distribution labor
SELECT   FISCAL_WEEK_ID,
         division_id, 
         facility_id, 
         sum(hly.EARNINGS_AMT) EARNINGS_TOT,
         sum(hly.NI_HRS_QTY) HRS_TOT,
         sum(hly.NI_OVERTIME_HRS_QTY) OVERTIME_HRS_TOT,
         sum((hly.NI_HRS_QTY + hly.NI_OVERTIME_HRS_QTY)) TOTAL_HRS
from
(
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
              when dwl.LOCATION_CD = '2915' then '015'
              when dwl.LOCATION_CD = '2917' then '061'
              when dwl.LOCATION_CD = 'GGM' then '001'
              when dwl.LOCATION_CD = 'GGR' then '001'
              when dwl.LOCATION_CD = 'GPR' then '001'
              when dwl.LOCATION_CD = 'VSPT' then '001'
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
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP', 'FRP', 'LRP', 'PSP', 'TNP', 'CIN', 'OPM') then 0
              else dwl.HRS_QTY
         end NI_HRS_QTY,
         case
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP', 'FRP', 'LRP', 'PSP', 'TNP', 'CIN','OPM') then 0
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
         case when dwl.DEPT_ID not in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0412', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case when dwl.DEPT_ID not in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0412', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND fw.FISCAL_WEEK_ID = 202025 --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date(current date) - (date_part('dow', date current date)- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8105', '8110') --, '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0412', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('035', '040', '050', '100', '35O', 'FLS', 'FNL', 'FRG', 'HLH', 'HLS', 'HLX', 'HPN', 'HXP', 'INC', 'IND', 'JRY', 'MOP', 'MTG', 'NET', 'NPO', 'NPR', 'OT1', 'PER', 'PHS', 'PIO', 'PIP', 'PPH', 'PPX', 'RAD', 'REG', 'RG+', 'RTO', 'SDH', 'SDS', 'SIC', 'SKH', 'SKP', 'SKS', 'SKT', 'SST', 'TAD', 'TRA', 'TRN', 'VAB', 'VAC', 'VAP', 'VAS', 'VAT', 'VBP', 'VBS', 'VBY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP', 'FRP', 'LRP', 'PSP', 'TNP', 'CIN','OPM')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
 )
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110') --, '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0412', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('015', '025', '030', '035', '040', '050', '100', '15O', '1OT', '25O', '35O', '40O', 'FAV', 'FLD', 'FPD', 'FPO', 'FRZ', 'GAR', 'GRO', 'GRV', 'ICV', 'INC', 'LPD', 'LPO', 'LPY', 'LSC', 'LSI', 'MID', 'MIN', 'MIO', 'MTG', 'NET', 'NPD', 'NPO', 'NPR', 'OAD', 'OLA', 'OT1', 'OT2', 'PIO', 'PIP', 'RAD', 'RBN', 'REG', 'RG+', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP', 'FRP', 'LRP', 'PSP', 'TNP', 'CIN','OPM')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
)
) hly
group by 1, 2, 3

union all

--salary labor
SELECT   202025 fiscal_week_id,
         division_id, 
         facility_id, 
         sum(sly.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum(sly.NI_HRS_QTY / 2) HRS_TOT,
         sum(sly.NI_OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT,
         sum((sly.NI_HRS_QTY + sly.NI_OVERTIME_HRS_QTY) / 2) TOTAL_HRS
from
(
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
              when dwl.LOCATION_CD = '2915' then '015'
              when dwl.LOCATION_CD = '2917' then '061'
              when dwl.LOCATION_CD = 'GGM' then '001'
              when dwl.LOCATION_CD = 'GGR' then '001'
              when dwl.LOCATION_CD = 'GPR' then '001'
              when dwl.LOCATION_CD = 'VSPT' then '001'
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
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP', 'FRP', 'LRP', 'PSP', 'TNP', 'CIN','OPM') then 0
              else dwl.HRS_QTY
         end NI_HRS_QTY,
         case
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP', 'FRP', 'LRP', 'PSP', 'TNP', 'CIN','OPM') then 0
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
         case when dwl.DEPT_ID not in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case when dwl.DEPT_ID not in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND fw.FISCAL_WEEK_ID between 202024 and 202025  --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date(current date) - (date_part('dow', date current date)- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8105', '8110') --, '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119')
     AND dwl.PAY_GROUP_CD in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('035', '040', '050', '100', '35O', 'FLS', 'FNL', 'FRG', 'HLH', 'HLS', 'HLX', 'HPN', 'HXP', 'INC', 'IND', 'JRY', 'MOP', 'MTG', 'NET', 'NPO', 'NPR', 'OT1', 'PER', 'PHS', 'PIO', 'PIP', 'PPH', 'PPX', 'RAD', 'REG', 'RG+', 'RTO', 'SDH', 'SDS', 'SIC', 'SKH', 'SKP', 'SKS', 'SKT', 'SST', 'TAD', 'TRA', 'TRN', 'VAB', 'VAC', 'VAP', 'VAS', 'VAT', 'VBP', 'VBS', 'VBY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP', 'FRP', 'LRP', 'PSP', 'TNP', 'CIN','OPM')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
 )
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110') --, '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119')
     AND dwl.PAY_GROUP_CD in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('015', '025', '030', '035', '040', '050', '100', '15O', '1OT', '25O', '35O', '40O', 'FAV', 'FLD', 'FPD', 'FPO', 'FRZ', 'GAR', 'GRO', 'GRV', 'HLH', 'HXO', 'HXP', 'ICV', 'INC', 'LPD', 'LPO', 'LPY', 'LSC', 'LSI', 'MID', 'MIN', 'MIO', 'MTG', 'NET', 'NPD', 'NPO', 'NPR', 'OAD', 'OLA', 'OT1', 'OT2', 'PIO', 'PIP', 'RAD', 'RBN', 'REG', 'RG+', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP', 'FRP', 'LRP', 'PSP', 'TNP', 'CIN','OPM')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
)
) sly
group by 1, 2, 3

) lbr
group by 2, 6, 7
;


 
--netezza
--total food distribution labor hours
SELECT   'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         'labor_total_hours' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY, 202018 KPI_DATE,
--         date(current date) - (date_part('dow', date current date)- 0) KPI_DATE,  --need end date, not weekid
         FACILITY_ID KPI_KEY_VALUE,
         sum(HRS_TOT + OVERTIME_HRS_TOT) KPI_DATA_VALUE
from 
(

--hourly food distribution labor
SELECT   FISCAL_WEEK_ID,
         division_id, 
         facility_id, 
         sum(hly.EARNINGS_AMT) EARNINGS_TOT,
         sum(hly.NI_HRS_QTY) HRS_TOT,
         sum(hly.NI_OVERTIME_HRS_QTY) OVERTIME_HRS_TOT,
         sum((hly.NI_HRS_QTY + hly.NI_OVERTIME_HRS_QTY)) TOTAL_HRS
from
(      
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
              when dwl.LOCATION_CD = '2915' then '015'
              when dwl.LOCATION_CD = '2917' then '061'
              when dwl.LOCATION_CD = 'GGM' then '001'
              when dwl.LOCATION_CD = 'GGR' then '001'
              when dwl.LOCATION_CD = 'GPR' then '001'
              when dwl.LOCATION_CD = 'VSPT' then '001'
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
 
 
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
 
 
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND fw.FISCAL_WEEK_ID = 202018   --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('035' ,'040' ,'050' ,'100' ,'35O' ,'FLS' ,'FNL' ,'FRG' ,'HLH' ,'HLS' ,'HLX' ,'HPN' ,'HXP' ,'INC' ,'IND' ,'JRY' ,'MOP' ,'MTG' ,'NET' ,'NPO' ,'NPR' ,'OT1' ,'PER' ,'PHS' ,'PIO' ,'PIP' ,'PPH' ,'PPX' ,'RAD' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'SDS' ,'SIC', 'SKH' ,'SKP' ,'SKS' ,'SKT' ,'SST' ,'TAD' ,'TRA', 'TRN' ,'VAB' ,'VAC' ,'VAP' ,'VAS' ,'VAT' ,'VBP' ,'VBS' ,'VBY')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
)
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('015' ,'025' ,'030' ,'035' ,'040' ,'050' ,'100' ,'15O' ,'1OT' ,'25O' ,'35O' ,'40O' ,'FAV' ,'FLD' ,'FPD' ,'FPO' ,'FRZ' ,'GAR' ,'GRO' ,'GRV' ,'HLH' ,'HXO' ,'HXP' ,'ICV' ,'INC' ,'LPD' ,'LPO' ,'LPY' ,'LSC' ,'LSI' ,'MID' ,'MIN' ,'MIO' ,'MTG' ,'NET' ,'NPD' ,'NPO' ,'NPR' ,'OAD' ,'OLA' ,'OT1' ,'OT2' ,'PIO' ,'PIP' ,'RAD' ,'RBN' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'TAD' ,'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
) 
) hly
group by 1, 2, 3

union all

--salary food dist labor hours
SELECT   202018 fiscal_week_id,
         division_id, 
         facility_id, 
         sum(sly.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum(sly.NI_HRS_QTY / 2) HRS_TOT,
         sum(sly.NI_OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT,
         sum((sly.NI_HRS_QTY + sly.NI_OVERTIME_HRS_QTY) / 2) TOTAL_HRS
from
(      
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
              when dwl.LOCATION_CD = '2915' then '015'
              when dwl.LOCATION_CD = '2917' then '061'
              when dwl.LOCATION_CD = 'GGM' then '001'
              when dwl.LOCATION_CD = 'GGR' then '001'
              when dwl.LOCATION_CD = 'GPR' then '001'
              when dwl.LOCATION_CD = 'VSPT' then '001'
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
 
 
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
 
 
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND fw.FISCAL_WEEK_ID between 202017 and 202018   --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.PAY_GROUP_CD in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('035' ,'040' ,'050' ,'100' ,'35O' ,'FLS' ,'FNL' ,'FRG' ,'HLH' ,'HLS' ,'HLX' ,'HPN' ,'HXP' ,'INC' ,'IND' ,'JRY' ,'MOP' ,'MTG' ,'NET' ,'NPO' ,'NPR' ,'OT1' ,'PER' ,'PHS' ,'PIO' ,'PIP' ,'PPH' ,'PPX' ,'RAD' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'SDS' ,'SIC', 'SKH' ,'SKP' ,'SKS' ,'SKT' ,'SST' ,'TAD' ,'TRA', 'TRN' ,'VAB' ,'VAC' ,'VAP' ,'VAS' ,'VAT' ,'VBP' ,'VBS' ,'VBY')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
)
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.PAY_GROUP_CD in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('015' ,'025' ,'030' ,'035' ,'040' ,'050' ,'100' ,'15O' ,'1OT' ,'25O' ,'35O' ,'40O' ,'FAV' ,'FLD' ,'FPD' ,'FPO' ,'FRZ' ,'GAR' ,'GRO' ,'GRV' ,'HLH' ,'HXO' ,'HXP' ,'ICV' ,'INC' ,'LPD' ,'LPO' ,'LPY' ,'LSC' ,'LSI' ,'MID' ,'MIN' ,'MIO' ,'MTG' ,'NET' ,'NPD' ,'NPO' ,'NPR' ,'OAD' ,'OLA' ,'OT1' ,'OT2' ,'PIO' ,'PIP' ,'RAD' ,'RBN' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'TAD' ,'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
) 
) sly
group by 1, 2, 3

) lbr
group by 2, 6, 7
;



 
--netezza
--overtime food distribution labor hours
SELECT   'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         'labor_overtime_hours' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY, 202018 KPI_DATE,
--         date(current date) - (date_part('dow', date current date)- 0) KPI_DATE,  --need end date, not weekid
         FACILITY_ID KPI_KEY_VALUE,
         sum(OVERTIME_HRS_TOT) KPI_DATA_VALUE
from 
(

--hourly food distribution labor
SELECT   FISCAL_WEEK_ID,
         division_id, 
         facility_id, 
         sum(hly.EARNINGS_AMT) EARNINGS_TOT,
         sum(hly.NI_HRS_QTY) HRS_TOT,
         sum(hly.NI_OVERTIME_HRS_QTY) OVERTIME_HRS_TOT,
         sum((hly.NI_HRS_QTY + hly.NI_OVERTIME_HRS_QTY)) TOTAL_HRS
from
(      
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
              when dwl.LOCATION_CD = '2915' then '015'
              when dwl.LOCATION_CD = '2917' then '061'
              when dwl.LOCATION_CD = 'GGM' then '001'
              when dwl.LOCATION_CD = 'GGR' then '001'
              when dwl.LOCATION_CD = 'GPR' then '001'
              when dwl.LOCATION_CD = 'VSPT' then '001'
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
 
 
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
 
 
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND fw.FISCAL_WEEK_ID = 202018   --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('035' ,'040' ,'050' ,'100' ,'35O' ,'FLS' ,'FNL' ,'FRG' ,'HLH' ,'HLS' ,'HLX' ,'HPN' ,'HXP' ,'INC' ,'IND' ,'JRY' ,'MOP' ,'MTG' ,'NET' ,'NPO' ,'NPR' ,'OT1' ,'PER' ,'PHS' ,'PIO' ,'PIP' ,'PPH' ,'PPX' ,'RAD' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'SDS' ,'SIC', 'SKH' ,'SKP' ,'SKS' ,'SKT' ,'SST' ,'TAD' ,'TRA', 'TRN' ,'VAB' ,'VAC' ,'VAP' ,'VAS' ,'VAT' ,'VBP' ,'VBS' ,'VBY')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
)
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('015' ,'025' ,'030' ,'035' ,'040' ,'050' ,'100' ,'15O' ,'1OT' ,'25O' ,'35O' ,'40O' ,'FAV' ,'FLD' ,'FPD' ,'FPO' ,'FRZ' ,'GAR' ,'GRO' ,'GRV' ,'HLH' ,'HXO' ,'HXP' ,'ICV' ,'INC' ,'LPD' ,'LPO' ,'LPY' ,'LSC' ,'LSI' ,'MID' ,'MIN' ,'MIO' ,'MTG' ,'NET' ,'NPD' ,'NPO' ,'NPR' ,'OAD' ,'OLA' ,'OT1' ,'OT2' ,'PIO' ,'PIP' ,'RAD' ,'RBN' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'TAD' ,'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
) 
) hly
group by 1, 2, 3

union all

--salary food dist labor hours
SELECT   202018 fiscal_week_id,
         division_id, 
         facility_id, 
         sum(sly.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum(sly.NI_HRS_QTY / 2) HRS_TOT,
         sum(sly.NI_OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT,
         sum((sly.NI_HRS_QTY + sly.NI_OVERTIME_HRS_QTY) / 2) TOTAL_HRS
from
(      
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
              when dwl.LOCATION_CD = '2915' then '015'
              when dwl.LOCATION_CD = '2917' then '061'
              when dwl.LOCATION_CD = 'GGM' then '001'
              when dwl.LOCATION_CD = 'GGR' then '001'
              when dwl.LOCATION_CD = 'GPR' then '001'
              when dwl.LOCATION_CD = 'VSPT' then '001'
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
 
 
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
 
 
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND fw.FISCAL_WEEK_ID between 202017 and 202018   --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.PAY_GROUP_CD in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('035' ,'040' ,'050' ,'100' ,'35O' ,'FLS' ,'FNL' ,'FRG' ,'HLH' ,'HLS' ,'HLX' ,'HPN' ,'HXP' ,'INC' ,'IND' ,'JRY' ,'MOP' ,'MTG' ,'NET' ,'NPO' ,'NPR' ,'OT1' ,'PER' ,'PHS' ,'PIO' ,'PIP' ,'PPH' ,'PPX' ,'RAD' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'SDS' ,'SIC', 'SKH' ,'SKP' ,'SKS' ,'SKT' ,'SST' ,'TAD' ,'TRA', 'TRN' ,'VAB' ,'VAC' ,'VAP' ,'VAS' ,'VAT' ,'VBP' ,'VBS' ,'VBY')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
)
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.PAY_GROUP_CD in ('SAL', 'SLY')
     AND dwl.EARNINGS_CD in ('015' ,'025' ,'030' ,'035' ,'040' ,'050' ,'100' ,'15O' ,'1OT' ,'25O' ,'35O' ,'40O' ,'FAV' ,'FLD' ,'FPD' ,'FPO' ,'FRZ' ,'GAR' ,'GRO' ,'GRV' ,'HLH' ,'HXO' ,'HXP' ,'ICV' ,'INC' ,'LPD' ,'LPO' ,'LPY' ,'LSC' ,'LSI' ,'MID' ,'MIN' ,'MIO' ,'MTG' ,'NET' ,'NPD' ,'NPO' ,'NPR' ,'OAD' ,'OLA' ,'OT1' ,'OT2' ,'PIO' ,'PIP' ,'RAD' ,'RBN' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'TAD' ,'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
) 
) sly
group by 1, 2, 3

) lbr
group by 2, 6, 7
;
 
 