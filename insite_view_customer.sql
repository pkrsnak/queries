----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_FACILITY
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_FACILITY
as
SELECT   SWAT_ID as facilityid,
         DIV_PREFIX_1 as FAC_SHORT_NAME,
         OMS_DC,
         OMS_CODE_SCHEME_CD,
         DIV_NAME,
         ENTERPRISE_KEY,
         ADDRESS,
         CITY,
         STATE, 
         ZIP_CODE,
         PHONE_NBR as PHONE,
         COUNTRY,
         REGION,
         ACTIVE_FLAG,
         PROCESS_ACTIVE_FLAG,
         PLATFORM_TYPE,
         UPSTREAM_DC_TYP_CD,
         HANDHELD_STATUS_CD,
         INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_DIV_XREF
WHERE    PROCESS_ACTIVE_FLAG = 'Y'
;

grant select on CRMADMIN.V_WEB_FACILITY to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_FACILITY to user ETL;
grant select on CRMADMIN.V_WEB_FACILITY to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_FACILITY to user ETL with grant option;
grant select on CRMADMIN.V_WEB_FACILITY to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_WEB_FACILITY_RETAIL_DEPT
--------------------------------------------------
create or replace view CRMADMIN.V_WEB_FACILITY_RETAIL_DEPT  
as  
SELECT   rd.FACILITYID,
         rd.RETAIL_DEPT,
         rd.RETAIL_DEPT_DESC,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_RETAIL_DEPT rd 
         inner join CRMADMIN.V_WEB_FACILITY dx on rd.FACILITYID = dx.FACILITYID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
;

grant select on CRMADMIN.V_WEB_FACILITY_RETAIL_DEPT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_FACILITY_RETAIL_DEPT to user ETL;
grant select,update,insert,delete on CRMADMIN.V_WEB_FACILITY_RETAIL_DEPT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_FACILITY_RETAIL_DEPT to user ETLX;
grant select on CRMADMIN.V_WEB_FACILITY_RETAIL_DEPT to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_FACILITY_RTL_PRICE_DEPT
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_FACILITY_RTL_PRICE_DEPT
as
SELECT   rd.FACILITYID,
         rd.RTL_PRICE_DEPT,
         rd.RTL_PRICE_DEPT_DESC,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_RTL_PRICE_DEPT rd 
         inner join CRMADMIN.V_WEB_FACILITY dx on rd.FACILITYID = dx.FACILITYID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
AND      dx.PLATFORM_TYPE not in ('LEGACY')
AND      dx.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_FACILITY_RTL_PRICE_DEPT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_FACILITY_RTL_PRICE_DEPT to user ETL;
grant select on CRMADMIN.V_WEB_FACILITY_RTL_PRICE_DEPT to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_FACILITY_RTL_PRICE_DEPT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_FACILITY_RTL_PRICE_DEPT to user WEB;


----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CORPORATION
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CORPORATION
as
SELECT   CORP_CODE,
         CORP_NAME,
         CORP_ADDRESS1,
         CORP_ADDRESS2,
         CORP_BURDEN_COST_IND,
         CORP_CITY,
         CORP_STATE,
         CORP_ZIP,
         CORP_COUNTRY,
         CORP_PHONE1,
         CORP_PHONE2,
         CORP_PHONE3,
         CORP_FAX,
         CORP_EMAIL,
         CORP_WEBSITE,
         CORP_CEO,
         CORP_STATUS_CD,
         CORP_STATUS_DESC,
         count(*) num_customers
FROM     CRMADMIN.T_WHSE_CORPORATION_MDM
WHERE    ACTIVE = 'Y'
GROUP BY CORP_CODE, CORP_NAME, CORP_ADDRESS1, CORP_ADDRESS2, 
         CORP_BURDEN_COST_IND, CORP_CITY, CORP_STATE, CORP_ZIP, CORP_COUNTRY, 
         CORP_PHONE1, CORP_PHONE2, CORP_PHONE3, CORP_FAX, CORP_EMAIL, 
         CORP_WEBSITE, CORP_CEO, CORP_STATUS_CD, CORP_STATUS_DESC
;

