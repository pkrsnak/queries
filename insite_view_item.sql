----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_ITEM_FAMILY_CLASS
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_ITEM_FAMILY_CLASS
as  
SELECT   scls.FACILITYID,
         scls.ITEM_SUBCLASS_KEY,
         scls.ITEM_SUBCLASS_ID,
         scls.ITEM_SUBCLASS_DESC,
         scls.ITEM_CLASS_KEY,
         cls.ITEM_CLASS_ID,
         cls.ITEM_CLASS_DESC,
         scls.ITEM_SUBCAT_KEY,
         scat.ITEM_SUBCAT_ID,
         scat.ITEM_SUBCAT_NAME,
         scls.ITEM_CATEGORY_KEY,
         cat.ITEM_CATEGORY_ID,
         cat.ITEM_CATEGORY_NAME
FROM     ETLADMIN.T_STAGE_ITEM_SUBCLASS scls 
         inner join ETLADMIN.T_STAGE_ITEM_CLASS cls on scls.FACILITYID = cls.FACILITYID and scls.ITEM_CLASS_KEY = cls.ITEM_CLASS_KEY 
         inner join ETLADMIN.T_STAGE_ITEM_SUBCATEGORY scat on cls.FACILITYID = scat.FACILITYID and cls.ITEM_SUBCAT_KEY = scat.ITEM_SUBCAT_KEY 
         inner join ETLADMIN.T_STAGE_ITEM_CATEGORY cat on scat.FACILITYID = cat.FACILITYID and scat.ITEM_CATEGORY_KEY = cat.ITEM_CATEGORY_KEY
;

grant select on CRMADMIN.V_WEB_ITEM_FAMILY_CLASS to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ITEM_FAMILY_CLASS to user ETL;
grant select on CRMADMIN.V_WEB_ITEM_FAMILY_CLASS to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ITEM_FAMILY_CLASS to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ITEM_FAMILY_CLASS to user WEB;


----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_ITEM_CORE
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_ITEM_CORE
as
SELECT   i.FACILITYID,
         '0' || trim(i.STOCK_FAC) as STOCKING_FACILITY,
         i.ITEM_NBR_HS,
         i.UPC_UNIT,
         case 
              when i.UPC_UNIT between '00000000000003000' and '00000000000004999' then '' 
              else case 
                        when i.UPC_UNIT between '00000000000093000' and '00000000000094999' then '' 
                        else case 
                                  when i.UPC_UNIT between '00000040000000000' and '00000049999999999' then '' 
                                  else i.UPC_UNIT 
                             end 
                   end 
         end UPC,
         case 
              when i.UPC_UNIT between '00000000000003000' and '00000000000004999' then i.UPC_UNIT 
              else case 
                        when i.UPC_UNIT between '00000000000093000' and '00000000000094999' then i.UPC_UNIT 
                        else '' 
                   end 
         end PLU,
         case 
              when i.UPC_UNIT between '00000040000000000' and '00000049999999999' then i.UPC_UNIT 
              else '' 
         end PSEUDO,
         i.UPC_CASE,
         i.UPC_UNIT_CD,
         i.UPC_CASE_CD,
         i.BRAND,
         trim(i.ITEM_DESCRIP) as ITEM_DESC,
         trim(i.SHORT_DESCRIPTION) as SHORT_DESC,
         trim(i.RETAIL_ITEM_DESC) RETAIL_ITEM_DESC,
         trim(i.POS_16_DESC) POS_16_DESC,
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
         i.ITEM_DEPT_OVERRIDE as WHOLESALE_DEPT_OVERRIDE,
         i.RETAIL_DEPT,
         i.WAREHOUSE_CODE,
         i.AVERAGE_COST,
         i.PVT_LBL,
         case 
              when int(i.PRIVATE_LABEL_KEY) > 0 then 'Y' 
              else 'N' 
         end PRIVATE_LABEL_INDICATOR,
         i.PRIVATE_LABEL_KEY,
         i.ORDER_UNIT,
         i.ITEM_HAS_BEEN_UPDATED,
         i.PRIMARY_ITEM_FLAG,
         case value(i.COMMODITY_XREF, 0) 
              when 0 then i.WAREHOUSE_CODE / 10 
              else i.COMMODITY_XREF 
         end COMMODITY_XREF,
         i.INVENTORY_STATUS_CD,
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.BILLING_STATUS_DATE,
         case 
              when (i.BILLING_STATUS_BACKSCREEN = 'D' and i.BILLING_STATUS_DATE < current date - 30 days) then 'D' 
              else 'A' 
         end BILLING_STATUS_FILTER,
         i.NA_TO_TAG AVAILABILITY_CODE,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         case 
              when i.AVAILABILITY_DATE between (current date - (dayofweek(current date) - 1) days) and (current date + (7 - dayofweek(current date)) days) then 'THISWEEK' 
              when i.AVAILABILITY_DATE between (current date - (dayofweek(current date) + 6) days) and (current date - dayofweek(current date) days) then 'LASTWEEK' 
              else 'NULL' 
         end AVAILABILITY_CATEGORY,
         i.RE_AVAILABLE_DATE,
         case value(i.SUPPLY_FLAG, ' ') 
              when ' ' then 'N' 
              else i.SUPPLY_FLAG 
         end SUPPLY_FLAG,
         case value(i.ITEM_RES33, ' ') 
              when ' ' then 'N' 
              else i.ITEM_RES33 
         end PRESELL_FLG,
         case dx.PLATFORM_TYPE 
              when 'SWAT' then case value(i.ENTERPRISE_KEY, '  ') 
                                    when '01' then 'N' 
                                    when '  ' then 'N' 
                                    else 'Y' 
                               end 
              else 'N' 
         end ITEM_XDOCK_FLG,
         i.ITEM_TYPE_CD SEASONAL_ITEM_CD,
         i.WHSE_TIE,
         i.WHSE_TIER,
         i.RAND_WGT_CD,
         i.SHIPPING_CASE_CUBE,
         i.SHIPPING_CASE_WEIGHT,
         case value(i.SHIP_UNIT_CD, '  ') 
              when '  ' then 'CS' 
              else i.SHIP_UNIT_CD 
         end SHIP_UNIT_CD,
         i.SHIP_CASE_CNT,
         case value(i.PRINT_SHELF_LBL_FLAG, ' ') 
              when ' ' then 'N' 
              else 'Y' 
         end PRINT_SHELF_LBL_FLAG,
         i.INVENTORY_TOTAL,
         i.RESERVE_COMMITTED,
         i.RESERVE_UNCOMMITTED,
         i.LAST_COST,
         vwicsg.LANDED_COST_AMT,
         vwicsg.LANDED_EFF_DATE,
         vwicsg.LANDED_EXP_DATE,
         i.BULLETIN_RES,
         case 
              when vwicsg.PALLET_QTY is null then 0 
              else vwicsg.PALLET_QTY 
         end PALLET_QTY,
         'N' PALLET_DISC_FLG,
         fc.ITEM_SUBCLASS_KEY,
         fc.ITEM_SUBCLASS_ID,
         fc.ITEM_SUBCLASS_DESC,
         fc.ITEM_CLASS_KEY,
         fc.ITEM_CLASS_ID,
         fc.ITEM_CLASS_DESC,
         fc.ITEM_SUBCAT_KEY,
         fc.ITEM_SUBCAT_ID,
         fc.ITEM_SUBCAT_NAME,
         fc.ITEM_CATEGORY_KEY,
         fc.ITEM_CATEGORY_ID,
         fc.ITEM_CATEGORY_NAME,
         trim(case when trim(i.ROOT_DESC) = '' then i.ITEM_DESCRIP else i.ROOT_DESC end) ROOT_DESC,
         i.ROOT_ITEM_NBR,
         case 
              when i.FULFILL_FACILITYID is null then '000' 
              else lpad(i.FULFILL_FACILITYID, 3, '0') 
         end as FACILITYID_FULFILL,
         i.FULFILL_ITEM_NBR_HS as ITEM_NBR_HS_TO,
         case 
              when i.FULFILL_DC_AREA_ID is null then 0 
              else i.FULFILL_DC_AREA_ID 
         end as DC_AREA_FULFILL,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD,
         case i.FACILITYID 
              when '001' then right(i.MERCH_DEPT, 3) 
              else i.ITEM_DEPT_OVERRIDE 
         end as RTL_PRICE_DEPT,
         case i.FACILITYID 
              when '001' then i.MERCH_DEPT_DESC 
              else wd.DEPT_DESCRIPTION 
         end as RTL_PRICE_DEPT_DESC,
         case i.INSITE_FLG 
              when 'Y' then 'Y' 
              else 'N' 
         end as INSITE_DISPLAY_FLG,
         case i.ITEM_DEPT_OVERRIDE 
              when '016' then 'Y' 
              when '017' then 'Y' 
              else 'N' 
         end as SPECIALTY_ITEM_FLG,
         i.SSRP_UNIT,
         i.SSRP_AMNT,
         i.LIST_COST,
		 case when (i.FACILITYID = '001' and i.ITEM_NBR_HS in ('0340000', '0370007', '0390005', '0600007', '0480004', '0490003', '0434340')) then 'Y' else 
         case 
              when i.INSITE_FLG = 'Y' then 'N' 
              else case 
                        when i.BILLING_STATUS_BACKSCREEN not In ('A', 'D', 'W', 'P') then 'N' 
                        else case 
                                  when i.BILLING_STATUS not In ('A', 'D', 'V', 'N', 'I') then 'N' 
                                  else case 
                                            when case 
                                                      when (i.BILLING_STATUS_BACKSCREEN = 'D' and i.BILLING_STATUS_DATE < current date - 30 days) then 'D' 
                                                      else 'A' 
                                                 end in ('D') then 'N' 
                                            else 'Y' 
                                       end 
                             end 
                   end 
         end 
		 end as ELIGIBILITY_RULES_FLG
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.V_WEB_FACILITY dx on i.FACILITYID = dx.FACILITYID 
         inner join CRMADMIN.T_WHSE_DEPT wd on i.ITEM_DEPT_OVERRIDE = wd.DEPT_CODE 
         left outer join CRMADMIN.V_WEB_ITEM_FAMILY_CLASS fc on i.FACILITYID = fc.FACILITYID and i.FAMILY_CLASS = fc.ITEM_SUBCLASS_ID 
         left outer join CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR vwicsg on i.FACILITYID = vwicsg.FACILITYID and i.ITEM_NBR_HS = vwicsg.ITEM_NBR_HS
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
AND      i.purch_status not in ('Z')
AND      i.BILLING_STATUS not in ('Z')
AND      i.MERCH_DEPT is not null
;

