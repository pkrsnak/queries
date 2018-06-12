
-- salesforce customer data
SELECT   cf.FACILITYID AS Facility,
         cf.HOME_BRANCH AS PRIMARY,
         cf.TERRITORY_NO AS Territory,
         cf.CUSTOMER_NBR_STND AS CustomerNumber,
         cf.CUST_STORE_NO AS StoreNumber,
         cf.NAME AS NAME,
         cf.ADDRESS1 AS ShippingStreet,
         cf.CITY AS ShippingCity,
         cf.STATE_CD AS ShippingState,
         cf.ZIP_CD AS ShippingPostalCode,
         cf.BILL_TO_ADDRESS1 AS BillingStreet,
         cf.BILL_TO_CITY AS BillingCity,
         cf.BILL_TO_STATE AS BillingState,
         cf.BILL_TO_ZIP_CDE AS BillingPostalCode,
         cf.BILL_TO_PHONE_NBR AS Phone,
         cf.BILL_TO_FAX_NBR AS Fax,
         cf.MDM_CUSTOMER_FLAG,
         cf.FEDERAL_ID_NO AS FederalTaxID,
         trim(cf.STORE_LICENSE_ID) as STORE_LICENSE_ID,
         trim(cf.STORE_CIGARETTE_TAX_ID) AS CigaretteLicense,
         trim(cf.STORE_TOBACCO_TAX_ID) as STORE_TOBACCO_TAX_ID,
         cf.BILLABLE_FLAG AS Billable,
         cf.TIME_ZONE_CUST AS Timezone,
         cf.MDM_CUST_STATUS_CD AS STATUS,
         trim(cd.RETAIL_REP_EMAIL) AS SalesRepEmail,
         trim(cf.STATE_SLS_ID_NO) AS StateTaxID
FROM     CRMADMIN.V_WEB_CUSTOMER_FAC cf 
         LEFT OUTER JOIN CRMADMIN.V_WEB_CUSTOMER_DEPT_REP cd ON cd.CUSTOMER_NO_FULL = cf.CUSTOMER_NO_FULL and cd.FACILITYID = cf.FACILITYID and RETAIL_REP_TYPE = 1 where cf.MEMBERSHIP_KEY not in ('E', 'C')
and cf.UPSTREAM_DC_TYP_CD = 'D'
;






SELECT cf.FACILITYID,  cf.MEMBERSHIP_KEY,
         cf.MEMBERSHIP_DESC,
         count(*)
FROM     CRMADMIN.V_WEB_CUSTOMER_FAC cf
GROUP BY cf.FACILITYID, cf.MEMBERSHIP_KEY, cf.MEMBERSHIP_DESC
;

SELECT   CustomerNumber,
         count(*)
from (
SELECT   cf.FACILITYID AS Facility,
         cf.HOME_BRANCH AS PRIMARY,
         cf.TERRITORY_NO AS Territory,
         cf.CUSTOMER_NBR_STND AS CustomerNumber,
         cf.CUST_STORE_NO AS StoreNumber,
         cf.NAME AS NAME,
         cf.ADDRESS1 AS ShippingStreet,
         cf.CITY AS ShippingCity,
         cf.STATE_CD AS ShippingState,
         cf.ZIP_CD AS ShippingPostalCode,
         cf.BILL_TO_ADDRESS1 AS BillingStreet,
         cf.BILL_TO_CITY AS BillingCity,
         cf.BILL_TO_STATE AS BillingState,
         cf.BILL_TO_ZIP_CDE AS BillingPostalCode,
         cf.BILL_TO_PHONE_NBR AS Phone,
         cf.BILL_TO_FAX_NBR AS Fax,
         cf.MDM_CUSTOMER_FLAG,
         cf.FEDERAL_ID_NO AS FederalTaxID,
         trim(cf.STORE_LICENSE_ID) as STORE_LICENSE_ID,
         trim(cf.STORE_CIGARETTE_TAX_ID) AS CigaretteLicense,
         trim(cf.STORE_TOBACCO_TAX_ID) as STORE_TOBACCO_TAX_ID,
         cf.BILLABLE_FLAG AS Billable,
         cf.TIME_ZONE_CUST AS Timezone,
         cf.MDM_CUST_STATUS_CD AS STATUS,
         trim(cd.RETAIL_REP_EMAIL) AS SalesRepEmail,
         trim(cf.STATE_SLS_ID_NO) AS StateTaxID
FROM     CRMADMIN.V_WEB_CUSTOMER_FAC cf 
         LEFT OUTER JOIN CRMADMIN.V_WEB_CUSTOMER_DEPT_REP cd ON cd.CUSTOMER_NO_FULL = cf.CUSTOMER_NO_FULL and cd.FACILITYID = cf.FACILITYID and RETAIL_REP_TYPE = 1 where cf.MEMBERSHIP_KEY not in ('E', 'C')
and cf.UPSTREAM_DC_TYP_CD = 'D'
)
group by CustomerNumber
         
having count(*) > 1
;

select * from CRMADMIN.T_WHSE_CUST_REP_MDM rep where rep.RETAIL_REP_TYPE = 1 and rep.CUSTOMER_NO_FULL in
(select CUSTOMER_NO_FULL
from
(
SELECT   rep.CUSTOMER_NO_FULL,
         rep.RETAIL_REP_KEY
FROM     CRMADMIN.T_WHSE_CUST_REP_MDM rep
WHERE    rep.ACTIVE = 'Y'
AND      rep.RETAIL_REP_TYPE = 1
group by rep.CUSTOMER_NO_FULL,
         rep.RETAIL_REP_KEY)
group by CUSTOMER_NO_FULL
having count(*) > 1
);

