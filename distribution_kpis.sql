--uat extract
SELECT   DIVISION_ID,
         KPI_TYPE,
         KPI_DATE,
         int(KPI_KEY_VALUE) kpi_key_value,
         KPI_DATA_VALUE
FROM     KPIADMIN.T_KPI_DETAIL
WHERE    SCORECARD_TYPE = 'distribution'
AND      KPI_DATE = '2020-03-07'
AND      KPI_TYPE = 'expenses_whse_all'
AND      DIVISION_ID in (2, 3)
;

--netezza extract prod
SELECT   *
FROM     KPI_WK_DIV_DISTRIB
WHERE    FISCAL_WEEK_ID = 202010
;


--netezza
--total labor hours
SELECT   'distribution' SCORECARD_TYPE,
         'labor_total_hours' KPI_TYPE,
         FISCAL_WEEK_ID DATE_VALUE,  --need end date, not weekid
         DIVISION_ID,
--         FACILITYID FACILITY_ID,
         FACILITY_ID KEY_VALUE,
         sum(NI_HRS_QTY + NI_OVERTIME_HRS_QTY) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY

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
         case 
              when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.HRS_QTY 
              else 0 
         end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case 
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0 
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
         case 
              when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.OVERTIME_HRS_QTY 
              else 0 
         end DT_OVERTIME_HRS_QTY,
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
     AND FISCAL_WEEK_ID = 202014)
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.EARNINGS_CD in ('015' ,'025' ,'030' ,'035' ,'040' ,'050' ,'100' ,'15O' ,'1OT' ,'25O' ,'35O' ,'40O' ,'FAV' ,'FLD' ,'FPD' ,'FPO' ,'FRZ' ,'GAR' ,'GRO' ,'GRV' ,'HLH' ,'HXO' ,'HXP' ,'ICV' ,'INC' ,'LPD' ,'LPO' ,'LPY' ,'LSC' ,'LSI' ,'MID' ,'MIN' ,'MIO' ,'MTG' ,'NET' ,'NPD' ,'NPO' ,'NPR' ,'OAD' ,'OLA' ,'OT1' ,'OT2' ,'PIO' ,'PIP' ,'RAD' ,'RBN' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'TAD' ,'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
     AND FISCAL_WEEK_ID = 202014)
) lbr
--where FACILITY_ID <> '999'
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
     AND FISCAL_WEEK_ID = 202014)
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.EARNINGS_CD in ('015' ,'025' ,'030' ,'035' ,'040' ,'050' ,'100' ,'15O' ,'1OT' ,'25O' ,'35O' ,'40O' ,'FAV' ,'FLD' ,'FPD' ,'FPO' ,'FRZ' ,'GAR' ,'GRO' ,'GRV' ,'HLH' ,'HXO' ,'HXP' ,'ICV' ,'INC' ,'LPD' ,'LPO' ,'LPY' ,'LSC' ,'LSI' ,'MID' ,'MIN' ,'MIO' ,'MTG' ,'NET' ,'NPD' ,'NPO' ,'NPR' ,'OAD' ,'OLA' ,'OT1' ,'OT2' ,'PIO' ,'PIP' ,'RAD' ,'RBN' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'TAD' ,'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
     AND FISCAL_WEEK_ID = 202014)
) lbr
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
         sum(NI_OVERTIME_HRS_QTY) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY

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
         case 
              when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.HRS_QTY 
              else 0 
         end DT_HRS_QTY,
         dwl.OVERTIME_HRS_QTY,
         case 
              when dwl.EARNINGS_CD in ('010' ,'015' ,'020' ,'025' ,'030' ,'035' ,'040' ,'045' ,'050' ,'055' ,'060' ,'064' ,'070' ,'074' ,'075' ,'080' ,'100' ,'150' ,'15O' ,'1OT' ,'1PR' ,'200' ,'250' ,'25O' ,'300' ,'30P' ,'35O' ,'40O' ,'40P' ,'500' ,'AP4' ,'CCR' ,'E25' ,'FPD' ,'FPO' ,'FRZ' ,'HXP' ,'ICM' ,'LDP' ,'LDR' ,'LPD' ,'LPO' ,'LPR' ,'LPY' ,'LSI' ,'MI2' ,'MIN' ,'MIO' ,'MIV' ,'MOT' ,'MRG' ,'N25' ,'NGT' ,'NPD' ,'NPO' ,'NPR' ,'NPT' ,'O10' ,'O15' ,'O20' ,'O25' ,'O30' ,'O35' ,'O40' ,'O45' ,'O50' ,'O55' ,'O60' ,'O64' ,'O74' ,'O75' ,'O80' ,'ONF' ,'ONP' ,'OSF' ,'OSP' ,'OV1' ,'P10' ,'P15' ,'P20' ,'P25' ,'P30' ,'P35' ,'P40' ,'P45' ,'P50' ,'P53' ,'P55' ,'P60' ,'P64' ,'P74' ,'P75' ,'P80' ,'PO5' ,'PR1' ,'PR5' ,'RNP' ,'SW1' ,'SW2' ,'SW3' ,'SW4' ,'SW5' ,'SWK' ,'SWR' ,'TEN' ,'THR' ,'TWY') then 0 
              else dwl.OVERTIME_HRS_QTY
         end NI_OVERTIME_HRS_QTY,
         case 
              when dwl.DEPT_ID in ('0410', '0411', '0412', '0413', '0419', '0420', '0717', '0819', '0840', '0844', '0845', '0847', '0850', '0879', '0955', '0958', '1119', '1140', '1434', '1436', '1638', '1639', '1640', '1642', '1643', '1644', '1645', '1646', '1647', '1648', '1649', '1650', '1651', '1652', '1653', '1654', '1655', '1657', '1658', '1659', '1660') then dwl.OVERTIME_HRS_QTY 
              else 0 
         end DT_OVERTIME_HRS_QTY,
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
     AND FISCAL_WEEK_ID = 202014)