grant select on CRMADMIN.V_WEB_CORPORATION to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CORPORATION to user ETL;
grant select on CRMADMIN.V_WEB_CORPORATION to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CORPORATION to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CORPORATION to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER
as
SELECT   Distinct corp.CORP_CODE, 
         cust.TERRITORY_NO,
         cust.CUSTOMER_NO_FULL,
         cust.CUSTOMER_NBR_STND,
         cust.RTL_SERV_CUST_CD,
         cust.NAME,
         cust.LEGAL_CUSTOMER_NAME,
         cust.ADDRESS1,
         trim(cust.ADDRES2) as ADDRESS2,
         cust.ADDRESS3 as CITY,
         cust.STATE_CD,
         cust.ZIP_CD,
         cust.BILL_TO_NAME,
         cust.BILL_TO_ADDRESS1,
         cust.BILL_TO_ADDRESS2,
         cust.BILL_TO_CITY,
         cust.BILL_TO_STATE,
         cust.BILL_TO_ZIP_CDE,
         cust.BILL_TO_COUNTRY,
         cust.TELEPHONE,
         trim(cust.BILL_TO_PHONE_NBR) as BILL_TO_PHONE_NBR,
         cust.BILL_TO_FAX_NBR,
         cust.BILL_TO_EMAIL,
         cust.COUNTY_CD_MDM,
         cust.COUNTY_KEY_MDM,
         cust.COUNTY_DESCRIPTION_MDM,
         cust.LONGITUDE_NBR,
         cust.LATITUDE_NBR,
         cust.ACQUISITION_DATE,
         cust.STORE_OPEN_DATE,
         cust.STORE_CLOSE_DATE,
         cust.BILLABLE_FLAG,
         cust.PI_IND,
         cust.PI_EFF_DATE,
         cust.PI_EXP_DATE,
         cust.COMP_STAT_KEY,
         cust.COMP_STAT_DESC,
         cust.COMP_STAT_DATE,
         cust.DC_COMP_STAT_KEY,
         cust.DC_COMP_STAT_DESC,
         cust.DC_COMP_STAT_DATE,
         cust.DC_COMP_LINK_NBR,
         cust.DEPT_STRUCT_KEY,
         cust.DEPT_STRUCT_DESC,
         cust.PRESELL_PART_IND,
         cust.RELATED_CUST_CD,
         cust.CUST_PCON_IND,
         cust.COMPARE_SAVE_IND,
         cust.FREQ_SHOPPER_IND,
         cust.FIRST_PURCHASE_IND,
         cust.WEB_LOCATOR_IND,
         cust.CUST_CLASS_KEY,
         cust.CUST_CLASS_CD,
         cust.CUST_CLASS_DESC,
         cust.FEDERAL_ID_NO,
         cust.STORE_LICENSE_ID,
         cust.STORE_CIGARETTE_TAX_ID,
         cust.STORE_TOBACCO_TAX_ID,
         cust.PRIM_STORE_NO,
         cust.SELL_SQFT,
         cust.TOWNSHIP_KEY,
         cust.TOWNSHIP_NAME,
         cust.SCHOOL_DIST_KEY,
         cust.SCHOOL_DIST_NAME,
         cust.BANNER_ID,
         banner.BANNER_DESC,
         cust.MEMBERSHIP_CODE,
         cust.MEMBERSHIP_KEY,
         cust.MEMBERSHIP_DESC,
         cust.MDM_CUST_STATUS_CD,
         cust.MDM_CUST_STATUS_DESC,
         cust.MDM_UPDATE_DATE,
         cust.CONTRACT_START_DATE,
         cust.CONTRACT_END_DATE,
         case 
              when current date between cust.CONTRACT_START_DATE and cust.CONTRACT_END_DATE then 'A' 
              else 'D' 
         end CONTRACT_STATUS,
         cust.MANAGER,
         cust.OWNER,
         upper(cust.TIME_ZONE_CUST) TIME_ZONE_CUST,
         corp.CORP_BURDEN_COST_IND,
         cust.STORE_FAX_NBR,
         cust.STORE_EMAIL,
         cust.STATEMENT_CYCLE_SUNDAY,
         cust.STATEMENT_CYCLE_MONDAY,
         cust.STATEMENT_CYCLE_TUESDAY,
         cust.STATEMENT_CYCLE_WEDNESDAY,
         cust.STATEMENT_CYCLE_THURSDAY,
         cust.STATEMENT_CYCLE_FRIDAY,
         cust.STATEMENT_CYCLE_SATURDAY,
         cust.STATEMENT_FREQ,
         cust.STATEMENT_FREQ_DESC
FROM     CRMADMIN.T_WHSE_CUST cust 
         inner join CRMADMIN.T_WHSE_CORPORATION_MDM corp on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND 
         inner join CRMADMIN.V_WEB_FACILITY dx on cust.FACILITYID = dx.FACILITYID 
         left outer join CRMADMIN.T_WHSE_CUST_BANNER banner on cust.BANNER_ID = banner.BANNER_ID
WHERE    dx.UPSTREAM_DC_TYP_CD = 'D'
AND      cust.CONTRACT_END_DATE > current date - 30 days
AND      corp.ACTIVE = 'Y'
AND      cust.FACILITYID = cust.HOME_BRANCH
AND      cust.MDM_CUST_STATUS_CD not in (3, 9)
AND      cust.TERRITORY_NO not in (29, 39, 59)
AND      cust.CUST_CLASS_CD not in (14)
AND      (cust.STATUS_CD not in ('P', 'Z')
     OR  cust.STATUS_CD is null)
;

