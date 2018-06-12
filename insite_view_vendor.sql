----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_VENDOR
----------------------------------------------------------------------------------------------------
create or replace view crmadmin.v_web_vendor  
as  
SELECT   v.PAYABLE_VENDOR_NBR as AP_VENDOR_NBR,
         a.AP_VENDOR_1_NM as AP_VENDOR_NAME,
         a.NO_CHRG_VENDOR_FLG,
         trim(b.MASTER_BROKER) as MASTER_BROKER,
         m.MSTRBKR_NAME,
         b.VENDOR_NBR as BROKER_NBR,
         b.VENDOR_NAME as BROKER_NAME,
         b.ADDRESS_1 as BROKER_ADDRESS_1,
         b.ADDRESS_2 as BROKER_ADDRESS_2,
         b.city as BROKER_CITY,
         b.state as BROKER_STATE,
         b.ZIP as BROKER_ZIP,
         b.PHONE as BROKER_PHONE,
         b.CONTACT as BROKER_CONTACT,
         b.AFE_FAX_NUMBER as BROKER_FAX_1,
         b.AFE_FAX_NUMBER_2 as BROKER_FAX_2,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         v.ADDRESS_1 as VENDOR_ADDRESS_1,
         v.ADDRESS_2 as VENDOR_ADDRESS_2,
         v.city as VENDOR_CITY,
         v.state as VENDOR_STATE,
         v.ZIP as VENDOR_ZIP,
         v.PHONE as VENDOR_PHONE,
         v.CONTACT as VENDOR_CONTACT,
         v.FACILITYID as FACILITY,
         d.DIV_NAME as FACILITY_NAME,
         v.BUYER_NBR,
         u.FULL_NAME as BUYER_NAME,
         v.WAREHOUSE_CODE_X,
         w.WAREHOUSE_CODE_DESC,
         v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC
FROM     CRMADMIN.T_WHSE_VENDOR v 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on v.FACILITYID = d.SWAT_ID 
         left outer join CRMADMIN.T_WHSE_VENDOR b on v.BROKER_NUMBER = b.VENDOR_NBR and v.FACILITYID = b.FACILITYID 
         left outer join CRMADMIN.V_WHSE_USER u on v.BUYER_NBR = u.BUYER_NBR 
         left outer join CRMADMIN.T_WHSE_WAREHOUSE_CODE w on v.WAREHOUSE_CODE_X = w.WAREHOUSE_CODE and v.FACILITYID = w.FACILITYID 
         left outer join CRMADMIN.T_WHSE_VENDOR_MASTERBROKER m on trim(b.MASTER_BROKER) = trim(m.MSTRBKR_NUMBER) 
         left outer join CRMADMIN.T_WHSE_PS_AP_VENDOR a on cast(v.PAYABLE_VENDOR_NBR as bigint) = cast(a.AP_VENDOR_NBR as bigint)
WHERE    v.VENDOR_TYPE = 'V'
AND      b.VENDOR_TYPE = 'B'
AND      v.STATUS not in ('D', 'Z')
;

grant select on CRMADMIN.V_WEB_VENDOR to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_VENDOR to user ETL;
grant select on CRMADMIN.V_WEB_VENDOR to user ETL with grant option;
grant select on CRMADMIN.V_WEB_VENDOR to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_MASTERBROKER
----------------------------------------------------------------------------------------------------
create or replace view crmadmin.v_web_masterbroker  
as  
SELECT   MSTRBKR_NUMBER,
         MSTRBKR_NAME,
         MSTRBKR_STATUS
FROM     CRMADMIN.T_WHSE_VENDOR_MASTERBROKER
;

grant select on CRMADMIN.V_WEB_MASTERBROKER to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_MASTERBROKER to user ETL;
grant select,update,insert,delete on CRMADMIN.V_WEB_MASTERBROKER to user ETL with grant option;
grant select on CRMADMIN.V_WEB_MASTERBROKER to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_AP_VENDOR
----------------------------------------------------------------------------------------------------
create or replace view crmadmin.v_web_ap_vendor  as  
SELECT   AP_VENDOR_NBR,
         AP_VENDOR_1_NM as AP_VENDOR_NM,
         STREET_1_ADR as STREET1_ADR,
         STREET_2_ADR as STREET2_ADR,
         CITY_NM,
         STATE_CD,
         ZIP_CD,
         NO_CHRG_VENDOR_FLG,
         VENDOR_STATUS
FROM     CRMADMIN.T_WHSE_PS_AP_VENDOR
;

grant select on CRMADMIN.V_WEB_AP_VENDOR to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_AP_VENDOR to user ETL;
grant select,update,insert,delete on CRMADMIN.V_WEB_AP_VENDOR to user ETL with grant option;
grant select on CRMADMIN.V_WEB_AP_VENDOR to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_BUYER
----------------------------------------------------------------------------------------------------
create or replace view crmadmin.v_web_buyer  as  
SELECT   u.BUYER_NBR,
         u.LAST_NAME,
         u.FIRST_NAME
FROM     CRMADMIN.T_WHSE_USER u 
WHERE    u.BUYER_NBR is not null
;

grant select on crmadmin.v_web_buyer to user CRMEXPLN;
grant control on crmadmin.v_web_buyer to user ETL;
grant select,update,insert,delete on crmadmin.v_web_buyer to user ETL with grant option;
grant select on crmadmin.v_web_buyer to user WEB;

----------------------------------------------------------------------------------------------------
-- Create View CRMADMIN.V_WEB_CAT_MANAGER
----------------------------------------------------------------------------------------------------
create or replace view crmadmin.v_web_cat_manager  as  
SELECT   cm.CATEGORY_MANAGER_CD,
         cm.EMP_ID,
         cm.FIRST_NAME,
         cm.LAST_NAME
FROM     CRMADMIN.T_WHSE_CATEGORY_MGR cm
WHERE    cm.STATUS_CD = 'A'
;

grant select on crmadmin.v_web_cat_manager to user CRMEXPLN;
grant control on crmadmin.v_web_cat_manager to user ETL;
grant select,update,insert,delete on crmadmin.v_web_cat_manager to user ETL with grant option;
grant select on crmadmin.v_web_cat_manager to user WEB;

----------------------------------------------------------------------------------------------------
-- Grant Authorities for CRMADMIN.V_WEB_CAT_MANAGER_CLASS
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CAT_MANAGER_CLASS
as
SELECT   cm.CATEGORY_MANAGER_CD,
         cm.FIRST_NAME,
         cm.LAST_NAME,
         cm.EMP_ID,
         cmc.MDSE_CLASS_CD,
         mcls.MDSE_CLS_CODE_DESC,
         mcls.MDSE_CAT_CODE
FROM     CRMADMIN.T_WHSE_CATEGORY_MGR cm 
         inner join CRMADMIN.T_WHSE_CATEGORY_MGR_CLASS cmc on cm.CATEGORY_MANAGER_CD = cmc.CATEGORY_MANAGER_CD 
         inner join ETLADMIN.T_MDM_MDSE_CLS mcls on cmc.MDSE_CLASS_CD = mcls.MDSE_CLS_CODE
WHERE    cm.STATUS_CD = 'A'
;

grant select on CRMADMIN.V_WEB_CAT_MANAGER_CLASS to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_CAT_MANAGER_CLASS to user ETL;
grant select on CRMADMIN.V_WEB_CAT_MANAGER_CLASS to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_WEB_CAT_MANAGER_CLASS to user ETL with grant option;
grant select on CRMADMIN.V_WEB_CAT_MANAGER_CLASS to user WEB;