OR       (hd.S_GL_DEPT_ID in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.EARNINGS_CD in ('015' ,'025' ,'030' ,'035' ,'040' ,'050' ,'100' ,'15O' ,'1OT' ,'25O' ,'35O' ,'40O' ,'FAV' ,'FLD' ,'FPD' ,'FPO' ,'FRZ' ,'GAR' ,'GRO' ,'GRV' ,'HLH' ,'HXO' ,'HXP' ,'ICV' ,'INC' ,'LPD' ,'LPO' ,'LPY' ,'LSC' ,'LSI' ,'MID' ,'MIN' ,'MIO' ,'MTG' ,'NET' ,'NPD' ,'NPO' ,'NPR' ,'OAD' ,'OLA' ,'OT1' ,'OT2' ,'PIO' ,'PIP' ,'RAD' ,'RBN' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'TAD' ,'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('2007', '2016', '2037', '2038', '2040', '2052', '2054', '2915', '2058', '2067', '2071', '2917', 'GGM', 'GGR', 'GPR', 'VSPT')
     AND FISCAL_WEEK_ID = 202014)
) lbr
group by 3, 4, 5
;

--mdv labor hours
--netezza
--total labor hours
SELECT   'distribution' SCORECARD_TYPE,
         'labor_total_hours' KPI_TYPE,
         FISCAL_WEEK_ID DATE_VALUE,  --need end date, not weekid
         DIVISION_ID,
         FACILITY_ID KEY_VALUE,
         round(TOTAL_HRS_QTY * (spt_cases / tot_cases), 2) DATA_VALUE,
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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD <> 'MSN'
     AND dwl.EARNINGS_CD in ('050', 'E25', 'F02', 'HXP', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MIC', 'MOT', 'MRG', 'N25', 'NET', 'OAD', 'OT1', 'PIP', 'RAD', 'REG', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID = 202014)

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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD <> 'MSN'
     AND dwl.EARNINGS_CD in ('050', 'E25', 'F02', 'HXP', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MIC', 'MOT', 'MRG', 'N25', 'NET', 'OAD', 'OT1', 'PIP', 'RAD', 'REG', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('6929', '6933')
     AND FISCAL_WEEK_ID = 202014)
) lbr
group by 1, 2, 3

union all

--salary labor
SELECT   202014 fiscal_week,
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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID between 202013 and 202014)
group by 2,3

union all

SELECT   202014 fiscal_week,
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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6929', '6933')
     AND FISCAL_WEEK_ID between 202013 and 202014)
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
WHERE    fw.FISCAL_WEEK_ID = 202014
AND      msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1

union all

SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 90 else 80 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD in (80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     MDV_WHSE_SHIP_DTL msd 
         join fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.FISCAL_WEEK_ID = 202014
AND      msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1
) cases
on labor.FACILITY_ID = cases.FACILITYID
) final
;



--mdv overtime hours
--netezza
--total overtime hours
SELECT   'distribution' SCORECARD_TYPE,
         'labor_overtime_hours' KPI_TYPE,
         FISCAL_WEEK_ID DATE_VALUE,  --need end date, not weekid
         DIVISION_ID,
         FACILITY_ID KEY_VALUE,
         round(OVERTIME_HRS_QTY * (spt_cases / tot_cases), 2) DATA_VALUE,
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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD <> 'MSN'
     AND dwl.EARNINGS_CD in ('050', 'E25', 'F02', 'HXP', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MIC', 'MOT', 'MRG', 'N25', 'NET', 'OAD', 'OT1', 'PIP', 'RAD', 'REG', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID = 202011)

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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD <> 'MSN'
     AND dwl.EARNINGS_CD in ('050', 'E25', 'F02', 'HXP', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MIC', 'MOT', 'MRG', 'N25', 'NET', 'OAD', 'OT1', 'PIP', 'RAD', 'REG', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('6929', '6933')
     AND FISCAL_WEEK_ID = 202011)
) lbr
group by 1, 2, 3

union all

--salary labor
SELECT   202011 fiscal_week,
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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID between 202010 and 202011)
group by 2,3

union all

SELECT   202011 fiscal_week,
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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6929', '6933')
     AND FISCAL_WEEK_ID between 202010 and 202011)
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
WHERE    fw.FISCAL_WEEK_ID = 202011
AND      msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1

union all

SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 90 else 80 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD in (80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     MDV_WHSE_SHIP_DTL msd 
         join fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.FISCAL_WEEK_ID = 202011
AND      msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1
) cases
on labor.FACILITY_ID = cases.FACILITYID
) final
;




--mdv overtime hours
--netezza
--total labor dollars
SELECT   'distribution' SCORECARD_TYPE,
         'labor_total_dollars' KPI_TYPE,
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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD <> 'MSN'
--     AND dwl.EARNINGS_CD in ('050', 'E25', 'F02', 'HXP', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MIC', 'MOT', 'MRG', 'N25', 'NET', 'OAD', 'OT1', 'PIP', 'RAD', 'REG', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID = 202012)

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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD <> 'MSN'
--     AND dwl.EARNINGS_CD in ('050', 'E25', 'F02', 'HXP', 'INC', 'IOV', 'IPO', 'IPT', 'IRG', 'MIC', 'MOT', 'MRG', 'N25', 'NET', 'OAD', 'OT1', 'PIP', 'RAD', 'REG', 'RTO', 'SDH', 'TAD', 'TRA', 'TRN')
     AND dwl.LOCATION_CD in ('6929', '6933')
     AND FISCAL_WEEK_ID = 202012)
) lbr
group by 1, 2, 3

union all

--salary labor
SELECT   202012 fiscal_week,
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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
     AND FISCAL_WEEK_ID between 202011 and 202012)
group by 2,3

union all

SELECT   202012 fiscal_week,
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
WHERE    (hd.S_GL_DEPT_ID in ('8100', '8500')
     AND dwl.PAY_GROUP_CD = 'MSN'
     AND dwl.LOCATION_CD in ('6929', '6933')
     AND FISCAL_WEEK_ID between 202011 and 202012)
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
WHERE    fw.FISCAL_WEEK_ID = 202012
AND      msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1

union all

SELECT   case when msd.DEPT_CD in (87, 89, 84, 88, 90) then 90 else 80 end facilityid,
         sum(msd.SHIP_CASE_QTY) total_cases,
         sum(case when msd.DEPT_CD in (80, 90) then msd.SHIP_CASE_QTY else 0 end) split_cases
FROM     MDV_WHSE_SHIP_DTL msd 
         join fiscal_day fd on (msd.SHIP_DATE = fd.SALES_DT) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.FISCAL_WEEK_ID = 202012
AND      msd.DEPT_CD in (87, 89, 84, 88, 77, 79, 78, 80, 90)
GROUP BY 1
) cases
on labor.FACILITY_ID = cases.FACILITYID
) final
;

--netezza
--total warehouse office labor dollars
SELECT   'distribution' SCORECARD_TYPE,
         'labor_whse_admin_dollars' KPI_TYPE,
         FISCAL_WEEK_ID DATE_VALUE,  --need end date, not weekid
         DIVISION_ID,
--         FACILITYID FACILITY_ID,
         FACILITY_ID KEY_VALUE,
         sum(EARNINGS_TOT) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY

from (
--hourly office labor
SELECT   FISCAL_WEEK_ID,
         division_id, 
         facility_id, 
         sum(x.EARNINGS_AMT) EARNINGS_TOT,
         sum(x.HRS_QTY) HRS_TOT,
         sum(x.OVERTIME_HRS_QTY) OVERTIME_HRS_TOT,
         sum((x.HRS_QTY + x.OVERTIME_HRS_QTY)) TOTAL_HRS
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
              when dwl.LOCATION_CD = '1010' then '008' 
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
              when dwl.LOCATION_CD = 'SPT' then '001' 
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
--WHERE    FISCAL_WEEK_ID between 202001 and 202016
WHERE    FISCAL_WEEK_ID = 202016
AND      hd.S_GL_DEPT_ID in ('8100')
AND      trim(hd.OPERATING_UNIT_CD) in ('FD', '201010', '201020', '202060', '202100', '202900', 'MDV', '606905', '606909', '606906', '606907')
AND      dwl.PAY_GROUP_CD in ('HLY', 'HRN', 'MHN')
--     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.EARNINGS_CD in ('035' ,'040' ,'050' ,'100' ,'35O' ,'FLS' ,'FNL' ,'FRG' ,'HLH' ,'HLS' ,'HLX' ,'HPN' ,'HXP' ,'INC' ,'IND' ,'JRY' ,'MOP' ,'MTG' ,'NET' ,'NPO' ,'NPR' ,'OT1' ,'PER' ,'PHS' ,'PIO' ,'PIP' ,'PPH' ,'PPX' ,'RAD' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'SDS' ,'SIC', 'SKH' ,'SKP' ,'SKS' ,'SKT' ,'SST' ,'TAD' ,'TRA', 'TRN' ,'VAB' ,'VAC' ,'VAP' ,'VAS' ,'VBP' ,'VBS' ,'VBY')
) x
group by 1, 2, 3

union all 

