SELECT   PURCH_STATUS,
         BILLING_STATUS,
         BILLING_STATUS_BACKSCREEN,
         AVAILABILITY_CODE,
         case 
              when NATAG_MAINT_DATE > current date - 60 days then 'D' 
              else 'A' 
         end filter,
--         NATAG_MAINT_DATE,
         count(*)
FROM     CRMADMIN.V_WEB_ITEM_CORE
WHERE    FACILITYID = '058'
--AND      NATAG_MAINT_DATE is not null
GROUP BY PURCH_STATUS, BILLING_STATUS, BILLING_STATUS_BACKSCREEN, 
         AVAILABILITY_CODE, 
         case when NATAG_MAINT_DATE > current date - 60 days then 'D' else 'A' end
--,         NATAG_MAINT_DATE