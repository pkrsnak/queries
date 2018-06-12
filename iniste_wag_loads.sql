SELECT   c.CUSTOMER_NO_FULL,
         'ZZ' CUST_STORE_NO,
         c.FACILITYID,
         cp.CORP_NAME,
         c.NAME,
         c.STATE_CD,
         'PLK' as create_user_id,
         c.PROCESS_TIMESTAMP,
         'PLK' as UPDATE_USER_ID,
         c.PROCESS_TIMESTAMP as UPDATE_TMSP,
         'ETL'
FROM     CRMADMIN.T_WHSE_CUST c inner join CRMADMIN.T_WHSE_CORPORATION_MDM cp on c.FACILITYID = cp.FACILITYID and c.CUSTOMER_NBR_STND = cp.CUSTOMER_NBR_STND
where cp.ACTIVE = 'Y'
and c.STATUS_CD not in ('D', 'Z')
and c.FACILITYID = c.HOME_BRANCH;


SELECT   FACILITYID,
         TERRITORY_NO,
         CUSTOMER_NO,
         CUSTOMER_NO_FULL,
         CUSTOMER_NBR_CORP,
         CUSTOMER_NBR_STND,
         CUST_GRP_LINK_KEY,
         ACTIVE,
         GROUP_KEY,
         CNTRL_STORE_IND,
         GROUP_CD,
         GROUP_DESC,
         CORP_CODE,
         SITE_CD,
         LEGACY_GROUP_NBR,
         GROUP_TYPE_KEY,
         GROUP_TYPE_CD,
         GROUP_TYPE_DESC,
         GRP_TYP_ENROLL_KEY,
         GRP_TYP_ENROLL_DESC,
         CREATE_USER_ID,
         CREATE_TMSP,
         UPDATE_USER_ID,
         UPDATE_TMSP,
         'CRM' as AUDIT_SOURCE_ID
FROM     CRMADMIN.T_WHSE_CUST_GRP_MDM
;