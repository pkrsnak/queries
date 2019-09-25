SELECT   ipc.FACILITYID_PARENT,
         ipc.ITEM_NBR_HS_PARENT,
         iu.ITEM_DESCRIP ITEM_DESCRIP_PARENT,
         iu.ITEM_SIZE_DESCRIP ITEM_SIZE_DESCRIP_PARENT,
         iu.PURCH_STATUS PURCH_STATUS_PARENT,
         iu.BILLING_STATUS BILLING_STATUS_PARENT,
         iu.LIST_COST LIST_COST_PARENT,
         ipc.FACILITYID_CHILD,
         ipc.ITEM_NBR_HS_CHILD,
         i.ITEM_DESCRIP,
         i.ITEM_SIZE_DESCRIP,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.LIST_COST
FROM     CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc 
         inner join CRMADMIN.T_WHSE_ITEM i on ipc.FACILITYID_CHILD = i.FACILITYID and ipc.ITEM_NBR_HS_CHILD = i.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_ITEM iu on ipc.FACILITYID_PARENT = iu.FACILITYID and ipc.ITEM_NBR_HS_PARENT = iu.ITEM_NBR_HS
WHERE    ipc.FACILITYID_PARENT = '002'
AND      i.PURCH_STATUS not in ('D', 'Z')
AND      ipc.ITEM_NBR_HS_PARENT in ('9475799', '0706663')
;


SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         pod.PO_NBR,
         pod.DATE_ORDERED,
         pod.DATE_RECEIVED,
         pod.DESCRIPTION,
         pod.PACK,
         pod.PACK_SIZE,
         pod.LIST_COST,
         pod.TURN,
         pod.PROMOTION,
         pod.FORWARD_BUY,
         pod.ORIGINAL_QUANTITY,
         pod.RECEIVED,
         pod.LINE_STATUS
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join CRMADMIN.T_WHSE_ITEM i on pod.ITEM_FAC = i.BICEPS_DC and pod.ITEM_NBR = i.ITEM_NBR
WHERE    pod.ITEM_FAC = '02'
AND      pod.ITEM_NBR in ('947579', '070666')
AND      pod.DATE_ORDERED >= '2019-08-01'
;


SELECT   shd.FACILITYID,
         shd.ITEM_NBR_HS,
         shd.INVOICE_NBR,
         shd.QTY_SOLD
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd
WHERE    ((shd.FACILITYID = '003'
        AND shd.ITEM_NBR_HS = '0706663')
     OR  (shd.FACILITYID = '008'
        AND shd.ITEM_NBR_HS = '0706663')
     OR  (shd.FACILITYID = '040'
        AND shd.ITEM_NBR_HS = '0706663'))
AND      BILLING_DATE >= '2019-09-01'