grant select on CRMADMIN.V_WEB_CUSTOMER to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER to user WEB;
grant select on CRMADMIN.V_WEB_CUSTOMER to user SIUSER;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER_FAC
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_FAC
as
SELECT   corp.CORP_CODE,
         cust.CUST_CORPORATION CORP_SWAT,
         cust.FACILITYID,
         cust.HOME_BRANCH,
         cust.TERRITORY_NO,
         cust.CUSTOMER_NO_FULL,
         cust.CUSTOMER_NBR_STND,
         trim(cust.CUST_STORE_NO) as CUST_STORE_NO,
         cust.RTL_SERV_CUST_CD,
         cust.NAME,
         cust.LEGAL_CUSTOMER_NAME,
         cust.SHORT_CUSTOMER_NAME,
         cust.ADDRESS1,
         trim(cust.ADDRES2) as ADDRESS2,
         cust.ADDRESS3 as CITY,
         cust.STATE_CD,
         cust.ZIP_CD,
         cust.BILL_TO_NAME,
         cust.BILL_TO_ADDRESS1,
         cust.BILL_TO_ADDRESS2,
         cust.BILL_TO_CITY,
         cust.BILL_TO_STATE,
         cust.BILL_TO_ZIP_CDE,
         cust.BILL_TO_COUNTRY,
         trim(cust.BILL_TO_PHONE_NBR) as BILL_TO_PHONE_NBR,
         cust.BILL_TO_FAX_NBR,
         cust.BILL_TO_EMAIL,
         cust.TELEPHONE,
         cust.REMIT_NAME,
         cust.REMIT_ADDRESS1,
         cust.REMIT_ADDRESS2,
         cust.REMIT_ZIP,
         cust.MDM_CUSTOMER_FLAG,
         cust.MDM_CUSTOMER_LASTUPDATE,
         cust.STATUS_CD,
         cust.CONTRACT_START_DATE,
         cust.CONTRACT_END_DATE,
         case 
              when current date between cust.CONTRACT_START_DATE and cust.CONTRACT_END_DATE then 'A' 
              else 'D' 
         end CONTRACT_STATUS,
         cust.COUNTY_CD_MDM,
         cust.COUNTY_KEY_MDM,
         cust.COUNTY_DESCRIPTION_MDM,
         cust.LONGITUDE_NBR,
         cust.LATITUDE_NBR,
         cust.ACQUISITION_DATE,
         cust.STORE_CLOSE_DATE,
         cust.PI_IND,
         cust.PI_EFF_DATE,
         cust.PI_EXP_DATE,
         cust.COMP_STAT_KEY,
         cust.COMP_STAT_DESC,
         cust.COMP_STAT_DATE,
         cust.DC_COMP_STAT_KEY,
         cust.DC_COMP_STAT_DESC,
         cust.DC_COMP_STAT_DATE,
         cust.DC_COMP_LINK_NBR,
         cust.DEPT_STRUCT_KEY,
         cust.DEPT_STRUCT_DESC,
         cust.PRESELL_PART_IND,
         cust.RELATED_CUST_CD,
         cust.CUST_PCON_IND,
         cust.COMPARE_SAVE_IND,
         cust.FREQ_SHOPPER_IND,
         cust.ALLOWANCE_CODE,
         cust.FIRST_PURCHASE_IND,
         cust.STORE_OPEN_DATE,
         cust.WEB_LOCATOR_IND,
         cust.GL_BUSINESS_UNIT,
         cust.GL_BUSINESS_UNIT_DESC,
         cust.CUST_CLASS_KEY,
         cust.CUST_CLASS_CD,
         cust.CUST_CLASS_DESC,
         cust.FEDERAL_ID_NO,
         cust.STORE_LICENSE_ID,
         cust.STORE_CIGARETTE_TAX_ID,
         cust.STORE_TOBACCO_TAX_ID,
         cust.CREATE_DATE,
         cust.PRIM_STORE_NO,
         cust.SELL_SQFT,
         cust.TOWNSHIP_KEY,
         cust.TOWNSHIP_NAME,
         cust.SCHOOL_DIST_KEY,
         cust.SCHOOL_DIST_NAME,
         cust.AGGREGATE_CUST_CD,
         cust.EXT_SYSTEM_CUST_CD,
         cust.ACPT_ORDER_FLG,
         cust.SMGROC_EINVC_IND,
         cust.MEMBERSHIP_CODE,
         cust.MEMBERSHIP_KEY,
         cust.MEMBERSHIP_DESC,
         cust.STORE_TYPE,
         case cust.PRIVATE_RTL_DEPT_FLAG 
              when 'Y' then 'Y' 
              else 'N' 
         end as custom_depts_flg,
         cust.DCUST_ON_DEPT_ORDERING as dept_order_flg,
         case 
              when cust.FACILITYID = cust.HOME_BRANCH then 'Y' 
              else 'N' 
         end FACILITYID_PRIMARY,
         cust.STATE_SLS_ID_NO,
         cust.ALLOW_B4_AFTER,
         case cust.FACILITYID 
              when '001' then 'E' 
              else cust.ITEM_AUTH_METHOD_CD 
         end ITEM_AUTH_METHOD_CD,
         case cust.FACILITYID 
              when '001' then corp.CORP_BURDEN_COST_IND 
              else case cust.MKUP_FRT_SPREAD_FLAG 
                        when '1' then 'Y' 
                        when '2' then 'Y' 
                        else 'N' 
                   end 
         end BURDENED_COST_FLG,
         cust.BILLABLE_FLAG,
         cust.TIME_ZONE_CUST,
         cust.MDM_CUST_STATUS_CD,
         case cust.FACILITYID 
              when '001' then 'N' 
              else case cust.ARDA_FLG 
                        when 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ARDA_FLG,
         dx.UPSTREAM_DC_TYP_CD,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST cust 
         inner join CRMADMIN.T_WHSE_CORPORATION_MDM corp on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND AND corp.ACTIVE = 'Y' 
         inner join CRMADMIN.V_WEB_FACILITY dx on cust.FACILITYID = dx.FACILITYID
