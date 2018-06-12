Select * from storedcarea where storeNum = 115;

select * from dcarea;

select * from delivsched where storeNum = 115;

select * from CRMADMIN.V_WEB_CUSTOMER_FAC where CUSTOMER_NBR_STND = 331;

select * from CRMADMIN.V_WEB_CUSTOMER_TROUBLESHOOT where CUSTOMER_NBR_STND = 331;


SELECT 
ds.delivSchedId,
ds.storenum,
ds.dc,
ds.dcArea,
da.SchedLikeDCArea,
ds.deliveryDay,
ds.deliveryTime,
ds.callDay,
ds.callTime,
ds.startingdelivdate,
ds.endingdelivdate,
ds.delivSchedType,
ds.overrideType,
cast(ds.lastChgTime as char) lastChgTime
FROM 
delivsched ds,
wavesched ws,
dcarea da
WHERE 
ws.waveschedid = ds.waveschedid
AND ds.dc = da.dc
AND ds.dcArea = da.dcArea
--AND ds.deliveryDay = '#deliv_weekday#'
AND ds.dcArea < 1000
--AND ds.startingdelivdate <= '#deliv_date#'
--AND ds.endingdelivdate >= '#deliv_date#'
AND ds.overrideType <> 'Cancel'
--AND ds.delivSchedId NOT IN
--(
--SELECT origDelivSchedId
--FROM delivsched
--WHERE origDelivSchedId = ds.delivSchedId
--AND startingDelivDate <= '#deliv_date#'
--AND endingDelivDate >= '#deliv_date#'
--)
and ds.storenum = 331
;

SELECT 
ds.delivSchedId,
ds.storenum,
ds.dc,
ds.dcArea,
da.SchedLikeDCArea,
ds.deliveryDay,
ds.deliveryTime,
ds.callDay,
ds.callTime,
ds.startingdelivdate,
ds.endingdelivdate,
ds.delivSchedType,
ds.overrideType,
cast(ds.lastChgTime as char) lastChgTime
FROM 
delivsched ds,
wavesched ws,
dcarea da
WHERE 
ws.waveschedid = ds.waveschedid
AND ds.dc = da.dc
AND ds.dcArea = da.dcArea
AND ds.dcArea < 1000
AND ds.overrideType <> 'Cancel'
and ds.storenum = 331
;

SELECT 
PROCESS_TIMESTAMP,
DELIV_SCHED_ID,
STORE_NUM,
DC,
DC_AREA,
SCHED_LIKE_DC_AREA,
DELIVERY_DAY,
DELIVERY_DATE,
DELIVERY_TIME,
CALL_DAY,
CALL_TIME,
STARTING_DELIV_DATE,
ENDING_DELIV_DATE,
DELIV_SCHED_TYPE,
OVERRIDE_TYPE,
LAST_CHG_TIME
FROM 
ETLADMIN.T_STAGE_ORDER_DELIVSCHED
WHERE
--DELIVERY_DATE = TO_DATE('#deliv_date#', 'yyyy-mm-dd') 
STORE_NUM = 331
ORDER BY 
DC,
CALL_DAY, 
CALL_TIME, 
STORE_NUM, 
DC_AREA, 
DELIVERY_DATE, 
DELIVERY_TIME
;

select * from CRMADMIN.T_WHSE_ORDER_DELIVSCHED where CUSTOMER_NBR_STND = 331;

select * from crmadmin.V_WEB_ORDERS_DELIVSCHED where CUSTOMER_NBR_STND = 115;