grant select on CRMADMIN.V_WEB_ITEM_CORE to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ITEM_CORE to user ETL;
grant select on CRMADMIN.V_WEB_ITEM_CORE to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ITEM_CORE to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ITEM_CORE to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_ITEM_COMPONENT
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_ITEM_COMPONENT
as
SELECT   sc.FACILITYID,
         vwic.STOCKING_FACILITY,
         sc.COMP_ITEM_NBR_HS ITEM_NBR_HS,
         sc.COMP_UPC_UNIT UPC_UNIT,
         sc.COMP_UPC_CASE UPC_CASE,
         i.UPC_UNIT_CD,
         i.UPC_CASE_CD,
         sc.BRAND_DESC,
         vwic.BRAND,
         trim(sc.COMP_DESC) as ITEM_DESC,
         trim(i.SHORT_DESCRIPTION) as SHORT_DESC,
         trim(sc.RETAIL_ITEM_DESC) RETAIL_ITEM_DESC,
         trim(sc.POS_16_DESC) POS_16_DESC,
         sc.COMP_SIZE ITEM_SIZE,
         sc.COMP_UOM ITEM_SIZE_UOM,
         i.ITEM_SIZE_DESCRIP,
         sc.COMP_PK PACK_CASE,
         sc.RTL_UNIT RET_UNIT_SIZE,
         sc.RTL_UNIT_DESC RET_UNIT_DESC,
         sc.QTY_IN_SHIPPER RETAIL_PACK,
         vwic.VENDOR_NBR,
         vwic.BUYER_NBR,
         sc.DEPT_GRP MERCH_DEPT_GRP,
         trim(dptg.DEPT_GRP_CODE_DESC ) as MERCH_DEPT_GRP_DESC,
         sc.DEPT MERCH_DEPT,
         trim(dpt.DEPT_CODE_DESC ) as MERCH_DEPT_DESC,
         sc.MERCH_GRP MERCH_GRP,
         trim(grp.MDSE_GRP_CODE_DESC ) as MERCH_GRP_DESC,
         sc.MERCH_CAT MERCH_CAT,
         trim(cat.MDSE_CAT_CODE_DESC ) as MERCH_CAT_DESC,
         sc.MERCH_CLASS MERCH_CLASS,
         trim(cls.MDSE_CLS_CODE_DESC ) as MERCH_CLASS_DESC,
         vwic.WHOLESALE_DEPT,
         vwic.RETAIL_DEPT,
         vwic.WAREHOUSE_CODE,
         i.AVERAGE_COST,
         i.PVT_LBL,
         case 
              when int(i.PRIVATE_LABEL_KEY) > 0 then 'Y' 
              else 'N' 
         end PRIVATE_LABEL_INDICATOR,
         i.PRIVATE_LABEL_KEY,
         i.ORDER_UNIT,
         i.ITEM_HAS_BEEN_UPDATED,
         sc.PRIMARY_ITEM_FLAG,
         i.COMMODITY_XREF,
         i.INVENTORY_STATUS_CD,
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NA_TO_TAG AVAILABILITY_CODE,
         sc.AVAIL_DATE AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.SUPPLY_FLAG 
              when ' ' then 'N' 
              else i.SUPPLY_FLAG 
         end SUPPLY_FLAG,
         case i.ITEM_RES33 
              when ' ' then 'N' 
              else i.ITEM_RES33 
         end PRESELL_FLG,
         i.ENTERPRISE_KEY ITEM_XDOCK_FLG,
         i.ITEM_TYPE_CD SEASONAL_ITEM_FLG,
         i.WHSE_TIE,
         i.WHSE_TIER,
         i.RAND_WGT_CD,
         sc.SHIP_DESC,
         i.SHIPPING_CASE_CUBE,
         i.SHIPPING_CASE_WEIGHT,
         i.SHIP_UNIT_CD,
         i.SHIP_CASE_CNT,
         i.PRINT_SHELF_LBL_FLAG,
         sc.SHIP_ITEM_NBR_HS,
         vwic.RTL_PRICE_DEPT,
         vwic.BILLING_STATUS_FILTER,
         vwic.INSITE_DISPLAY_FLG,
         vwic.HANDHELD_STATUS_CD,
         vwic.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_SHIPPER_CMPNTS sc 
         inner join CRMADMIN.V_WEB_ITEM_CORE vwic on sc.FACILITYID = vwic.FACILITYID and sc.SHIP_ITEM_NBR_HS = vwic.ITEM_NBR_HS
         LEFT OUTER JOIN CRMADMIN.T_WHSE_ITEM i on sc.FACILITYID = i.FACILITYID and sc.COMP_ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join ETLADMIN.T_MDM_MDSE_CLS cls on sc.MERCH_CLASS = cls.MDSE_CLS_CODE and cls.ACTIVE_FLAG = 'Y'
         left outer join ETLADMIN.T_MDM_MDSE_CAT cat on sc.MERCH_CAT = cat.MDSE_CAT_CODE and cat.ACTIVE_FLAG = 'Y'
         left outer join ETLADMIN.T_MDM_MDSE_GRP grp on sc.MERCH_GRP = grp.MDSE_GRP_CODE and grp.ACTIVE_FLAG = 'Y'
         left outer join ETLADMIN.T_MDM_MDSE_DEPT dpt on sc.DEPT = dpt.DEPT_CODE and dpt.ACTIVE_FLAG = 'Y'
         left outer join ETLADMIN.T_MDM_MDSE_DEPT_GRP dptg on sc.DEPT_GRP = dptg.DEPT_GRP_CODE and dptg.ACTIVE_FLAG = 'Y'
