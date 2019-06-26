SELECT   i.ITEM_DEPT,
         ecb.FACILITYID,
         ecb.ITEM_NBR_HS,
         ecb.DESCRIPTION,
         ecb.MANUFACTURER,
         ecb.UPC_CASE_CD,
         ecb.UPC_CASE,
         ecb.GTIN,
         ecb.BRAND,
         ecb.MASTER_UOM,
         ecb.PACK_CASE,
         ecb.INNER_PACKAGE_UNIT,
         ecb.INNER_PACK_SIZE,
         ecb.INNER_PACK_SIZE_UOM,
         ecb.PIECES_IN_RETAIL_PACK,
         ecb.ITEM_SIZE,
         ecb.ITEM_SIZE_UOM,
         ecb.SNGLE_UNITS_PER_MSTR_SELL_UNIT,
         ecb.SNGLE_UNITS_UOM,
         ecb.RANDOM_WEIGHT,
         ecb.SHIPPING_CASE_WEIGHT,
         ecb.NET_WEIGHT,
         ecb.SHIPPING_CASE_LENGTH,
         ecb.SHIPPING_CASE_WIDTH,
         ecb.SHIPPING_CASE_HEIGHT,
         ecb.SHIPPING_CASE_CUBE,
         ecb.RETAIL_BREAKABLE,
         ecb.UNIT_NET_WEIGHT,
         ecb.SKU_CASE_LENGTH,
         ecb.SKU_CASE_WIDTH,
         ecb.SKU_CASE_HEIGHT,
         ecb.UPC_UNIT_CD,
         ecb.SHELF_LIFE,
         ecb.DISTRESS_DAYS,
         ecb.STORAGE_TYPE,
         ecb.WHSE_TIE,
         ecb.WHSE_TIER,
         ecb.BURDENED_COST_CASE_AMT,
         ecb.UNBURDENED_COST_CASE_AMT,
         ecb.COMMENTS,
         ecb.PALLET_QTY,
         ecb.INSITE_FLG,
         ecb.CORP_AUTH_FLG,
         ecb.ITEM_AUTH_FLG,
         ecb.PRIVATE_BRAND_AUTH_FLG,
         ecb.ITEM_TYPE_CD
FROM     EDIADMIN.V_EDI_CATALOG_BASE ecb 
         inner join CRMADMIN.T_WHSE_ITEM i on ecb.FACILITYID = i.FACILITYID and ecb.ITEM_NBR_HS = i.ITEM_NBR_HS
WHERE    ecb.FACILITYID = '001'
AND      ecb.CUSTOMER_NBR_STND = 815
--AND      ecb.CORP_AUTH_FLG = 'Y'
AND      ecb.BILLING_STATUS_BACKSCREEN in ('A', 'W', 'S')
--AND      ecb.ITEM_TYPE_CD not in ('I')
--AND      ecb.INSITE_FLG = 'N'
AND      current date between ecb.COST_START_DATE and ecb.COST_END_DATE
--AND      ecb.ITEM_AUTH_FLG = 'Y'
--AND      ecb.PRIVATE_BRAND_AUTH_FLG = 'Y'
AND      i.ITEM_DEPT = '040'
;