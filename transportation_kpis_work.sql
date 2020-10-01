select * from TRANSPORT.T_TMS_COM_ROUTE_HISTORY 
where (SITEID, ROUTEID) in
(SELECT   distinct crh.SITEID, crh.ROUTEID
FROM     TRANSPORT.T_TMS_COM_ROUTE_HISTORY crh 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on crh.SITEID = dx.SWAT_ID 
--         inner join TRANSPORT.T_TRA_ACTCC_AOUNTS ta on ta.ACCT_ENTITY_ID = crh.ACCT_ENTITY_ID and ta.REG_ENTITY_ID = crh.REG_ENTITY_ID 
--         inner join TRANSPORT.T_TRA_ACT_ACCOUNTS_CATEGORY tac on tac.REG_ENTITY_ID = ta.REG_ENTITY_ID and tac.ACCT_CTGY_ENTITY_ID = ta.ACCT_CTGY_ENTITY_ID
WHERE    crh.ROUTE_START_TIME between '2020-08-09' and '2020-08-16'
OR       crh.ROUTE_END_TIME between '2020-08-09' and '2020-08-16'
OR       crh.ARRIVE_TIME between '2020-08-09' and '2020-08-16')
and ROUTE_START_TIME between '2020-08-04' and '2020-08-16'
;


select * from TRANSPORT.T_TRA_ACT_ACCOUNTS where (ACCT_ENTITY_ID, REG_ENTITY_ID) in (
select ta.ACCT_ENTITY_ID, ta.REG_ENTITY_ID from TRANSPORT.T_TRA_ACT_ACCOUNTS ta --on ta.ACCT_ENTITY_ID = crh.ACCT_ENTITY_ID and ta.REG_ENTITY_ID = crh.REG_ENTITY_ID 
group by ta.ACCT_ENTITY_ID , ta.REG_ENTITY_ID
having count(*) > 1)
;




--transportation KPIs
--source:  CRM
SELECT   'distribution' SCORECARD_TYPE,
         dx.ENTERPRISE_KEY + case when (crh.SITEID = 29 and x.ACCT_CTGY_CD = 'DG') then 0 when (crh.SITEID = 33 and x.ACCT_CTGY_CD = 'DG') then 0 else 1 end DIVISION_ID,
         'routes_total' KPI_TYPE,
--         'routes_late_dock_out' KPI_TYPE,
--         'miles_total' KPI_TYPE,
--         'miles_planned' KPI_TYPE,
--         'cube_total' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         '2020-09-12' KPI_DATE,
         case when (crh.SITEID = 29 and x.ACCT_CTGY_CD = 'DG') then 90 when (crh.SITEID = 33 and x.ACCT_CTGY_CD = 'DG') then 80 when (crh.SITEID = 95) then 40 when (crh.SITEID = 9) then 40 else crh.SITEID end KPI_KEY_VALUE,
         count(distinct crh.ROUTEID) KPI_DATA_VALUE_TOTAL_ROUTES,
         sum(case when crh.STOP_NUMBER = 0 and crh.DEPART_TIME > crh.DISPATCHED_DEPARTTIME_PLAN then 1 else 0 end) KPI_DATA_VALUE_LATE_DOCKOUT,
         sum(crh.DISTANCE) KPI_DATA_VALUE_TOTAL_MILES,
         sum(crh.ROUTED_DISTANCE_PLAN) KPI_DATA_VALUE_PLANNED_MILES,
         sum(case when date(crh.ROUTE_END_TIME) <= '2020-09-12' then crh.ROUTED_CUBE else crh.CUBE end) KPI_DATA_VALUE_TOTAL_CUBE
FROM     TRANSPORT.T_TMS_COM_ROUTE_HISTORY crh 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on crh.SITEID = dx.SWAT_ID
         left outer join 