WHERE    sc.SOURCE in ('MDM', 'GRMF')
and sc.DEPT is not null
;

grant select on CRMADMIN.V_WEB_ITEM_COMPONENT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ITEM_COMPONENT to user ETL;
grant select on CRMADMIN.V_WEB_ITEM_COMPONENT to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ITEM_COMPONENT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ITEM_COMPONENT to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR
as
SELECT   FACILITYID,
         ORD_ITEM_ID,
         COMMODITY,
         ORDER_CD,
         ITEM_NBR_HS,
         SHIP_UNIT_CD,
         PRESELL_FLG,
         DELIV_LIMIT_QTY,
         ABS_LIMIT_QTY,
         STATUS_CD,
         PRIVATE_BRAND_CD,
         ITEM_XDOC_FLG,
         MEAT_RDM_WGHT_FLG,
         SHIP_CASE_QTY,
         DO_NOT_PRINT_FLG,
         WHSE_ITEM_AVAIL_DT,
         SUPPLY_ITEM_FLG,
         ORDERABLE_ITEM_DSC,
         CUBE_MSR,
         CASE_UPC_CD,
         NEW_ITEM_AVAIL_DT,
         PALLET_QTY,
         WEIGHT_MSR, 
         LANDED_COST_AMT, 
         LANDED_EFF_DATE, 
         LANDED_EXP_DATE
FROM     ETLADMIN.T_STAGE_ITEM_GR
;

grant select on CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR to user ETL;
grant select on CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ITEM_CORE_SUPP_GR to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER_ITEM_COST
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_ITEM_COST
as
SELECT   case cic.REC_ACTIVE_FLG 
              when 'N' then 'D' 
              else 'C' 
         end REC_TYPE,
         cic.FACILITYID,
         cic.CUSTOMER_NBR_STND, 
         vwcf.BURDENED_COST_FLG,
         vwcf.CORP_SWAT,
         cic.UPC_UNIT,
         cic.ITEM_NBR_HS,
         cic.MASTER_ITEM_FLG,
         cic.RANDOM_WEIGHT_CD,
         cic.REC_START_DATE START_DATE,
         case cic.REC_END_DATE 
              when '2049-12-31' then null 
              else cic.REC_END_DATE 
         end END_DATE,
         cic.REC_END_DATE END_DATE_REAL,
         dec(round(cic.UNBURDENED_UNIT_SELL_NO_ALLOW_AMT, 2), 31, 2) UNBURDENED_COST_UNIT_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.UNBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 2), 31, 2) UNBURDENED_COST_CASE_AMT,
         dec(round(cic.FULLBURDENED_UNIT_SELL_NO_ALLOW_AMT, 2), 31, 2) BURDENED_COST_UNIT_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.FULLBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 2), 31, 2) BURDENED_COST_CASE_AMT,
         dec(cic.UNBURDENED_UNIT_SELL_NO_ALLOW_AMT, 31, 2) UNBURDENED_COST_UNIT_AMT_UR,
         dec(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.UNBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 31, 2) UNBURDENED_COST_CASE_AMT_UR,
         dec(cic.FULLBURDENED_UNIT_SELL_NO_ALLOW_AMT, 31, 2) BURDENED_COST_UNIT_AMT_UR,
         dec(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.FULLBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 31, 2) BURDENED_COST_CASE_AMT_UR,
         dec(round(cic.UNBURDENED_UNIT_SELL_NET_AMT, 2), 31, 2) UNBURDENED_COST_UNIT_NET_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.UNBURDENED_FINAL_SELL_NET_AMT)), 2), 31, 2) UNBURDENED_COST_CASE_NET_AMT,
         dec(round(cic.FULLBURDENED_UNIT_SELL_NET_AMT, 2), 31, 2) BURDENED_COST_UNIT_NET_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.FULLBURDENED_FINAL_SELL_NET_AMT)), 2), 31, 2) BURDENED_COST_CASE_NET_AMT,
         dec(cic.UNBURDENED_UNIT_SELL_NET_AMT, 31, 2) UNBURDENED_COST_UNIT_AMT_NET_UR,
         dec(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.UNBURDENED_FINAL_SELL_NET_AMT)), 31, 2) UNBURDENED_COST_CASE_AMT_NET_UR,
         dec(cic.FULLBURDENED_UNIT_SELL_NET_AMT, 31, 2) BURDENED_COST_UNIT_AMT_NET_UR,
         dec(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.FULLBURDENED_FINAL_SELL_NET_AMT)), 31, 2) BURDENED_COST_CASE_AMT_NET_UR,
         cic.OI_ALLOWANCE_START_DATE,
         cic.OI_ALLOWANCE_END_DATE,
         cic.OI_ALLOWANCE_AMT,
         cic.PA_ALLOWANCE_START_DATE, 
         cic.PA_ALLOWANCE_END_DATE,
         cic.PA_ALLOWANCE_AMT,
         cic.CREATE_TIME CREATE_TIMESTAMP,
         cic.PROCESS_TIMESTAMP,
         case 
              when current date between cic.REC_START_DATE and cic.REC_END_DATE then 'C' 
              when cic.REC_END_DATE < current date then 'P' 
              when cic.REC_START_DATE > current date then 'F' 
              else 'Z' 
         end STATUS_CD,
         cic.REC_TYPE_CD,
         case 
              when (not((vwcf.ALLOW_B4_AFTER = 'B' and vwcf.BURDENED_COST_FLG = 'Y')) and (cic.REC_TYPE_CD in ('007', '003'))) then 'N' 
              else 'Y' 
         end HANDHELD_ELIGIBLE_CD,
         vwcf.MEMBERSHIP_KEY,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_ITEM_COST cic 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on cic.FACILITYID = vwcf.FACILITYID and cic.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL
WHERE    cic.REC_ACTIVE_FLG = 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER_ITEM_COST_MAINT
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_ITEM_COST_MAINT
as
SELECT   case cic.REC_ACTIVE_FLG when 'N' then 'D' else 'C' end REC_TYPE,
         cic.FACILITYID,
         cic.CUSTOMER_NBR_STND,
         vwcf.CORP_SWAT,
         vwcf.BURDENED_COST_FLG,
         cic.UPC_UNIT,
         cic.ITEM_NBR_HS,
         cic.MASTER_ITEM_FLG,
         cic.RANDOM_WEIGHT_CD,
         cic.REC_START_DATE START_DATE,
         case cic.REC_END_DATE when '2049-12-31' then null else cic.REC_END_DATE end END_DATE,
         cic.REC_END_DATE END_DATE_REAL,
         dec(round(cic.UNBURDENED_UNIT_SELL_NO_ALLOW_AMT, 2), 31, 2) UNBURDENED_COST_UNIT_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.UNBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 2), 31, 2) UNBURDENED_COST_CASE_AMT,
         dec(round(cic.FULLBURDENED_UNIT_SELL_NO_ALLOW_AMT, 2), 31, 2) BURDENED_COST_UNIT_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.FULLBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 2), 31, 2) BURDENED_COST_CASE_AMT,
         dec(cic.UNBURDENED_UNIT_SELL_NO_ALLOW_AMT, 31, 2) UNBURDENED_COST_UNIT_AMT_UR,
         dec(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.UNBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 31, 2) UNBURDENED_COST_CASE_AMT_UR,
         dec(cic.FULLBURDENED_UNIT_SELL_NO_ALLOW_AMT, 31, 2) BURDENED_COST_UNIT_AMT_UR,
         dec(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.FULLBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 31, 2) BURDENED_COST_CASE_AMT_UR,
         dec(round(cic.UNBURDENED_UNIT_SELL_NET_AMT, 2), 31, 2) UNBURDENED_COST_UNIT_NET_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.UNBURDENED_FINAL_SELL_NET_AMT)), 2), 31, 2) UNBURDENED_COST_CASE_NET_AMT,
         dec(round(cic.FULLBURDENED_UNIT_SELL_NET_AMT, 2), 31, 2) BURDENED_COST_UNIT_NET_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.FULLBURDENED_FINAL_SELL_NET_AMT)), 2), 31, 2) BURDENED_COST_CASE_NET_AMT,
         dec(cic.UNBURDENED_UNIT_SELL_NET_AMT, 31, 2) UNBURDENED_COST_UNIT_AMT_NET_UR,
         dec(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.UNBURDENED_FINAL_SELL_NET_AMT)), 31, 2) UNBURDENED_COST_CASE_AMT_NET_UR,
         dec(cic.FULLBURDENED_UNIT_SELL_NET_AMT, 31, 2) BURDENED_COST_UNIT_AMT_NET_UR,
         dec(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.FULLBURDENED_FINAL_SELL_NET_AMT)), 31, 2) BURDENED_COST_CASE_AMT_NET_UR,
         cic.OI_ALLOWANCE_START_DATE,
         cic.OI_ALLOWANCE_END_DATE,
         cic.OI_ALLOWANCE_AMT,
         cic.PA_ALLOWANCE_START_DATE, 
         cic.PA_ALLOWANCE_END_DATE,
         cic.PA_ALLOWANCE_AMT,
         cic.CREATE_TIME CREATE_TIMESTAMP,
         cic.PROCESS_TIMESTAMP,
         case 
              when current date between cic.REC_START_DATE and cic.REC_END_DATE then 'C' 
              when cic.REC_END_DATE < current date then 'P' 
              when cic.REC_START_DATE > current date then 'F' 
              else 'Z' 
         end STATUS_CD,
         cic.REC_TYPE_CD, 
         case when (not((vwcf.ALLOW_B4_AFTER = 'B' and vwcf.BURDENED_COST_FLG = 'Y')) and (cic.REC_TYPE_CD in ('007', '003'))) then 'N' else 'Y' end HANDHELD_ELIGIBLE_CD,
         vwcf.MEMBERSHIP_KEY,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_ITEM_COST cic 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on cic.FACILITYID = vwcf.FACILITYID and cic.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL
WHERE    cic.CREATE_DATE >= current date - 1 days --cic.REC_ACTIVE_FLG = 'Y'
AND      cic.REC_ACTIVE_FLG = 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST_MAINT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST_MAINT to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST_MAINT to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST_MAINT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_COST_MAINT to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP_HDR
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP_HDR
as  
SELECT   ipg.FACILITYID,
         ipg.CUSTOMER_GRP_CLASS,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     crmadmin.V_WEB_CUSTOMER_ITEM_PROMO_GRP ipg 
         inner join CRMADMIN.V_WEB_FACILITY dx on ipg.FACILITYID = dx.FACILITYID
