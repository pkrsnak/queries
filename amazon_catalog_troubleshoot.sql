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
              when i.BILLING_STATUS_BACKSCREEN = 'P' then 'NOT IN STOCK YET' 
              else 'PERM_OUT_OF_STOCK' 
         end availability_status,
         CASE 
              WHEN right(cast(round(cast(cast(cic.BURDENED_COST_CASE_AMT as decimal(7,3)) / cast(i.PACK_CASE as decimal(7,3)) as decimal(7,3)),3) as decimal(7,3)), 1) > 0 THEN cast(round(cast(cast(cic.BURDENED_COST_CASE_AMT as decimal(7,3)) / cast(i.PACK_CASE as decimal(7,3)) as decimal(7,3)),3) as decimal(6,2)) + 0.01 
                                                                                                                                                                                                                                                                    Else cast(cic.BURDENED_COST_CASE_AMT / i.PACK_CASE as decimal(6,2)) 
                                                                                                                                                                                                                                                                                                                  END item_cost_price,
         i.PACK_CASE case_pack_quantity,
         cic.BURDENED_COST_CASE_AMT case_pack_cost_price,
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
         cic.BURDENED_COST_CASE_AMT case_pack_cost_burdened,
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
FROM     TABLE( SELECT FACILITYID, CUSTOMER_NBR_STND, BURDENED_COST_FLG, CORP_SWAT, ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, BURDENED_COST_UNIT_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST WHERE FACILITYID = '054' and CUSTOMER_NBR_STND = 634001 and MASTER_ITEM_FLG = 'Y' AND current date between START_DATE and END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    (i.ITEM_TYPE_CD = 'R'
     OR  (i.ITEM_TYPE_CD = 'I'
        AND asin.LU_CODE is not null))
AND      (i.PURCH_STATUS in ('A','S','D')
     AND i.BILLING_STATUS not in ('D','I'))
and i.UPC_UNIT_CD in ('00000018000426911', '00000858030008073', '00000193908110015', '00000193908110060')
;


SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.UPC_UNIT_CD,
         i.ITEM_TYPE_CD,
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         c.BURDENED_COST_FLG,
         c.BURDENED_COST_CASE_AMT,
         c.START_DATE,
         c.END_DATE_REAL
FROM     CRMADMIN.T_WHSE_ITEM i 
         left join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST c on i.FACILITYID = c.FACILITYID and i.ITEM_NBR_HS = c.ITEM_NBR_HS and c.CUSTOMER_NBR_STND = 634001
WHERE    i.UPC_UNIT_CD in ('00000018000426911', '00000858030008073', '00000193908110015', '00000193908110060')
AND      i.FACILITYID in ('008', '040')
--AND (current date between c.START_DATE and c.END_DATE_REAL or (c.START_DATE  is null and c.END_DATE_REAL is null))
;


Select * from CRMADMIN.V_AMZ_CATALOG_FEED
where  UNIT_UPC in ('00000018000426911', '00000858030008073', '00000193908110015', '00000193908110060')
and FACILITYID in ('040', '008')
;

B01DC73HO8 AmazonUs/F3SPB 18000426911
B07QHHB7PV AmazonUs/SPD2Z 858030008073
B082FZ1J22 AmazonUs/SPD2Z 193908110015
B082FZ8RBZ AmazonUs/SPD2Z 193908110060