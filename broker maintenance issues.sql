SELECT   wv.MASTER_BROKER,
         wv.MSTRBKR_NAME,
         wv.BROKER_NBR,
         wv.BROKER_NAME,
         wv.VENDOR_NBR,
         wv.VENDOR_NAME,
         wv.BROKER_ADDRESS_1,
         wv.BROKER_ADDRESS_2,
         wv.BROKER_CITY,
         wv.BROKER_STATE,
         wv.BROKER_ZIP,
         wv.BROKER_PHONE,
         wv.BROKER_CONTACT,
         wv.BROKER_FAX_1,
         wv.BROKER_FAX_2,
         wv.FACILITY,
         wv.FACILITY_NAME,
         wv.BUYER_NBR,
         wv.BUYER_NAME,
         wv.WAREHOUSE_CODE_X,
         wv.WAREHOUSE_CODE_DESC,
         wv.AP_VENDOR_NBR,
         wv.AP_VENDOR_NAME,
         wv.NO_CHRG_VENDOR_FLG,
         trim(cmr.LAST_NAME) || ', ' || trim(cmr.FIRST_NAME) cat_manager,
         count(i.ITEM_NBR_HS) num_items
FROM     CRMADMIN.V_WEB_VENDOR wv 
         inner join CRMADMIN.T_WHSE_ITEM i on wv.FACILITY = i.FACILITYID and wv.VENDOR_NBR = i.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CAT_MANAGER_CLASS cmr on i.MERCH_CLASS = cmr.MDSE_CLASS_CD
WHERE    i.PURCH_STATUS not in ('D', 'Z')
GROUP BY wv.MASTER_BROKER, wv.MSTRBKR_NAME, wv.BROKER_NBR, wv.BROKER_NAME, 
         wv.VENDOR_NBR, wv.VENDOR_NAME, wv.BROKER_ADDRESS_1, 
         wv.BROKER_ADDRESS_2, wv.BROKER_CITY, wv.BROKER_STATE, wv.BROKER_ZIP, 
         wv.BROKER_PHONE, wv.BROKER_CONTACT, wv.BROKER_FAX_1, wv.BROKER_FAX_2, 
         wv.FACILITY, wv.FACILITY_NAME, wv.BUYER_NBR, wv.BUYER_NAME, 
         wv.WAREHOUSE_CODE_X, wv.WAREHOUSE_CODE_DESC, wv.AP_VENDOR_NBR, 
         wv.AP_VENDOR_NAME, wv.NO_CHRG_VENDOR_FLG, 
         trim(cmr.LAST_NAME) || ', ' || trim(cmr.FIRST_NAME);



SELECT   wv.MASTER_BROKER,
         wv.MSTRBKR_NAME,
         wv.BROKER_NAME,
         wv.VENDOR_NBR,
         wv.VENDOR_NAME,
         wv.BROKER_ADDRESS_1,
         wv.BROKER_ADDRESS_2,
         wv.BROKER_CITY,
         wv.BROKER_STATE,
         wv.BROKER_ZIP,
         wv.BROKER_PHONE,
         wv.BROKER_CONTACT,
         wv.BROKER_FAX_1,
         wv.BROKER_FAX_2,
         wv.FACILITY,
         wv.FACILITY_NAME,
         wv.BUYER_NBR,
         wv.BUYER_NAME,
         wv.WAREHOUSE_CODE_X,
         wv.WAREHOUSE_CODE_DESC,
         wv.AP_VENDOR_NBR,
         wv.AP_VENDOR_NAME,
         wv.NO_CHRG_VENDOR_FLG
--         trim(cmr.LAST_NAME) || ', ' || trim(cmr.FIRST_NAME) cat_manager
FROM     CRMADMIN.V_WEB_VENDOR wv 
--         inner join CRMADMIN.T_WHSE_ITEM i on wv.FACILITY = i.FACILITYID and wv.VENDOR_NBR = i.VENDOR_NBR 
--         inner join CRMADMIN.V_WEB_CAT_MANAGER_CLASS cmr on i.MERCH_CLASS = cmr.MDSE_CLASS_CD
--where i.PURCH_STATUS not in ('D', 'Z')
;