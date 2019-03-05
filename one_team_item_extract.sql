SELECT   i.FACILITYID,
         '0' || trim(i.STOCK_FAC) as STOCKING_FACILITY,
         i.ITEM_NBR_HS,
         i.UPC_UNIT,
--         case 
--              when i.UPC_UNIT between '00000000000003000' and '00000000000004999' then '' 
--              else case 
--                        when i.UPC_UNIT between '00000000000093000' and '00000000000094999' then '' 
--                        else case 
--                                  when i.UPC_UNIT between '00000040000000000' and '00000049999999999' then '' 
--                                  else i.UPC_UNIT 
--                             end 
--                   end 
--         end UPC,
--         case 
--              when i.UPC_UNIT between '00000000000003000' and '00000000000004999' then i.UPC_UNIT 
--              else case 
--                        when i.UPC_UNIT between '00000000000093000' and '00000000000094999' then i.UPC_UNIT 
--                        else '' 
--                   end 
--         end PLU,
--         case 
--              when i.UPC_UNIT between '00000040000000000' and '00000049999999999' then i.UPC_UNIT 
--              else '' 
--         end PSEUDO,
         i.UPC_CASE,
         i.BRAND,
         trim(i.ITEM_DESCRIP) as ITEM_DESC,
--         trim(i.SHORT_DESCRIPTION) as SHORT_DESC,
--         trim(i.RETAIL_ITEM_DESC) RETAIL_ITEM_DESC,
--         trim(i.POS_16_DESC) POS_16_DESC,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.ITEM_SIZE_DESCRIP,
         i.PACK_CASE,
         i.RET_UNIT_SIZE,
         i.RET_UNIT_DESC,
         i.RETAIL_PACK,
         i.VENDOR_NBR,
         i.BUYER_NBR,
         i.MERCH_DEPT_GRP,
         trim(i.MERCH_DEPT_GRP_DESC) as MERCH_DEPT_GRP_DESC,
         i.MERCH_DEPT,
         trim(i.MERCH_DEPT_DESC) as MERCH_DEPT_DESC,
         i.MERCH_GRP,
         trim(i.MERCH_GRP_DESC) as MERCH_GRP_DESC,
         i.MERCH_CAT,
         trim(i.MERCH_CAT_DESC) as MERCH_CAT_DESC,
         i.MERCH_CLASS,
         trim(i.MERCH_CLASS_DESC) as MERCH_CLASS_DESC,
         i.ITEM_DEPT as WHOLESALE_DEPT,
         d.DEPT_DESCRIPTION,
         i.ITEM_DEPT_OVERRIDE as WHOLESALE_DEPT_OVERRIDE,
         i.PRODUCT_GROUP,
         pg.PROD_GROUP_DESC,
         i.PRODUCT_SUB_GROUP,
         psg.PROD_SUBGROUP_DESC,
         i.RETAIL_DEPT,
         rd.RETAIL_DEPT_DESC,
         i.CAT_HDG, 
         ch.CATLG_HDNG_DESC,
         i.SET_CD,
         sc.SET_CD_DESC,