WHERE    cust.CONTRACT_END_DATE > current date - 30 days
AND      cust.MDM_CUST_STATUS_CD not in (3, 9)
AND      cust.TERRITORY_NO not in (29, 39, 59)
AND      cust.CUST_CLASS_CD not in (14)
AND      (cust.STATUS_CD not in ('P', 'Z')
     OR  cust.STATUS_CD is null)
;


grant select on CRMADMIN.V_WEB_CUSTOMER_FAC to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_FAC to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_FAC to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_FAC to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_FAC to user WEB;
grant select on CRMADMIN.V_WEB_CUSTOMER_FAC to user SIUSER;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUST_WHSE_DEPT
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_WHSE_DEPT
as
SELECT   wcd.CUSTOMER_NBR_STND,
         wcd.FACILITYID,
         wcd.DEPT_CODE,
         wd.DEPT_DESCRIPTION,
         wcd.HOME_SRP_ZONE,
         wcd.PRIVATE_SRP_ZONE,
         wcd.SALES_PLAN,
         wcd.PVT_RTL_ZN_RESTRICT,
         wcd.STATUS,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_DEPT wcd 
         inner join CRMADMIN.T_WHSE_DEPT wd on wcd.DEPT_CODE = wd.DEPT_CODE 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on wcd.FACILITYID = vwcf.FACILITYID and wcd.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL
WHERE    wcd.STATUS = 'A'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;
grant select on CRMADMIN.V_WEB_CUSTOMER_WHSE_DEPT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_WHSE_DEPT to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_WHSE_DEPT to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_WHSE_DEPT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_WHSE_DEPT to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUST_MDSE_DEPT
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT
as
SELECT   Distinct cdm.FACILITYID,
         vwcf.CUSTOMER_NO_FULL,
         cdm.CUSTOMER_NBR_STND,
         cdm.MDSE_DEPT_CD,
         md.DEPT_CODE_DESC,
         cdm.DEPT_PI_IND,
         cdm.DEPT_PI_EFF_DATE,
         cdm.DEPT_PI_EXP_DATE, 
         cdm.RESTRICT_PRIVATE_LABEL_ONLY, 
         cdm.RESTRICT_SPECIALITY_ONLY, 
         vwcf.MEMBERSHIP_KEY, 
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_DEPT_MDM cdm 
         inner join ETLADMIN.T_MDM_MDSE_DEPT md on cdm.MDSE_DEPT_CD = md.DEPT_CODE 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on cdm.CUSTOMER_NBR_STND = vwcf.CUSTOMER_NBR_STND and cdm.FACILITYID = vwcf.FACILITYID
WHERE    cdm.ACTIVE = 'Y'
AND      md.ACTIVE_FLAG = 'A'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT to user WEB;


----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUST_PRVT_BRAND
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND
as
SELECT   cpb.FACILITYID,
         cpb.CUSTOMER_NBR_STND,
         cpb.PRIV_BRAND_KEY,
         pl.PRIVATE_LABEL_DESC,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_PRIVATE_BRAND_MDM cpb 
         inner join CRMADMIN.T_WHSE_PRIVATE_LABEL pl on cpb.PRIV_BRAND_KEY = pl.PRIVATE_LABEL_KEY 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on cpb.FACILITYID = vwcf.FACILITYID and cpb.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL
WHERE    cpb.ACTIVE = 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUST_DEPT_REP
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_DEPT_REP
as
SELECT   distinct vwcf.FACILITYID,
         vwcf.TERRITORY_NO,
         vwcf.CUSTOMER_NO_FULL,
         vwcf.CUSTOMER_NBR_STND,
         rep.RETAIL_REP_KEY,
         rep.RETAIL_REP_CODE,
         rep.RETAIL_REP_NAME,
         rep.RETAIL_REP_PHONE1,
         rep.RETAIL_REP_PHONE2,
         rep.RETAIL_REP_MOBILE,
         rep.RETAIL_REP_FAX,
         rep.RETAIL_REP_EMAIL,
         rep.RETAIL_REP_TYPE,
         rep.RETAIL_REP_TYPE_DESC,
         rep.RETAIL_REP_DIVISION_CODE,
         rep.RETAIL_REP_DIVISION_DESC,
         rep.RETAIL_REP_REGION_CODE,
         rep.RETAIL_REP_REGION_DESC,
         rep.MDSE_DEPT_KEY,
         rep.MDSE_DEPT_CD,
         rep.MDSE_DEPT_CD_MDM,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_REP_MDM rep 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on rep.CUSTOMER_NBR_STND = vwcf.CUSTOMER_NBR_STND 
