SELECT   facilityid, count(*)

FROM     ( 
--;
SELECT   od.FACILITYID,
         od.RTL_ORDER_ID,
         od.DC_ORDER_ID,
         od.LINE_ITEM_ID,
         od.ITEM_NBR_HS,
         od.CUSTOMER_NBR_STND,
         od.ORDER_TYPE,
         od.SHIP_DATE,
         od.ORDER_STATUS_HS,
         od.INVOICE_NBR,
         od.BILLING_DATE,
         od.QTY,
         od.NET_QTY,
         od.ORDER_RECVD_DTE,
         od.RTL_PO_NUMBER,
         od.FACILITYID_REQUESTED,
         od.ITEM_NBR_HS_REQUESTED
FROM     CRMADMIN.T_WHSE_ORDER_DTL od 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC C on od.FACILITYID = c.FACILITYID and od.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND 
         inner join CRMADMIN.V_WEB_CORPORATION corp on corp.CORP_CODE = c.CORP_CODE 
         inner join crmadmin.T_WHSE_ITEM i on od.FACILITYID = i.FACILITYID and od.ITEM_NBR_CD = i.ITEM_NBR_CD 
         inner join ETLADMIN.T_TEMP_FAC_ITEM tfi on tfi.FACILITYID = i.FACILITYID and tfi.ITEM_NBR = i.ITEM_NBR_HS
WHERE    corp.CORP_CODE = 634001
AND      od.ORDER_RECVD_DTE between '2020-06-01' and current date
--AND      od.ORDER_RECVD_DTE between '2019-12-29' and '2020-07-31'
--AND      od.ORDER_RECVD_DTE between '2020-08-01' and '2021-01-31'
--AND      od.ORDER_RECVD_DTE >= '2021-02-01' --and '2021-01-31'
--;

)
group by facilityid
;



--snowflake
SELECT   facilityid, count(*)

FROM     ( 
;
SELECT   od.FACILITYID,
         od.RTL_ORDER_ID,
         od.DC_ORDER_ID,
         od.LINE_ITEM_ID,
         od.ITEM_NBR_HS,
         od.CUSTOMER_NBR_STND,
         od.ORDER_TYPE,
         od.SHIP_DATE,
         od.ORDER_STATUS_HS,
         od.INVOICE_NBR,
         od.BILLING_DATE,
         od.QTY,
         od.NET_QTY,
         od.ORDER_RECVD_DTE,
         od.RTL_PO_NUMBER,
         od.FACILITYID_REQUESTED,
         od.ITEM_NBR_HS_REQUESTED
FROM     EDL.CRM.T_WHSE_ORDER_DTL od 
         inner join EDW.FD.WEB_CUSTOMER_FAC_VW C on od.FACILITYID = c.FACILITYID and od.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND 
--         inner join crmadmin.T_WHSE_ITEM i on od.FACILITYID = i.FACILITYID and od.ITEM_NBR_CD = i.ITEM_NBR_CD 
         inner join SBX_IT.PATRICK_KRSNAK.T_TEMP_FAC_ITEM tfi on tfi.FACILITYID = od.FACILITYID and tfi.ITEM_NBR = od.ITEM_NBR_HS
WHERE    c.CORP_CODE = 634001
AND      od.ORDER_RECVD_DTE between '2020-06-01' and CURRENT_DATE()
--AND      od.ORDER_RECVD_DTE between '2019-12-29' and '2020-07-31'
--AND      od.ORDER_RECVD_DTE between '2020-08-01' and '2021-01-31'
--AND      od.ORDER_RECVD_DTE >= '2021-02-01' --and '2021-01-31'
;

)
group by facilityid
;

insert into SBX_IT.PATRICK_KRSNAK.T_TEMP_FAC_ITEM (select distinct FACILITYID , ITEM_NBR from SBX_IT.PATRICK_KRSNAK.T_TEMP_FAC_ITEM_WORK)

