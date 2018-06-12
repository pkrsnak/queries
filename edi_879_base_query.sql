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
         cic.UNBURDENED_COST_CASE_AMT, cic.START_DATE COST_START_DATE, cic.END_DATE COST_END_DATE,
         '' as COMMENTS,
--         cip.ALLOW_DATE_EFF,
--         cip.ALLOW_DATE_EXP,
--         cip.ALLOW_AMT,
--         cip.ALLOW_TYPE,
         vwicsg.PALLET_QTY
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC c on i.FACILITYID = c.FACILITYID and c.FACILITYID = '058' and c.CUSTOMER_NBR_STND = 11655 
         inner join CRMADMIN.T_WHSE_CUST_DEPT_MDM cmd on i.FACILITYID = cmd.FACILITYID  and  i.MERCH_DEPT = cmd.MDSE_DEPT_CD and cmd.ACTIVE = 'Y' and cmd.FACILITYID = '058' and cmd.CUSTOMER_NBR_STND = 11655
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY and vwcpb.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and vwcpb.FACILITYID = '058' and vwcpb.CUSTOMER_NBR_STND = 11655
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH cid on i.FACILITYID = cid.FACILITYID and i.ITEM_NBR_HS = cid.ITEM_NBR_HS and cid.FACILITYID = '058' and cid.CUSTOMER_NBR_STND = 11655 
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO cip on i.FACILITYID = cip.FACILITYID and i.ITEM_NBR_HS = cip.ITEM_NBR_HS and cip.CUSTOMER_GRP_CLASS = 0 and cip.FACILITYID = '058' and current date + 7 days between cip.ALLOW_DATE_EFF and cip.ALLOW_DATE_EXP
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST cic on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS and cic.FACILITYID = '058' and cic.CUSTOMER_NBR_STND = 11655 and cic.MASTER_ITEM_FLG = 'Y' and cic.START_DATE <= current date + 7 days and (cic.END_DATE >= current date + 7 days or cic.END_DATE is null) 
WHERE    i.FACILITYID = '058'
and v.FACILITYID = '058'
AND      (cid.ITEM_AUTH_CD is null
     OR  cid.ITEM_AUTH_CD = 'Y')
AND       i.INSITE_FLG = 'N'
AND      (i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY
     OR  i.PRIVATE_LABEL_KEY is null)
and i.ITEM_TYPE_CD not in ('I')
;

create or replace view ediadmin.V_EDI_CATALOG_BASE
as
;
SELECT   c.FACILITYID,                   --?????????????????  cic
         c.CUSTOMER_NBR_STND,                   --?????????????????  cic
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
         wc.WAREHOUSE_CODE_DESC as STORAGE_TYPE,
         '' as kosher,
         '' as halal,
         '' as gluten_free,
         i.HAZARD_CODE,
         '' as raw_cooked,
         i.WHSE_TIE,
         i.WHSE_TIER,
         i.UPC_CASE_CD as UPC_CASE,
         i.GTIN,
         cic.START_DATE COST_START_DATE,
         cic.END_DATE_REAL COST_END_DATE,
         cic.BURDENED_COST_CASE_AMT,
         cic.UNBURDENED_COST_CASE_AMT,
         cic.BURDENED_COST_CASE_NET_AMT,
         cic.UNBURDENED_COST_CASE_NET_AMT,
         cic.OI_ALLOWANCE_START_DATE, cic.OI_ALLOWANCE_END_DATE, cic.OI_ALLOWANCE_AMT,
         cic.PA_ALLOWANCE_START_DATE, cic.PA_ALLOWANCE_END_DATE, cic.PA_ALLOWANCE_AMT,
         '' as COMMENTS,
         vwicsg.PALLET_QTY,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         i.BILLING_STATUS_BACKSCREEN
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC c on i.FACILITYID = c.FACILITYID 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST cic on i.FACILITYID = cic.FACILITYID and c.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.ITEM_NBR_HS = cic.ITEM_NBR_HS and cic.MASTER_ITEM_FLG = 'Y' 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD  
         inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc on i.FACILITYID = wc.FACILITYID and i.WAREHOUSE_CODE = wc.WAREHOUSE_CODE 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS 
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH cid on i.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and i.ITEM_NBR_HS = cid.ITEM_NBR_HS 
WHERE    (cid.ITEM_AUTH_CD is null
     OR  cid.ITEM_AUTH_CD = 'Y')
