create or replace view ediadmin.V_EDI_CATALOG_BASE as 
SELECT   cic.FACILITYID,
         cic.CUSTOMER_NBR_STND,
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
         cic.BURDENED_COST_FLG,
         cic.START_DATE COST_START_DATE,
         cic.END_DATE_REAL COST_END_DATE,
         case cic.BURDENED_COST_FLG 
              when 'Y' then cic.BURDENED_COST_CASE_AMT 
              else cic.UNBURDENED_COST_CASE_AMT 
         end CASE_COST_AMT,
         cic.BURDENED_COST_CASE_AMT,
         cic.UNBURDENED_COST_CASE_AMT,
         case cic.BURDENED_COST_FLG 
              when 'Y' then cic.BURDENED_COST_CASE_NET_AMT 
              else cic.UNBURDENED_COST_CASE_NET_AMT 
         end CASE_COST_NET_AMT,
         cic.BURDENED_COST_CASE_NET_AMT,
         cic.UNBURDENED_COST_CASE_NET_AMT,
         cic.OI_ALLOWANCE_START_DATE,
         cic.OI_ALLOWANCE_END_DATE,
         cic.OI_ALLOWANCE_AMT,
         cic.PA_ALLOWANCE_START_DATE,
         cic.PA_ALLOWANCE_END_DATE,
         cic.PA_ALLOWANCE_AMT,
         '' as COMMENTS,
         vwicsg.PALLET_QTY,
         i.MERCH_DEPT_GRP,
         i.MERCH_DEPT,
         i.MERCH_GRP,
         i.MERCH_CAT,
         i.MERCH_CLASS,
         i.BILLING_STATUS_BACKSCREEN,
         case i.CORP_RES 
              when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' 
              when '000' then 'Y' 
              else 'N' 
         end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case 
              when cid.ITEM_AUTH_CD is null then 'Y' 
              else case 
                        when cid.ITEM_AUTH_CD = 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ITEM_AUTH_FLG,
         case 
              when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' 
              else case 
                        when i.PRIVATE_LABEL_KEY is null then 'Y' 
                        else 'N' 
                   end 
         end PRIVATE_BRAND_AUTH_FLG,
         case value(i.ITEM_RES33, ' ') 
              when ' ' then 'N' 
              else i.ITEM_RES33 
         end PRESELL_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date > A.START_DATE ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc on i.WAREHOUSE_CODE = wc.WAREHOUSE_CODE and i.FACILITYID = wc.FACILITYID 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on i.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y'
--WHERE    case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
--AND      cic.FACILITYID = '015'
--AND      cic.CUSTOMER_NBR_STND = 6467
--AND      i.BILLING_STATUS_BACKSCREEN in ('A', 'W', 'S')
--AND      i.ITEM_TYPE_CD not in ('I')
--AND      i.INSITE_FLG = 'N'
--AND      current date between cic.START_DATE and cic.END_DATE_REAL
;

grant select on ediadmin.V_EDI_CATALOG_BASE to user CRMEXPLN;
grant control on ediadmin.V_EDI_CATALOG_BASE to user ETL;
grant select on ediadmin.V_EDI_CATALOG_BASE to user ETLX;
grant select,update,insert,delete on ediadmin.V_EDI_CATALOG_BASE to user ETL with grant option;
grant select on ediadmin.V_EDI_CATALOG_BASE to user WEB;
grant select on ediadmin.V_EDI_CATALOG_BASE to user SIUSER;


create or replace view ediadmin.V_EDI_DEAL_BASE
as
SELECT   i.FACILITYID,
         i.CUSTOMER_NBR_STND,
         i.UPC_UNIT_CD,
         i.ITEM_NBR_HS,
         i.DESCRIPTION,
         cip.ALLOW_DATE_EFF,
         cip.ALLOW_DATE_EXP,
         cip.ALLOW_AMT,
         cip.ALLOW_TYPE,
         i.CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         i.BILLING_STATUS_BACKSCREEN,
         i.ITEM_AUTH_FLG,
         i.PRIVATE_BRAND_AUTH_FLG
FROM     EDIADMIN.V_EDI_CATALOG_BASE i 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = i.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP cipg on cipg.FACILITYID = i.FACILITYID and cipg.CUSTOMER_NBR_STND = i.CUSTOMER_NBR_STND 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO cip on i.FACILITYID = cip.FACILITYID and cip.CUSTOMER_GRP_CLASS = cipg.CUSTOMER_GRP_CLASS and i.ITEM_NBR_HS = cip.ITEM_NBR_HS 
;