GROUP BY ipg.FACILITYID, ipg.CUSTOMER_GRP_CLASS, dx.HANDHELD_STATUS_CD, 
         dx.INSITE_STATUS_CD
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP_HDR to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP_HDR to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP_HDR to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP_HDR to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP_HDR to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP  
as  
SELECT   grp.FACILITYID,
         grp.CUSTOMER_NBR_STND,
         grp.CUSTOMER_GRP_CLASS, 
         vwcf.ALLOWANCE_CODE,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_GRP grp
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on grp.FACILITYID = vwcf.FACILITYID and grp.CUSTOMER_NBR_STND = vwcf.CUSTOMER_NBR_STND 
WHERE    grp.CUSTOMER_GRP_TYPE = '2'
AND      grp.STATUS = 'A'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_GRP to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO
as
SELECT   allow.FACILITYID,
--         allow.REF_HS DEAL_ID,
         case allow.ALLOW_TYPE when 'RPA' then varchar(int(allow.REF_HS) + 9000000) else allow.REF_HS end DEAL_ID,
--         case allow.ALLOW_TYPE when 'RPA' then '-' || trim(allow.REF_HS) else allow.REF_HS end DEAL_ID,
         allow.ALLOW_CUST_GRP CUSTOMER_GRP_CLASS,
         allow.ITEM_NBR_HS,
         allow.UPC_UNIT,
         allow.MASTER_ITEM_FLG,
         allow.ALLOW_DATE_EFF,
         allow.ALLOW_DATE_EXP,
         allow.ALLOW_AMT,
         case allow.ALLOW_TYPE 
              when 'PA' then 1 
              when 'RPA' then 1 
              else 0 
         end MIN_REQ,
         case allow.ALLOW_TYPE when 'RPA' then 'PA' else allow.ALLOW_TYPE end ALLOW_TYPE,
         case 
              when (current date between allow.ALLOW_DATE_EFF and allow.ALLOW_DATE_EXP) and allow.ALLOW_DATE_EXP  < (current date + (7 - dayofweek(current date)) days + 3 days) then 'LASTCHANCE' 
              when (current date between allow.ALLOW_DATE_EFF and allow.ALLOW_DATE_EXP) and allow.ALLOW_DATE_EXP  >= (current date + (7 - dayofweek(current date)) days + 3 days) then 'CURRENT' 
              when (allow.ALLOW_DATE_EFF > current date) then 'FUTURE' 
              when (allow.ALLOW_DATE_EXP < current date) then 'PAST' 
              else 'UNKNOWN' 
         end DEAL_CATEGORY,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_ALLOWANCES allow 
         inner join CRMADMIN.V_WEB_FACILITY dx on allow.FACILITYID = dx.FACILITYID
WHERE    allow.STATUS = 'A'
AND      dx.PROCESS_ACTIVE_FLAG = 'Y'
--AND      ALLOW_TYPE not in ('VENDRPA', 'RPA')
AND      allow.ALLOW_TYPE not in ('VENDRPA')
AND      allow.ALLOW_AMT <> 0
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_ALL
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_ALL
as
SELECT   allow.FACILITYID,
         allow.REF_HS DEAL_ID,
--         case allow.ALLOW_TYPE when 'RPA' then char(int(allow.REF_HS) + 9000000) else allow.REF_HS end DEAL_ID,
--         case allow.ALLOW_TYPE when 'RPA' then '-' || trim(allow.REF_HS) else allow.REF_HS end DEAL_ID,
         allow.ALLOW_CUST_GRP CUSTOMER_GRP_CLASS,
         allow.ITEM_NBR_HS,
         allow.UPC_UNIT,
         allow.MASTER_ITEM_FLG,
         allow.ALLOW_DATE_EFF,
         allow.ALLOW_DATE_EXP,
         allow.ALLOW_AMT,
         case allow.ALLOW_TYPE 
              when 'PA' then 1 
              when 'RPA' then 1 
              else 0 
         end MIN_REQ,
         case allow.ALLOW_TYPE when 'RPA' then 'PA' else allow.ALLOW_TYPE end ALLOW_TYPE,
         case 
              when (current date between allow.ALLOW_DATE_EFF and allow.ALLOW_DATE_EXP) and allow.ALLOW_DATE_EXP  < (current date + (7 - dayofweek(current date)) days + 3 days) then 'LASTCHANCE' 
              when (current date between allow.ALLOW_DATE_EFF and allow.ALLOW_DATE_EXP) and allow.ALLOW_DATE_EXP  >= (current date + (7 - dayofweek(current date)) days + 3 days) then 'CURRENT' 
              when (allow.ALLOW_DATE_EFF > current date) then 'FUTURE' 
              when (allow.ALLOW_DATE_EXP < current date) then 'PAST' 
              else 'UNKNOWN' 
         end DEAL_CATEGORY,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_ALLOWANCES allow 
         inner join CRMADMIN.V_WEB_FACILITY dx on allow.FACILITYID = dx.FACILITYID
WHERE    allow.STATUS = 'A'
AND      dx.PROCESS_ACTIVE_FLAG = 'Y'
--AND      ALLOW_TYPE not in ('VENDRPA', 'RPA')
AND      allow.ALLOW_TYPE not in ('VENDRPA')
AND      allow.ALLOW_AMT <> 0
--and allow.FACILITYID = '015'
--and allow.ALLOW_CUST_GRP = 3
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_ALL to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_ALL to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_ALL to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_ALL to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_PROMO_ALL to user WEB;


----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_GRP
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_GRP  
as  
SELECT   grp.FACILITYID,
         grp.CUSTOMER_NBR_STND,
         grp.CUSTOMER_GRP_CLASS,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_GRP grp
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on grp.FACILITYID = vwcf.FACILITYID and grp.CUSTOMER_NBR_STND = vwcf.CUSTOMER_NBR_STND 
WHERE    grp.CUSTOMER_GRP_TYPE = '4'
AND      grp.STATUS = 'A'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_GRP to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_GRP to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_GRP to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_GRP to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_GRP to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_ZONE
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_ZONE
as  
SELECT   cd.FACILITYID,
         vwcf.CUSTOMER_NBR_STND,
         cd.DEPT_CODE as RTL_PRICE_DEPT,
         vrpd.RTL_PRICE_DEPT_DESC,
         cd.HOME_SRP_ZONE_HS as HOME_SRP_ZONE,
         varchar(cd.PRIVATE_SRP_ZONE) as PRIVATE_SRP_ZONE,
         int(case 
              when wcrcp.RCP_GROUP is null then 0 
              else wcrcp.RCP_GROUP 
         end) RCP_GROUP_NBR,
         vwcf.MEMBERSHIP_KEY, 
         cd.PVT_RTL_ZN_RESTRICT,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_DEPT cd 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on cd.FACILITYID = vwcf.FACILITYID and cd.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL 
         inner join CRMADMIN.V_WEB_FACILITY_RTL_PRICE_DEPT vrpd on cd.FACILITYID = vrpd.FACILITYID and cd.DEPT_CODE = vrpd.RTL_PRICE_DEPT 
         left outer join ETLADMIN.T_WHSE_CUST_RCP wcrcp on cd.FACILITYID = wcrcp.FACILITYID and cd.CUSTOMER_NO_FULL = wcrcp.CUSTOMER_NO_FULL and cd.DEPT_CODE = wcrcp.DEPT_CODE and wcrcp.ACTIVE_FLG = 'Y'
