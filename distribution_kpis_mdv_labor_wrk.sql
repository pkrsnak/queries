--potential view for MDV:
SELECT   --date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0) KPI_DATE,
         dwl.FISCAL_WEEK_ID KPI_DATE,
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
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND dwl.FISCAL_WEEK_ID between 202001 and 202025 --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
WHERE    (hd.S_GL_DEPT_ID in ('8100')
--     AND dwl.PAY_GROUP_CD <> 'MSN'
--     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.EARNINGS_CD not in ('AAB', 'AIP', 'BON', 'CCR', 'DTP', 'DVD', 'MVG', 'NET', 'RST', 'SHO', 'WCI')
     AND hd.OPERATING_UNIT_CD not in ('606905', '606909')
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924'))
;


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
select KPI_DATE, division_id, facility_id, sum(EARNINGS_AMT) EARNINGS_TOT, sum(NI_HRS_QTY) HRS_TOT, sum(NI_OVERTIME_HRS_QTY) OVERTIME_HRS_TOT, sum(NI_HRS_QTY + NI_OVERTIME_HRS_QTY) TOTAL_HRS
from (
--hourly labor

;
SELECT   --date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0) KPI_DATE,
         dwl.FISCAL_WEEK_ID KPI_DATE,
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
--         case when dwl.EARNINGS_CD in ('050', '100', 'CFP', 'DRV', 'E25', 'F01', 'F02', 'FLS', 'FNL', 'GRV', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MFL', 'MIC', 'MIL', 'MOT', 'MRG', 'MTG', 'MTO', 'N25', 'NET', 'OAD', 'OT1', 'OTP', 'RAD', 'REG', 'RTO', 'SCA', 'TRA', 'TRN') then 'LABOR' else 'OTHER' end PAY_TYPE_CD,
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
--         case
--              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0
--              else dwl.HRS_QTY
--         end NI_HRS_QTY,
--         case when dwl.DEPT_ID in ('0865', '0867', '0868', '0871', '0872', '0873', '0874', '0878', '0880', '0891', '0892', '0901', '0902', '0903', '0904', '0906', '0907', '0908', '0910', '0911', '0912', '0915', '0917', '0918', '0920', '0921', '0922', '0923', '0925', '0926', '0929', '0966', '0969', '0970', '0971', '1014', '1044', '1076', '1081', '1159', '1179', '1184', '1462', '1472', '1476', '1480') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY --,
--         case
--              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0
--              else dwl.OVERTIME_HRS_QTY
--         end NI_OVERTIME_HRS_QTY,
--         case when dwl.DEPT_ID in ('0865', '0867', '0868', '0871', '0872', '0873', '0874', '0878', '0880', '0891', '0892', '0901', '0902', '0903', '0904', '0906', '0907', '0908', '0910', '0911', '0912', '0915', '0917', '0918', '0920', '0921', '0922', '0923', '0925', '0926', '0929', '0966', '0969', '0970', '0971', '1014', '1044', '1076', '1081', '1159', '1179', '1184', '1462', '1472', '1476', '1480') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY
FROM     WH_OWNER.DCLBR_WK_LOC dwl
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND dwl.FISCAL_WEEK_ID between 202001 and 202025 --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
 
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
         left outer join WH_OWNER.EARN_PAY_TYPE_XREF epx on epx.EARNINGS_CD = dwl.EARNINGS_CD
         left outer join WH_OWNER.MDV_RPT_TREE rt on rt.DEPT_ID = dwl.DEPT_ID
WHERE    (hd.S_GL_DEPT_ID in ('8100')
     AND dwl.PAY_GROUP_CD <> 'MSN'
--     AND dwl.PAY_GROUP_CD = 'MSN'
--     AND dwl.EARNINGS_CD in ('050', '100', 'CFP', 'DRV', 'E25', 'F01', 'F02', 'FLS', 'FNL', 'GRV', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MFL', 'MIC', 'MIL', 'MOT', 'MRG', 'MTG', 'MTO', 'N25', 'NET', 'OAD', 'OT1', 'OTP', 'RAD', 'REG', 'RTO', 'SCA', 'TRA', 'TRN', 'FRP', 'LRP', 'PSP', 'TNP')
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924'))
; 
union all
; 
--san antonio - columbus food dist
SELECT   --date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0) KPI_DATE,
         dwl.FISCAL_WEEK_ID,
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
--         case when dwl.EARNINGS_CD in ('050', '100', 'CFP', 'DRV', 'E25', 'F01', 'F02', 'FLS', 'FNL', 'GRV', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MFL', 'MIC', 'MIL', 'MOT', 'MRG', 'MTG', 'MTO', 'N25', 'NET', 'OAD', 'OT1', 'OTP', 'RAD', 'REG', 'RTO', 'SCA', 'TRA', 'TRN') then 'LABOR' else 'OTHER' end PAY_TYPE_CD,
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
 
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND dwl.FISCAL_WEEK_ID = 202001 --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+6)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
 
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100')
     AND dwl.PAY_GROUP_CD <> 'MSN'
     AND dwl.EARNINGS_CD in ('050', '100', 'CFP', 'DRV', 'E25', 'F01', 'F02', 'FLS', 'FNL', 'GRV', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MFL', 'MIC', 'MIL', 'MOT', 'MRG', 'MTG', 'MTO', 'N25', 'NET', 'OAD', 'OT1', 'OTP', 'RAD', 'REG', 'RTO', 'SCA', 'TRA', 'TRN', 'FRP', 'LRP', 'PSP', 'TNP')
     AND dwl.LOCATION_CD in ('6929', '6933'))
) lbr
group by 1, 2, 3
 
union all

--salary labor
SELECT   --date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0) KPI_DATE,
         202001 FISCAL_WEEK_ID,
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
 
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND dwl.FISCAL_WEEK_ID in (201952, 202001) --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+13)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924'))
group by 2,3

union all
 
SELECT   --date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0) KPI_DATE,
         202001 FISCAL_WEEK_ID,
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
 
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND dwl.FISCAL_WEEK_ID in (201952, 202001) --(fw.START_DT >= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')+13)) And fw.END_DT <= date(date('#CURRENT_DATE_DB2#') - (date_part('dow', date '#CURRENT_DATE_DB2#')- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6929', '6933'))
group by 2,3
 
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