WHERE    rep.ACTIVE = 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_DEPT_REP to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_DEPT_REP to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_DEPT_REP to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_DEPT_REP to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_DEPT_REP to user WEB;
grant select on CRMADMIN.V_WEB_CUSTOMER_DEPT_REP to user SIUSER;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUST_COMMODITY
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_COMMODITY
as
SELECT   comm.FACILITYID,
         comm.CUSTOMER_NO_FULL,
         comm.TERRITORY_NO,
         comm.CUSTOMER_NBR_STND,
         comm.COMMODITY_POST_KEY as COMMODITY,
         comm.COMMODITY_DESC,
         comm.CUSTOMER_CODE,
         comm.DELIVERY_TYPE_KEY,
         comm.DELIVERY_TYPE_DESC,
         comm.PRINT_PICK_LBL_IND,
         comm.ORDER_SUB_IND,
         comm.PRINT_CUST_RTL_IND,
         comm.PRINT_SCHG_IND,
         comm.ORDER_IND,
         comm.FRGHT_FACILITY_KEY,
         comm.MIN_ORDER_FEE_IND,
         comm.RTL_WKLY_FEED_IND,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_COMMODITY_MDM comm 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on comm.FACILITYID = vwcf.FACILITYID and comm.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL
WHERE    comm.ACTIVE = 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_COMMODITY to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_COMMODITY to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_COMMODITY to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_COMMODITY to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_COMMODITY to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_COMPETITOR_REL
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_COMPETITOR_REL
as
SELECT   distinct comp.CUSTOMER_NBR_STND,
         comp.COMPETITOR_CD, 
         vwcf.MEMBERSHIP_KEY
FROM     CRMADMIN.T_WHSE_CUST_COMPETITOR_MDM comp 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on comp.FACILITYID = vwcf.FACILITYID and comp.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL
WHERE    comp.ACTIVE = 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_COMPETITOR_REL to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_COMPETITOR_REL to user ETL;
grant select on CRMADMIN.V_WEB_COMPETITOR_REL to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_COMPETITOR_REL to user ETL with grant option;
grant select on CRMADMIN.V_WEB_COMPETITOR_REL to user WEB;


----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER_CUSTOM_DEPT
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_CUSTOM_DEPT
as
SELECT   csd.FACILITYID,
         csd.CUSTOMER_NO_FULL,
         csd.CUSTOMER_NBR_STND,
         csd.DEPT_TYPE_CD as CUSTOM_DEPT_TYPE,
         csd.DEPT_CD as CUSTOM_DEPT,
         csd.DEPT_DESC as CUSTOM_DEPT_DESC,
         csd.DEPT_SHORT_DESC as CUSTOM_DEPT_SHORT_DESC,
         vwcf.MEMBERSHIP_KEY,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_STORE_DEPT csd 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on csd.FACILITYID = vwcf.FACILITYID and csd.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL
WHERE    csd.ACTIVE_FLG = 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_CUSTOM_DEPT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_CUSTOM_DEPT to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_CUSTOM_DEPT to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_CUSTOM_DEPT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_CUSTOM_DEPT to user WEB;


----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER_ATTR
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_ATTR 
as 
SELECT   ca.CUSTOMER_NBR_STND,
         ca.CLASS_CDE,
         ca.ATTRIB_CDE,
         ca.ATTRIB_VALUE,
         ca.START_DATE,
         ca.END_DATE
FROM     CRMADMIN.T_MDM_CUST_ATTRIBUTE ca 
         inner join CRMADMIN.V_WEB_CUSTOMER vwc on ca.CUSTOMER_NBR_STND = vwc.CUSTOMER_NBR_STND
WHERE    ca.STATUS_DWH = 'A'
AND      current date between ca.START_DATE and ca.END_DATE
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ATTR to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ATTR to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ATTR to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ATTR to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ATTR to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER_ITEM_ORD_LIMIT
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_ITEM_ORD_LIMIT as 
SELECT   coil.FACILITYID,
         coil.CUSTOMER_NO_FULL,
         coil.CUSTOMER_NBR_CORP,
         coil.CUSTOMER_NBR_STND,
         coil.ITEM_NBR_HS,
         coil.REG_ORD_REMAIN,
         coil.ABS_ORD_REMAIN,
         coil.START_DATE,
         vwcf.MEMBERSHIP_KEY,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_ITEM_ORDER_LIMIT coil 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on coil.FACILITYID = vwcf.FACILITYID and coil.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL
WHERE    coil.ACTIVE_FLG = 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_ORD_LIMIT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_ITEM_ORD_LIMIT to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_ORD_LIMIT to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_ITEM_ORD_LIMIT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_ITEM_ORD_LIMIT to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_MDSE_DEPT_GRP
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_MDSE_DEPT_GRP
as
SELECT   DEPT_GRP_CODE,
         DEPT_GRP_CODE_DESC
