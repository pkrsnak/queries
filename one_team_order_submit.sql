Select count(*) from CRMADMIN.T_WHSE_ORDER_DTL where SUBMIT_TIME between '2019-02-01' and '2019-02-28' and FACILITYID = '001';

SELECT   *
FROM     CRMADMIN.T_WHSE_CORPORATION_MDM
WHERE    (CUSTOMER_NBR_STND) in  (select  CUSTOMER_NBR_STND from CRMADMIN.T_WHSE_CUST where NAME like 'HARDING%'
     AND FACILITYID = '001')
;


--corp code 385

SELECT   crp.CORP_CODE,
         crp.CORP_NAME,
         crp.CUSTOMER_NBR_STND,
         c.NAME,
         c.ADDRESS1,
         c.ADDRES2,
         c.ADDRESS3,
         od.ORDER_TYPE,
         od.ITEM_NBR_HS,
         od.QTY,
         od.NET_QTY,
         od.ORDER_STATUS,
         od.RESERVE_DATE,
         od.BOOKING_NBR,
         od.ORDER_ID,
         od.INVOICE_NBR,
         od.SUBMIT_TIME,
         od.ORDER_RECVD_DTE,
         od.ORDER_RECVD_TIME,
         od.DELIV_REQUESTED_DATE,
         od.BILLING_DATE,
         od.SHIP_DATE,
         od.LAST_CHG_TIME,
         od.RTL_ORDER_ID,
         od.DC_ORDER_ID,
         od.LINE_ITEM_ID,
         od.DC_AREA,
         od.DELIVERY_ID
FROM     CRMADMIN.T_WHSE_ORDER_DTL od 
         inner join CRMADMIN.T_WHSE_CUST c on od.FACILITYID = c.FACILITYID and od.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL 
         inner join CRMADMIN.T_WHSE_CORPORATION_MDM crp on c.CUSTOMER_NBR_STND = crp.CUSTOMER_NBR_STND
WHERE    od.SUBMIT_TIME between '2019-02-01' and '2019-02-28'
AND      od.FACILITYID = '001'
AND      crp.CORP_CODE = 385
order by crp.CORP_CODE, crp.CUSTOMER_NBR_STND, od.SUBMIT_TIME, od.RTL_ORDER_ID
;

SELECT   os.DELIV_SCHED_ID,
         os.FACILITYID,
         os.CUSTOMER_NBR_STND,
         os.DC_AREA_ID,
         os.DUE_IN_DAY,
         os.DUE_IN_DATE,
         os.DUE_IN_TIME,
         os.DELIVERY_DAY,
         os.DELIVERY_DATE,
         os.DELIVERY_TIME,
         os.STARTING_DELIV_DATE,
         os.ENDING_DELIV_DATE,
         os.DELIV_SCHED_TYPE,
         os.OVERRIDE_TYPE,
         os.LAST_CHG_TIME
FROM     CRMADMIN.T_WHSE_ORDER_DELIVSCHED os 
         inner join CRMADMIN.T_WHSE_CUST c on os.FACILITYID = c.FACILITYID and os.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND 
         inner join CRMADMIN.T_WHSE_CORPORATION_MDM crp on c.CUSTOMER_NBR_STND = crp.CUSTOMER_NBR_STND
WHERE    os.FACILITYID = '001'
AND      crp.CORP_CODE = 385
ORDER BY os.CUSTOMER_NBR_STND, os.DUE_IN_DATE, os.DC_AREA_ID;

--od.SUBMIT_TIME between '2019-02-01' and '2019-02-28'
      