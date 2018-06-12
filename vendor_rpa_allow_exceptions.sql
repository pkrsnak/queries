-- orphans
SELECT   case twi.RETAIL_DEPT 
              when '16' then 'GMS Exception' 
              when '17' then 'GMS Exception' 
              when '66' then 'GMS Exception' 
              when '67' then 'GMS Exception' 
              else 'Orphan' 
         end EXCEPTION_TYPE,
         twa.FACILITYID,
         twa.ITEM_NBR_HS,
         twi.ITEM_DESCRIP,
         twi.ITEM_DEPT,
         twi.PRODUCT_GROUP,
         pg.PROD_GROUP_DESC,
         twi.RETAIL_DEPT,
         twi.STOCK_FAC,
         case twa.ALLOW_TYPE when 'RPA' then 'Customer Reflect' when 'VENDRPA' then 'Vendor Contract' else 'Other' end allowance_type,
         twa.ALLOW_CUST_GRP,
         twa.ALLOW_DATE_EFF,
         twa.ALLOW_DATE_EXP,
         case twa.ALLOW_TYPE 
              when 'RPA' then twa.ALLOW_AMT 
              else 0 
         end reflect_allow_amt,
         case twa.ALLOW_TYPE 
              when 'VENDRPA' then twa.ALLOW_AMT 
              else 0 
         end contract_allow_amt,
         twa.ALLOW_STATUS,
         twa.REF_HS,
         twa.STATUS,
         twa.CONTRACT_ID,
         twa.CONTRACT_STATUS,
         twa.CONTRACT_DEAL_STATUS,
         twa.CONTRACT_ITEM_STATUS,
         twa.CONTRACT_CREATE_DATE,
         twa.CONTRACT_UPDATE_DATE,
         twa.DEAL_ID,
         twa.DEAL_TYPE_ID,
         twa.CORP_ONLY_FLG,
         twa.CORP_AD_DATE,
         twa.IDPT_AD_DATE,
         twa.OFFER,
         trim(merch.LAST_NAME) || ', ' || trim(merch.FIRST_NAME) MERCHANDISER
FROM     CRMADMIN.T_WHSE_ALLOWANCES twa 
         inner join CRMADMIN.T_WHSE_ITEM twi on twa.FACILITYID = twi.FACILITYID and twa.ITEM_NBR_HS = twi.ITEM_NBR_HS inner join CRMADMIN.T_WHSE_PROD_GROUP pg on twi.FACILITYID = pg.FACILITY and twi.PRODUCT_GROUP = pg.PROD_GROUP
         left outer join (SELECT psg.FACILITY, psg.PROD_GROUP, psg.PROD_SUBGROUP, psg.NMC_MERCH, psg.PL_MERCH, wu.LAST_NAME, wu.FIRST_NAME FROM CRMADMIN.T_WHSE_PROD_SUBGROUP psg 
         inner join CRMADMIN.T_WHSE_USER wu on psg.NMC_MERCH = wu.USERID) merch on twi.FACILITYID = merch.FACILITY and twi.PRODUCT_GROUP = merch.PROD_GROUP and twi.PRODUCT_SUB_GROUP = merch.PROD_SUBGROUP
WHERE    twa.ALLOW_TYPE in ('RPA', 'VENDRPA')
AND      twa.ALLOW_DATE_EFF between '2014-09-06' and '2014-10-04'
AND      twa.FACILITYID in ('058', '059', '008', '054')
AND      twa.STATUS = 'A'
AND      (twa.FACILITYID, twa.ITEM_NBR_HS, twa.ALLOW_DATE_EFF, twa.ALLOW_DATE_EXP) in (SELECT FACILITYID, ITEM_NBR_HS, ALLOW_DATE_EFF, ALLOW_DATE_EXP FROM CRMADMIN.T_WHSE_ALLOWANCES WHERE ALLOW_TYPE in ('RPA', 'VENDRPA')
     AND ALLOW_DATE_EFF between '2014-09-06' and '2014-10-04'
     AND twa.FACILITYID in ('058', '059', '008', '054')
     AND STATUS = 'A' GROUP BY FACILITYID, ITEM_NBR_HS, ALLOW_DATE_EFF, ALLOW_DATE_EXP HAVING count(*) = 1)

union all

