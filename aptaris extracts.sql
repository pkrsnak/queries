--item list
SELECT   MERCH_DEPT_GRP,
         MERCH_DEPT_GRP_DESC,
         MERCH_DEPT,
         MERCH_DEPT_DESC,
         MERCH_GRP,
         MERCH_GRP_DESC,
         MERCH_CAT,
         MERCH_CAT_DESC,
         MERCH_CLASS,
         MERCH_CLASS_DESC,
         ROOT_ITEM_NBR,
         ROOT_DESC,
         LV_ITEM_NBR,
         LV_DESC,
         FACILITYID,
         ITEM_NBR_HS,
         UPC_CASE,
         UPC_UNIT,
         BRAND,
         ITEM_DESCRIP,
         PACK_CASE,
         ITEM_SIZE,
         ITEM_SIZE_UOM,
         SHIP_UNIT_CD,
         CATALOG_PRICE, VEND_LIST_CURR
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    PURCH_STATUS not in ('D', 'Z')
AND      FACILITYID in ('001', '008', '058', '040', '005')
ORDER BY MERCH_DEPT_GRP, MERCH_DEPT, MERCH_GRP, MERCH_CAT, MERCH_CLASS, 
         UPC_UNIT, UPC_CASE, ROOT_ITEM_NBR, LV_ITEM_NBR, FACILITYID, 
         ITEM_NBR_HS
;


--componenet list
SELECT   sc.FACILITYID,
         sc.SHIP_UPC_CASE,
         sc.SHIP_UPC_UNIT,
         sc.SHIP_ITEM_NBR_HS,
         sc.SHIP_DESC,
         sc.SHIP_PK,
         sc.SHIP_SIZE,
         sc.SHIP_UOM,
         sc.COMP_UPC_CASE,
         sc.COMP_UPC_UNIT,
         sc.COMP_ITEM_NBR_HS,
         sc.COMP_DESC,
         sc.COMP_PK,
         sc.COMP_SIZE,
         sc.COMP_UOM,
         sc.QTY_IN_SHIPPER,
         sc.BRAND_CD,
         sc.BRAND_DESC
FROM     CRMADMIN.T_WHSE_SHIPPER_CMPNTS sc inner join CRMADMIN.T_WHSE_ITEM i on sc.FACILITYID = i.FACILITYID and sc.SHIP_ITEM_NBR_HS = i.ITEM_NBR_HS
WHERE    sc.SOURCE = 'MDM'
AND      i.PURCH_STATUS not in ('D', 'Z')
AND      sc.FACILITYID in ('001', '008', '058', '040', '005')