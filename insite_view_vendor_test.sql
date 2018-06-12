create or replace view crmadmin.v_web_vendor_test
as   
SELECT   v.PAYABLE_VENDOR_NBR as AP_VENDOR_NBR,
         a.AP_VENDOR_NM as AP_VENDOR_NAME,
         a.NO_CHRG_VENDOR_FLG,
         b.MASTER_BROKER,
         m.MSTRBKR_NAME,
         b.BROKER_NBR,
         b.BROKER_NAME,
         b.BROKER_ADDRESS_1,
         b.BROKER_ADDRESS_2,
         b.BROKER_CITY,
         b.BROKER_STATE,
         b.BROKER_ZIP,
         b.BROKER_PHONE,
         b.BROKER_CONTACT,
         b.BROKER_FAX_1,
         b.BROKER_FAX_2,
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
         w.WAREHOUSE_CODE_DESC
FROM     CRMADMIN.T_WHSE_VENDOR v 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on v.FACILITYID = d.SWAT_ID
         left outer join (select   x.FACILITYID, trim(x.MASTER_BROKER) as MASTER_BROKER, x.VENDOR_NBR as BROKER_NBR, x.VENDOR_NAME as BROKER_NAME, x.ADDRESS_1 as BROKER_ADDRESS_1, x.ADDRESS_2 as BROKER_ADDRESS_2, x.city as BROKER_CITY, x.state as BROKER_STATE, x.ZIP as BROKER_ZIP, x.PHONE as BROKER_PHONE, x.CONTACT as BROKER_CONTACT, x.AFE_FAX_NUMBER as BROKER_FAX_1, x.AFE_FAX_NUMBER_2 as BROKER_FAX_2 from CRMADMIN.T_WHSE_VENDOR x inner join CRMADMIN.T_WHSE_DIV_XREF y on x.FACILITYID = y.SWAT_ID where x.VENDOR_TYPE = 'B' and y.active_flag = 'Y') b on v.BROKER_NUMBER = b.BROKER_NBR and v.FACILITYID = b.FACILITYID 
         left outer join CRMADMIN.V_WHSE_USER u on v.BUYER_NBR = u.BUYER_NBR 
         left outer join CRMADMIN.T_WHSE_WAREHOUSE_CODE w on v.WAREHOUSE_CODE_X = w.WAREHOUSE_CODE and v.FACILITYID = w.FACILITYID 
         left outer join CRMADMIN.T_WHSE_VENDOR_MASTERBROKER m on trim(b.MASTER_BROKER) = trim(m.MSTRBKR_NUMBER) 
         left outer join CRMADMIN.T_WHSE_PS_AP_VENDOR a on cast(trim(case v.PAYABLE_VENDOR_NBR when '' then 0 else v.PAYABLE_VENDOR_NBR end) as bigint) = cast(a.AP_VENDOR_NBR as bigint)
WHERE    v.VENDOR_TYPE = 'V'
AND      v.STATUS not in ('D', 'Z');


--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_WEB_VENDOR
--------------------------------------------------
grant select on CRMADMIN.V_WEB_VENDOR_TEST to user CRMEXPLN;
grant control on CRMADMIN.V_WEB_VENDOR_TEST to user ETL;
grant select on CRMADMIN.V_WEB_VENDOR_TEST to user ETL with grant option;
grant select on CRMADMIN.V_WEB_VENDOR_TEST to user WEB;