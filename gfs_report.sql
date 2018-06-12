SELECT   i.FACILITYID,
         c.CUSTOMER_NBR_STND,
         i.UPC_UNIT,
         i.ITEM_NBR_HS,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         case d.ITEM_AUTH_CD 
              when 'N' then 'N' 
              else 'Y' 
         end ITEM_AUTH,
         s.START_DATE,
         s.END_DATE,
         case c.BURDENED_COST_FLG 
              when 'N' then s.UNBURDENED_COST_CASE_AMT 
              else s.BURDENED_COST_CASE_AMT 
         end COST_AMOUNT,
         i.BILLING_STATUS_BACKSCREEN
FROM     CRMADMIN.V_WEB_ITEM_CORE AS i 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC c on i.FACILITYID = c.FACILITYID and c.FACILITYID = '058' and c.CUSTOMER_NBR_STND = 1429 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.MDSE_DEPT_CD = i.MERCH_DEPT and cmd.CUSTOMER_NBR_STND = 1429 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST s ON i.FACILITYID = s.FACILITYID and i.ITEM_NBR_HS = s.ITEM_NBR_HS and s.MASTER_ITEM_FLG = 'Y' and s.CUSTOMER_NBR_STND = 1429 and s.STATUS_CD = 'C' 
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH d on i.FACILITYID = d.FACILITYID and i.ITEM_NBR_HS = d.ITEM_NBR_HS and c.FACILITYID = d.FACILITYID and c.CUSTOMER_NBR_STND = d.CUSTOMER_NBR_STND and d.FACILITYID = '058' and d.CUSTOMER_NBR_STND = 1429 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY and vwcpb.FACILITYID = '058' and vwcpb.CUSTOMER_NBR_STND = 1429
WHERE    i.INSITE_DISPLAY_FLG = 'N'
AND      (i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY
     OR  i.PRIVATE_LABEL_KEY is null)
;


SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         trim(case when trim(i.ROOT_DESC) = '' then i.ITEM_DESCRIP else i.ROOT_DESC end) as DESCRIPTION,
         v.MASTER_VENDOR_DESC as manufacturer,
         i.UPC_CASE_CD,
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
         i.DISTRESS_DAYS,
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
         cic.BURDENED_COST_CASE_AMT,
         cic.UNBURDENED_COST_CASE_AMT,
         '' as COMMENTS,
         cip.ALLOW_DATE_EFF,
         cip.ALLOW_DATE_EXP,
         cip.ALLOW_AMT,
         cip.ALLOW_TYPE,
         vwicsg.PALLET_QTY
FROM     CRMADMIN.T_WHSE_ITEM i 
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR and v.FACILITYID = '001' 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC c on i.FACILITYID = c.FACILITYID and c.FACILITYID = '001' and c.CUSTOMER_NBR_STND = 467 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.MDSE_DEPT_CD = i.MERCH_DEPT and cmd.FACILITYID = '001' and cmd.CUSTOMER_NBR_STND = 467 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST cic on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS and cic.FACILITYID = '001' and cic.CUSTOMER_NBR_STND = 467 and cic.MASTER_ITEM_FLG = 'Y' and cic.START_DATE <= current date + 7 days and (cic.END_DATE >= current date + 7 days or cic.END_DATE is null) 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY and vwcpb.FACILITYID = '001' and vwcpb.CUSTOMER_NBR_STND = 467
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH cid on i.FACILITYID = cid.FACILITYID and i.ITEM_NBR_HS = cid.ITEM_NBR_HS and cid.FACILITYID = '001' and cid.CUSTOMER_NBR_STND = 467 
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO cip on i.FACILITYID = cip.FACILITYID and i.ITEM_NBR_HS = cip.ITEM_NBR_HS and cip.CUSTOMER_GRP_CLASS = 0 and cip.FACILITYID = '001' and current date + 7 days between cip.ALLOW_DATE_EFF and cip.ALLOW_DATE_EXP
WHERE    i.FACILITYID = '001'
AND      (cid.ITEM_AUTH_CD is null
     OR  cid.ITEM_AUTH_CD = 'Y')
AND       i.INSITE_FLG = 'N'
AND      (i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY
     OR  i.PRIVATE_LABEL_KEY is null)
;

-----------------------------------------------------------------------------------------------------------------------
--in progress





SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         trim(case when trim(i.ROOT_DESC) = '' then i.ITEM_DESCRIP else i.ROOT_DESC end) as DESCRIPTION,
         v.MASTER_VENDOR_DESC as manufacturer,
         i.UPC_CASE_CD,
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
         i.DISTRESS_DAYS,
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
         cic.BURDENED_COST_CASE_AMT,
         cic.UNBURDENED_COST_CASE_AMT,
         '' as COMMENTS,
         cip.ALLOW_DATE_EFF,
         cip.ALLOW_DATE_EXP,
         cip.ALLOW_AMT,
         cip.ALLOW_TYPE,
         vwicsg.PALLET_QTY
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC c on i.FACILITYID = c.FACILITYID and c.FACILITYID = '015' and c.CUSTOMER_NBR_STND = 6467 
         inner join CRMADMIN.T_WHSE_CUST_DEPT_MDM cmd on i.FACILITYID = cmd.FACILITYID  and  i.MERCH_DEPT = cmd.MDSE_DEPT_CD and cmd.ACTIVE = 'Y' and cmd.FACILITYID = '015' and cmd.CUSTOMER_NBR_STND = 6467
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY and vwcpb.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and vwcpb.FACILITYID = '015' and vwcpb.CUSTOMER_NBR_STND = 6467
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH cid on i.FACILITYID = cid.FACILITYID and i.ITEM_NBR_HS = cid.ITEM_NBR_HS and cid.FACILITYID = '015' and cid.CUSTOMER_NBR_STND = 6467 
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO cip on i.FACILITYID = cip.FACILITYID and i.ITEM_NBR_HS = cip.ITEM_NBR_HS and cip.CUSTOMER_GRP_CLASS = 0 and cip.FACILITYID = '015' and current date + 7 days between cip.ALLOW_DATE_EFF and cip.ALLOW_DATE_EXP
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST cic on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS and cic.FACILITYID = '015' and cic.CUSTOMER_NBR_STND = 6467 and cic.MASTER_ITEM_FLG = 'Y' and cic.START_DATE <= current date + 7 days and (cic.END_DATE >= current date + 7 days or cic.END_DATE is null) 
WHERE    i.FACILITYID = '015'
and v.FACILITYID = '015'
AND      (cid.ITEM_AUTH_CD is null
     OR  cid.ITEM_AUTH_CD = 'Y')
AND       i.INSITE_FLG = 'N'
AND      (i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY
     OR  i.PRIVATE_LABEL_KEY is null)
and i.ITEM_TYPE_CD not in ('I')
;
