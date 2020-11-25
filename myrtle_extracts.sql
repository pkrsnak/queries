SELECT   i.FACILITYID,
         i.VENDOR_NBR,
         v.VENDOR_NAME,
         v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         v.PAYABLE_VENDOR_NBR,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.UPC_CASE,
         i.UPC_UNIT,
         pod.PO_NBR,
         pod.LINE_STATUS,
         pod.DATE_ORDERED,
         pod.DATE_RECEIVED,
         pod.QUANTITY
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join CRMADMIN.T_WHSE_ITEM i on pod.ITEM_FAC = i.BICEPS_DC and pod.ITEM_NBR = i.ITEM_NBR 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR
WHERE    pod.ITEM_FAC = '01'
AND      pod.DATE_ORDERED >= current date - 90 days;


--select count(*) from (
SELECT   i.FACILITYID,
         od.CUSTOMER_NBR_STND,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.UPC_CASE,
         i.UPC_UNIT,
         od.ORDER_TYPE,
         od.QTY,
         od.NET_QTY,
         od.ORDER_STATUS,
         od.INVOICE_NBR,
         od.ORDER_RECVD_DTE,
         od.ORDER_RECVD_TIME,
         od.SUBMIT_TIME,
         od.BILLING_DATE,
         od.SHIP_DATE,
         od.RTL_ORDER_ID,
         od.DC_ORDER_ID,
         od.LINE_ITEM_ID
FROM     CRMADMIN.T_WHSE_ORDER_DTL od 
         inner join CRMADMIN.T_WHSE_ITEM i on od.FACILITYID = i.FACILITYID and od.ITEM_NBR_HS = i.ITEM_NBR_HS
WHERE    od.FACILITYID = '001'
AND      od.ORDER_RECVD_DTE >= current date - 90 day
--AND      od.ORDER_RECVD_DTE = current date - 90 day
--)
;


SELECT   TRANSACTION_DATE,
         FACILITY_ID,
         CUSTOMER_NBR,
         INVOICE_NBR,
         count(*) num_line_items
FROM     WH_OWNER.DC_SALES_HST
WHERE    FACILITY_ID = 1
AND      TRANSACTION_DATE >= '08-26-2020'
GROUP BY TRANSACTION_DATE, FACILITY_ID, CUSTOMER_NBR, INVOICE_NBR