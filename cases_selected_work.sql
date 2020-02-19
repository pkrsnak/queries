--warehouse cases selected by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         'cases_selected' KPI_TYPE,
          'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         DATE('2020-02-09') - (DAYOFWEEK(DATE('2020-02-09'))-0) DAYS KPI_DATE,
         FACILITYID KPI_KEY_VALUE,
         sum(cases_selected) KPI_DATA_VALUE
from (
SELECT FACILITYID, SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected FROM CRMADMIN.T_WHSE_EXE_ASELD aseld
WHERE (FACILITYID, assg_id) in (select aassg.FACILITYID, aassg.assg_id from CRMADMIN.T_WHSE_EXE_AASSG aassg
where aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id
AND rpt_dt between DATE('2020-02-09') - (DAYOFWEEK(DATE(''2020-02-09''))+6) DAYS AND DATE(''2020-02-09'') - (DAYOFWEEK(DATE(''2020-02-09''))-0) DAYS)
GROUP BY FACILITYID
) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by dx.ENTERPRISE_KEY, x.FACILITYID
;


SELECT  aseld.* -- aseld.FACILITYID, aseld.WHSE_ID, 
         --SUM((aseld.prod_qty - value(aseld.out_qty,0)) / aseld.unit_ship_cse) cases_selected
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld
WHERE    (FACILITYID, assg_id) in (select aassg.FACILITYID, aassg.assg_id from CRMADMIN.T_WHSE_EXE_AASSG aassg where aassg.FACILITYID = aseld.FACILITYID
     AND aassg.phys_whse_id = aseld.phys_whse_id
     AND aassg.assg_id = aseld.assg_id
     AND aassg.rpt_dt between '2020-02-02' and '2020-02-08')
     AND aseld.FACILITYID = '001'
 --GROUP BY aseld.FACILITYID, aseld.WHSE_ID 