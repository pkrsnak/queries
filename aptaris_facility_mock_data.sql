SELECT   ITEM_NBR_HS order_code,
         FACILITYID facility_code,
         99 lead_time,
         SHIP_UNIT_CD type,
         LIST_COST current_cost,
         ITEM_DESCRIP description,
         MASTER_PACK quantity,
         UPC_UNIT upc,
         UPC_UNIT ITEM_NO,
         FACILITYID || VENDOR_NBR vendor_no_1,
         PACK_CASE case_qty,
         FACILITYID || VENDOR_NBR vendor_no_2
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    UPC_UNIT = '00000002100002688'
AND      PURCH_STATUS not in ('D', 'Z');


SELECT   UPC_UNIT ITEM_NO,
         UPC_UNIT upc,
         FACILITYID || VENDOR_NBR vendor_no,
         PACK_CASE case_qty
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    UPC_UNIT = '00000002100002688'
AND      PURCH_STATUS not in ('D', 'Z');