(SELECT distinct crh.ROUTE_END_TIME, 
         crh.SITEID,
         crh.ROUTEID,
         tac.ACCT_CTGY_CD
FROM     TRANSPORT.T_TMS_COM_ROUTE_HISTORY crh 
         inner join TRANSPORT.T_TRA_ACT_ACCOUNTS ta on crh.REG_ENTITY_ID = ta.REG_ENTITY_ID and crh.ACCT_ENTITY_ID = ta.ACCT_ENTITY_ID 
         inner join TRANSPORT.T_TRA_ACT_ACCOUNTS_CATEGORY tac on tac.REG_ENTITY_ID = ta.REG_ENTITY_ID and tac.ACCT_CTGY_ENTITY_ID = ta.ACCT_CTGY_ENTITY_ID
WHERE    tac.ACCT_CTGY_CD = 'DG'
AND      crh.ROUTE_END_TIME between '2020-09-05' and '2020-09-12'
AND      crh.STATUS = 'COMPLETE'
AND      crh.SITEID in (29,33)) x on crh.ROUTE_END_TIME =x.ROUTE_END_TIME and crh.SITEID = x.SITEID and crh.ROUTEID = x.ROUTEID 
WHERE    crh.ROUTE_END_TIME between '2020-09-05' and '2020-09-12'
AND      crh.STATUS = 'COMPLETE'
AND      crh.SITEID not in (1,58)
GROUP BY dx.ENTERPRISE_KEY + case when (crh.SITEID = 29 and x.ACCT_CTGY_CD = 'DG') then 0 when (crh.SITEID = 33 and x.ACCT_CTGY_CD = 'DG') then 0 else 1 end, 
         case when (crh.SITEID = 29 and x.ACCT_CTGY_CD = 'DG') then 90 when (crh.SITEID = 33 and x.ACCT_CTGY_CD = 'DG') then 80 when (crh.SITEID = 95) then 40 when (crh.SITEID = 9) then 40 else crh.SITEID end

union all

SELECT   'distribution' SCORECARD_TYPE,
         (dx.ENTERPRISE_KEY + 1) DIVISION_ID,
         'routes_total' KPI_TYPE,
--         'routes_late_dock_out' KPI_TYPE,
--         'miles_total' KPI_TYPE,
--         'miles_planned' KPI_TYPE,
--         'cube_total' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         '2020-09-12' DATE_VALUE,
         crh.SITEID KPI_KEY_VALUE,
         count(distinct crh.ROUTEID) KPI_DATA_VALUE_TOTAL_ROUTES,
         sum(case when crh.STOP_NUMBER = 0 and crh.DEPART_TIME > crh.DISPATCHED_DEPARTTIME_PLAN then 1 else 0 end) KPI_DATA_VALUE_LATE_DOCKOUT,
         sum(crh.DISTANCE) KPI_DATA_VALUE_TOTAL_MILES,
         sum(crh.DISPATCHED_DISTANCE_PLAN) KPI_DATA_VALUE_PLANNED_MILES,
         sum(case when date(crh.ROUTE_END_TIME) <= '2020-09-12' then crh.ROUTED_CUBE else crh.CUBE end) KPI_DATA_VALUE_TOTAL_CUBE
FROM     TRANSPORT.T_TMS_COM_ROUTE_HISTORY crh 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on crh.SITEID = dx.SWAT_ID 
WHERE (crh.SITEID, crh.ROUTEID) in (SELECT SITEID, ROUTEID FROM TRANSPORT.T_TMS_COM_ROUTE_HISTORY WHERE SITEID in (1, 58) AND STOP_TYPE = 'DC' AND STATUS = 'COMPLETE' GROUP BY SITEID, ROUTEID HAVING max(arrive_time) between '2020-09-05' and '2020-09-12')   
GROUP BY dx.ENTERPRISE_KEY +  1, crh.SITEID
;



SELECT ta.ACCT_ENTITY_ID, ta.REG_ENTITY_ID, tac.ACCT_CTGY_CD FROM TRANSPORT.T_TRA_ACT_ACCOUNTS ta inner join TRANSPORT.T_TRA_ACT_ACCOUNTS_CATEGORY tac on tac.REG_ENTITY_ID = ta.REG_ENTITY_ID and tac.ACCT_CTGY_ENTITY_ID = ta.ACCT_CTGY_ENTITY_ID WHERE tac.ACCT_CTGY_CD = 'DG' GROUP BY ta.ACCT_ENTITY_ID, ta.REG_ENTITY_ID, tac.ACCT_CTGY_CD