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
         count(distinct crh.ROUTEID) DATA_VALUE,
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
         count(distinct crh.ROUTEID) DATA_VALUE,
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

--total drive time
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         'time_drive' KPI_TYPE,
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



 