WHERE    cd.STATUS = 'A'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_ZONE to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_ZONE to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_ZONE to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_ZONE to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_ZONE to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_PRICE
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_PRICE
as  
SELECT   rp.FACILITYID,
         rp.CUST_GROUP_NBR,
         rp.DEPT_CODE as RTL_PRICE_DEPT,
         rp.CUST_OVERRIDE_RETAIL_DEPT,
         rp.UPC_UNIT,
         case rp.SHIP_ITEM_NBR_HS 
              when '0000000' then rp.ITEM_NBR_HS 
              else rp.SHIP_ITEM_NBR_HS 
         end ITEM_NBR_HS,
         rp.START_DATE,
         rp.END_DATE,
         rp.RETAIL_UNITS_PER_SRP,
         rp.SRP,
         rp.DESIRED_GP_PERCENT,
         case 
              when (rp.END_DATE between current date - 60 day and current date - 1 day) Then 'P' 
              when rp.START_DATE = current date then 'C'
              Else rp.SRP_TYPE_CD 
         end as SRP_TYPE_CD,
         rp.ACTIVE_FLG,
         rp.CREATE_TIMESTAMP,
         rp.UPDATE_TIMESTAMP,
         rp.ZONE_TYPE_CD,
         rp.MASTER_ITEM_FLG,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_ITEM_RTL_PRICE rp 
         inner join CRMADMIN.V_WEB_FACILITY dx on rp.FACILITYID = dx.FACILITYID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
AND      rp.ACTIVE_FLG = 'Y'
AND      ((current date between rp.START_DATE and (case when rp.END_DATE is null then '2049-12-31' else rp.END_DATE end))
     OR  rp.START_DATE >= current date
     OR  rp.END_DATE >= current date - 60 days)
AND      rp.START_DATE is not null
;


grant select on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_PRICE to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_PRICE to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_PRICE to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_PRICE to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_PRICE to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_ITEM_BUYER_NOTES
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_ITEM_BUYER_NOTES
as
SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.NOTE_TYPE_CD,
         i.NOTE_EFF_DATE,
         i.NOTE_EXP_DATE,
         i.BUYER_NOTE_TXT,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.V_WEB_FACILITY dx on i.FACILITYID = dx.FACILITYID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
AND      i.purch_status not in ('Z')
AND      i.BILLING_STATUS not in ('Z')
AND      i.NOTE_EXP_DATE > current date
;

grant select on CRMADMIN.V_WEB_ITEM_BUYER_NOTES to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ITEM_BUYER_NOTES to user ETL;
grant select on CRMADMIN.V_WEB_ITEM_BUYER_NOTES to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ITEM_BUYER_NOTES to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ITEM_BUYER_NOTES to user WEB;


----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_ITEM_RETAIL
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_ITEM_RETAIL
as
SELECT   a.UPC_UNIT,
         a.BRAND,
         a.ROOT_DESC,
         a.ITEM_SIZE,
         a.ITEM_SIZE_UOM,
         a.MERCH_DEPT
FROM   table 
(SELECT   ROW_NUMBER() OVER (partition by x.UPC_UNIT order by x.ROOT_DESC desc, x.UPC_UNIT, x.PURCH_STAT_SORT, x.BILL_STAT_SORT, x.BRAND, x.ITEM_SIZE, x.ITEM_SIZE_UOM, x.MERCH_DEPT) rownumber,
         x.UPC_UNIT,
         x.BRAND,
         x.ROOT_DESC,
         x.ITEM_SIZE,
         x.ITEM_SIZE_UOM,
         x.MERCH_DEPT,
         x.PURCH_STAT_SORT,
         x.BILL_STAT_SORT
from table (
select   b.UPC_UNIT,
         b.BRAND,
         case when trim(b.ROOT_DESC) = '' then b.ITEM_DESC else b.ROOT_DESC end ROOT_DESC,
         b.ITEM_SIZE,
         b.ITEM_SIZE_UOM,
         b.MERCH_DEPT,
         case b.PURCH_STATUS when 'A' then 1 when 'S' then 2 when 'X' then 3 when 'D' then 4 else 5 end PURCH_STAT_SORT,
         case b.BILLING_STATUS when 'A' then 1 when 'I' then 2 when 'N' then 3 when 'V' then 4 when 'D' then 5 else 6 end BILL_STAT_SORT
FROM     crmadmin.V_WEB_ITEM_CORE b
union all
select   c.UPC_UNIT,
         c.BRAND,
         c.ITEM_DESC,
         c.ITEM_SIZE,
         c.ITEM_SIZE_UOM,
         c.MERCH_DEPT,
         case c.PURCH_STATUS when 'A' then 1 when 'S' then 2 when 'X' then 3 when 'D' then 4 else 5 end PURCH_STAT_SORT,
         case c.BILLING_STATUS when 'A' then 1 when 'I' then 2 when 'N' then 3 when 'V' then 4 when 'D' then 5 else 6 end BILL_STAT_SORT
FROM     crmadmin.V_WEB_ITEM_COMPONENT c) x) a
where rownumber = 1

/*
SELECT   Distinct i.UPC_UNIT,
         i.BRAND,
         i.ROOT_DESC,
         i.ROOT_ITEM_NBR,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.MERCH_DEPT
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
AND      i.ROOT_ITEM_NBR is not null
AND      not(i.MERCH_DEPT = '0000')
AND      i.purch_status not in ('Z')
AND      i.BILLING_STATUS not in ('D', 'Z')
AND      i.PRIMARY_ITEM_FLAG = 'Y'
*/
;

grant select on CRMADMIN.V_WEB_ITEM_RETAIL to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ITEM_RETAIL to user ETL;
grant select on CRMADMIN.V_WEB_ITEM_RETAIL to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ITEM_RETAIL to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ITEM_RETAIL to user WEB;


