SELECT   aseld.FACILITYID,
         d.WEEK_ENDING_DATE,
         --vd.COMPANY_WEEK_ID,
         --aassg.assoc_id,
         SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld
         inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id
         --INNER JOIN CRMADMIN.V_DATE vd ON (vd.DATE_KEY = aassg.RPT_DT)
         inner join CRMADMIN.V_WED d on aassg.rpt_dt = d.LOOKUP_DATE --and d.WEEK_ENDING_DATE = '2021-04-17'
WHERE
--        vd.COMPANY_YEAR_ID = 2021
--    AND COMPANY_WEEK_ID IN (9,10,11,12,13,14,15,16)
    d.WEEK_ENDING_DATE <= '2021-04-24'
    AND d.WEEK_ENDING_DATE >= '2021-03-06'
    AND not(aseld.FACILITYID = '001' AND aassg.RPTG_ID in ('X', ''))
    AND not(aseld.FACILITYID = '070'AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST'))
    AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'E000' and 'E999')
    AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'X000' and 'X999')
    AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'F000' and 'F999')
    AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'L000' and 'L999')
    AND aassg.RPTG_ID is not NULL
    AND aseld.FACILITYID = '001'
GROUP BY aseld.FACILITYID,
    --aassg.assoc_id,
    d.WEEK_ENDING_DATE
    --vd.COMPANY_WEEK_ID
;



SELECT   aseld.FACILITYID,
         d.WEEK_ENDING_DATE,
         SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld 
         inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id 
         inner join CRMADMIN.V_WED d on aassg.rpt_dt = d.LOOKUP_DATE and d.WEEK_ENDING_DATE = '2021-04-17'
WHERE    not(aseld.FACILITYID = '001'
     AND aassg.RPTG_ID in ('X', ''))
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST'))
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'E000' and 'E999')
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'X000' and 'X999')
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'F000' and 'F999')
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'L000' and 'L999')
AND      aassg.RPTG_ID is not null
GROUP BY aseld.FACILITYID, d.WEEK_ENDING_DATE
;


SELECT   'distribution' SCORECARD_TYPE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         'cases_selected' KPI_TYPE,
          'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         DATE('#CURRENT_DATE_DB2#') - (DAYOFWEEK(DATE('#CURRENT_DATE_DB2#'))-0) DAYS KPI_DATE,
         FACILITYID KPI_KEY_VALUE, 
         sum(cases_selected) KPI_DATA_VALUE
from (SELECT aseld.FACILITYID, d.WEEK_ENDING_DATE, SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected FROM CRMADMIN.T_WHSE_EXE_ASELD aseld inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id inner join CRMADMIN.V_WED d on aassg.rpt_dt = d.LOOKUP_DATE and d.WEEK_ENDING_DATE between DATE('#CURRENT_DATE_DB2#') - (DAYOFWEEK(DATE('#CURRENT_DATE_DB2#'))+6) DAYS AND DATE('#CURRENT_DATE_DB2#') - (DAYOFWEEK(DATE('#CURRENT_DATE_DB2#'))-0) DAYS WHERE not(aseld.FACILITYID = '001' AND aassg.RPTG_ID in ('X', '')) AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST')) AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'E000' and 'E999') AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'X000' and 'X999') AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'F000' and 'F999') AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'L000' and 'L999') AND aassg.RPTG_ID is not null GROUP BY aseld.FACILITYID, d.WEEK_ENDING_DATE ) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by dx.ENTERPRISE_KEY, x.FACILITYID, x.WEEK_ENDING_DATE
;


SELECT   aseld.FACILITYID,
         d.WEEK_ENDING_DATE,
         SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld 
         inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id 
         inner join CRMADMIN.V_WED d on aassg.rpt_dt = d.LOOKUP_DATE and d.WEEK_ENDING_DATE = '2021-04-17'
WHERE    not(aseld.FACILITYID = '001'
     AND aassg.RPTG_ID in ('X', ''))
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST'))
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'E000' and 'E999')
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'X000' and 'X999')
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'F000' and 'F999')
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'L000' and 'L999')
AND      aassg.RPTG_ID is not null
GROUP BY aseld.FACILITYID, d.WEEK_ENDING_DATE