-- amount differences
SELECT   'Amount Exception' EXCEPTION_TYPE,
         twa.FACILITYID,
         twa.ITEM_NBR_HS,
         twi.ITEM_DESCRIP,
         twi.ITEM_DEPT,
         twi.PRODUCT_GROUP,
         pg.PROD_GROUP_DESC,
         twi.RETAIL_DEPT,
         twi.STOCK_FAC,
         case twa.ALLOW_TYPE when 'RPA' then 'Customer Reflect' when 'VENDRPA' then 'Vendor Contract' else 'Other' end allowance_type,
         twa.ALLOW_CUST_GRP,
         twa.ALLOW_DATE_EFF,
         twa.ALLOW_DATE_EXP,
         vendrpa.ALLOW_AMT reflect_allow_amt,
         twa.ALLOW_AMT contract_allow_amt,
         twa.ALLOW_STATUS,
         twa.REF_HS,
         twa.STATUS,
         twa.CONTRACT_ID,
         twa.CONTRACT_STATUS,
         twa.CONTRACT_DEAL_STATUS,
         twa.CONTRACT_ITEM_STATUS,
         twa.CONTRACT_CREATE_DATE,
         twa.CONTRACT_UPDATE_DATE,
         twa.DEAL_ID,
         twa.DEAL_TYPE_ID,
         twa.CORP_ONLY_FLG,
         twa.CORP_AD_DATE,
         twa.IDPT_AD_DATE,
         twa.OFFER,
         trim(merch.LAST_NAME) || ', ' || trim(merch.FIRST_NAME) MERCHANDISER
FROM     CRMADMIN.T_WHSE_ALLOWANCES twa 
         inner join CRMADMIN.T_WHSE_ITEM twi on twa.FACILITYID = twi.FACILITYID and twa.ITEM_NBR_HS = twi.ITEM_NBR_HS inner join CRMADMIN.T_WHSE_PROD_GROUP pg on twi.FACILITYID = pg.FACILITY and twi.PRODUCT_GROUP = pg.PROD_GROUP 
         inner join (SELECT twa.FACILITYID, twa.ITEM_NBR_HS, twa.ALLOW_DATE_EFF, twa.ALLOW_DATE_EXP, twa.ALLOW_AMT FROM CRMADMIN.T_WHSE_ALLOWANCES twa 
         inner join CRMADMIN.T_WHSE_ITEM twi on twa.FACILITYID = twi.FACILITYID and twa.ITEM_NBR_HS = twi.ITEM_NBR_HS WHERE twa.ALLOW_TYPE in ('RPA') AND twa.ALLOW_DATE_EFF > current date - 20 days AND twa.FACILITYID in ('058', '059', '008', '054')
 AND twa.STATUS = 'A' GROUP BY twa.FACILITYID, twa.ITEM_NBR_HS, twa.ALLOW_DATE_EFF, twa.ALLOW_DATE_EXP, twa.ALLOW_AMT) vendrpa on twa.FACILITYID = vendrpa.FACILITYID and twa.ITEM_NBR_HS = vendrpa.ITEM_NBR_HS and twa.ALLOW_DATE_EFF = vendrpa.ALLOW_DATE_EFF and twa.ALLOW_DATE_EXP = vendrpa.ALLOW_DATE_EXP
         left outer join (SELECT psg.FACILITY, psg.PROD_GROUP, psg.PROD_SUBGROUP, psg.NMC_MERCH, psg.PL_MERCH, wu.LAST_NAME, wu.FIRST_NAME FROM CRMADMIN.T_WHSE_PROD_SUBGROUP psg 
         inner join CRMADMIN.T_WHSE_USER wu on psg.NMC_MERCH = wu.USERID) merch on twi.FACILITYID = merch.FACILITY and twi.PRODUCT_GROUP = merch.PROD_GROUP and twi.PRODUCT_SUB_GROUP = merch.PROD_SUBGROUP
WHERE    twa.ALLOW_TYPE in ('VENDRPA')
AND      twa.ALLOW_DATE_EFF between '2014-09-06' and '2014-10-04'
AND      twa.FACILITYID in ('058', '059', '008', '054')
AND      twa.STATUS = 'A'
AND      twa.ALLOW_AMT <> vendrpa.ALLOW_AMT