FROM     ETLADMIN.T_MDM_MDSE_DEPT_GRP
WHERE    (DEPT_GRP_CODE, START_DATE) in (select DEPT_GRP_CODE, max(START_DATE) 
                                         from ETLADMIN.T_MDM_MDSE_DEPT_GRP
                                         where current date between START_DATE and END_DATE
                                         group by DEPT_GRP_CODE)
 and ACTIVE_FLAG = 'A'
;

grant select on CRMADMIN.V_WEB_MDSE_DEPT_GRP to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_MDSE_DEPT_GRP to user ETL;
grant select on CRMADMIN.V_WEB_MDSE_DEPT_GRP to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_MDSE_DEPT_GRP to user ETL with grant option;
grant select on CRMADMIN.V_WEB_MDSE_DEPT_GRP to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_MDSE_DEPT
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_MDSE_DEPT
as
SELECT   DEPT_CODE,
         DEPT_CODE_DESC,
         DEPT_GRP_CODE
FROM     ETLADMIN.T_MDM_MDSE_DEPT
WHERE    (DEPT_CODE, START_DATE) in (select DEPT_CODE, max(START_DATE) 
                                     from ETLADMIN.T_MDM_MDSE_DEPT
                                     where current date between START_DATE and END_DATE
                                     group by DEPT_CODE)
 and ACTIVE_FLAG = 'A'
;

grant select on CRMADMIN.V_WEB_MDSE_DEPT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_MDSE_DEPT to user ETL;
grant select on CRMADMIN.V_WEB_MDSE_DEPT to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_MDSE_DEPT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_MDSE_DEPT to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_MDSE_GRP
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_MDSE_GRP
as
SELECT   MDSE_GRP_CODE,
         MDSE_GRP_CODE_DESC,
         DEPT_CODE
FROM     ETLADMIN.T_MDM_MDSE_GRP
WHERE    (MDSE_GRP_CODE, START_DATE) in (select MDSE_GRP_CODE, max(START_DATE) 
                                         from ETLADMIN.T_MDM_MDSE_GRP
                                         where current date between START_DATE and END_DATE
                                         group by MDSE_GRP_CODE)
 and ACTIVE_FLAG = 'A'
;

grant select on CRMADMIN.V_WEB_MDSE_GRP to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_MDSE_GRP to user ETL;
grant select on CRMADMIN.V_WEB_MDSE_GRP to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_MDSE_GRP to user ETL with grant option;
grant select on CRMADMIN.V_WEB_MDSE_GRP to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_MDSE_CAT
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_MDSE_CAT
as
SELECT   MDSE_CAT_CODE,
         MDSE_CAT_CODE_DESC,
         MDSE_GRP_CODE
FROM     ETLADMIN.T_MDM_MDSE_CAT
WHERE    (MDSE_CAT_CODE, START_DATE) in (select MDSE_CAT_CODE, max(START_DATE) 
                                         from ETLADMIN.T_MDM_MDSE_CAT
                                         where current date between START_DATE and END_DATE
                                         group by MDSE_CAT_CODE)
 and ACTIVE_FLAG = 'A'
;

grant select on CRMADMIN.V_WEB_MDSE_CAT to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_MDSE_CAT to user ETL;
grant select on CRMADMIN.V_WEB_MDSE_CAT to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_MDSE_CAT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_MDSE_CAT to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_MDSE_CLS
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_MDSE_CLS
as
SELECT   MDSE_CLS_CODE,
         MDSE_CLS_CODE_DESC,
         MDSE_CAT_CODE 
FROM     ETLADMIN.T_MDM_MDSE_CLS
WHERE    (MDSE_CLS_CODE, START_DATE) in (select MDSE_CLS_CODE, max(START_DATE) 
                                         from ETLADMIN.T_MDM_MDSE_CLS
                                         where current date between START_DATE and END_DATE
                                         group by MDSE_CLS_CODE)
 and ACTIVE_FLAG = 'A'
;

grant select on CRMADMIN.V_WEB_MDSE_CLS to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_MDSE_CLS to user ETL;
grant select on CRMADMIN.V_WEB_MDSE_CLS to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_MDSE_CLS to user ETL with grant option;
grant select on CRMADMIN.V_WEB_MDSE_CLS to user WEB;;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER_DC_AREA
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_DC_AREA
as
SELECT   cda.FACILITYID,
         cda.DC_AREA_ID,
         cda.CUSTOMER_NBR_STND,
         dx.HANDHELD_STATUS_CD,
         dx.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_DC_AREA cda 
         inner join CRMADMIN.V_WEB_CUSTOMER wc on cda.CUSTOMER_NBR_STND = wc.CUSTOMER_NBR_STND 
         inner join CRMADMIN.V_WEB_FACILITY dx on cda.FACILITYID = dx.FACILITYID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
;

grant select on CRMADMIN.V_WEB_CUSTOMER_DC_AREA to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_DC_AREA to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_DC_AREA to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_DC_AREA to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_DC_AREA to user WEB;