AND      (i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY
     OR  i.PRIVATE_LABEL_KEY is null)
AND      i.FACILITYID = '015'
AND      c.CUSTOMER_NBR_STND = 6467
AND      i.BILLING_STATUS_BACKSCREEN in ('A', 'W', 'S')
AND      i.ITEM_TYPE_CD not in ('I')
AND      i.INSITE_FLG = 'N'
AND      current date between cic.START_DATE and cic.END_DATE_REAL
;

grant select on ediadmin.V_EDI_CATALOG_BASE to user CRMEXPLN;
grant control on ediadmin.V_EDI_CATALOG_BASE to user ETL;
grant select on ediadmin.V_EDI_CATALOG_BASE to user ETLX;
grant select,update,insert,delete on ediadmin.V_EDI_CATALOG_BASE to user ETL with grant option;
grant select on ediadmin.V_EDI_CATALOG_BASE to user WEB;
grant select on ediadmin.V_EDI_CATALOG_BASE to user SIUSER;


create or replace view ediadmin.V_EDI_DEAL_BASE
as
SELECT   cip.FACILITYID,
         c.CUSTOMER_NBR_STND,
         cip.UPC_UNIT,
         cip.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         cip.ALLOW_DATE_EFF,
         cip.ALLOW_DATE_EXP,
         cip.ALLOW_AMT,
         cip.ALLOW_TYPE,
         case i.INSITE_FLG 
              when 'Y' then 'Y' 
              else 'N' 
         end INSITE_FLG,
         i.ITEM_TYPE_CD,
         i.BILLING_STATUS_BACKSCREEN
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC c on i.FACILITYID = c.FACILITYID 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and i.MERCH_DEPT = cmd.MDSE_DEPT_CD and cmd.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP cipg on cipg.FACILITYID = c.FACILITYID and cipg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND 
         inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc on i.FACILITYID = wc.FACILITYID and i.WAREHOUSE_CODE = wc.WAREHOUSE_CODE 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST cic on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS and c.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.MASTER_ITEM_FLG = 'Y' 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_ALL cip on i.FACILITYID = cip.FACILITYID and cip.CUSTOMER_GRP_CLASS = cipg.CUSTOMER_GRP_CLASS and i.ITEM_NBR_HS = cip.ITEM_NBR_HS 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY and vwcpb.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND 
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH cid on i.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and i.ITEM_NBR_HS = cid.ITEM_NBR_HS
WHERE    (cid.ITEM_AUTH_CD is null
     OR  cid.ITEM_AUTH_CD = 'Y')
AND      case i.INSITE_FLG when 'Y' then 'Y' else 'N' end = 'N'
AND      (i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY
     OR  i.PRIVATE_LABEL_KEY is null)
AND      i.ITEM_TYPE_CD not in ('I')
--AND      i.BILLING_STATUS_BACKSCREEN in ('A', 'W', 'S')
--AND      i.FACILITYID = '015'
--AND      c.CUSTOMER_NBR_STND = 6467
--AND      current date + 7 days between cic.START_DATE and cic.END_DATE_REAL
--AND      current date between cic.START_DATE and cic.END_DATE_REAL 
;

grant select on ediadmin.V_EDI_DEAL_BASE to user CRMEXPLN;
grant control on ediadmin.V_EDI_DEAL_BASE to user ETL;
grant select on ediadmin.V_EDI_DEAL_BASE to user ETLX;
grant select,update,insert,delete on ediadmin.V_EDI_DEAL_BASE to user ETL with grant option;
grant select on ediadmin.V_EDI_DEAL_BASE to user WEB;
grant select on ediadmin.V_EDI_DEAL_BASE to user SIUSER;