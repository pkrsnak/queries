SELECT   DWL.FISCAL_WEEK_ID,
         DWL.LOCATION_CD,
         DWL.DEPT_ID,
         DWL.EARNINGS_CD,
         DWL.PAY_GROUP_CD,
         DWL.JOB_CD,
         DWL.WORKER_TYPE,
         DWL.EARNINGS_AMT,
         DWL.HRS_QTY, rt.METRIC_INFO_CD
FROM     WH_OWNER.DCLBR_WK_LOC DWL
         JOIN WH_OWNER.PS_HR_LOCATION HL ON DWL.LOCATION_CD = HL.LOCATION_CD
         JOIN WH_OWNER.PS_HR_DEPT HD ON DWL.DEPT_ID = HD.DEPT_ID
         JOIN WH_OWNER.PS_HR_JOB HJ ON DWL.JOB_CD = HJ.JOB_CD
         JOIN WH_OWNER.PS_HR_EARNINGS HE ON DWL.EARNINGS_CD = HE.EARNINGS_CD
         JOIN WH_OWNER.EARN_PAY_TYPE_XREF EPX ON EPX.EARNINGS_CD = DWL.EARNINGS_CD
         JOIN WH_OWNER.FISCAL_WEEK FW ON DWL.FISCAL_WEEK_ID = FW.FISCAL_WEEK_ID
         left JOIN WH_OWNER.MDV_RPT_TREE RT ON RT.DEPT_ID = DWL.DEPT_ID
WHERE    DWL.FISCAL_WEEK_ID >= 202201
AND      DWL.LOCATION_CD IN ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')
--AND      dwl.dept_id in ('8578', '0933', '0820', '1150', '1641', '1654', '1404')  
and rt.METRIC_INFO_CD is null    
;



SELECT   DWL.FISCAL_WEEK_ID AS KPI_DATE,
         3 AS DIVISION_ID,
         CASE 
              WHEN DWL.LOCATION_CD = '6922' THEN '069' 
              WHEN DWL.LOCATION_CD = '6924' THEN '070' 
              WHEN DWL.LOCATION_CD = '6927' THEN '027' 
              WHEN DWL.LOCATION_CD = '6929' THEN '029' 
              WHEN DWL.LOCATION_CD = '6933' THEN '033' 
              WHEN DWL.LOCATION_CD = '6938' THEN '038' 
              WHEN DWL.LOCATION_CD = '6939' THEN '039' 
              WHEN DWL.LOCATION_CD = 'S6924' THEN '070' 
              ELSE '999' 
         END AS FACILITY_ID,
         HD.OPERATING_UNIT_CD,
         DWL.LOCATION_CD,
         HL.LOCATION_DESC,
         HL.S_DIVISION_CD,
         HL.S_REGION_CD,
         HL.S_DISTRICT_CD,
         HL.S_BANNER_CD,
         DWL.DEPT_ID,
         HD.DEPT_DESC,
         RT.METRIC_INFO_CD,
         RT.LABOR_TYPE_CD,
         HD.S_GL_DEPT_ID,
         HD.S_GL_DEPT_ID_DESC,
         DWL.EARNINGS_CD,
         HE.EARNINGS_DESC,
         EPX.PAY_TYPE_CD,
         DWL.PAY_GROUP_CD,
         DWL.JOB_CD,
         HJ.JOB_CD_DESC,
         CASE 
              WHEN DWL.OVERTIME_HRS_QTY <> '0' THEN 'OT' 
              ELSE 'RG' 
         END AS OVERTIME,
         DWL.EARNINGS_AMT,
         DWL.HRS_QTY,
         DWL.OVERTIME_HRS_QTY
FROM     WH_OWNER.DCLBR_WK_LOC DWL 
         JOIN WH_OWNER.PS_HR_LOCATION HL ON DWL.LOCATION_CD = HL.LOCATION_CD
         JOIN WH_OWNER.PS_HR_DEPT HD ON DWL.DEPT_ID = HD.DEPT_ID
         JOIN WH_OWNER.PS_HR_JOB HJ ON DWL.JOB_CD = HJ.JOB_CD
         JOIN WH_OWNER.PS_HR_EARNINGS HE ON DWL.EARNINGS_CD = HE.EARNINGS_CD
         JOIN WH_OWNER.EARN_PAY_TYPE_XREF EPX ON EPX.EARNINGS_CD = DWL.EARNINGS_CD
         left JOIN WH_OWNER.MDV_RPT_TREE RT ON RT.DEPT_ID = DWL.DEPT_ID
         JOIN WH_OWNER.FISCAL_WEEK FW ON DWL.FISCAL_WEEK_ID = FW.FISCAL_WEEK_ID
WHERE    (((HD.S_GL_DEPT_ID IN ('8100', '8500'))
        AND (HD.OPERATING_UNIT_CD NOT IN ('606905', '606909')))
     AND (DWL.LOCATION_CD IN ('6922', '6924', '6927', '6929', '6933', '6938', '6939', 'S6924')))
AND      DWL.FISCAL_WEEK_ID = 202208
--AND      dwl.dept_id in ('8578', '0933', '0820', '1150', '1641', '1654', '1404')
;

select * from WH_OWNER.MDV_RPT_TREE where dept_id = 1152;