SELECT   'LEGACY' deal_source,
         'PA' deal_type,
         a.FACILITYID, 
         cm.FIRST_NAME || ' ' ||cm.LAST_NAME CATEGORY_MANAGER, a.ALLOW_CUST_GRP, 
         i.ITEM_NBR_HS, i.UPC_CASE , i.UPC_UNIT, i.ITEM_DESCRIP, bi.STORE_PACK, i.ITEM_SIZE, i.ITEM_SIZE_UOM, 
         case coalesce(i.ITEM_RES_33, ' ') when ' ' then 'N' else i.ITEM_RES_33 end PRESELL_FLG,
         cast(a.DEAL_ID as char(15)) DEAL_NBR,
         a.ALLOW_DATE_EFF,
         a.ALLOW_DATE_EXP,
         a.ALLOW_AMT, a.ACOUSTIC_CNTL_NBR
FROM     EDL.CRM.T_WHSE_ALLOWANCES a 
         inner join EDW.FD.FD_ITEM_VW i on i.FACILITY_ID = a.FACILITYID and i.ITEM_NBR_HS = a.ITEM_NBR_HS and i.CURRENT_FLG = 1 
         inner join EDL.BICEPS.ITEM bi on i.FACILITY_ID = bi.FACILITYID and i.ITEM_NBR = bi.ITEM_NBR
         inner join EDW.MDM.MDSE_CLASS_MANAGER_VW mcm on mcm.MDSE_CLASS_KEY = i.MDSE_CLASS_KEY 
         inner join EDW.MDM.CATEGORY_MANAGER cm on cm.CATGY_MANAGER_KEY = mcm.CATGY_MANAGER_KEY
WHERE    a.ALLOW_TYPE = 'PA' and a.STATUS = 'A'  
AND      a.ALLOW_DATE_EXP >= '2022-04-17'
AND      a.FACILITYID = '001'
AND      a.MASTER_ITEM_FLG = 'Y'
AND      a.ALLOW_CUST_GRP = 0
AND      (a.ACOUSTIC_CNTL_NBR is null or trim(a.ACOUSTIC_CNTL_NBR) = '') 

union all

SELECT   'LEGACY' deal_source,
         'PA' deal_type,
         a.FACILITYID, 
         cm.FIRST_NAME || ' ' ||cm.LAST_NAME CATEGORY_MANAGER, a.ALLOW_CUST_GRP, 
         i.ITEM_NBR_HS, i.UPC_CASE , i.UPC_UNIT, i.ITEM_DESCRIP, bi.STORE_PACK, i.ITEM_SIZE, i.ITEM_SIZE_UOM, 
         case coalesce(i.ITEM_RES_33, ' ') when ' ' then 'N' else i.ITEM_RES_33 end PRESELL_FLG,
         cast(a.DEAL_ID as char(15)) DEAL_NBR,
         a.ALLOW_DATE_EFF,
         a.ALLOW_DATE_EXP,
         a.ALLOW_AMT, a.ACOUSTIC_CNTL_NBR
FROM     EDL.CRM.T_WHSE_ALLOWANCES a 
         inner join EDW.FD.FD_ITEM_VW i on i.FACILITY_ID = a.FACILITYID and i.ITEM_NBR_HS = a.ITEM_NBR_HS and i.CURRENT_FLG = 1 
         inner join EDL.BICEPS.ITEM bi on i.FACILITY_ID = bi.FACILITYID and i.ITEM_NBR = bi.ITEM_NBR
         inner join EDW.MDM.MDSE_CLASS_MANAGER_VW mcm on mcm.MDSE_CLASS_KEY = i.MDSE_CLASS_KEY 
         inner join EDW.MDM.CATEGORY_MANAGER cm on cm.CATGY_MANAGER_KEY = mcm.CATGY_MANAGER_KEY
WHERE    a.ALLOW_TYPE = 'RPA' and a.STATUS = 'A'  
AND      a.ALLOW_DATE_EXP >= '2022-04-17'
AND      a.FACILITYID <> '001'
AND      a.MASTER_ITEM_FLG = 'Y'
AND      (a.ACOUSTIC_CNTL_NBR is null or trim(a.ACOUSTIC_CNTL_NBR) = '') 
;


SELECT   FACILITYID,
         CUSTOMER_NBR_STND,
         CUST_GRP_LINK_KEY,
         ACTIVE,
         GROUP_CD,
         GROUP_DESC,
         GROUP_TYPE_CD,
         GROUP_TYPE_DESC
FROM     EDW.FD.WEB_CUSTOMER_GRP_VW
WHERE    GROUP_TYPE_CD = 8
;


Select * from EDL.GOLD.ALLOWANCE_RESTRICTION_V;
Select * from EDL.GOLD.DEAL_START_DAY_V;
Select * from EDL.GOLD.OFFSET_DATA_V;
