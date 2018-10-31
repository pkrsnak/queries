SELECT   FACILITYID,
         CUSTOMER_NBR_STND,
         ITEM_NBR_HS,
         DESCRIPTION,
--         MANUFACTURER,
         UPC_CASE_CD,
--         BRAND,
--         MASTER_UOM,
         PACK_CASE,
--         INNER_PACKAGE_UNIT,
--         INNER_PACK_SIZE,
--         INNER_PACK_SIZE_UOM,
--         PIECES_IN_RETAIL_PACK,
         ITEM_SIZE,
         ITEM_SIZE_UOM,
--         SNGLE_UNITS_PER_MSTR_SELL_UNIT,
--         SNGLE_UNITS_UOM,
         RANDOM_WEIGHT,
         SHIPPING_CASE_WEIGHT,
--         NET_WEIGHT,
--         SHIPPING_CASE_LENGTH,
--         SHIPPING_CASE_WIDTH,
--         SHIPPING_CASE_HEIGHT,
--         SHIPPING_CASE_CUBE,
--         RETAIL_BREAKABLE,
--         UNIT_NET_WEIGHT,
--         SKU_CASE_LENGTH,
--         SKU_CASE_WIDTH,
--         SKU_CASE_HEIGHT,
         UPC_UNIT_CD,
--         ROTATION_CODE_DISPLAYED,
--         SHELF_LIFE,
--         DISTRESS_DAYS,
--         STORAGE_TYPE,
--         KOSHER,
--         HALAL,
--         GLUTEN_FREE,
--         HAZARD_CODE,
--         RAW_COOKED,
--         WHSE_TIE,
--         WHSE_TIER,
--         UPC_CASE,
--         GTIN,
         BURDENED_COST_FLG,
--         COST_START_DATE,
--         COST_END_DATE,
         CASE_COST_AMT,
         BURDENED_COST_CASE_AMT,
         UNBURDENED_COST_CASE_AMT,
         CASE_COST_NET_AMT,
         BURDENED_COST_CASE_NET_AMT,
         UNBURDENED_COST_CASE_NET_AMT,
         OI_ALLOWANCE_START_DATE,
         OI_ALLOWANCE_END_DATE,
         OI_ALLOWANCE_AMT,
         PA_ALLOWANCE_START_DATE,
         PA_ALLOWANCE_END_DATE,
         PA_ALLOWANCE_AMT --,
--         COMMENTS,
--         PALLET_QTY,
--         CORP_AUTH_FLG,
--         INSITE_FLG,
--         ITEM_TYPE_CD,
--         BILLING_STATUS_BACKSCREEN,
--         ITEM_AUTH_FLG,
--         PRIVATE_BRAND_AUTH_FLG
FROM     EDIADMIN.V_EDI_CATALOG_BASE
WHERE    FACILITYID = '015' --, '054')
AND      CUSTOMER_NBR_STND = 634001
AND      CORP_AUTH_FLG = 'Y'
AND      BILLING_STATUS_BACKSCREEN in ('A', 'W', 'S')
AND      ITEM_TYPE_CD not in ('I')
AND      INSITE_FLG = 'N'
AND      current date between COST_START_DATE and COST_END_DATE
AND      ITEM_AUTH_FLG = 'Y'
AND      PRIVATE_BRAND_AUTH_FLG = 'Y'