--salary office labor
SELECT   202016 fiscal_week_id,
         division_id, 
         facility_id, 
         sum(x.EARNINGS_AMT / 2) EARNINGS_TOT,
         sum(x.HRS_QTY / 2) HRS_TOT,
         sum(x.OVERTIME_HRS_QTY / 2) OVERTIME_HRS_TOT,
         sum((x.HRS_QTY + x.OVERTIME_HRS_QTY) / 2) TOTAL_HRS
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
              when dwl.LOCATION_CD = '1010' then '008' 
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
              when dwl.LOCATION_CD = 'SPT' then '001' 
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
WHERE    FISCAL_WEEK_ID between 202015 and 202016
AND      hd.S_GL_DEPT_ID in ('8100')
AND      trim(hd.OPERATING_UNIT_CD) in ('FD', '201010', '201020', '202060', '202100', '202900', 'MDV', '606905', '606909', '606906', '606907')
AND      dwl.PAY_GROUP_CD in ('SLY', 'MSN', 'SAL')
--     AND hd.DEPT_ID not in ('0839', '0843', '0851', '0842', '1116')
     AND dwl.EARNINGS_CD in ('035' ,'040' ,'050' ,'100' ,'35O' ,'FLS' ,'FNL' ,'FRG' ,'HLH' ,'HLS' ,'HLX' ,'HPN' ,'HXP' ,'INC' ,'IND' ,'JRY' ,'MOP' ,'MTG' ,'NET' ,'NPO' ,'NPR' ,'OT1' ,'PER' ,'PHS' ,'PIO' ,'PIP' ,'PPH' ,'PPX' ,'RAD' ,'REG' ,'RG+' ,'RTO' ,'SDH' ,'SDS' ,'SIC', 'SKH' ,'SKP' ,'SKS' ,'SKT' ,'SST' ,'TAD' ,'TRA', 'TRN' ,'VAB' ,'VAC' ,'VAP' ,'VAS' ,'VBP' ,'VBS' ,'VBY')
) x
group by 2,3
) y
group by 1,2,3,4,5
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
         max(fiscal_day_dt) DATE_VALUE,  --need end date, not weekid
         hc.DIVISION_ID,
         hc.FACILITY_ID KEY_VALUE,
         trunc(avg(head_count) + 1) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
select division_id, facility_id, fiscal_day_dt, count(*) head_count
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
              when loc.LOCATION_CD = '2071' and dept.dept_id in ('1103', '1115', '1116', '1117', '1118', '1119', '1140', '1434', '1436') then '066' 
              when loc.LOCATION_CD = '2071' and dept.dept_id not in ('1103', '1115', '1116', '1117', '1118', '1119', '1140', '1434', '1436') then '071' 
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
         dept.dept_id,
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
WHERE    ea.fiscal_day_dt between '01-05-2020' and '01-11-2020'
AND      ea.gl_dept_id in ('8100', '8105', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
)
group by division_id, facility_id, fiscal_day_dt
) hc
where hc.FACILITY_ID <> '999'
group by 4, 5
;

--pshrdw
--termed headcount
SELECT   'distribution' SCORECARD_TYPE,
         'headcount_termed' KPI_TYPE,
         tc.end_dt DATE_VALUE,  --need end date, not MAX function
         tc.DIVISION_ID,
         tc.FACILITY_ID KEY_VALUE,
         count(tc.empl_id) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
SELECT   eah.fiscal_day_dt, fw.end_dt, 
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
--              when loc.LOCATION_CD = '2071' then '071' 
              when loc.LOCATION_CD = '2071' and dept.dept_id in ('1103', '1115', '1116', '1117', '1118', '1119', '1140', '1434', '1436') then '066' 
              when loc.LOCATION_CD = '2071' and dept.dept_id not in ('1103', '1115', '1116', '1117', '1118', '1119', '1140', '1434', '1436') then '071' 
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
         inner join whmgr.fiscal_day fd on eah.fiscal_day_dt = fd.fiscal_day_dt 
         inner join whmgr.fiscal_week fw on fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID
WHERE    eah.fiscal_day_dt between '01-05-2020' and '03-07-2020'
AND      eah.status_flg = 'Y'
AND      eah.gl_dept_id in ('8100', '8110', '8160', '8500', '8115', '8116', '8117', '8716', '8717')
) tc
where tc.FACILITY_ID <> '999'
group by  3, 4, 5  --needs fixing once DATE_KEY is fixed
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
WHERE    fw.end_dt = '03-14-2020'
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
/*
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
WHERE    date(receipt_dtim) = '02-19-2022'
GROUP BY 1, 2, 3, 4, 5, 7, 8
;
*/
--cases_received
--source: datawhse02, entods
SELECT 'distribution' SCORECARD_TYPE,
irctd.division_id DIVISION_ID,
'cases_received' KPI_TYPE,
'F' DATA_GRANULARITY,
'W' TIME_GRANULARITY,
DATE('02-20-2022') - (WEEKDAY(DATE('02-20-2022')) + 1) UNITS DAY KPI_DATE,
irctd.facility_id KPI_KEY_VALUE,
sum(irctd.rct_qty / irctd.item_pack_qty) KPI_DATA_VALUE
FROM entods@ods_prd_tcp:ent_irctd irctd
-- inner join #P_IX_datawhse_02.$pd_db_schema_datawhse02_whmgr#.dc_item i on irctd.facility_id = i.facility_id and irctd.prod_id = i.item_nbr
WHERE date(irctd.receipt_dtim) between DATE('02-20-2022') - (WEEKDAY(DATE('02-20-2022')) + 7) UNITS DAY and DATE('02-20-2022') - (WEEKDAY(DATE('02-20-2022')) + 1) UNITS DAY
GROUP BY 1, 2, 3, 4, 5, 6, 7
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
--     AND wsd.FACILITY_ID not in (16)
     AND wsd.COMMODITY_CODE not in (900))