--         i.WAREHOUSE_CODE,
--         i.AVERAGE_COST,
--         i.PVT_LBL,
--         case 
--              when int(i.PRIVATE_LABEL_KEY) > 0 then 'Y' 
--              else 'N' 
--         end PRIVATE_LABEL_INDICATOR,
--         i.PRIVATE_LABEL_KEY,
--         i.ORDER_UNIT,
--         i.ITEM_HAS_BEEN_UPDATED,
--         i.PRIMARY_ITEM_FLAG,
--         case value(i.COMMODITY_XREF, 0) 
--              when 0 then i.WAREHOUSE_CODE 
--              else i.COMMODITY_XREF 
--         end COMMODITY_XREF,
--         i.INVENTORY_STATUS_CD,
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.BILLING_STATUS_DATE --,
--         case 
--              when (i.BILLING_STATUS_BACKSCREEN = 'D' and i.BILLING_STATUS_DATE < current date - 30 days) then 'D' 
--              else 'A' 
--         end BILLING_STATUS_FILTER,
--         i.NA_TO_TAG AVAILABILITY_CODE,
--         i.NATAG_MAINT_DATE,
--         i.AVAILABILITY_DATE,
--         case 
--              when i.AVAILABILITY_DATE between (current date - (dayofweek(current date) - 1) days) and (current date + (7 - dayofweek(current date)) days) then 'THISWEEK' 
--              when i.AVAILABILITY_DATE between (current date - (dayofweek(current date) + 6) days) and (current date - dayofweek(current date) days) then 'LASTWEEK' 
--              else 'NULL' 
--         end AVAILABILITY_CATEGORY,
--         i.RE_AVAILABLE_DATE,
--         case value(i.SUPPLY_FLAG, ' ') 
--              when ' ' then 'N' 
--              else i.SUPPLY_FLAG 
--         end SUPPLY_FLAG,
--         case value(i.ITEM_RES33, ' ') 
--              when ' ' then 'N' 
--              else i.ITEM_RES33 
--         end PRESELL_FLG,
--         case dx.PLATFORM_TYPE 
--              when 'SWAT' then case value(i.ENTERPRISE_KEY, '  ') 
--                                    when '01' then 'N' 
--                                    when '  ' then 'N' 
--                                    else 'Y' 
--                               end 
--              else 'N' 
--         end ITEM_XDOCK_FLG,
--         i.ITEM_TYPE_CD SEASONAL_ITEM_CD,
--         i.WHSE_TIE,
--         i.WHSE_TIER,
--         i.RAND_WGT_CD,
--         i.SHIPPING_CASE_CUBE,
--         i.SHIPPING_CASE_WEIGHT,
--         case value(i.SHIP_UNIT_CD, '  ') 
--              when '  ' then 'CS' 
--              else i.SHIP_UNIT_CD 
--         end SHIP_UNIT_CD,
--         i.SHIP_CASE_CNT,
--         case value(i.PRINT_SHELF_LBL_FLAG, ' ') 
--              when ' ' then 'N' 
--              else 'Y' 
--         end PRINT_SHELF_LBL_FLAG,
--         i.INVENTORY_TOTAL,
--         i.RESERVE_COMMITTED,
--         i.RESERVE_UNCOMMITTED,
--         i.LAST_COST,
--         vwicsg.LANDED_COST_AMT,
--         vwicsg.LANDED_EFF_DATE,
--         vwicsg.LANDED_EXP_DATE,
--         i.BULLETIN_RES,
--         case 
--              when vwicsg.PALLET_QTY is null then 0 
--              else vwicsg.PALLET_QTY 
--         end PALLET_QTY,
--         'N' PALLET_DISC_FLG,
--         fc.ITEM_SUBCLASS_KEY,
--         fc.ITEM_SUBCLASS_ID,
--         fc.ITEM_SUBCLASS_DESC,
--         fc.ITEM_CLASS_KEY,
--         fc.ITEM_CLASS_ID,
--         fc.ITEM_CLASS_DESC,
--         fc.ITEM_SUBCAT_KEY,
--         fc.ITEM_SUBCAT_ID,
--         fc.ITEM_SUBCAT_NAME,
--         fc.ITEM_CATEGORY_KEY,
--         fc.ITEM_CATEGORY_ID,
--         fc.ITEM_CATEGORY_NAME,
--         trim(case when trim(i.ROOT_DESC) = '' then i.ITEM_DESCRIP else i.ROOT_DESC end) ROOT_DESC,
--         i.ROOT_ITEM_NBR,
--         i.LV_ITEM_NBR,
--         i.LV_DESC,
--         case 
--              when i.FULFILL_FACILITYID is null then '000' 
--              else lpad(i.FULFILL_FACILITYID, 3, '0') 
--         end as FACILITYID_FULFILL,
--         i.FULFILL_ITEM_NBR_HS as ITEM_NBR_HS_TO,
--         case 
--              when i.FULFILL_DC_AREA_ID is null then 0 
--              else i.FULFILL_DC_AREA_ID 
--         end as DC_AREA_FULFILL,
--         dx.HANDHELD_STATUS_CD,
--         dx.INSITE_STATUS_CD,
--         case i.FACILITYID 
--              when '001' then right(i.MERCH_DEPT, 3) 
--              else i.ITEM_DEPT_OVERRIDE 
--         end as RTL_PRICE_DEPT,
--         case i.FACILITYID 
--              when '001' then i.MERCH_DEPT_DESC 
--              else wd.DEPT_DESCRIPTION 
--         end as RTL_PRICE_DEPT_DESC,
--         case i.INSITE_FLG 
--              when 'Y' then 'Y' 
--              else 'N' 
--         end as INSITE_DISPLAY_FLG,
--         case i.ITEM_DEPT_OVERRIDE 
--              when '016' then 'Y' 
--              when '017' then 'Y' 
--              else 'N' 
--         end as SPECIALTY_ITEM_FLG,
--         i.SSRP_UNIT,
--         i.SSRP_AMNT,
--         i.LIST_COST,
--		 case when (i.FACILITYID = '001' and i.ITEM_NBR_HS in ('0340000', '0370007', '0390005', '0600007', '0480004', '0490003', '0434340')) then 'Y' else 
--         case 
--              when i.INSITE_FLG = 'Y' then 'N' 
--              else case 
--                        when i.BILLING_STATUS_BACKSCREEN not In ('A', 'D', 'W', 'P') then 'N' 
--                        else case 
--                                  when i.BILLING_STATUS not In ('A', 'D', 'V', 'N', 'I') then 'N' 
--                                  else case 
--                                            when case 
--                                                      when (i.BILLING_STATUS_BACKSCREEN = 'D' and i.BILLING_STATUS_DATE < current date - 30 days) then 'D' 
--                                                      else 'A' 
--                                                 end in ('D') then 'N' 
--                                            else 'Y' 
--                                       end 
--                             end 
--                   end 
--         end 
--		 end as ELIGIBILITY_RULES_FLG,
--         i.FIRST_RECEIVED_DATE
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.V_WEB_FACILITY dx on i.FACILITYID = dx.FACILITYID 
         inner join CRMADMIN.T_WHSE_DEPT wd on i.ITEM_DEPT_OVERRIDE = wd.DEPT_CODE 
         left outer join CRMADMIN.V_WEB_ITEM_FAMILY_CLASS fc on i.FACILITYID = fc.FACILITYID and i.FAMILY_CLASS = fc.ITEM_SUBCLASS_ID 
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS
         left outer join CRMADMIN.T_WHSE_PROD_SUBGROUP psg on i.PRODUCT_SUB_GROUP = psg.PROD_SUBGROUP and i.FACILITYID = psg.FACILITY
         left outer join CRMADMIN.T_WHSE_PROD_GROUP pg on i.PRODUCT_GROUP = pg.PROD_GROUP and i.FACILITYID = pg.FACILITY
         left outer join CRMADMIN.T_WHSE_DEPT d on i.ITEM_DEPT = d.DEPT_CODE
         left outer join ETLADMIN.T_TEMP_SET_CODE sc on i.FACILITYID = sc.FACILITY_ID and i.SET_CD = sc.SET_CD
         left outer join CRMADMIN.T_WHSE_CATALOG_HEADING ch on i.FACILITYID = ch.FACILITYID and i.CAT_HDG = ch.CATLG_HDNG
         left outer join CRMADMIN.T_WHSE_RETAIL_DEPT rd on i.FACILITYID = rd.FACILITYID and i.RETAIL_DEPT = rd.RETAIL_DEPT
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
AND      i.purch_status not in ('Z')
AND      i.BILLING_STATUS_BACKSCREEN not in ('D', 'Z')
AND      i.MERCH_DEPT is not null
and i.FACILITYID = '058'
order by i.UPC_UNIT, i.PACK_CASE
;


Table
T_WHSE_PROD_GROUP
