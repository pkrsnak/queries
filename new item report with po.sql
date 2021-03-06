SELECT   pod.FACILITYID,
         pod.ITEM_NBR,
         pod.PO_NBR,
         pod.LINE_STATUS,
         poh.DATE_ORDERED,
         poh.DATE_ARRIVAL,
         poh.DATE_APPOINTMENT,
         poh.PO_ORIGINAL_DLVRY_DATE,
         poh.BUYER_ARRIVAL_DATE,
         pod.QUANTITY
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join CRMADMIN.T_WHSE_PO_HDR poh on poh.FACILITYID = pod.FACILITYID and poh.PO_NBR = pod.PO_NBR and poh.DATE_ORDERED = pod.DATE_ORDERED
         inner join CRMADMIN.T_WHSE_ITEM i on pod.FACILITYID = i.FACILITYID and pod.ITEM_NBR = i.ITEM_NBR
WHERE    (pod.LINE_STATUS <> 'D'
     AND pod.DATE_ORDERED >= SYSDATE -60 DAY)
;



Name

poh.APPOINT_MADE_DATE

poh.DATE_CANCEL

poh.BUYER_PICKUP_DATE
poh.DATE_SHIP
poh.DATE_PICKUP
poh.DATE_RECEIVED


poh.EXE_FIRST_RECVD_DATE
poh.EXE_LAST_RECVD_DATE
poh.PO_DATE_CREATED