grant select on ediadmin.V_EDI_DEAL_BASE to user CRMEXPLN;
grant control on ediadmin.V_EDI_DEAL_BASE to user ETL;
grant select on ediadmin.V_EDI_DEAL_BASE to user ETLX;
grant select,update,insert,delete on ediadmin.V_EDI_DEAL_BASE to user ETL with grant option;
grant select on ediadmin.V_EDI_DEAL_BASE to user WEB;
grant select on ediadmin.V_EDI_DEAL_BASE to user SIUSER;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT   FACILITYID,
         ITEM_NBR_HS,
         DESCRIPTION,
         MANUFACTURER,
         UPC_CASE_CD,
         BRAND,
         MASTER_UOM,
         PACK_CASE,
         INNER_PACKAGE_UNIT,
         INNER_PACK_SIZE,
         INNER_PACK_SIZE_UOM,
         PIECES_IN_RETAIL_PACK,
         ITEM_SIZE,
         ITEM_SIZE_UOM,
         SNGLE_UNITS_PER_MSTR_SELL_UNIT,
         SNGLE_UNITS_UOM,
         RANDOM_WEIGHT,
         SHIPPING_CASE_WEIGHT,
         NET_WEIGHT,
         SHIPPING_CASE_LENGTH,
         SHIPPING_CASE_WIDTH,
         SHIPPING_CASE_HEIGHT,
         SHIPPING_CASE_CUBE,
         RETAIL_BREAKABLE,
         UNIT_NET_WEIGHT,
         SKU_CASE_LENGTH,
         SKU_CASE_WIDTH,
         SKU_CASE_HEIGHT,
         UPC_UNIT_CD,
         ROTATION_CODE_DISPLAYED,
         SHELF_LIFE,
         DISTRESS_DAYS,
         STORAGE_TYPE,
         KOSHER,
         HALAL,
         GLUTEN_FREE,
         HAZARD_CODE,
         RAW_COOKED,
         WHSE_TIE,
         WHSE_TIER,
         UPC_CASE,
         GTIN,
         BURDENED_COST_CASE_AMT,
         UNBURDENED_COST_CASE_AMT,
         COMMENTS,
         OI_ALLOWANCE_START_DATE,
         OI_ALLOWANCE_END_DATE,
         OI_ALLOWANCE_AMT,
         PA_ALLOWANCE_START_DATE,
         PA_ALLOWANCE_END_DATE,
         PA_ALLOWANCE_AMT,
         PALLET_QTY
--         INSITE_FLG,
--         ITEM_TYPE_CD, 
--         CORP_AUTH_FLG,
--         ITEM_AUTH_FLG, 
--         PRIVATE_BRAND_AUTH_FLG
FROM     EDIADMIN.V_EDI_CATALOG_BASE
--WHERE    FACILITYID = #prompt('facility')# 
--AND      CUSTOMER_NBR_STND = #prompt('customer')# 
--AND      BILLING_STATUS_BACKSCREEN in #prompt('billing_status')# 
--AND      ITEM_TYPE_CD not in #prompt('item_type')# 
--AND      #prompt('snapshot_date')# between START_DATE and END_DATE
--AND      (#prompt('snapshot_date')# between ALLOW_DATE_EFF and ALLOW_DATE_EXP or ALLOW_DATE_EXP is null)
--WHERE    FACILITYID = '001'
--AND      CUSTOMER_NBR_STND = 467
WHERE    FACILITYID = '015'
AND      CUSTOMER_NBR_STND = 6467
AND      current date between COST_START_DATE and COST_END_DATE
AND      BILLING_STATUS_BACKSCREEN in ('A', 'W', 'S') 
AND      ITEM_TYPE_CD not in ('I')
AND      INSITE_FLG = 'N'
AND      CORP_AUTH_FLG = 'Y'
AND      ITEM_AUTH_FLG = 'Y'
AND      PRIVATE_BRAND_AUTH_FLG = 'Y'
;

WHERE    1=1
--AND      (cid.ITEM_AUTH_CD is null
--     OR  cid.ITEM_AUTH_CD = 'Y')
--AND      (i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY
--     OR  i.PRIVATE_LABEL_KEY is null)
AND      i.FACILITYID = '058'
AND      c.CUSTOMER_NBR_STND = 85
AND      i.BILLING_STATUS_BACKSCREEN in ('A', 'W', 'S')
AND      i.ITEM_TYPE_CD not in ('I')
AND      i.INSITE_FLG = 'N'
AND      current date between cic.START_DATE and cic.END_DATE_REAL
;


--deal view hold 

create or replace view ediadmin.V_EDI_DEAL_BASE
as
SELECT   cic.FACILITYID,
         cic.CUSTOMER_NBR_STND,
         cip.UPC_UNIT,
         cip.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         cip.ALLOW_DATE_EFF,
         cip.ALLOW_DATE_EXP,
         cip.ALLOW_AMT,
         cip.ALLOW_TYPE,
         case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         i.BILLING_STATUS_BACKSCREEN,
         case when cid.ITEM_AUTH_CD is null then 'Y' else case when cid.ITEM_AUTH_CD = 'Y' then 'Y' else 'N' end end ITEM_AUTH_FLG,
         case when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' else case when i.PRIVATE_LABEL_KEY is null then 'Y' else 'N' end end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT,
                       BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT,
                       PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT
                  FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A 
                  WHERE      A.CUSTOMER_NBR_STND > 0 and A.FACILITYID in (select SWAT_ID from CRMADMIN.T_WHSE_DIV_XREF where ACTIVE_FLAG = 'Y')
                         AND current date between A.START_DATE and A.END_DATE_REAL
                         AND A.MASTER_ITEM_FLG = 'Y'                          
               ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP cipg on cipg.FACILITYID = cic.FACILITYID and cipg.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO cip on i.FACILITYID = cip.FACILITYID and cip.CUSTOMER_GRP_CLASS = cipg.CUSTOMER_GRP_CLASS and i.ITEM_NBR_HS = cip.ITEM_NBR_HS 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on i.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y'
;
