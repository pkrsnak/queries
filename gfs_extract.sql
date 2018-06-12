--create or replace view ETLADMIN.V_TEMP_GFS_EXTRACT as;
SELECT distinct  i.FACILITYID, 
         i.ITEM_NBR_HS,
         trim(case when trim(i.ROOT_DESC) = '' then i.ITEM_DESCRIP else i.ROOT_DESC end) as DESCRIPTION,
         v.MASTER_VENDOR_DESC as manufacturer,
         i.UPC_CASE_CD,
         i.MANUFACTURER_NUMBER,
         i.BRAND,
         'Case' as MASTER_UOM,
         i.PACK_CASE,
         '' as INNER_PACKAGE_UNIT,
         i.ITEM_SIZE as INNER_PACK_SIZE,
         i.ITEM_SIZE_UOM as INNER_PACK_SIZE_UOM,
         i.PIECES_IN_RETAIL_PACK,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         (i.ITEM_SIZE * i.PACK_CASE) as SNGLE_UNITS_PER_MSTR_SELL_UNIT,
         i.ITEM_SIZE_UOM as SNGLE_UNITS_UOM,
         case trim(i.RAND_WGT_CD) 
              when 'R' then 'Yes' 
              else 'No' 
         end as RANDOM_WEIGHT,
         i.SHIPPING_CASE_WEIGHT,
         case 
              when i.NET_WEIGHT <> 0 then i.NET_WEIGHT 
              else i.SHIPPING_CASE_WEIGHT 
         end as NET_WEIGHT,
         i.SHIPPING_CASE_LENGTH,
         i.SHIPPING_CASE_WIDTH,
         i.SHIPPING_CASE_HEIGHT,
         i.SHIPPING_CASE_CUBE,
         'Yes' as RETAIL_BREAKABLE,
         dec(round(((case when i.NET_WEIGHT <> 0 then i.NET_WEIGHT else i.SHIPPING_CASE_WEIGHT end) / i.PACK_CASE), 2),6,2) as UNIT_NET_WEIGHT,
         i.SKU_CASE_LENGTH,
         i.SKU_CASE_WIDTH,
         i.SKU_CASE_HEIGHT,
         i.UPC_UNIT_CD,
         case i.SHELF_LIFE 
              when 365 then 'Open' 
              else 'Closed' 
         end as ROTATION_CODE_DISPLAYED,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS, --i.CODE_DATE_MIN, i.CODE_DATE_MAX,i.CODE_DATE_INVL, i.CODE_DATE_FLAG,
--         case i.WAREHOUSE_CODE 
--              when '10' then 30 
--              when '20' then 30 
--              when '30' then 10
--              when '40' then 60 
--              when '50' then 9999 
--              when '60' then 9999
--              when '70' then 9999
--              else 'Unknown' 
--         end as ACCEPT_DAYS,
         case i.WAREHOUSE_CODE 
              when '10' then 'Grocery' 
              when '20' then 'Frozen' 
              when '30' then 'Dairy' 
              when '40' then 'GM' 
              when '50' then 'Fresh Meat' 
              when '60' then 'Frozen Meat' 
              when '70' then 'Produce' 
              else 'Unknown' 
         end as STORAGE_TYPE,
         '' as kosher,
         '' as halal,
         '' as gluten_free,
         i.HAZARD_CODE,
         '' as raw_cooked,
         i.WHSE_TIE,
         i.WHSE_TIER,
         i.UPC_CASE_CD as UPC_CASE,
         i.GTIN,
0 cost1,
0 cost2,
--         cic.BURDENED_COST_CASE_AMT,
--         cic.UNBURDENED_COST_CASE_AMT,
         '' as COMMENTS,
--         cip.ALLOW_DATE_EFF,
--         cip.ALLOW_DATE_EXP,
--         cip.ALLOW_AMT,
--         cip.ALLOW_TYPE,
         vwicsg.PALLET_QTY
FROM     ETLADMIN.T_TEMP_FAC_ITEM tfi inner join
         CRMADMIN.T_WHSE_ITEM i on tfi.FACILITYID = i.FACILITYID and tfi.ITEM_NBR = i.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
--         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST cic on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS and cic.CUSTOMER_NBR_STND = 467 and cic.STATUS_CD = 'C' and cic.MASTER_ITEM_FLG = 'Y'
--         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH cid on i.FACILITYID = cid.FACILITYID and i.ITEM_NBR_HS = cid.ITEM_NBR_HS and cid.CUSTOMER_NBR_STND = 467 
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS 
--         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO cip on i.FACILITYID = cip.FACILITYID and i.ITEM_NBR_HS = cip.ITEM_NBR_HS and cip.CUSTOMER_GRP_CLASS = 0 and cip.FACILITYID = '001' and current date between cip.ALLOW_DATE_EFF and cip.ALLOW_DATE_EXP
WHERE    i.FACILITYID = '001'
--AND      (cid.ITEM_AUTH_CD is null
--     OR  cid.ITEM_AUTH_CD = 'Y')
;

--authorized item list
SELECT   Distinct i.FACILITYID,
         i.MERCH_DEPT,
         i.MERCH_DEPT_DESC,
         i.ITEM_NBR_HS,
         i.PURCH_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
--         i.PRIVATE_LABEL_KEY,
--         vwcpb.PRIV_BRAND_KEY,
         trim(case when trim(i.ROOT_DESC) = '' then i.ITEM_DESC else i.ROOT_DESC end) as DESCRIPTION,
         i.UPC_UNIT,
         i.UPC_CASE,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         (i.ITEM_SIZE * i.PACK_CASE) as SNGLE_UNITS_PER_MSTR_SELL_UNIT,
         i.ITEM_SIZE_UOM as SNGLE_UNITS_UOM,
         case trim(i.RAND_WGT_CD) 
              when 'R' then 'Yes' 
              else 'No' 
         end as RANDOM_WEIGHT,
         vwicsg.PALLET_QTY
FROM     CRMADMIN.V_WEB_ITEM_CORE i 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on cmd.FACILITYID = i.FACILITYID and cmd.MDSE_DEPT_CD = i.MERCH_DEPT and cmd.CUSTOMER_NBR_STND = 467 
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH cid on i.FACILITYID = cid.FACILITYID and i.ITEM_NBR_HS = cid.ITEM_NBR_HS and cid.CUSTOMER_NBR_STND = 467 
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY and vwcpb.CUSTOMER_NBR_STND = 467
WHERE    i.FACILITYID = '001'
AND      (cid.ITEM_AUTH_CD is null
     OR  cid.ITEM_AUTH_CD = 'Y')
AND      (i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY
     OR  i.PRIVATE_LABEL_KEY is null)
AND      i.PURCH_STATUS not in ('D', 'Z', 'X');