GROUP BY fw.end_dt, 
         wsd.FACILITY_ID
;

--sales by stocked facility - fd
--source:  datawhse02
SELECT   'distribution' SCORECARD_TYPE,
         'sales_stocked' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         2 DIVISION_ID,
         sh.ship_facility_id KEY_VALUE,
         sum(sh.TOTAL_SALES_AMT) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_SALES_HST sh 
         join WHMGR.fiscal_day fd on (sh.TRANSACTION_DATE = fd.SALES_DT) 
         join WHMGR.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.end_dt = '01-25-2020' --need to determine prior week Saturday date
--     AND sh.FACILITY_ID not in (16)
group by fw.end_dt,
--         sh.FACILITY_ID,
         sh.ship_facility_id
;

--sales by stocked facility - mdv 
--source:  eisdw01
SELECT   'distribution' SCORECARD_TYPE,
         'sales_stocked' KPI_TYPE,
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

--cases shipped by stocked facility - fd
--source:  datawhse02
SELECT   'distribution' SCORECARD_TYPE,
         'cases_shipped_stocked' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         2 DIVISION_ID,
         sh.ship_facility_id KEY_VALUE,
         sum(sh.shipped_qty) DATA_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     WHMGR.DC_SALES_HST sh 
         join WHMGR.fiscal_day fd on (sh.TRANSACTION_DATE = fd.SALES_DT) 
         join WHMGR.fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    fw.end_dt = '03-07-2020' --need to determine prior week Saturday date
  AND    sh.order_type_cd not in ('CR')  
group by fw.end_dt,
--         sh.FACILITY_ID,
         sh.ship_facility_id
;


--cases shipped by stocked facility - mdv 
--source:  eisdw01
SELECT   'distribution' SCORECARD_TYPE,
         'cases_shipped_stocked' KPI_TYPE,
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


--total abs value inventory adjustments by facility
SELECT   'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         'inventory_adjust_total' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         KPI_DATE,
         KPI_KEY_VALUE,
         sum(KPI_DATA_VALUE) KPI_DATA_VALUE
