select input_date,
         required_by_date,
         dept_cd,
         order_nbr,
         case_upc_cd,
         order_qty, discount_price_amt, initials_txt, line_nbr, order_status_cd, case_pack_msr, order_denied_qty, reference_cd, received_qty, vendor_cd, line_weight_msr, distributed_qty 
from (
SELECT   ROW_NUMBER() OVER(partition by pod.dept_cd, pod.case_upc_cd) row_num,
         pod.input_date,
         poh.required_by_date,
         pod.dept_cd,
         pod.order_nbr,
         pod.case_upc_cd,
         pod.order_qty, pod.discount_price_amt, pod.initials_txt, pod.line_nbr, pod.order_status_cd, pod.case_pack_msr, pod.order_denied_qty, pod.reference_cd, pod.received_qty, pod.vendor_cd, pod.line_weight_msr, pod.distributed_qty
FROM     whmgr.mdv_po_dtl pod 
         inner join whmgr.mdv_po_hdr poh on pod.order_nbr = poh.order_nbr
WHERE    pod.order_status_cd = 'OPN'
order by pod.dept_cd, pod.case_upc_cd, poh.required_by_date
)
where row_num = 1
;



SELECT   ROW_NUMBER() OVER(partition by LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS) row_num,
         LAYER_FILE_DTE,
         FACILITYID,
         ITEM_NBR_HS,
         PO_NBR,
         PO_RECEIPT_DTE,
         RAND_WGT_CD,
         lh.SHIPPING_CASE_WEIGHT,
         fc.FISCAL_WEEK,
         (lh.INVENTORY_TURN + lh.TURN_QTY_SOLD + lh.INVENTORY_PROMOTION + lh.PROMO_QTY_SOLD + lh.INVENTORY_FWD_BUY + lh.FWD_BUY_SOLD) po_received_qty,
         (case when CORRECT_NET_COST <> 0 then CORRECT_NET_COST else NET_COST_PER_CASE end) layer_cost
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.V_FISCAL_CALENDAR fc on lh.LAYER_FILE_DTE = fc.DATE_KEY and lh.LAYER_FILE_DTE between current date - 1 days and current date - 1 days
ORDER BY LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_RECEIPT_DTE, PO_NBR
--having row_num = 1 
;


--------------------------------------------------
-- Create Table whmgr.mdv_po_dtl
--------------------------------------------------
Create table whmgr.mdv_po_dtl (
    input_date                     DATE                          ,
    required_by_date               DATE                          ,
    dept_cd                        CHAR(3)                       ,
    order_nbr                      INTEGER                       ,
    case_upc_cd                    CHAR(10)                      ,
    order_qty                      INTEGER                       ,
    discount_price_amt             DECIMAL(13,2)                 ,
    initials_txt                   CHAR(3)                       ,
    line_nbr                       INTEGER                       ,
    order_status_cd                CHAR(3)                       ,
    case_pack_msr                  INTEGER                       ,
    order_denied_qty               INTEGER                       ,
    reference_cd                   CHAR(8)                       ,
    received_qty                   INTEGER                       ,
    vendor_cd                      INTEGER                       ,
    line_weight_msr                DECIMAL(10,2)                 ,
    distributed_qty                INTEGER                       )   
;


input_date	required_by_date	dept_cd	order_nbr	case_upc_cd	order_qty	discount_price_amt	initials_txt	line_nbr	order_status_cd	case_pack_msr	order_denied_qty	reference_cd	received_qty	vendor_cd	line_weight_msr	distributed_qty
2020-12-01	2020-12-11	001	383304	0376005858	54	47.85	DE	1	OPN	1	0		0	37637	1134.00	54