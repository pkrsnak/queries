SELECT   count(*)
FROM     (
;
SELECT   v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         v.FACILITYID,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         i.ITEM_NBR_HS,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM, i.RAND_WGT_CD,
         i.ITEM_DEPT,
         d.DEPT_DESCRIPTION,
         i.MERCH_DEPT_GRP,
         i.MERCH_DEPT_GRP_DESC,
         i.MERCH_DEPT,
         i.MERCH_DEPT_DESC,
         i.MERCH_GRP,
         i.MERCH_GRP_DESC,
         i.MERCH_CAT,
         i.MERCH_CAT_DESC,
         i.MERCH_CLASS,
         i.MERCH_CLASS_DESC,
         pod.DATE_ORDERED,
         pod.DATE_RECEIVED,
         pod.PO_NBR,
         pod.QUANTITY,
         pod.RECEIVED,
         pod.WEIGHT,
         pod.WEIGHT_RECEIVED,
         pod.DESCRIPTION,
         pod.LIST_COST,
         pod.AMOUNT_OFF_INVOICE,
         pod.AMOUNT_WHSE_DISCOUNT,
         pod.AMOUNT_ITEM_UP_DOWN,
         pod.AMOUNT_FREIGHT_ALLOW,
         pod.AMOUNT_VENDOR_UP_DOWN,
         pod.AMOUNT_PREPAY_AND_ADD,
         pod.AMOUNT_BILLBACK,
         pod.CORRECTED_LAST_COST,
         pod.CORRECTED_LIST_COST,
         pod.CORRECTED_OFF_INVOICE,
         pod.CORRECTED_FREE_GOODS,
         pod.CORRECTED_BILLBACK,
         pod.LINE_STATUS
FROM     CRMADMIN.T_WHSE_VENDOR v 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.T_WHSE_DEPT d on d.DEPT_CODE = i.ITEM_DEPT 
         inner join ETLADMIN.T_TEMP_UPC_2 u on i.UPC_CASE = u.UPC_UNIT --pork upcs
--         inner join ETLADMIN.T_TEMP_FAC_ITEM fi on fi.FACILITYID = i.FACILITYID and fi.ITEM_NBR = i.ITEM_NBR_HS --beef items
         inner join CRMADMIN.T_WHSE_PO_DTL pod on pod.FACILITYID = i.FACILITYID and pod.ITEM_NBR = i.ITEM_NBR
--WHERE    v.MASTER_VENDOR in ('023700', '038057', '038507', '053700', '436031', '716432') -- beef vendors
ORDER BY v.MASTER_VENDOR, i.UPC_CASE, i.FACILITYID
;
);

---MDV - mdvods

select count(*) from (
;
SELECT   v.customer_nbr,
         v.customer_name,
         v.street_1_addr,
         v.street_2_addr,
         v.city_name,
         v.state_cd,
         v.zip_cd,
         v.broker_nbr,
         v.export_broker_nbr,
         v.bill_method_cd, dept.division_cd, div.division_name, 
         i.dept_cd, dept.dept_desc, 
         i.case_upc_cd,
         i.customer_nbr,
         i.item_desc,
         i.item_pack_qty,
         i.item_size_desc,
         i.prod_group_cd,
         i.commodity_cd,
         pod.discount_price_amt,
         pod.input_date,
         pod.line_nbr,
         pod.order_nbr,
         pod.order_status_cd,
         pod.case_pack_msr,
         pod.order_qty,
         pod.order_denied_qty,
         pod.received_qty,
         pod.line_weight_msr,
         pod.distributed_qty
FROM     whmgr.mdv_customer v 
         inner join whmgr.mdv_item i on i.vendor_id = v.customer_nbr 
         inner join whmgr.mdv_po_dtl pod on pod.dept_cd = i.dept_cd and pod.case_upc_cd = i.case_upc_cd
         inner join whmgr.mdv_dept dept on dept.dept_cd = i.dept_cd
         inner join whmgr.mdv_division div on div.division_cd = dept.division_cd
WHERE    v.customer_nbr in (28180, 28182)
;
)
;

SELECT   distinct v.master_vendor 
FROM     crmadmin.T_WHSE_VENDOR v 
         inner join ETLADMIN.T_TEMP_FAC_VENDOR tfv on v.FACILITYID = tfv.FACILITYID and v.VENDOR_NBR = tfv.VENDOR
;

----------------PORK--------------------
SELECT   count(*)
FROM     (
;
SELECT   v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         v.FACILITYID,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         i.ITEM_NBR_HS,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.ITEM_DEPT,
         d.DEPT_DESCRIPTION,
         i.MERCH_DEPT_GRP,
         i.MERCH_DEPT_GRP_DESC,
         i.MERCH_DEPT,
         i.MERCH_DEPT_DESC,
         i.MERCH_GRP,
         i.MERCH_GRP_DESC,
         i.MERCH_CAT,
         i.MERCH_CAT_DESC,
         i.MERCH_CLASS,
         i.MERCH_CLASS_DESC--,
--         pod.DATE_ORDERED,
--         pod.DATE_RECEIVED,
--         pod.PO_NBR,
--         pod.QUANTITY,
--         pod.RECEIVED,
--         pod.WEIGHT,
--         pod.WEIGHT_RECEIVED,
--         pod.DESCRIPTION,
--         pod.LIST_COST,
--         pod.AMOUNT_OFF_INVOICE,
--         pod.AMOUNT_WHSE_DISCOUNT,
--         pod.AMOUNT_ITEM_UP_DOWN,
--         pod.AMOUNT_FREIGHT_ALLOW,
--         pod.AMOUNT_VENDOR_UP_DOWN,
--         pod.AMOUNT_PREPAY_AND_ADD,
--         pod.AMOUNT_BILLBACK,
--         pod.CORRECTED_LAST_COST,
--         pod.CORRECTED_LIST_COST,
--         pod.CORRECTED_OFF_INVOICE,
--         pod.CORRECTED_FREE_GOODS,
--         pod.CORRECTED_BILLBACK,
--         pod.LINE_STATUS
FROM     CRMADMIN.T_WHSE_VENDOR v 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.T_WHSE_DEPT d on d.DEPT_CODE = i.ITEM_DEPT 
--         inner join ETLADMIN.T_TEMP_FAC_ITEM fi on fi.FACILITYID = i.FACILITYID and fi.ITEM_NBR = i.ITEM_NBR_HS 
--         inner join CRMADMIN.T_WHSE_PO_DTL pod on pod.FACILITYID = i.FACILITYID and pod.ITEM_NBR = i.ITEM_NBR
WHERE    v.MASTER_VENDOR in (SELECT distinct v.master_vendor FROM crmadmin.T_WHSE_VENDOR v inner join ETLADMIN.T_TEMP_FAC_VENDOR tfv on v.FACILITYID = tfv.FACILITYID
     AND v.VENDOR_NBR = tfv.VENDOR)
AND      i.item_dept in ('070', '071', '072', '073', '074', '075', '077', '078')
ORDER BY v.MASTER_VENDOR, i.UPC_CASE, i.FACILITYID
;
);