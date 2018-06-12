SELECT   rb.LAWSON_VENDOR_NBR,
         rb.LAWSON_VENDOR_NAME,
         rb.PURCH_VENDOR_NBR,
         rb.PUCH_VENDOR_NAME,
         rb.CONTRACT_ID,
         trim(d.DIV_NAME) || ' - ' || rb.FACILITYID FACILITY,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE_DESCRIP,
         sum(rb.QTY_SHIPPED) qty,
         rb.VEND_RPA_AMT,
         sum(rb.VEND_RPA_AMT_EXT) VEND_RPA_AMT_EXTENDED,
         rb.RPA_ADMIN_AMT,
         sum(rb.RPA_ADMIN_AMT_EXT) VEND_RPA_ADMIN_FEE_EXT
FROM     CRMADMIN.T_WHSE_RPA_BILLINGS rb 
         inner join CRMADMIN.T_WHSE_ITEM i on rb.FACILITYID = i.FACILITYID and rb.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on rb.FACILITYID = d.SWAT_ID
WHERE    rb.REFLECT_ALLW_END between '2014-08-03' and '2014-08-09'
GROUP BY rb.LAWSON_VENDOR_NBR, rb.LAWSON_VENDOR_NAME, rb.PURCH_VENDOR_NBR, 
         rb.PUCH_VENDOR_NAME, rb.CONTRACT_ID, 
         trim(d.DIV_NAME) || ' - ' || rb.FACILITYID, i.UPC_CASE, i.UPC_UNIT, 
         i.ITEM_DESCRIP, i.PACK_CASE, i.ITEM_SIZE_DESCRIP, rb.VEND_RPA_AMT, 
         rb.RPA_ADMIN_AMT