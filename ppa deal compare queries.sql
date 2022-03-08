--from legacy systems
--CRM 
SELECT   'CRM_ALLOWANCE' deal_source,
         'RPA - PA' deal_type,
         a.FACILITYID, --cmc.CATEGORY_MANAGER_CD, 
         cmc.FIRST_NAME || ' ' ||cmc.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE, i.UPC_UNIT, i.ITEM_DESCRIP, i.PACK_CASE, i.ITEM_SIZE_UOM, case value(i.ITEM_RES33, ' ') when ' ' then 'N' else i.ITEM_RES33 end PRESELL_FLG,
         char(a.DEAL_ID) DEAL_NBR,
         a.ALLOW_DATE_EFF,
         a.ALLOW_DATE_EXP,
         a.ALLOW_AMT
FROM     CRMADMIN.T_WHSE_ALLOWANCES a 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = a.FACILITYID and i.ITEM_NBR_HS = a.ITEM_NBR_HS
         inner join CRMADMIN.V_WEB_CAT_MANAGER_CLASS cmc on cmc.MDSE_CLASS_CD = i.MERCH_CLASS
WHERE    a.ALLOW_TYPE in 'VENDRPA' and a.STATUS = 'A'  and a.CONTRACT_STATUS = 'A' and a.CONTRACT_DEAL_STATUS = 'A' and a.CONTRACT_ITEM_STATUS = 'A'
AND      a.ALLOW_DATE_EXP >= '2022-04-17'
AND      a.FACILITYID not in ('061', '062', '009', '059')

union all

--CRM 
SELECT   'CRM_ALLOWANCE' deal_source,
         'RPA - PA' deal_type,
         a.FACILITYID, --cmc.CATEGORY_MANAGER_CD, 
         cmc.FIRST_NAME || ' ' ||cmc.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE, i.UPC_UNIT, i.ITEM_DESCRIP, i.PACK_CASE, i.ITEM_SIZE_UOM, case value(i.ITEM_RES33, ' ') when ' ' then 'N' else i.ITEM_RES33 end PRESELL_FLG,
         char(a.DEAL_ID) DEAL_NBR,
         a.ALLOW_DATE_EFF,
         a.ALLOW_DATE_EXP,
         a.ALLOW_AMT
FROM     CRMADMIN.T_WHSE_ALLOWANCES a 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = a.FACILITYID and i.ITEM_NBR_HS = a.ITEM_NBR_HS
         inner join CRMADMIN.V_WEB_CAT_MANAGER_CLASS cmc on cmc.MDSE_CLASS_CD = i.MERCH_CLASS
WHERE    a.ALLOW_TYPE in 'PA' and a.STATUS = 'A'  --and a.CONTRACT_STATUS = 'A' and a.CONTRACT_DEAL_STATUS = 'A' and a.CONTRACT_ITEM_STATUS = 'A'
AND      a.ALLOW_DATE_EXP >= '2022-04-17'
AND      a.FACILITYID = '001'
AND      a.MASTER_ITEM_FLG = 'Y'
AND      a.ALLOW_CUST_GRP = 0

union all

SELECT   'BICEPS_DEAL' deal_source,
         'OI_LEGACY' deal_source,
         d.FACILITYID, --cmc.CATEGORY_MANAGER_CD, 
         cmc.FIRST_NAME || ' ' ||cmc.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE, i.UPC_UNIT, i.ITEM_DESCRIP, i.PACK_CASE, i.ITEM_SIZE_UOM, case value(i.ITEM_RES33, ' ') when ' ' then 'N' else i.ITEM_RES33 end PRESELL_FLG,
         char(d.DEAL_NBR) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_OI DEAL_AMT
FROM     CRMADMIN.T_WHSE_DEAL d 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = d.FACILITYID and i.ITEM_NBR_CD = d.ITEM_NBR
         inner join CRMADMIN.V_WEB_CAT_MANAGER_CLASS cmc on cmc.MDSE_CLASS_CD = i.MERCH_CLASS
WHERE    d.DATE_END > '2022-04-17'
AND      d.AMT_OI > 0
AND      not(d.DEAL_NBR between 560001 and 800000)

union all

SELECT   'BICEPS_DEAL' deal_source,
         'BBACK_LEGACY' deal_type,
         d.FACILITYID, --cmc.CATEGORY_MANAGER_CD, 
         cmc.FIRST_NAME || ' ' ||cmc.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE, i.UPC_UNIT, i.ITEM_DESCRIP, i.PACK_CASE, i.ITEM_SIZE_UOM, case value(i.ITEM_RES33, ' ') when ' ' then 'N' else i.ITEM_RES33 end PRESELL_FLG,
         char(d.DEAL_NBR) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_BBACK DEAL_AMT
FROM     CRMADMIN.T_WHSE_DEAL d 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = d.FACILITYID and i.ITEM_NBR_CD = d.ITEM_NBR
         inner join CRMADMIN.V_WEB_CAT_MANAGER_CLASS cmc on cmc.MDSE_CLASS_CD = i.MERCH_CLASS
WHERE    d.DATE_END > '2022-04-17'
AND      d.AMT_BBACK > 0
AND      not(d.DEAL_NBR between 560001 and 800000) 

union all