from
(
--fd inventory adjustments except SAT / COL
--source:  datawhse02
SELECT   dr.division_id,
         fd.fiscal_week_id KPI_DATE, --need week end date for prior week
         fia.facility_id KPI_KEY_VALUE,
         sum(abs(fia.ext_layer_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.dc_d_fac_invctrl_adj fia
         inner join whmgr.FISCAL_DAY fd on fia.billing_date = fd.SALES_DT 
         inner join whmgr.DC_FACILITY df on fia.FACILITY_ID = df.FACILITY_ID 
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fia.ext_layer_cost_amt <> 0
AND      fd.FISCAL_WEEK_ID = 202025 --need to determine prior week start - end
AND      fia.invtry_adjust_cd in ('CC', 'FL', 'CL', 'CG', 'DS', 'MA', 'AM', 'PC', 'PI', 'RC')
GROUP BY dr.division_id, fia.facility_id, fd.fiscal_week_id
 
UNION ALL
 
--fd inventory adjustments for SAT / COL
SELECT   dr.division_id,
         fd.fiscal_week_id KPI_DATE, --need week end date for prior week
         mia.facility_id KPI_KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.mdv_d_fac_invctrl_adj mia
         inner join whmgr.FISCAL_DAY fd on mia.invtry_adj_date = fd.SALES_DT 
         inner join whmgr.DC_FACILITY df on mia.FACILITY_ID = df.FACILITY_ID 
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    mia.ext_layer_cost_amt <> 0
AND      fd.FISCAL_WEEK_ID = 202025 --need to determine prior week start - end
AND      mia.facility_id in (80, 90)
AND      mia.invtry_adjust_cd in ('CC', 'FL', 'CL', 'CG', 'DS', 'MA', 'AM', 'PC', 'PI', 'RC')
GROUP BY dr.division_id, mia.facility_id, fd.fiscal_week_id
 
UNION ALL

--mdv inventory adjustments928424
SELECT   dr.division_id,
         fd.fiscal_week_id KPI_DATE, --need week end date for prior week
         mia.facility_id KPI_KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.mdv_d_fac_invctrl_adj mia
         inner join whmgr.FISCAL_DAY fd on mia.invtry_adj_date = fd.SALES_DT 
         inner join whmgr.DC_FACILITY df on mia.FACILITY_ID = df.FACILITY_ID 
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    mia.ext_layer_cost_amt <> 0
AND      fd.FISCAL_WEEK_ID = 202025 --need to determine prior week start - end
and      mia.facility_id not in (80, 90)
AND      mia.invtry_adjust_cd in ('CC', 'FL', 'CL', 'CG', 'DS', 'MA', 'AM', 'PC', 'PI', 'RC')
GROUP BY dr.division_id, mia.facility_id, fd.fiscal_week_id

UNION ALL

--fd customer credits per definition
SELECT   dr.DIVISION_ID,
         fd.FISCAL_WEEK_ID KPI_DATE,
         dsh.SHIP_FACILITY_ID KPI_KEY_VALUE,
         sum(abs(dsh.TOTAL_SALES_AMT)) KPI_DATA_VALUE
FROM     whmgr.DC_SALES_HST dsh 
         inner join whmgr.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT 
         inner join whmgr.DC_FACILITY df on dsh.SHIP_FACILITY_ID = df.FACILITY_ID 
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.FISCAL_WEEK_ID = 202025
AND      ((dsh.FACILITY_ID <> 1
        AND dsh.CREDIT_REASON_CD in ('01', '03', '05', '08', '09', '10', '11', '12', '19', '20', '21', '22', '26', '29', '40''43', '44', '45', '48'))
     OR  (dsh.FACILITY_ID = 1
        AND dsh.CREDIT_REASON_CD in ('01', '02', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '23', '24', '25')))
GROUP BY dr.DIVISION_ID, dsh.SHIP_FACILITY_ID, fd.FISCAL_WEEK_ID
) x
group by division_id, KPI_DATE, KPI_KEY_VALUE
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
AND      fia.invtry_adjust_cd in ('WD', 'DA')
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
AND      mia.invtry_adjust_cd in ('WD', 'DA')
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
AND      mia.invtry_adjust_cd in ('WD', 'DA')
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
         sum(iloc.SLOT_COUNT) KPI_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_EXE_ILOC iloc 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on iloc.FACILITYID = dx.SWAT_ID
WHERE    iloc.ISTA_ID = 'F'
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
         sum(iloc.SLOT_COUNT) KPI_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_EXE_ILOC iloc 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on iloc.FACILITYID = dx.SWAT_ID
WHERE    iloc.ISTA_ID = 'F'
AND      iloc.ICAT_ID = 'R'
--AND      WEEK_END_DT = '2020-01-08'
GROUP BY dx.ENTERPRISE_KEY, iloc.FACILITYID
;

--warehouse selection slots total by facility
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'slots_selection_total' KPI_TYPE,
--         WEEK_END_DT DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         iloc.FACILITYID KEY_VALUE,
         sum(iloc.SLOT_COUNT) KPI_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_EXE_ILOC iloc 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on iloc.FACILITYID = dx.SWAT_ID
WHERE    iloc.ICAT_ID = 'S'
AND      iloc.ISTA_ID not in ('H')
--AND      WEEK_END_DT = '2020-01-08'
GROUP BY dx.ENTERPRISE_KEY, iloc.FACILITYID
;

--warehouse reserve slots total by facility
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'slots_reserve_total' KPI_TYPE,
--         WEEK_END_DT DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         iloc.FACILITYID KEY_VALUE,
         sum(iloc.SLOT_COUNT) KPI_VALUE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     CRMADMIN.T_WHSE_EXE_ILOC iloc 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on iloc.FACILITYID = dx.SWAT_ID
WHERE    iloc.ICAT_ID = 'R'
AND      iloc.ISTA_ID not in ('H')
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

--warehouse actual selection hours by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         'els_actuals' KPI_TYPE,
         x.WEEK_ENDING_DATE DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         FACILITYID KEY_VALUE, 
         round(sum(actual_time_on_standard), 2) data_value,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
SELECT   wed.WEEK_ENDING_DATE,
         aassg.FACILITYID,
         aassg.dc_id,
         aassg.whse_id,
         aassg.assoc_id,
         aassg.std_tim,
         value(hour(aassg.std_tim) * 60 + minute(aassg.std_tim) + (decimal(second(aassg.std_tim)) / 60), 0) / 60 std_time,
         aassg.start_dtim,
         aassg.end_dtim,
         (aassg.end_dtim - aassg.start_dtim) elapse_tim,
         value(hour(aassg.end_dtim - aassg.start_dtim) * 60 + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60), 0) / 60 elapse_time,
         aassg.suspend_tim,
         value(hour(aassg.suspend_tim) * 60 + minute(aassg.suspend_tim) + (decimal(second(aassg.suspend_tim)) / 60), 0) / 60 suspend_time,
         aassg.walk_tim,
         value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0) / 60 walk_time,
         aassg.delay_tim,
         value(hour(aassg.delay_tim) * 60 + minute(aassg.delay_tim) + (decimal(second(aassg.delay_tim)) / 60), 0) / 60 delay_time,
         (value(hour(aassg.end_dtim - aassg.start_dtim) * 60 + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60), 0) / 60) - (value(hour(aassg.suspend_tim) * 60 + minute(aassg.suspend_tim) + (decimal(second(aassg.suspend_tim)) / 60), 0) / 60) - (value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0) / 60) - (value(hour(aassg.delay_tim) * 60 + minute(aassg.delay_tim) + (decimal(second(aassg.delay_tim)) / 60), 0) / 60) actual_time_on_standard,
         aseld.jcty_id,
         aseld.jcfn_id,
         aseld.jcsf_id,
         aseld.jbcd_id,
         aassg.assg_id,
         aassg.asgt_id