----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER_GRP
----------------------------------------------------------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_GRP
as
SELECT   cgm.FACILITYID,
         cgm.TERRITORY_NO,
         cgm.CUSTOMER_NO,
         cgm.CUSTOMER_NO_FULL,
         cgm.CUSTOMER_NBR_CORP,
         cgm.CUSTOMER_NBR_STND,
         cgm.CUST_GRP_LINK_KEY,
         cgm.ACTIVE,
         cgm.GROUP_KEY,
         cgm.CNTRL_STORE_IND,
         cgm.GROUP_CD,
         cgm.GROUP_DESC,
         cgm.CORP_CODE,
         cgm.SITE_CD,
         cgm.LEGACY_GROUP_NBR,
         cgm.GROUP_TYPE_KEY,
         cgm.GROUP_TYPE_CD,
         cgm.GROUP_TYPE_DESC,
         cgm.GRP_TYP_ENROLL_KEY,
         cgm.GRP_TYP_ENROLL_DESC,
         cgm.CREATE_USER_ID,
         cgm.UPDATE_USER_ID,
         cgm.CREATE_TMSP,
         cgm.UPDATE_TMSP,
         'MDM' AUDIT_SOURCE_ID
FROM     crmadmin.T_WHSE_CUST_GRP_MDM cgm 
         inner join CRMADMIN.V_WEB_FACILITY dx on cgm.FACILITYID = dx.FACILITYID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
and cgm.ACTIVE = 'Y'
AND      dx.PLATFORM_TYPE not in ('LEGACY')
union all
SELECT   gp.FACILITYID,
         c.TERRITORY_NO,
         substr(c.CUSTOMER_NO_FULL,3,6),
         c.CUSTOMER_NO_FULL,
         c.FACILITYID || c.CUSTOMER_NO_FULL CUSTOMER_NBR_CORP,
         c.CUSTOMER_NBR_STND,
         0 CUST_GRP_LINK_KEY,
         gp.STATUS,
         gp.CUSTOMER_GRP_CLASS,
         '' CNTRL_STORE_IND,
         gpc.CUSTOMER_GRP_CLASS,
         gpc.CUSTOMER_GRP_CLASS_DESC,
         c.CORP_CODE,
         int(gp.FACILITYID),
         0 LEGACY_GROUP_NBR,
         gpc.CUSTOMER_GRP_TYPE,
         gpc.CUSTOMER_GRP_TYPE,
         gpc.CUSTOMER_GRP_TYPE_DESC,
         0 GRP_TYP_ENROLL_KEY,
         '' GRP_TYP_ENROLL_DESC,
         gp.PROCESS_USER,
         gp.PROCESS_USER,
         gp.PROCESS_TIMESTAMP,
         gp.PROCESS_TIMESTAMP,
         'SWAT' AUDIT_SOURCE_ID
FROM     CRMADMIN.T_WHSE_CUST_GRP gp 
         inner join CRMADMIN.T_WHSE_CUST_GRP_CLASS gpc on gp.FACILITYID = gpc.FACILITYID and gp.CUSTOMER_GRP_TYPE = gpc.CUSTOMER_GRP_TYPE and gp.CUSTOMER_GRP_CLASS = gpc.CUSTOMER_GRP_CLASS 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC c on gp.FACILITYID = c.FACILITYID and gp.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND 
         inner join CRMADMIN.V_WEB_FACILITY dx on gp.FACILITYID = dx.FACILITYID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
AND      dx.PLATFORM_TYPE not in ('LEGACY')
AND      gp.STATUS not in ('D')
AND      c.STATUS_CD not in ('Z')
;

grant select on CRMADMIN.V_WEB_CUSTOMER_GRP to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_GRP to user ETL;
grant select on CRMADMIN.V_WEB_CUSTOMER_GRP to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_GRP to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_GRP to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_WEB_CUSTOMER_TROUBLESHOOT
--------------------------------------------------
create or replace view CRMADMIN.V_WEB_CUSTOMER_TROUBLESHOOT  as  
SELECT   cust.FACILITYID,
         cust.HOME_BRANCH,
         cust.CUSTOMER_NO_FULL,
         cust.TERRITORY_NO,
         cust.CUSTOMER_NBR_STND,
         cust.NAME,
         cust.STATUS_CD,
         cust.MDM_CUST_STATUS_CD,
         cust.MDM_CUST_STATUS_DESC,
         cust.CONTRACT_START_DATE,
         cust.CONTRACT_END_DATE,
         cust.CUST_CLASS_CD,
         cust.CUST_CLASS_DESC,
         cust.MEMBERSHIP_CODE,
         cust.MEMBERSHIP_KEY,
         cust.MEMBERSHIP_DESC,
         cust.PROCESS_TIMESTAMP,
         corp.CORP_CODE,
         corp.CORP_NAME
FROM     CRMADMIN.T_WHSE_CUST cust 
         left outer join (select CORP_CODE, CORP_NAME, CUSTOMER_NBR_STND from CRMADMIN.T_WHSE_CORPORATION_MDM where ACTIVE = 'Y') corp on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND
