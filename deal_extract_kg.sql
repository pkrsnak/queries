SELECT   edb.FACILITYID,
         edb.CUSTOMER_NBR_STND,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         i.ITEM_DEPT,
         cm.CATEGORY_MANAGER_CD,
         cm.LAST_NAME,
         cm.FIRST_NAME,
         edb.UPC_UNIT_CD,
         edb.ITEM_NBR_HS,
         edb.DESCRIPTION,
         edb.ALLOW_DATE_EFF,
         edb.ALLOW_DATE_EXP,
         edb.ALLOW_AMT,
         edb.ALLOW_TYPE
FROM     EDIADMIN.V_EDI_DEAL_BASE edb 
         inner join CRMADMIN.T_WHSE_ITEM i on edb.FACILITYID = i.FACILITYID and edb.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on v.FACILITYID = i.FACILITYID and v.VENDOR_NBR = i.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CAT_MANAGER_CLASS cm on i.MERCH_CLASS = cm.MDSE_CLASS_CD
WHERE    edb.FACILITYID = '054'
AND      edb.CUSTOMER_NBR_STND = 167515
AND      edb.CORP_AUTH_FLG = 'Y'
AND      edb.BILLING_STATUS_BACKSCREEN in ('A', 'W', 'S')
AND      edb.ITEM_TYPE_CD not in ('I')
AND      edb.INSITE_FLG = 'N'
AND      edb.ALLOW_DATE_EXP >= current date
AND      edb.ITEM_AUTH_FLG = 'Y'
AND      edb.PRIVATE_BRAND_AUTH_FLG = 'Y';