----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE  
as
SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.UPC_UNIT,
         i.PACK_CASE,
         'Y' MASTER_FLAG,
         i.PRIMARY_ITEM_FLAG,
         case ur.ACTIVE_FLG when 'Y' then 'Y' else 'N' end RECLAIM_FLG,
         case ur.FULL_CASE_FLG when 'Y' then 'Y' else 'N' end RECLAIM_FULL_CASE_FLG,
         i.HANDHELD_STATUS_CD,
         i.INSITE_STATUS_CD
FROM     CRMADMIN.V_WEB_ITEM_CORE i 
         left outer join CRMADMIN.T_WHSE_UPC_RECLAM ur on i.UPC_UNIT = ur.UPC_UNIT and i.FACILITYID = ur.FACILITYID
union all
SELECT   ic.FACILITYID,
         ic.SHIP_ITEM_NBR_HS,
         ic.UPC_UNIT,
         max(ic.RETAIL_PACK) RETAIL_PACK,  --REMOVE------------------------
         'N' MASTER_FLAG,
         min(case ic.PRIMARY_ITEM_FLAG when 'Y' then 'Y' else 'N' end) PRIMARY_ITEM_FLAG,  --REMOVE------------------------
         case ur.ACTIVE_FLG when 'Y' then 'Y' else 'N' end RECLAIM_FLG,
         case ur.FULL_CASE_FLG when 'Y' then 'Y' else 'N' end RECLAIM_FULL_CASE_FLG,
         ic.HANDHELD_STATUS_CD,
         ic.INSITE_STATUS_CD
FROM     CRMADMIN.V_WEB_ITEM_COMPONENT ic 
         left outer join CRMADMIN.T_WHSE_UPC_RECLAM ur on ic.UPC_UNIT = ur.UPC_UNIT and ic.FACILITYID = ur.FACILITYID
where (ic.FACILITYID, ic.SHIP_ITEM_NBR_HS, ic.UPC_UNIT) not in (select FACILITYID, ITEM_NBR_HS, UPC_UNIT from CRMADMIN.T_WHSE_ITEM)
group by ic.FACILITYID,  --REMOVE------------------------
         ic.SHIP_ITEM_NBR_HS,
         ic.UPC_UNIT,
         'N',
         case ur.ACTIVE_FLG when 'Y' then 'Y' else 'N' end,
         case ur.FULL_CASE_FLG when 'Y' then 'Y' else 'N' end,
         ic.HANDHELD_STATUS_CD,
         ic.INSITE_STATUS_CD
;


grant select on CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE to user ETL;
grant select on CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE to user WEB;


----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.CRMADMIN.V_WEB_ORDERS_DELIVSCHED  
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW   CRMADMIN.V_WEB_ORDERS_DELIVSCHED  
AS  
SELECT   sldc.FACILITYID,
         sldc.CUSTOMER_NBR_STND,
         sldc.SCHED_LIKE_DC_AREA_ID, 
         vwcf.MEMBERSHIP_KEY,
         timestamp(da.DUE_IN_DATE, time(trim(da.DUE_IN_TIME)))- current timezone DUE_IN_TIMESTAMP_UTC,
         timestamp(da.DUE_IN_DATE, time(trim(da.DUE_IN_TIME))) DUE_IN_TIMESTAMP,
         date(timestamp(da.DUE_IN_DATE, time(trim(da.DUE_IN_TIME)))- current timezone) DUE_IN_DATE,
         time(timestamp(da.DUE_IN_DATE, time(trim(da.DUE_IN_TIME)))- current timezone) DUE_IN_TIME,
         da.DELIVERY_DATE,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     (SELECT   Distinct FACILITYID,
                   CUSTOMER_NBR_STND,
                   SCHED_LIKE_DC_AREA_ID
          FROM     CRMADMIN.T_WHSE_ORDER_DELIVSCHED) sldc 
         LEFT OUTER JOIN (SELECT DISTINCT FACILITYID, CUSTOMER_NBR_STND, DC_AREA_ID, DELIVERY_DATE, DUE_IN_DATE, DUE_IN_TIME FROM CRMADMIN.T_WHSE_ORDER_DELIVSCHED) da ON (sldc.SCHED_LIKE_DC_AREA_ID = da.DC_AREA_ID AND sldc.FACILITYID = da.FACILITYID AND sldc.CUSTOMER_NBR_STND = da.CUSTOMER_NBR_STND) 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on sldc.FACILITYID = vwcf.FACILITYID and sldc.CUSTOMER_NBR_STND = vwcf.CUSTOMER_NBR_STND
;

grant select on CRMADMIN.V_WEB_ORDERS_DELIVSCHED to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ORDERS_DELIVSCHED to user ETL;
grant select on CRMADMIN.V_WEB_ORDERS_DELIVSCHED to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ORDERS_DELIVSCHED to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ORDERS_DELIVSCHED to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.CRMADMIN.V_WEB_ORDERS_PENDING  
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW   CRMADMIN.V_WEB_ORDERS_PENDING   
AS    
SELECT   od.FACILITYID_REQUESTED,
         od.CUSTOMER_NBR_STND,
         od.SHIP_DATE DELIV_SCHED_DATE,
         od.ITEM_NBR_HS_REQUESTED,
         cf.MEMBERSHIP_KEY,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD,
         SUM(od.NET_QTY) NET_QTY
FROM     CRMADMIN.T_WHSE_ORDER_DTL od 
         inner join CRMADMIN.V_WEB_FACILITY dx on od.FACILITYID = dx.FACILITYID 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC cf on od.FACILITYID_REQUESTED = cf.FACILITYID and od.CUSTOMER_NO_FULL = cf.CUSTOMER_NO_FULL
         inner join CRMADMIN.V_WEB_ITEM_CORE ic on od.FACILITYID_REQUESTED = ic.FACILITYID and od.ITEM_NBR_HS_REQUESTED = ic.ITEM_NBR_HS 
WHERE    dx.ACTIVE_FLAG = 'Y'
AND      od.SHIP_DATE > TRUNC(SYSDATE)
AND      od.DELIV_REQUESTED_DATE >= TRUNC(SYSDATE)
AND      od.ORDER_STATUS_HS = 'Firm'
AND      od.ORDER_TYPE NOT IN ('NO')
AND      od.OMS_SERVER_TYPE <> 'SHARP'
AND      od.NET_QTY <> 0
GROUP BY od.FACILITYID_REQUESTED, od.CUSTOMER_NBR_STND, od.SHIP_DATE, 
         od.ITEM_NBR_HS_REQUESTED, cf.MEMBERSHIP_KEY,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
;

