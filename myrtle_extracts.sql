--select count(*) from (
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
WHERE    pod.DATE_ORDERED >= current date - 90 days
--AND      pod.ITEM_FAC = '01'
--)
;

--select count(*) from (
SELECT   d.division_cd,
         pod.dept_cd,
         poh.vendor_cd,
         v.vendor_name,
         pod.case_upc_cd,
         i.item_desc,
         i.item_pack_qty,
         i.item_size_desc,
         i.item_upc_cd,
         poh.order_nbr,
         poh.order_date,
         poh.receive_date,
         pod.order_qty,
         pod.received_qty
FROM     whmgr.mdv_po_dtl pod 
         inner join whmgr.mdv_po_hdr poh on pod.order_nbr = poh.order_nbr 
         inner join whmgr.mdv_item i on pod.dept_cd = i.dept_cd and pod.case_upc_cd = i.case_upc_cd 
         inner join whmgr.mdv_dept d on i.dept_cd = d.dept_cd 
         inner join whmgr.mdv_vendor v on i.vendor_id = v.vendor_cd
WHERE    poh.receive_date >= date(current) - 90
--)
;


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
WHERE    od.ORDER_RECVD_DTE >= current date - 90 day
--AND      od.FACILITYID = '001'
--)
;



--select count(*) from (
SELECT   d.division_cd,
         shd.dept_cd,
         shd.customer_nbr,
         shd.ship_to_id,
         v.vendor_name,
         i.case_upc_cd,
         i.item_desc,
         i.item_pack_qty,
         i.item_size_desc,
         i.item_upc_cd,
         shd.sales_catgy_code,
         shd.sales_catgy_desc,
         shd.order_qty,
         shd.ship_qty,
         shd.ship_date,
         shd.order_nbr,
         shd.order_line_nbr
FROM     whmgr.mdv_sales_hst shd 
         inner join whmgr.mdv_item i on shd.dept_cd = i.dept_cd and shd.upc_cd = i.case_upc_cd 
         inner join whmgr.mdv_dept d on i.dept_cd = d.dept_cd 
         inner join whmgr.mdv_vendor v on i.vendor_id = v.vendor_cd
WHERE    shd.ship_date >= date(current) - 90
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