FROM     crmadmin.T_WHSE_EXE_AASSG aassg 
         inner join crmadmin.T_WHSE_EXE_ASELD aseld on aassg.FACILITYID = aseld.FACILITYID and aseld.assg_id = aassg.assg_id 
         inner join CRMADMIN.V_WED wed on wed.LOOKUP_DATE = aassg.RPT_DT
WHERE    wed.WEEK_ENDING_DATE = '2020-03-21' --between '2020-01-25' and current date
AND      aassg.asta_id = 'C'
AND      aassg.start_dtim IS NOT NULL
AND      aassg.end_dtim IS NOT NULL
AND      aseld.start_dtim IS NOT NULL
AND      aseld.complete_dtim IS NOT NULL
AND      aassg.asgt_id = 'S'
AND      not(aseld.FACILITYID = '001' AND aassg.RPTG_ID in ('X', ''))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST'))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'E000' and 'E999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'X000' and 'X999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'F000' and 'F999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'L000' and 'L999')
GROUP BY wed.WEEK_ENDING_DATE, aassg.FACILITYID, aassg.dc_id, aassg.whse_id, 
         aassg.assoc_id, aassg.std_tim, aassg.start_dtim, aassg.end_dtim, 
         (aassg.end_dtim - aassg.start_dtim), aassg.suspend_tim, 
         aassg.walk_tim, aassg.delay_tim, aseld.jcty_id, aseld.jcfn_id, 
         aseld.jcsf_id, aseld.jbcd_id, aassg.assg_id, aassg.asgt_id
) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by x.WEEK_ENDING_DATE, dx.ENTERPRISE_KEY, x.FACILITYID
;


--warehouse els standard minutes by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         'els_standards' KPI_TYPE,
--         x.per_wk_id DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         x.FACILITYID KEY_VALUE,
         round(SUM(std_time), 2) data_value,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     (
SELECT   wed.WEEK_ENDING_DATE,
         aassg.FACILITYID,
         aassg.dc_id,
         aassg.whse_id,
         aassg.assoc_id,
--         ((aseld.prod_qty - value(aseld.out_qty,0)) / aseld.unit_ship_cse) cases_selected,
         aassg.std_tim,
         value(hour(aassg.std_tim) * 60 + minute(aassg.std_tim) + (decimal(second(aassg.std_tim)) / 60), 0) / 60 std_time,
         aassg.start_dtim,
         aassg.end_dtim,
         (aassg.end_dtim - aassg.start_dtim) elapse_tim,
         value(hour(aassg.end_dtim - aassg.start_dtim) * 60 + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60), 0) / 60 elapse_time,
         aassg.suspend_tim,
         value(hour(aassg.suspend_tim) * 60 + minute(aassg.suspend_tim) + (decimal(second(aassg.suspend_tim)) / 60), 0) / 60 suspend_time,
         aassg.walk_tim,
         value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0) / 60 walk_time,
         aassg.delay_tim,
         value(hour(aassg.delay_tim) * 60 + minute(aassg.delay_tim) + (decimal(second(aassg.delay_tim)) / 60), 0) / 60 delay_time,
         (value(hour(aassg.end_dtim - aassg.start_dtim) * 60 + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60), 0) / 60) - (value(hour(aassg.suspend_tim) * 60 + minute(aassg.suspend_tim) + (decimal(second(aassg.suspend_tim)) / 60), 0) / 60) - (value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0) / 60) - (value(hour(aassg.delay_tim) * 60 + minute(aassg.delay_tim) + (decimal(second(aassg.delay_tim)) / 60), 0) / 60) actual_time_on_standard,
         aseld.jcty_id,
         aseld.jcfn_id,
         aseld.jcsf_id,
         aseld.jbcd_id,
         aassg.assg_id,
         aassg.asgt_id
FROM     crmadmin.T_WHSE_EXE_AASSG aassg 
         inner join crmadmin.T_WHSE_EXE_ASELD aseld on aassg.FACILITYID = aseld.FACILITYID and aseld.assg_id = aassg.assg_id 
         inner join CRMADMIN.V_WED wed on wed.LOOKUP_DATE = aassg.RPT_DT
WHERE    wed.WEEK_ENDING_DATE = '2020-03-07' --between '2020-01-25' and current date
AND      aassg.asta_id = 'C'
AND      aassg.start_dtim IS NOT NULL
AND      aassg.end_dtim IS NOT NULL
AND      aseld.start_dtim IS NOT NULL
AND      aseld.complete_dtim IS NOT NULL
AND      aassg.asgt_id = 'S'
AND      not(aseld.FACILITYID = '001' AND aassg.RPTG_ID in ('X', ''))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST'))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'E000' and 'E999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'X000' and 'X999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'F000' and 'F999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'L000' and 'L999')
GROUP BY wed.WEEK_ENDING_DATE, aassg.FACILITYID, aassg.dc_id, aassg.whse_id, 
         aassg.assoc_id, aassg.std_tim, aassg.start_dtim, aassg.end_dtim, 
         (aassg.end_dtim - aassg.start_dtim), aassg.suspend_tim, 
         aassg.walk_tim, aassg.delay_tim, aseld.jcty_id, aseld.jcfn_id, 
         aseld.jcsf_id, aseld.jbcd_id, aassg.assg_id, aassg.asgt_id) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