;
--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_WEB_CUSTOMER_TROUBLESHOOT
--------------------------------------------------
grant select on CRMADMIN.V_WEB_CUSTOMER_GRP to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CUSTOMER_TROUBLESHOOT to user ETL;
grant select,update,insert,delete on CRMADMIN.V_WEB_CUSTOMER_TROUBLESHOOT to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CUSTOMER_TROUBLESHOOT to user ETLX;
grant select on CRMADMIN.V_WEB_CUSTOMER_TROUBLESHOOT to user WEB;


--------------------------------------------------
-- Create View CRMADMIN.V_WEB_INVOICE_DTL
--------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_INVOICE_DTL as 
SELECT   CUSTOMER_NBR_STND AS INVC_RPT_CUST_NBR,
         DELIVERY_DATE AS DELIVERY_DT,
         INVOICE_NBR AS CUST_INVC_NBR,
         CUST_INVC_ITEM_KEY,
         BATCH_ID_NBR,
         INVC_RECORD_TYP_CD,
         ITEM_CATEGORY_CD,
         ORD_ITEM_UPC_NBR,
         ORD_ITEM_CD,
         INVC_ORDER_TYPE_CD,
         ITEM_PACK_QTY,
         ORDERABLE_ITEM_DSC,
         INVC_REFERENCE_NBR,
         ITM_PRICE_AMT,
         CASH_DISCNT_AMT,
         ITM_PRICE_NET_AMT,
         ITM_PRICE_EXTD_AMT,
         ITEM_SHIP_QTY,
         ITEM_ORDER_QTY,
         ITEM_WEIGHT_MSR,
         RTL_UNIT_COST_AMT,
         RTL_UNIT_PRICE_TXT,
         ITM_GROSS_MRGN_PCT,
         SUB_ITEM_CD,
         INVC_MESSAGE_TXT,
         INVC_LITERAL_TXT,
         CUBE_MSR,
         TOTL_REFLCT_PA_AMT,
         TOTL_COSTPLUS_AMT,
         TOTL_BRDN_COST_AMT,
         TOTL_BRDN_GRSS_AMT,
         TOTL_BRDN_MRGN_PCT,
         ORD_ITM_SIZE_MSR,
         ADVERTISEMENT_FLG,
         BRDN_UNIT_CST_AMT,
         ITEM_BRDN_GMGN_PCT,
         CMPNT_ITM_CD
FROM     CRMADMIN.T_WHSE_SALES_INVOICE_RPTDTL;
--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_WEB_INVOICE_DTL
--------------------------------------------------
grant select on CRMADMIN.V_WEB_INVOICE_DTL to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_INVOICE_DTL to user ETL;
grant select,update,insert,delete on CRMADMIN.V_WEB_INVOICE_DTL to user ETL with grant option;
grant select on CRMADMIN.V_WEB_INVOICE_DTL to user ETLX;
grant select on CRMADMIN.V_WEB_INVOICE_DTL to user SIUSER;
grant select on CRMADMIN.V_WEB_INVOICE_DTL to user WEB;
--------------------------------------------------
-- Create View CRMADMIN.V_WEB_INVOICE_HDR
--------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_INVOICE_HDR as 
SELECT   CUSTOMER_NBR_STND as INVC_RPT_CUST_NBR,
         DELIVERY_DATE AS DELIVERY_DT,
         INVOICE_NBR AS CUST_INVC_NBR,
         BATCH_ID_NBR,
         COMMODITY_CODE,
         DEPT_DESC,
         FACILITY_CODE,
         WAREHOUSE_CD,
         BILLING_DATE AS INVOICE_DATE,
         BILLING_TIME AS INVOICE_TIME,
         PRICE_EFFECTIVE_DT,
         INVOICE_ROUTE_NBR,
         TAX_POLICY_TXT,
         SHIP_TO_NAME,
         SHIP_TO_STRT1_ADDR,
         SHIPTO_CITYST_NAME,
         SHIP_TO_ZIP_CD,
         BILL_TO_NAME,
         BILL_TO_STRT1_ADDR,
         BILLTO_CITYST_NAME,
         BILL_TO_ZIP_CD,
         INVC_TOTL_AMT,
         CUST_INVC_FMT_CD,
         XDOCK_CMDTY_DESC
FROM     CRMADMIN.T_WHSE_SALES_INVOICE_RPTHDR;
--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_WEB_INVOICE_HDR
--------------------------------------------------
grant select on CRMADMIN.V_WEB_INVOICE_HDR to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_INVOICE_HDR to user ETL;
grant select,update,insert,delete on CRMADMIN.V_WEB_INVOICE_HDR to user ETL with grant option;
grant select on CRMADMIN.V_WEB_INVOICE_HDR to user ETLX;
grant select on CRMADMIN.V_WEB_INVOICE_HDR to user SIUSER;
grant select on CRMADMIN.V_WEB_INVOICE_HDR to user WEB;
