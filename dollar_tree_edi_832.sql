SELECT
       FACILITYID,
       CUSTOMER_NBR_STND,
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
       BURDENED_COST_FLG,
       COST_START_DATE,
       COST_END_DATE,
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
       PA_ALLOWANCE_AMT,
       COMMENTS,
       PALLET_QTY,
       CORP_AUTH_FLG,
       INSITE_FLG,
       ITEM_TYPE_CD,
       BILLING_STATUS_BACKSCREEN,
       ITEM_AUTH_FLG,
       PRIVATE_BRAND_AUTH_FLG
FROM
       EDIADMIN.V_EDI_CATALOG_BASE
WHERE
       FACILITYID = '079'
       AND CUSTOMER_NBR_STND = '564101'
       AND CORP_AUTH_FLG = 'Y'
       AND BILLING_STATUS_BACKSCREEN IN ('A', 'W', 'S')
       AND ITEM_TYPE_CD NOT IN ('I')
       AND INSITE_FLG = 'N'
       AND CURRENT date BETWEEN COST_START_DATE AND COST_END_DATE
       AND ITEM_AUTH_FLG = 'Y'
       AND PRIVATE_BRAND_AUTH_FLG = 'Y'
       AND PRESELL_FLG = 'N'
 ;


select * from CRMADMIN.V_WEB_CUSTOMER_ITEM_COST where CUSTOMER_NBR_STND = '564101'
;

select * from CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT where CUSTOMER_NBR_STND = '564101'
;

select * from CRMADMIN.T_WHSE_WAREHOUSE_CODE where facilityid = '079'
;
CREATE view ediadmin.V_EDI_CATALOG_BASE as 
;

select * from (
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
         i.BILLING_STATUS_BACKSCREEN, i.INVENTORY_TOTAL,
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
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date >= A.START_DATE ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc on i.WAREHOUSE_CODE = wc.WAREHOUSE_CODE and i.FACILITYID = wc.FACILITYID 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on i.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y'
)
WHERE
       FACILITYID = '079'
       AND CUSTOMER_NBR_STND = '564101'
       AND CORP_AUTH_FLG = 'Y'
       AND BILLING_STATUS_BACKSCREEN IN ('A', 'W', 'S')
       AND ITEM_TYPE_CD NOT IN ('I')
       AND INSITE_FLG = 'N'
       AND CURRENT date BETWEEN COST_START_DATE AND COST_END_DATE 
       AND ITEM_AUTH_FLG = 'Y'
       AND PRIVATE_BRAND_AUTH_FLG = 'Y'
       AND PRESELL_FLG = 'N'
;


SELECT   *
FROM     CRMADMIN.V_WEB_CUSTOMER_ITEM_COST
WHERE    FACILITYID = '079'
AND      CUSTOMER_NBR_STND = 564101
AND      current date between start_date and END_DATE_REAL
;

SELECT   *
FROM     crmadmin.T_WHSE_SALES_HISTORY_DTL_EXT
WHERE    INVOICE_NBR=4362590
AND      CUSTOMER_NBR_STND =325030
AND      ITEM_NBR_hs = '0104877'
AND      FACILITYID = '040'
;

SELECT   FACILITYID,
         ITEM_NBR_HS,
         billing_status_backscreen,
         BILLING_STATUS,
         PURCH_STATUS
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    item_nbr in ( '840207', '840215', '840231', '840249', '840256', '840264', '840298', '840306', '840314', '840322', '840371')
AND      FACILITYID = '079'