--food distribution labor
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
         case 
              when dwl.OVERTIME_HRS_QTY <> 0 then 'OT' 
              else 'RG' 
         end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.EARNINGS_CD in ('035' ,'040' ,'050' ,'100' ,'35O' ,'FLS' ,'FNL' ,'FRG' ,'HLH' ,'HLS' ,'HLX' ,'HPN' ,'HXP' ,'INC' ,'IND' ,'JRY' ,'MOP' ,'MTG' ,'NET' ,'NPO' ,'NPR' ,'OT1' ,'PER' ,'PHS' ,'PIO' ,'PIP' ,'PPH' ,'PPX' ,'RAD' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'SDS' ,'SIC', 'SKH' ,'SKP' ,'SKS' ,'SKT' ,'SST' ,'TAD' ,'TRA', 'TRN' ,'VAB' ,'VAC' ,'VAP' ,'VAS' ,'VAT' ,'VBP' ,'VBS' ,'VBY')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT') 
     AND FISCAL_WEEK_ID between 202001 and 202012)
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.EARNINGS_CD in ('015' ,'025' ,'030' ,'035' ,'040' ,'050' ,'100' ,'15O' ,'1OT' ,'25O' ,'35O' ,'40O' ,'FAV' ,'FLD' ,'FPD' ,'FPO' ,'FRZ' ,'GAR' ,'GRO' ,'GRV' ,'HLH' ,'HXO' ,'HXP' ,'ICV' ,'INC' ,'LPD' ,'LPO' ,'LPY' ,'LSC' ,'LSI' ,'MID' ,'MIN' ,'MIO' ,'MTG' ,'NET' ,'NPD' ,'NPO' ,'NPR' ,'OAD' ,'OLA' ,'OT1' ,'OT2' ,'PIO' ,'PIP' ,'RAD' ,'RBN' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'TAD' ,'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
     AND FISCAL_WEEK_ID = 202013)
;

--mdv labor
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
         case 
              when dwl.OVERTIME_HRS_QTY <> 0 then 'OT' 
              else 'RG' 
         end overtime,
         dwl.EARNINGS_AMT,
         dwl.HRS_QTY,
         case when dwl.DEPT_ID in ('0865', '0867', '0868', '0871', '0872', '0873', '0874', '0878', '0880', '0891', '0892', '0901', '0902', '0903', '0904', '0906', '0907', '0908', '0910', '0911', '0912', '0915', '0917', '0918', '0920', '0921', '0922', '0923', '0925', '0926', '0929', '0966', '0969', '0970', '0971', '1014', '1044', '1076', '1081', '1159', '1179', '1184', '1462', '1472', '1476', '1480') then dwl.HRS_QTY else 0 end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case when dwl.DEPT_ID in ('0865', '0867', '0868', '0871', '0872', '0873', '0874', '0878', '0880', '0891', '0892', '0901', '0902', '0903', '0904', '0906', '0907', '0908', '0910', '0911', '0912', '0915', '0917', '0918', '0920', '0921', '0922', '0923', '0925', '0926', '0929', '0966', '0969', '0970', '0971', '1014', '1044', '1076', '1081', '1159', '1179', '1184', '1462', '1472', '1476', '1480') then dwl.OVERTIME_HRS_QTY else 0 end DT_OVERTIME_HRS_QTY,
         dwl.LOAD_BATCH_ID,
         dwl.ORIGIN_ID
FROM     WH_OWNER.DCLBR_WK_LOC dwl 
         inner join WH_OWNER.PS_HR_LOCATION hl on dwl.LOCATION_CD = hl.LOCATION_CD 
         inner join WH_OWNER.PS_HR_DEPT hd on dwl.DEPT_ID = hd.DEPT_ID 
         inner join WH_OWNER.PS_HR_JOB hj on dwl.JOB_CD = hj.JOB_CD 
         left outer join WH_OWNER.PS_HR_EARNINGS he on dwl.EARNINGS_CD = he.EARNINGS_CD
--WHERE    hd.S_GL_DEPT_ID in ('8100', '8500')
--     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
--     AND FISCAL_WEEK_ID between 202001 and 202012


WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND hd.DEPT_ID in ('0139', '0876', '0881', '0883', '0884', '0885', '0886', '0888', '0893', '0895', '0897', '0899', '0933', '0934', '0935', '0936', '0937', '0938', '0939', '0941', '0942', '0944', '1149', '1150', '1404', '1478', '1490')
     AND dwl.EARNINGS_CD in ('CCR', 'CLM', 'F02', 'FLS', 'FNL', 'HLH', 'HLS', 'HLX', 'HXP', 'IHO', 'IPO', 'IPT', 'IRG', 'JRY', 'JYS', 'MFL', 'MHO', 'MHX', 'MIC', 'MOT', 'MPR', 'MRG', 'MSK', 'MVC', 'N25', 'NET', 'OAD', 'OT1', 'PER', 'PHS', 'PIP', 'PPH', 'PPX', 'RAD', 'REG', 'RTO', 'SDH', 'SDS', 'SEV', 'SIC', 'SKH', 'SKS', 'TRA', 'TRN', 'VAB', 'VAC', 'VAP', 'VAS', 'VAT', 'VBP', 'VBS', 'VBY')
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID between 202001 and 202012)
OR       (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND hd.DEPT_ID not in ('0139', '0876', '0881', '0883', '0884', '0885', '0886', '0888', '0893', '0895', '0897', '0899', '0933', '0934', '0935', '0936', '0937', '0938', '0939', '0941', '0942', '0944', '1149', '1150', '1404', '1478', '1490')
     AND dwl.EARNINGS_CD in ('050', 'E25', 'F02', 'HXP', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MIC', 'MOT', 'MRG', 'N25', 'NET', 'OAD', 'OT1', 'PIP', 'RAD', 'REG', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID between 202001 and 202012)


;


------------------------------------------------------------------
-- old
------------------------------------------------------------------


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
;
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
WHERE    FISCAL_WEEK_ID = 202008
AND      hd.S_GL_DEPT_ID in ('8100', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
and      dwl.EARNINGS_CD = 'REG'
--AND    hl.exec_rollup_cd = 'DIST'
;
) lbr
where FACILITY_ID <> '999'
group by 3, 4, 5
;