--original
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
              when dwl.LOCATION_CD = '2085' then '085'
              when dwl.LOCATION_CD = '2086' then '086'
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
         --hj.JOB_CD_DESC,
         case
              when dwl.OVERTIME_HRS_QTY <> 0 then 'OT'
              else 'RG'
         end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         case --deduping of hours (not touble dipping for incentives, etc.
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP','FRP', 'LRP', 'PSP', 'TNP','LED','CIN','OPM','TRA','ATB') then 0
              else dwl.HRS_QTY
         end NI_HRS_QTY,
         case --deduping of hours (not touble dipping for incentives, etc.
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP','FRP', 'LRP', 'PSP', 'TNP','LED','CIN','OPM','TRA','ATB') then 0
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
         --inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND (fw.START_DT >= date(date('2022-02-02') - (date_part('dow', date '2022-02-02')+6)) And fw.END_DT <= date(date('2022-02-02') - (date_part('dow', date '2022-02-02')- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
--include only the specific departments, for specific earnings codes
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8105', '8110') --, '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0412', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY','Bi-Weekly') --exclude salaried associates
    AND dwl.WORKER_TYPE <> 'Agency' --exclude contractor labor
     AND dwl.EARNINGS_CD in ('035', '040', '050', '100', '35O', 'FLS', 'FNL', 'FRG', 'HLH', 'HLS', 'HLX', 'HPN', 'HXP', 'INC', 'IND', 'JRY', 'MOP', 'MTG', 'NET', 'NPO', 'NPR', 'OT1', 'PER', 'PHS', 'PIO', 'PIP', 'PPH', 'PPX', 'RAD', 'REG', 'RG+', 'RTO', 'SDH', 'SDS', 'SIC', 'SKH', 'SKP', 'SKS', 'SKT', 'SST', 'TAD', 'TRA', 'TRN', 'VAB', 'VAC', 'VAP', 'VAS', 'VAT', 'VBP', 'VBS', 'VBY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP','FRP', 'LRP', 'PSP', 'TNP','LED','CIN','OPM','TRA','ATB')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT','2085','2086')
)
--include only the specific departments, for other dept_ids
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110') --, '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0412', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY','Bi-Weekly')
     AND dwl.EARNINGS_CD in ('015', '025', '030', '035', '040', '050', '100', '15O', '1OT', '25O', '35O', '40O', 'FAV', 'FLD', 'FPD', 'FPO', 'FRZ', 'GAR', 'GRO', 'GRV', 'ICV', 'INC', 'LPD', 'LPO', 'LPY', 'LSC', 'LSI', 'MID', 'MIN', 'MIO', 'MTG', 'NET', 'NPD', 'NPO', 'NPR', 'OAD', 'OLA', 'OT1', 'OT2','OT15', 'PIO', 'PIP', 'RAD', 'RBN', 'REG', 'RG+', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP','FRP', 'LRP', 'PSP', 'TNP','LED','CIN','OPM','TRA','ATB')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT','2085','2086')
)
;



--revised
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
              when dwl.LOCATION_CD = '2085' then '085'
              when dwl.LOCATION_CD = '2086' then '086'
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
         dwl.JOB_CD, dwl.WORKER_TYPE,
         --hj.JOB_CD_DESC,
         case
              when dwl.OVERTIME_HRS_QTY <> 0 then 'OT'
              else 'RG'
         end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         case --deduping of hours (not touble dipping for incentives, etc.
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP','FRP', 'LRP', 'PSP', 'TNP','LED','CIN','OPM','TRA','ATB', 'INP') then 0
              else dwl.HRS_QTY
         end NI_HRS_QTY,
         case --deduping of hours (not touble dipping for incentives, etc.
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP','FRP', 'LRP', 'PSP', 'TNP','LED','CIN','OPM','TRA','ATB', 'INP') then 0
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
         --inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD
         inner join WH_OWNER.FISCAL_WEEK fw on dwl.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID AND (fw.START_DT >= date(date('2022-02-19') - (date_part('dow', date '2022-02-19')+6)) And fw.END_DT <= date(date('2022-02-19') - (date_part('dow', date '2022-02-19')- 0)))
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
--include only the specific departments, for specific earnings codes
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160') --, '8160', '8500', '8115', '8116', '8117', '8716', '8717') -- add 8500 for military
--     AND hd.DEPT_ID in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0412', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY','Bi-Weekly') --exclude salaried associates
     AND dwl.WORKER_TYPE <> 'Agency' --exclude contractor labor
     AND dwl.EARNINGS_CD in ('015', '025', '030', '035', '040', '050', '100', '15O', '1OT', '25O', '35O', '40O', 'FAV', 'FLD', 'FPD', 'FPO', 'FRZ', 'GAR', 'GRO', 'GRV', 'ICV', 'INC', 'LPD', 'LPO', 'LPY', 'LSC', 'LSI', 'MID', 'MIN', 'MIO', 'MTG', 'NET', 'NPD', 'NPO', 'NPR', 'OAD', 'OLA', 'OT1', 'OT2','OT15', 'PIO', 'PIP', 'RAD', 'RBN', 'REG', 'RG+', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP','FRP', 'LRP', 'PSP', 'TNP','LED','CIN','OPM','TRA','ATB', 'FNL', 'HERO', 'HXP', 'INP', 'NHT', 'NET', 'PD4', 'PRD', 'STY')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT','2085','2086')
)
;



--include only the specific departments, for other dept_ids
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110') --, '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0285', '0289', '0295', '0305', '0306', '0314', '0341', '0369', '0412', '0416', '0616', '0820', '0826', '0839', '0851', '0842', '0850', '1103', '1116', '1119')
     AND dwl.PAY_GROUP_CD not in ('SAL', 'SLY','Bi-Weekly')
     AND dwl.EARNINGS_CD in ('015', '025', '030', '035', '040', '050', '100', '15O', '1OT', '25O', '35O', '40O', 'FAV', 'FLD', 'FPD', 'FPO', 'FRZ', 'GAR', 'GRO', 'GRV', 'ICV', 'INC', 'LPD', 'LPO', 'LPY', 'LSC', 'LSI', 'MID', 'MIN', 'MIO', 'MTG', 'NET', 'NPD', 'NPO', 'NPR', 'OAD', 'OLA', 'OT1', 'OT2','OT15', 'PIO', 'PIP', 'RAD', 'RBN', 'REG', 'RG+', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN', 'AAB', 'FLB', 'FLP', 'FLU', 'IFP', 'WRP','FRP', 'LRP', 'PSP', 'TNP','LED','CIN','OPM','TRA','ATB')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT','2085','2086')
)