--overlapping dates
with tbl1 as (
Select FACILITYID, ITEM_NBR_HS ,  ALLOW_DATE_EFF , ALLOW_DATE_EXP 
from CRMADMIN.T_WHSE_ALLOWANCES
where ALLOW_TYPE = 'VENDRPA'
 and STATUS = 'A' and ALLOW_DATE_EFF >= current date 
order by FACILITYID, ITEM_NBR_HS ,  ALLOW_DATE_EFF , ALLOW_DATE_EXP
),
tbl2 as
(SELECT   Distinct t1.FACILITYID,
         t1.ITEM_NBR_HS,
         t1.ALLOW_DATE_EFF,
         t1.ALLOW_DATE_EXP
FROM     tbl1 t1 
         inner join tbl1 t2 on t1.FACILITYID = t1.FACILITYID and t1.ITEM_NBR_HS = t2.ITEM_NBR_HS and t1.ALLOW_DATE_EFF <> t2.ALLOW_DATE_EFF and t1.ALLOW_DATE_EXP <> t2.ALLOW_DATE_EXP and (t1.ALLOW_DATE_EFF >= t2.ALLOW_DATE_EFF and t1.ALLOW_DATE_EFF <= t2.ALLOW_DATE_EXP)
)
SELECT   'Overlapping Dates' EXCEPTION_TYPE,
         a.FACILITYID,
         i.ITEM_DEPT,
         a.ITEM_NBR,
         a.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE_DESCRIP,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
--         a.ALLOW_TYPE,
--         a.ALLOW_DESC,
--         a.ALLOW_CUST_GRP,
         a.ALLOW_DATE_EFF,
         a.ALLOW_DATE_EXP,
         a.ALLOW_AMT,
         a.ALLOW_STATUS,
         a.ALLOW_SRC,
--         a.REF_HS,
--         a.START_DATE,
--         a.END_DATE,
         a.STATUS,
--         a.PROCESS_USER,
--         a.PROCESS_TYPE,
--         a.CREATE_TIMESTAMP,
--         a.PROCESS_TIMESTAMP,
         a.CONTRACT_ID,
         a.CONTRACT_STATUS,
         a.CONTRACT_DEAL_STATUS,
         a.CONTRACT_ITEM_STATUS,
         a.CONTRACT_CREATE_DATE,
         a.CONTRACT_UPDATE_DATE,
         a.DEAL_ID,
--         a.DEAL_TYPE_ID,
--         a.CORP_ONLY_FLG,
--         a.CORP_AD_DATE,
--         a.IDPT_AD_DATE,
         a.OFFER
FROM     CRMADMIN.T_WHSE_ALLOWANCES a 
         inner join CRMADMIN.T_WHSE_ITEM i on a.FACILITYID = i.FACILITYID and a.ITEM_NBR_HS = i.ITEM_NBR_HS
WHERE    a.ALLOW_TYPE = 'VENDRPA' and a.STATUS = 'A'
AND      a.ALLOW_DATE_EFF >= current date
AND      (a.FACILITYID, a.ITEM_NBR_HS ) in (select distinct t1.FACILITYID, t1.ITEM_NBR_HS from tbl2 t1)
;
union all
;
--duplicate date range
with tbl3 as 
(
Select FACILITYID, ITEM_NBR_HS ,  ALLOW_DATE_EFF , ALLOW_DATE_EXP 
from CRMADMIN.T_WHSE_ALLOWANCES
where ALLOW_TYPE = 'VENDRPA'
 and STATUS = 'A' and ALLOW_DATE_EFF >= current date 
group by FACILITYID, ITEM_NBR_HS ,  ALLOW_DATE_EFF , ALLOW_DATE_EXP 
having count(*) > 1
)

SELECT   'Duplicate Date Range' EXCEPTION_TYPE,
         a.FACILITYID,
         i.ITEM_DEPT,
         a.ITEM_NBR,
         a.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE_DESCRIP,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
--         a.ALLOW_TYPE,
--         a.ALLOW_DESC,
--         a.ALLOW_CUST_GRP,
         a.ALLOW_DATE_EFF,
         a.ALLOW_DATE_EXP,
         a.ALLOW_AMT,
         a.ALLOW_STATUS,
         a.ALLOW_SRC,
--         a.REF_HS,
--         a.START_DATE,
--         a.END_DATE,
         a.STATUS,
--         a.PROCESS_USER,
--         a.PROCESS_TYPE,
--         a.CREATE_TIMESTAMP,
--         a.PROCESS_TIMESTAMP,
         a.CONTRACT_ID,
         a.CONTRACT_STATUS,
         a.CONTRACT_DEAL_STATUS,
         a.CONTRACT_ITEM_STATUS,
         a.CONTRACT_CREATE_DATE,
         a.CONTRACT_UPDATE_DATE,
         a.DEAL_ID,
--         a.DEAL_TYPE_ID,
--         a.CORP_ONLY_FLG,
--         a.CORP_AD_DATE,
--         a.IDPT_AD_DATE,
         a.OFFER
FROM     CRMADMIN.T_WHSE_ALLOWANCES a 
         inner join CRMADMIN.T_WHSE_ITEM i on a.FACILITYID = i.FACILITYID and a.ITEM_NBR_HS = i.ITEM_NBR_HS
WHERE    a.ALLOW_TYPE = 'VENDRPA' and a.STATUS = 'A'
AND      a.ALLOW_DATE_EFF >= current date
AND      (a.FACILITYID, a.ITEM_NBR_HS, a.ALLOW_DATE_EFF, a.ALLOW_DATE_EXP) in (select distinct t1.FACILITYID, t1.ITEM_NBR_HS,  t1.ALLOW_DATE_EFF, t1.ALLOW_DATE_EXP from tbl3 t1)


;