--from legacy systems
--CRM 
SELECT   'CRM_ALLOWANCE' deal_source,
         'RPA - PA' deal_type,
         a.FACILITYID,
         a.ITEM_NBR_HS,
         char(a.DEAL_ID) DEAL_NBR,
         a.ALLOW_DATE_EFF,
         a.ALLOW_DATE_EXP,
         a.ALLOW_AMT
FROM     CRMADMIN.T_WHSE_ALLOWANCES a 
WHERE    a.ALLOW_TYPE = 'VENDRPA' and a.STATUS = 'A'  and a.CONTRACT_STATUS = 'A' and a.CONTRACT_DEAL_STATUS = 'A' and a.CONTRACT_ITEM_STATUS = 'A'
AND      a.ALLOW_DATE_EFF >= current date
AND      a.FACILITYID not in ('061', '062', '009', '059')

union all

SELECT   'BICEPS_DEAL' deal_source,
         'OI_LEGACY' deal_source,
         d.FACILITYID,
         i.ITEM_NBR_HS,
         char(d.DEAL_NBR) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_OI DEAL_AMT
FROM     CRMADMIN.T_WHSE_DEAL d 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = d.FACILITYID and i.ITEM_NBR_CD = d.ITEM_NBR
WHERE    d.DATE_START > current date
AND      d.AMT_OI > 0
AND      not(d.DEAL_NBR between 560001 and 800000)

union all

SELECT   'BICEPS_DEAL' deal_source,
         'BBACK_LEGACY' deal_type,
         d.FACILITYID,
         i.ITEM_NBR_HS,
         char(d.DEAL_NBR) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_BBACK DEAL_AMT
FROM     CRMADMIN.T_WHSE_DEAL d 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = d.FACILITYID and i.ITEM_NBR_CD = d.ITEM_NBR
WHERE    d.DATE_START > current date
AND      d.AMT_BBACK > 0
AND      not(d.DEAL_NBR between 560001 and 800000) 

union all

--from Acoustic
SELECT   'BICEPS_DEAL' deal_source,
         'OI_ACOUSTIC' deal_type,
         d.FACILITYID,
         i.ITEM_NBR_HS,
         char(d.DEAL_NBR) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_OI DEAL_AMT
FROM     CRMADMIN.T_WHSE_DEAL d 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = d.FACILITYID and i.ITEM_NBR_CD = d.ITEM_NBR
WHERE    d.DATE_START > current date
AND      d.AMT_OI > 0
AND      d.DEAL_NBR between 560001 and 800000

union all

SELECT   'BICEPS_DEAL' deal_source,
         'BBACK_ACOUSTIC' deal_type,
         d.FACILITYID,
         i.ITEM_NBR_HS,
         char(d.DEAL_NBR) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_BBACK DEAL_AMT
FROM     CRMADMIN.T_WHSE_DEAL d 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = d.FACILITYID and i.ITEM_NBR_CD = d.ITEM_NBR
WHERE    d.DATE_START > current date
AND      d.AMT_BBACK > 0
AND      d.DEAL_NBR between 560001 and 800000
;


--SNOWFLAKE EDW - Acoustic Deals
SELECT   'ACOUSTIC' deal_source,
         d.PERFORMANCE_TYPE deal_type,
         d.FACILITY_ID FACILITYID,
         d.ITEM_NBR ITEM_NBR_HS,
         d.DEAL_NBR DEAL_NBR,
         d.PERFORMANCE_START_TMSP DATE_START,
         d.PERFORMANCE_END_TMSP DATE_END,
         d.PRICE_AMT1 DEAL_AMT --, d.PRICE_AMT2, d.PRICE_AMT3
FROM     PROMOS.MAIN_DEAL_MANAGEMENT d
WHERE    d.PERFORMANCE_START_TMSP > getdate()
AND      d.PRICE_AMT1 > 0
