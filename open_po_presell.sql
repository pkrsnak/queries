--open POs
SELECT   pod.FACILITYID,
         poh.PO_NBR, poh.PO_TYPE,
         poh.VENDOR_NBR,
         poh.VENDOR_NAME,
         az.LU_CODE AS ASIN,
         i.ITEM_NBR_HS,
         i.UPC_UNIT,
         i.UPC_CASE,
         i.ITEM_DESCRIP,
         pod.PACK,
         CASE i.ITEM_RES28 
              WHEN 'A' THEN 'YES' 
              ELSE 'NO' 
         END AS AMZ_SPECIFIC_UPC,
         pod.LIST_COST,
         pod.AMOUNT_OFF_INVOICE,
         pod.LINE_STATUS,
         pod.DATE_ORDERED,
         poh.PO_ORIGINAL_DLVRY_DATE,
         poh.BUYER_ARRIVAL_DATE,
         poh.DATE_ARRIVAL,
         poh.APPOINT_MADE_DATE,
         poh.DATE_CANCEL,
         poh.BUYER_PICKUP_DATE,
         poh.DATE_SHIP,
         poh.DATE_PICKUP,
         poh.DATE_RECEIVED,
         poh.ASN_DELV_DATE,
         poh.DATE_APPOINTMENT,
         poh.EXE_FIRST_RECVD_DATE,
         poh.EXE_LAST_RECVD_DATE,
         poh.PO_DATE_CREATED,
         pod.QUANTITY,
         pod.RECEIVED,
         pod.TURN,
         pod.PROMOTION,
         pod.FORWARD_BUY
FROM     CRMADMIN.T_WHSE_PO_HDR poh 
         INNER JOIN CRMADMIN.T_WHSE_PO_DTL pod ON poh.VENDOR_FAC = pod.ITEM_FAC AND poh.PO_NBR = pod.PO_NBR AND poh.DATE_ORDERED = pod.DATE_ORDERED 
         INNER JOIN CRMADMIN.T_WHSE_ITEM i ON pod.ITEM_FAC = i.BICEPS_DC AND pod.ITEM_NBR = i.ITEM_NBR 
         INNER JOIN CRMADMIN.T_WHSE_DIV_XREF dx ON i.FACILITYID = dx.SWAT_ID 
         INNER JOIN CRMADMIN.T_WHSE_VENDOR v ON poh.FACILITYID = v.FACILITYID AND poh.VENDOR_NBR = v.VENDOR_NBR 
         LEFT OUTER JOIN CRMADMIN.V_AMZ_ASIN az ON i.ROOT_ITEM_NBR = az.ROOT_ITEM_NBR AND i.LV_ITEM_NBR = az.LV_ITEM_NBR
WHERE    pod.DATE_ORDERED >= SYSDATE - 60 days
AND      pod.QUANTITY > 0
AND      i.FACILITYID in ('001', '008')
AND      v.MASTER_VENDOR NOT IN ('757575', '767676')
AND      pod.LINE_STATUS <> 'D'
;

--open presell orders
SELECT   facilityid, ORDER_TYPE, SHIP_DATE, RESERVE_DATE, BILLING_DATE, ORDER_RECVD_DTE, DELIV_REQUESTED_DATE, count(*)

FROM     ( 
;
SELECT   od.FACILITYID,
         od.RTL_ORDER_ID,
         od.DC_ORDER_ID,
         od.LINE_ITEM_ID,
         od.ITEM_NBR_HS,
         od.CUSTOMER_NBR_STND,
         od.ORDER_TYPE,
         od.ORDER_STATUS_HS,
         od.UPLOAD_TO_BILL,
         od.SHIP_DATE,
         od.ORDER_STATUS,
         od.RESERVE_DATE,
         od.ORDER_RECVD_DTE,
         od.DELIV_REQUESTED_DATE,
         od.QTY,
         od.NET_QTY,
         od.RTL_PO_NUMBER,
         od.FACILITYID_REQUESTED,
         od.ITEM_NBR_HS_REQUESTED
FROM     CRMADMIN.T_WHSE_ORDER_DTL od 
         inner join crmadmin.T_WHSE_ITEM i on od.FACILITYID = i.FACILITYID and od.ITEM_NBR_HS = i.ITEM_NBR_HS
WHERE    od.ORDER_RECVD_DTE >= '2021-01-01'
AND      od.ORDER_STATUS_HS in ('Firm','Hold')
AND      od.UPLOAD_TO_BILL in ('Pending','NoSend','Ready')
AND      od.FACILITYID in ('001', '008')
and      od.DELIV_REQUESTED_DATE between current date + 1 days and current date + 15 days
AND      od.ORDER_TYPE <> 'RG'
;

)
group by facilityid, ORDER_TYPE, SHIP_DATE, RESERVE_DATE, BILLING_DATE, ORDER_RECVD_DTE, DELIV_REQUESTED_DATE
;


select * from dcorder
where orderStatus in ('Firm','Hold')
and uploadToBill in ('Pending','NoSend','Ready');