grant select on CRMADMIN.V_WEB_ORDERS_PENDING to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ORDERS_PENDING to user ETL;
grant select on CRMADMIN.V_WEB_ORDERS_PENDING to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ORDERS_PENDING to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ORDERS_PENDING to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH  
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW   CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH   
AS    
SELECT   ia.FACILITYID,
         ia.CUSTOMER_NBR_STND,
         ia.ITEM_NBR_HS,
         ia.ITEM_AUTH_CD,
         ia.ITEM_STATUS_CD,
         ia.ITEM_ACTIVE_FLG,
         ia.RESTRCT_PVT_RTL_CD,
         ia.EFF_DATE,
         ia.EXP_DATE,
         ia.PROCESS_TIMESTAMP,
         vwcf.ITEM_AUTH_METHOD_CD,
         vwcf.MEMBERSHIP_KEY,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_ITEM_AUTH ia 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on ia.FACILITYID = vwcf.FACILITYID and ia.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL
WHERE    vwcf.ITEM_AUTH_METHOD_CD = 'E'
AND      ia.ITEM_ACTIVE_FLG = 'Y'
AND      ia.ITEM_AUTH_CD <> 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
AND      (ia.EXP_DATE is null
     OR  ia.EXP_DATE > current date)
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.CRMADMIN.V_WEB_ITEM_RECALL_NOTICE  
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW   CRMADMIN.V_WEB_ITEM_RECALL_NOTICE   
AS    
SELECT   distinct irn.FACILITYID,
         irn.RECALL_NBR,
         irn.UPC_UNIT,
         irn.START_DATE,
         irn.END_DATE,
         irn.ABSTRACT_TXT,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_ITEM_RECALL_NOTICE irn 
         inner join CRMADMIN.V_WEB_FACILITY dx on irn.FACILITYID = dx.FACILITYID 
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
AND      irn.ACTIVE_FLG = 'Y'
;

grant select on CRMADMIN.V_WEB_ITEM_RECALL_NOTICE to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ITEM_RECALL_NOTICE to user ETL;
grant select on CRMADMIN.V_WEB_ITEM_RECALL_NOTICE to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ITEM_RECALL_NOTICE to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ITEM_RECALL_NOTICE to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.CRMADMIN.V_WEB_ITEM_NO_ORDER  
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW   CRMADMIN.V_WEB_ITEM_NO_ORDER
AS  
SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
--         i.PURCH_STATUS,
--         i.BILLING_STATUS_BACKSCREEN,
--         i.BILLING_STATUS,
--         i.ITEM_DEPT, 
         i.COMMODITY_XREF, 
         int(i.COMMODITY_XREF) * 100 as DC_AREA_ID,
         mia.ATTRIB_CDE as NO_ORDER_CODE_FLG
--         mia.ROOT_ITEM_NBR,
--         mia.ROOT_TYPE_CDE,
--         mia.ROOT_CATEGORY,
--         mia.ROOT_STATUS
FROM     CRMADMIN.T_WHSE_ITEM i
         left outer join CRMADMIN.T_MDM_ITEM_ATTRIBUTE mia on mia.ROOT_ITEM_NBR = i.ROOT_ITEM_NBR
WHERE    (mia.CLASS_CDE = 'NOORDERC'
AND      mia.ATTRIB_CDE = 'Y'
AND      current date between mia.START_DATE and mia.END_DATE)
or (i.FACILITYID = '001' and i.ITEM_NBR_HS in ('0340000', '0370007', '0390005', '0600007', '0480004', '0490003', '0434340'))
;

grant select on CRMADMIN.V_WEB_ITEM_NO_ORDER to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_ITEM_NO_ORDER to user ETL;
grant select on CRMADMIN.V_WEB_ITEM_NO_ORDER to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_ITEM_NO_ORDER to user ETL with grant option;
grant select on CRMADMIN.V_WEB_ITEM_NO_ORDER to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.CRMADMIN.V_WEB_DC_AREA  
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW   CRMADMIN.V_WEB_DC_AREA
AS  
SELECT   da.FACILITYID,
         da.DC_CD OMS_DC,
         da.DC_AREA_ID,
         da.DC_AREA_DESC,
         da.SCHED_LIKE_FACILITYID,
         da.SCHED_LIKE_DC_AREA_ID, 
         ino.ITEM_NBR_HS,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_DC_AREA da 
         inner join CRMADMIN.V_WEB_FACILITY dx on da.FACILITYID = dx.FACILITYID 
         left outer join CRMADMIN.V_WEB_ITEM_NO_ORDER ino on da.FACILITYID = ino.FACILITYID and da.SCHED_LIKE_DC_AREA_ID = ino.DC_AREA_ID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
;

grant select on CRMADMIN.V_WEB_DC_AREA to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_DC_AREA to user ETL;
grant select on CRMADMIN.V_WEB_DC_AREA to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_DC_AREA to user ETL with grant option;
grant select on CRMADMIN.V_WEB_DC_AREA to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_BOOKING 
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_BOOKING as 
SELECT   obh.FACILITYID,
         obh.CUST_GROUP_NUM,
         obh.AD_BOOKING_CNTL_NUM,
         obh.AD_DESC,
--         obh.AD_BOOKING_BOOTH_ID,
         obh.AD_ORD_RETURN_DATE,
         obh.AD_SHIP_START_DATE,
         obh.AD_SHIP_END_DATE,
         obh.VENDOR_NBR,
         v.VENDOR_NAME,
--         obh.ITEM_NBR,
         obh.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.UPC_UNIT,
         i.UPC_CASE,
         obh.ORDER_TYPE,
--         obh.RECORD_ID,
         obh.BUYER_NBR,
         obh.QTY_ORDERED,
         obh.AD_HOLD_QTY,
         obh.AD_BOOKING_AMT,
         obh.AD_ALLOW_AMT,
         obh.AD_RELEASE_CD,
         obh.ENCUMBERANCE_FLG,
         obh.AD_FEATURE_CD,
         obh.SUBSTITUTION_FLG,
         obh.PROMO_CNTL_NBR,
         obh.PAGE_NUM,
         obh.BASE_SELL_PRICE1,
         obh.BASE_SELL_PRICE2,
         obh.BASE_SELL_PRICE3,
         obh.AD_BOOKING_INCENTIVE,
         obh.AD_REG_ALLOWANCE,
         obh.MLTRY_CNTRL_ID,
         obh.CUST_ITEM_NUM,
         obh.CUST_BILL_NUM
FROM     CRMADMIN.T_WHSE_ORDER_BOOK_HDR obh 
         left outer join CRMADMIN.T_WHSE_ITEM i on obh.FACILITYID = i.FACILITYID and obh.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join CRMADMIN.T_WHSE_VENDOR v on obh.FACILITYID = v.FACILITYID and obh.VENDOR_NBR = v.VENDOR_NBR
WHERE    obh.AD_ORD_RETURN_DATE >= current date
AND      ACTIVE_FLG = 'Y'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_BOOKING to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_BOOKING to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_BOOKING to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_BOOKING to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_AD_BOOKING to user WEB;