--from Acoustic
SELECT   'BICEPS_DEAL' deal_source,
         'OI_ACOUSTIC' deal_type,
         d.FACILITYID, --cmc.CATEGORY_MANAGER_CD, 
         cmc.FIRST_NAME || ' ' ||cmc.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE, i.UPC_UNIT, i.ITEM_DESCRIP, i.PACK_CASE, i.ITEM_SIZE_UOM, case value(i.ITEM_RES33, ' ') when ' ' then 'N' else i.ITEM_RES33 end PRESELL_FLG,
         char(d.DEAL_NBR) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_OI DEAL_AMT
FROM     CRMADMIN.T_WHSE_DEAL d 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = d.FACILITYID and i.ITEM_NBR_CD = d.ITEM_NBR
         inner join CRMADMIN.V_WEB_CAT_MANAGER_CLASS cmc on cmc.MDSE_CLASS_CD = i.MERCH_CLASS
WHERE    d.DATE_END > '2022-04-17'
AND      d.AMT_OI > 0
AND      d.DEAL_NBR between 560001 and 800000

union all

SELECT   'BICEPS_DEAL' deal_source,
         'BBACK_ACOUSTIC' deal_type,
         d.FACILITYID, --cmc.CATEGORY_MANAGER_CD, 
         cmc.FIRST_NAME || ' ' ||cmc.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE, i.UPC_UNIT, i.ITEM_DESCRIP, i.PACK_CASE, i.ITEM_SIZE_UOM, case value(i.ITEM_RES33, ' ') when ' ' then 'N' else i.ITEM_RES33 end PRESELL_FLG,
         char(d.DEAL_NBR) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_BBACK DEAL_AMT
FROM     CRMADMIN.T_WHSE_DEAL d 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = d.FACILITYID and i.ITEM_NBR_CD = d.ITEM_NBR
         inner join CRMADMIN.V_WEB_CAT_MANAGER_CLASS cmc on cmc.MDSE_CLASS_CD = i.MERCH_CLASS
WHERE    d.DATE_END > '2022-04-17'
AND      d.AMT_BBACK > 0
AND      d.DEAL_NBR between 560001 and 800000

;



--Snowflake - from Kevin
SELECT   'ACOUSTIC_SNOWFLAKE' deal_source,
         CASE
              WHEN ma.EVENT_TYPE_SHORT_DESC like 'DSD%' THEN 'OI'
              WHEN ma.EVENT_TYPE_SHORT_DESC like 'PA%' THEN 'RPA'
              WHEN ma.EVENT_TYPE_SHORT_DESC like 'OI' THEN 'OI'
              ELSE 'Unknown'
         END as DEAL_TYPE,
         dm.FACILITY_ID, dm.CATEGORY_MANAGER,
         dm.ITEM_NBR, dm.UPC_CASE, dm.UPC_CONSUMER, dm.ITEM_DESC, dm.PACK_CNT, dm.PACK_SIZE, dm.SHIPPER_FLG as PRESELL_FLG,
         dm.OFFER_NBR,
         date(ma.EVENT_TYPE_START_TMSP) event_start,
         date(ma.EVENT_TYPE_END_TMSP) event_end,
         ma.EVENT_TYPE_AMT
FROM     EDW.PROMOS.MAIN_DEAL_MANAGEMENT dm
         INNER JOIN EDW.PROMOS.MAIN_ALLOWANCE ma ON dm.DM_MAIN_ID=ma.DM_MAIN_ID
--         inner join EDW.FD.FD_ITEM_VW fdi on fdi.FACILITY_ID = dm.FACILITY_ID and fdi.ITEM_NBR_HS_NUM = dm.ITEM_NBR
--FROM     EDW.PROMOS.MAIN_DEAL_MANAGEMENT dm
--         INNER JOIN EDW.PROMOS.MAIN_ALLOWANCE ma ON dm.DM_MAIN_ID=ma.DM_MAIN_ID
WHERE    ma.EVENT_TYPE_SHORT_DESC not in ('Scan', 'AF')
AND      ma.EVENT_TYPE_START_TMSP > sysdate()
AND      dm.DEAL_STATUS_CD ='PROCESS'
AND      dm.EXPORT_ACTION <> 'D'
AND      dm.ITEM_REMOVE_TMSP is null
AND      dm.FACILITY_ID not in ('DSD')
--and fdi.CURRENT_FLG = 1
;

--------------------------------------------
--JUNK--------------------------------------
--------------------------------------------


SELECT
dm.FACILITY_ID
,dm.ITEM_NBR
,dm.OFFER_NBR

,CASE
WHEN ma.EVENT_TYPE_SHORT_DESC like 'DSD%' THEN 'OI'
WHEN ma.EVENT_TYPE_SHORT_DESC like 'PA%' THEN 'RPA'
WHEN ma.EVENT_TYPE_SHORT_DESC like 'OI' THEN 'OI'
ELSE 'Unknown'
END as DEAL_TYPE
,ma.EVENT_TYPE_START_TMSP
,ma.EVENT_TYPE_END_TMSP
,ma.EVENT_TYPE_AMT
FROM
EDW_UAT.PROMOS.MAIN_DEAL_MANAGEMENT dm
INNER JOIN EDW_UAT.PROMOS.MAIN_ALLOWANCE ma
ON dm.DM_MAIN_ID=ma.DM_MAIN_ID
WHERE
ma.EVENT_TYPE_SHORT_DESC not in ('Scan', 'AF')
and ma.EVENT_TYPE_START_TMSP > sysdate()
and dm.DEAL_STATUS_CD ='PROCESS'
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
;
