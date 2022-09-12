SELECT   v.MASTER_VENDOR,
         o.FACILITYID,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         o.DC_ORDER_ID,
         o.RTL_ORDER_ID,
         o.ORIGIN_CDE,
         o.ORIGIN_APP,
         o.ORIGIN_CODE,
         o.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE,
         o.CUSTOMER_NBR_STND,
         o.ORDER_TYPE,
         o.SHIP_DATE,
         o.QTY,
         o.NET_QTY,
         o.ORDER_STATUS_HS
FROM     CRMADMIN.T_WHSE_ORDER_DTL o 
         inner join CRMADMIN.T_WHSE_ITEM i on o.FACILITYID = i.FACILITYID and o.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on v.FACILITYID = i.FACILITYID and v.VENDOR_NBR = i.VENDOR_NBR
WHERE    ORDER_RECVD_DTE >= '2022-07-20'
AND      ORDER_TYPE in ('PP', 'PS', 'FS')
AND      DELIV_REQUESTED_DATE between '2022-10-01' and '2023-04-30'
order by 1,2,4