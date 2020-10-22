SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PURCH_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.ITEM_RES28
FROM     CRMADMIN.T_WHSE_ITEM i
WHERE    i.FACILITYID = '040'
AND      i.ITEM_NBR_HS in ('0059550', '0059626', '3003985', '3003993', '3004215', '3004223', '3004314', '5899224', '5912332', '5912431', '5912597', '5922802', '5923057', '5923065', '5923206', '5923313', '5923321', '5923339', '8418154', '8423212', '0033290', '0059204', '0059345', '0059469', '0059485', '0059600', '0093583', '1310614', '4825683', '4951240', '5192208', '5192216', '5851712', '5852009', '5912324', '5912357', '5950704', '5950753', '5950761', '5950787', '5971767', '9345604', '9514084', '9836420')
;

SELECT   cic.FACILITYID,
         cic.CUSTOMER_NBR_STND,
         cic.ITEM_NBR_HS,
         cic.START_DATE,
         cic.END_DATE_REAL,
         cic.UNBURDENED_COST_UNIT_AMT,
         cic.UNBURDENED_COST_CASE_AMT
FROM     CRMADMIN.V_WEB_CUSTOMER_ITEM_COST cic
WHERE    cic.FACILITYID = '040'
AND      cic.ITEM_NBR_HS in ('0059550', '0059626', '3003985', '3003993', '3004215')
AND      cic.CUSTOMER_NBR_STND = 634001
;


SELECT   *
FROM     CRMADMIN.V_AMZ_CATALOG_FEED acf
WHERE    acf.FACILITYID = '040'
AND      acf.VENDOR_SKU in ('0059550', '0059626', '3003985', '3003993', '3004215')
;


Select * from CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH cid
WHERE    cid.FACILITYID = '040'
AND      cid.ITEM_NBR_HS in ('0059550', '0059626', '3003985', '3003993', '3004215')
;



SELECT   case cic.FACILITYID 
     when '054' then '040' 
     else cic.FACILITYID 
end FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '054' then 'F3SPB' 
              when '040' then 'F3SPB' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.LU_CODE asin,
         i.UPC_UNIT_CD unit_upc,
         i.UPC_CASE_CD case_upc,
         i.GTIN,
         i.ITEM_NBR_HS vendor_sku,
         trim(i.BRAND) || ' ' || trim(i.RETAIL_ITEM_DESC) || ' ' || trim(i.ITEM_SIZE) || ' ' || trim(i.ITEM_SIZE_UOM) item_name,
         i.BRAND brand,
         v.MASTER_VENDOR_DESC manufacturer,
         v.VENDOR_NAME supplier_Name,
         case 
              when i.BILLING_STATUS_BACKSCREEN in ('A', 'W') then case 
                                                                       when i.AVAILABILITY_DATE > current date then 'TEMP_OUT_OF_STOCK' 
                                                                       when i.RE_AVAILABLE_DATE > current date then 'TEMP_OUT_OF_STOCK' 
                                                                       else 'AVAILABLE' 
                                                                  end 
              else 'PERM_OUT_OF_STOCK' 
         end availability_status,
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_Price,
         case i.WAREHOUSE_CODE 
              when '01' then 'Chilled' 
              when '02' then 'Chilled' 
              when '08' then 'Chilled' 
              when '07' then 'Frozen' 
              else 'Ambient' 
         end temp_type,
         i.RET_UNIT_SIZE,
         i.RET_UNIT_DESC,
         (case i.CODE_DATE_FLAG when 'Y' then 'Shelf Life' else 'Does Not Expire' end) expiration_type,
         (case i.CODE_DATE_FLAG when 'Y' then i.SHELF_LIFE else 365 end) shelf_life,
         i.MERCH_DEPT_DESC,
         i.MERCH_GRP_DESC,
         i.MERCH_CAT_DESC,
         i.MERCH_CLASS_DESC,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_burdened,
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
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
         end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date between A.START_DATE and A.END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    cic.FACILITYID = '040'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