GROUP BY dx.ENTERPRISE_KEY, x.FACILITYID
;

--warehouse actual selection hours by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         'labor_selector_hours' KPI_TYPE,
         x.WEEK_ENDING_DATE DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         FACILITYID KEY_VALUE, 
         round(sum(actual_time_on_standard), 2) data_value,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
SELECT   wed.WEEK_ENDING_DATE,
         aassg.FACILITYID,
         aassg.dc_id,
         aassg.whse_id,
         aassg.assoc_id,
         aassg.std_tim,
         value(hour(aassg.std_tim) * 60 + minute(aassg.std_tim) + (decimal(second(aassg.std_tim)) / 60), 0) / 60 std_time,
         aassg.start_dtim,
         aassg.end_dtim,
         (aassg.end_dtim - aassg.start_dtim) elapse_tim,
         value(hour(aassg.end_dtim - aassg.start_dtim) * 60 + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60), 0) / 60 elapse_time,
         aassg.suspend_tim,
         value(hour(aassg.suspend_tim) * 60 + minute(aassg.suspend_tim) + (decimal(second(aassg.suspend_tim)) / 60), 0) / 60 suspend_time,
         aassg.walk_tim,
         value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0) / 60 walk_time,
         aassg.delay_tim,
         value(hour(aassg.delay_tim) * 60 + minute(aassg.delay_tim) + (decimal(second(aassg.delay_tim)) / 60), 0) / 60 delay_time,
         (value(hour(aassg.end_dtim - aassg.start_dtim) * 60 + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60), 0) / 60) - (value(hour(aassg.suspend_tim) * 60 + minute(aassg.suspend_tim) + (decimal(second(aassg.suspend_tim)) / 60), 0) / 60) - (value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0) / 60) - (value(hour(aassg.delay_tim) * 60 + minute(aassg.delay_tim) + (decimal(second(aassg.delay_tim)) / 60), 0) / 60) actual_time_on_standard,
         aseld.jcty_id,
         aseld.jcfn_id,
         aseld.jcsf_id,
         aseld.jbcd_id,
         aassg.assg_id,
         aassg.asgt_id
FROM     crmadmin.T_WHSE_EXE_AASSG aassg 
         inner join crmadmin.T_WHSE_EXE_ASELD aseld on aassg.FACILITYID = aseld.FACILITYID and aseld.assg_id = aassg.assg_id 
         inner join CRMADMIN.V_WED wed on wed.LOOKUP_DATE = aassg.RPT_DT
WHERE    wed.WEEK_ENDING_DATE = '2020-03-07' --between '2020-01-25' and current date
AND      aassg.asta_id = 'C'
AND      aassg.start_dtim IS NOT NULL
AND      aassg.end_dtim IS NOT NULL
AND      aseld.start_dtim IS NOT NULL
AND      aseld.complete_dtim IS NOT NULL
AND      aassg.asgt_id = 'S'
AND      not(aseld.FACILITYID = '001' AND aassg.RPTG_ID in ('X', ''))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST'))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'E000' and 'E999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'X000' and 'X999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'F000' and 'F999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'L000' and 'L999')
GROUP BY wed.WEEK_ENDING_DATE, aassg.FACILITYID, aassg.dc_id, aassg.whse_id, 
         aassg.assoc_id, aassg.std_tim, aassg.start_dtim, aassg.end_dtim, 
         (aassg.end_dtim - aassg.start_dtim), aassg.suspend_tim, 
         aassg.walk_tim, aassg.delay_tim, aseld.jcty_id, aseld.jcfn_id, 
         aseld.jcsf_id, aseld.jbcd_id, aassg.assg_id, aassg.asgt_id
) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by x.WEEK_ENDING_DATE, dx.ENTERPRISE_KEY, x.FACILITYID
;


--warehouse cases selected by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         'cases_selected' KPI_TYPE,
          'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         x.WEEK_ENDING_DATE KPI_DATE,
         FACILITYID KPI_KEY_VALUE, 
         sum(cases_selected) KPI_DATA_VALUE
from (SELECT aseld.FACILITYID, d.WEEK_ENDING_DATE, SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected FROM CRMADMIN.T_WHSE_EXE_ASELD aseld inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id inner join CRMADMIN.V_WED d on aassg.rpt_dt = d.LOOKUP_DATE and d.WEEK_ENDING_DATE between '2020-01-25' and current date WHERE not(aseld.FACILITYID = '001' AND aassg.RPTG_ID in ('X', '')) AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST')) AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'E000' and 'E999') AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'X000' and 'X999') AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'F000' and 'F999') AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'L000' and 'L999') AND aassg.RPTG_ID is not null GROUP BY aseld.FACILITYID, d.WEEK_ENDING_DATE ) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by dx.ENTERPRISE_KEY, x.FACILITYID, x.WEEK_ENDING_DATE
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