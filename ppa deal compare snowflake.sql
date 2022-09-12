





--MOVED TO SNOWSIGHT...............................................
























































--extract sql

create or replace view SBX_IT.PATRICK_KRSNAK.PPA_RPT_OVERLAP_DEALS
as
SELECT   paa.DEAL_SOURCE,
         paa.DEAL_TYPE,
         paa.FACILITY_ID,
         paa.CATEGORY_MANAGER,
         paa.ITEM_NBR,
         paa.UPC_CASE,
         paa.UPC_CONSUMER,
         paa.ITEM_DESC,
         paa.PACK_CNT,
         paa.UNIT_SIZE,
         paa.UNIT_MEASURE_CD,
         paa.PRESELL_FLG,
         paa.OFFER_NBR,
         paa.EVENT_START,
         paa.EVENT_END,
         paa.EVENT_TYPE_AMT,
         pal.DEAL_SOURCE DEAL_SOURCE_LEGACY,
         pal.DEAL_TYPE DEAL_TYPE_LEGACY,
         pal.PRESELL_FLG PRESELL_FLG_LEGACY,
         pal.DEAL_NBR DEAL_NBR_LEGACY,
         pal.ALLOW_DATE_EFF ALLOW_DATE_EFF_LEGACY,
         pal.ALLOW_DATE_EXP ALLOW_DATE_EXP_LEGACY,
         pal.ALLOW_AMT ALLOW_AMT_LEGACY
FROM     SBX_IT.PATRICK_KRSNAK.PPA_ALLOWANCES_ACOUSTIC_VW paa 
         inner join SBX_IT.PATRICK_KRSNAK.PPA_ALLOWANCES_LEGACY_VW pal on paa.DEAL_TYPE = pal.DEAL_TYPE and paa.FACILITY_ID = pal.FACILITYID and paa.ITEM_NBR = pal.ITEM_NBR_HS
WHERE    (pal.ALLOW_DATE_EFF between paa.EVENT_START and paa.EVENT_END
     OR  pal.ALLOW_DATE_EXP between paa.EVENT_START and paa.EVENT_END)
order by paa.CATEGORY_MANAGER, paa.UPC_CONSUMER, paa.FACILITY_ID
;
--union all

create or replace view SBX_IT.PATRICK_KRSNAK.PPA_RPT_LEGACY_CONTRACTS
as
SELECT   pal.DEAL_SOURCE,
         pal.DEAL_TYPE,
         pal.FACILITYID,
         pal.CATEGORY_MANAGER,
         pal.ITEM_NBR_HS,
         pal.UPC_CASE,
         pal.UPC_UNIT,
         pal.ITEM_DESCRIP,
         pal.STORE_PACK,
         pal.ITEM_SIZE,
         pal.ITEM_SIZE_UOM,
         pal.PRESELL_FLG,
         pal.DEAL_NBR,
         pal.ALLOW_DATE_EFF,
         pal.ALLOW_DATE_EXP,
         pal.ALLOW_AMT,
         paa.DEAL_SOURCE DEAL_SOURCE_ACOUSTIC,
         paa.DEAL_TYPE DEAL_TYPE_ACOUSTIC,
         paa.PRESELL_FLG PRESELL_FLG_ACOUSTIC,
         paa.OFFER_NBR OFFER_NBR_ACOUSTIC,
         paa.EVENT_START EVENT_START_ACOUSTIC,
         paa.EVENT_END EVENT_END_ACOUSTIC,
         paa.EVENT_TYPE_AMT EVENT_TYPE_AMT_ACOUSTIC
FROM     SBX_IT.PATRICK_KRSNAK.PPA_ALLOWANCES_LEGACY_VW pal 
         inner join SBX_IT.PATRICK_KRSNAK.PPA_ALLOWANCES_ACOUSTIC_VW paa on paa.FACILITY_ID = pal.FACILITYID and paa.ITEM_NBR = pal.ITEM_NBR_HS
WHERE    pal.DEAL_TYPE = 'VEND_CONTRACT'
AND      paa.DEAL_TYPE = 'PA'
AND      (paa.EVENT_START between pal.ALLOW_DATE_EFF and pal.ALLOW_DATE_EXP
     OR  paa.EVENT_END between pal.ALLOW_DATE_EFF and pal.ALLOW_DATE_EXP)
ORDER BY pal.CATEGORY_MANAGER, pal.UPC_UNIT, pal.FACILITYID
;


CREATE OR REPLACE VIEW SBX_IT.PATRICK_KRSNAK.PPA_ALLOWANCES_LEGACY_VW  as
SELECT   'LEGACY' deal_source,
         'VEND_CONTRACT' deal_type,
         a.FACILITYID, 
         cm.FIRST_NAME || ' ' ||cm.LAST_NAME CATEGORY_MANAGER, 
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
WHERE    a.ALLOW_TYPE = 'VENDRPA' and a.STATUS = 'A'  and a.CONTRACT_STATUS = 'A' and a.CONTRACT_DEAL_STATUS = 'A' and a.CONTRACT_ITEM_STATUS = 'A'
AND      a.ALLOW_DATE_EXP >= '2022-04-17'
AND      a.FACILITYID not in ('061', '062', '009', '059')

union all

--CRM 
SELECT   'LEGACY' deal_source,
         'PA' deal_type,
         a.FACILITYID, 
         cm.FIRST_NAME || ' ' ||cm.LAST_NAME CATEGORY_MANAGER, 
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
WHERE    a.ALLOW_TYPE = 'PA' and a.STATUS = 'A'  --and a.CONTRACT_STATUS = 'A' and a.CONTRACT_DEAL_STATUS = 'A' and a.CONTRACT_ITEM_STATUS = 'A'
AND      a.ALLOW_DATE_EXP >= '2022-04-17'
AND      a.FACILITYID = '001'
AND      a.MASTER_ITEM_FLG = 'Y'
AND      a.ALLOW_CUST_GRP = 0
AND      (a.ACOUSTIC_CNTL_NBR is null or trim(a.ACOUSTIC_CNTL_NBR) = '') 

union all

SELECT   'LEGACY' deal_source,
         'PA' deal_type,
         a.FACILITYID, --a.ALLOW_CUST_GRP,
         cm.FIRST_NAME || ' ' ||cm.LAST_NAME CATEGORY_MANAGER, 
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
WHERE    a.ALLOW_TYPE = 'RPA' and a.STATUS = 'A'  --and a.CONTRACT_STATUS = 'A' and a.CONTRACT_DEAL_STATUS = 'A' and a.CONTRACT_ITEM_STATUS = 'A'
AND      a.ALLOW_DATE_EXP >= '2022-04-17'
AND      a.FACILITYID <> '001'
AND      a.MASTER_ITEM_FLG = 'Y'
--AND      a.ALLOW_CUST_GRP = 0
AND      (a.ACOUSTIC_CNTL_NBR is null or trim(a.ACOUSTIC_CNTL_NBR) = '') 

union all

SELECT   'LEGACY' deal_source,
         'OI' deal_source,
         d.FACILITYID, 
         cm.FIRST_NAME || ' ' ||cm.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE , i.UPC_UNIT, i.ITEM_DESCRIP, bi.STORE_PACK, i.ITEM_SIZE, i.ITEM_SIZE_UOM, 
         case coalesce(i.ITEM_RES_33, ' ') when ' ' then 'N' else i.ITEM_RES_33 end PRESELL_FLG,
         cast(d.DEAL_NBR as char(15)) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_OI DEAL_AMT, '' as ACOUSTIC_CNTL_NBR
FROM     EDL.CRM.T_BICEPS_DEAL d 
         inner join EDW.FD.FD_ITEM_VW i on d.FACILITYID = i.FACILITY_ID and i.ITEM_NBR = left(d.ITEM_NBR, 6) and i.CURRENT_FLG = 1 
         inner join EDL.BICEPS.ITEM bi on i.FACILITY_ID = bi.FACILITYID and i.ITEM_NBR = bi.ITEM_NBR
         inner join EDW.MDM.MDSE_CLASS_MANAGER_VW mcm on mcm.MDSE_CLASS_KEY = i.MDSE_CLASS_KEY 
         inner join EDW.MDM.CATEGORY_MANAGER cm on cm.CATGY_MANAGER_KEY = mcm.CATGY_MANAGER_KEY
WHERE    d.DATE_END >= '2022-04-17'
AND      d.AMT_OI > 0
AND      not(d.DEAL_NBR between 560001 and 800000)

union all

SELECT   'LEGACY' deal_source,
         'BBACK' deal_type,
         d.FACILITYID, 
         cm.FIRST_NAME || ' ' ||cm.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE , i.UPC_UNIT, i.ITEM_DESCRIP, bi.STORE_PACK, i.ITEM_SIZE, i.ITEM_SIZE_UOM, 
         case coalesce(i.ITEM_RES_33, ' ') when ' ' then 'N' else i.ITEM_RES_33 end PRESELL_FLG,
         cast(d.DEAL_NBR as char(15)) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_BBACK DEAL_AMT, '' as ACOUSTIC_CNTL_NBR
FROM     EDL.CRM.T_BICEPS_DEAL d 
         inner join EDW.FD.FD_ITEM_VW i on d.FACILITYID = i.FACILITY_ID and i.ITEM_NBR = left(d.ITEM_NBR, 6) and i.CURRENT_FLG = 1 
         inner join EDL.BICEPS.ITEM bi on i.FACILITY_ID = bi.FACILITYID and i.ITEM_NBR = bi.ITEM_NBR
         inner join EDW.MDM.MDSE_CLASS_MANAGER_VW mcm on mcm.MDSE_CLASS_KEY = i.MDSE_CLASS_KEY 
         inner join EDW.MDM.CATEGORY_MANAGER cm on cm.CATGY_MANAGER_KEY = mcm.CATGY_MANAGER_KEY
WHERE    d.DATE_END >= '2022-04-17'
AND      d.AMT_BBACK > 0
AND      not(d.DEAL_NBR between 560001 and 800000) 
;

--from Acoustic
CREATE OR REPLACE VIEW SBX_IT.PATRICK_KRSNAK.PPA_ALLOWANCES_LEGACY_AC_VW  as
SELECT   'ACOUSTIC_BICEPS' deal_source,
         'OI' deal_type,
         d.FACILITYID, 
         cm.FIRST_NAME || ' ' ||cm.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE , i.UPC_UNIT, i.ITEM_DESCRIP, bi.STORE_PACK, i.ITEM_SIZE, i.ITEM_SIZE_UOM, 
         case coalesce(i.ITEM_RES_33, ' ') when ' ' then 'N' else i.ITEM_RES_33 end PRESELL_FLG,
         cast(d.DEAL_NBR as char(15)) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_OI DEAL_AMT
FROM     EDL.CRM.T_BICEPS_DEAL d 
         inner join EDW.FD.FD_ITEM_VW i on d.FACILITYID = i.FACILITY_ID and i.ITEM_NBR = left(d.ITEM_NBR, 6) and i.CURRENT_FLG = 1 
         inner join EDL.BICEPS.ITEM bi on i.FACILITY_ID = bi.FACILITYID and i.ITEM_NBR = bi.ITEM_NBR
         inner join EDW.MDM.MDSE_CLASS_MANAGER_VW mcm on mcm.MDSE_CLASS_KEY = i.MDSE_CLASS_KEY 
         inner join EDW.MDM.CATEGORY_MANAGER cm on cm.CATGY_MANAGER_KEY = mcm.CATGY_MANAGER_KEY
WHERE    d.DATE_END >= '2022-04-17'
AND      d.AMT_OI > 0
AND      d.DEAL_NBR between 560001 and 800000

union all

SELECT   'ACOUSTIC_BICEPS' deal_source,
         'BBACK' deal_type,
         d.FACILITYID, 
         cm.FIRST_NAME || ' ' ||cm.LAST_NAME CATEGORY_MANAGER, 
         i.ITEM_NBR_HS, i.UPC_CASE , i.UPC_UNIT, i.ITEM_DESCRIP, bi.STORE_PACK, i.ITEM_SIZE, i.ITEM_SIZE_UOM, 
         case coalesce(i.ITEM_RES_33, ' ') when ' ' then 'N' else i.ITEM_RES_33 end PRESELL_FLG,
         cast(d.DEAL_NBR as char(15)) DEAL_NBR,
         d.DATE_START,
         d.DATE_END,
         d.AMT_BBACK DEAL_AMT
FROM     EDL.CRM.T_BICEPS_DEAL d 
         inner join EDW.FD.FD_ITEM_VW i on d.FACILITYID = i.FACILITY_ID and i.ITEM_NBR = left(d.ITEM_NBR, 6) and i.CURRENT_FLG = 1 
         inner join EDL.BICEPS.ITEM bi on i.FACILITY_ID = bi.FACILITYID and i.ITEM_NBR = bi.ITEM_NBR
         inner join EDW.MDM.MDSE_CLASS_MANAGER_VW mcm on mcm.MDSE_CLASS_KEY = i.MDSE_CLASS_KEY 
         inner join EDW.MDM.CATEGORY_MANAGER cm on cm.CATGY_MANAGER_KEY = mcm.CATGY_MANAGER_KEY
WHERE    d.DATE_END >= '2022-04-17'
AND      d.AMT_BBACK > 0
AND      d.DEAL_NBR between 560001 and 800000
;

--Snowflake - from Kevin
CREATE OR REPLACE VIEW SBX_IT.PATRICK_KRSNAK.PPA_ALLOWANCES_ACOUSTIC_VW  as
SELECT   'ACOUSTIC' deal_source,
         CASE 
              WHEN ma.EVENT_TYPE_SHORT_DESC like 'DSD%' THEN 'OI' 
              WHEN ma.EVENT_TYPE_SHORT_DESC like 'PA%' THEN 'PA' 
              WHEN ma.EVENT_TYPE_SHORT_DESC like 'OI' THEN 'OI' 
              ELSE 'Unknown' 
         END as DEAL_TYPE,
         dm.FACILITY_ID,
         dm.CATEGORY_MANAGER,
         dm.ITEM_NBR, dm.UPC_CASE, dm.UPC_CONSUMER, dm.ITEM_DESC, dm.PACK_CNT,  dm.UNIT_SIZE, dm.UNIT_MEASURE_CD, 
         dm.SHIPPER_FLG as PRESELL_FLG,
         dm.OFFER_NBR,
         date(ma.EVENT_TYPE_START_TMSP) event_start,
         date(ma.EVENT_TYPE_END_TMSP) event_end,
         ma.EVENT_TYPE_AMT
FROM     EDW.PROMOS.MAIN_DEAL_MANAGEMENT dm 
         INNER JOIN EDW.PROMOS.MAIN_ALLOWANCE ma ON dm.DM_MAIN_ID=ma.DM_MAIN_ID
WHERE    ma.EVENT_TYPE_SHORT_DESC not in ('Scan', 'AF')
AND      ma.EVENT_TYPE_END_TMSP >= '2022-04-17'
AND      dm.DEAL_STATUS_CD ='PROCESS'
AND      dm.EXPORT_ACTION <> 'D'
AND      dm.ITEM_REMOVE_TMSP is null
AND      dm.FACILITY_ID not in ('DSD')
;

--------------------------------------------



create or replace view SBX_IT.PATRICK_KRSNAK.V_ACOUSTIC_BILLINGS
as
SELECT   AXFAC FACILITY_ID,
         AXCST CUSTOMER_NBR,
         AXITEM ITEM_NBR_HS,
         AXBDTE BILLING_DT,
         AXINV INVOICE_NBR,
         AXNFNO ALLOW_ID_ACOUSTIC,
         AXPFTY ALLOW_TYPE,
         AXSDTE ALLOW_START_DT,
         AXEDTE ALLOW_END_DT,
         AXALAM ALLOW_AMT,
         AXQTYS SHIPPED_QTY,
         AXDLID ALLOW_SOURCE_CD
FROM     
(
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_03_FGDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_08_SCDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_15_LMDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_16_RXDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_40_OMDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_54_GMDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_58_LODATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_61_BLDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_66_BCDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_67_OCDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_85_NMDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_86_SVDATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select AXFAC, AXCST, AXITEM, to_date(AXBDTE::varchar, 'YYYYMMDD') AXBDTE, AXINV, AXNFNO, AXPFTY, to_date(AXSDTE::varchar, 'YYYYMMDD') AXSDTE, to_date(AXEDTE::varchar, 'YYYYMMDD') AXEDTE, AXALAM, AXQTYS, AXDLID from EDL.SWAT_87_SODATA01.BH0PALCS
where AXBDTE >= 20220417 and AXRFFG = 'Y' and AXQTYS <> 0
union all
Select FACILITY_ID, CUSTOMER_ID, ITEM_NBR, to_date(BILLING_DT) BILLING_DT, INVOICE_NM, ALLOWANCE_DEAL_NM, ALLOWANCE_TYPE, to_date(ALLOWANCE_START_DT) ALLOWANCE_START_DT, to_date(ALLOWANCE_END_DT) ALLOWANCE_END_DT, ALLOWANCE_AMT, SHIPPED_QTY, DEAL_ID_SOURCE from EDL.ACOUSTICS.BILL_ALLOWANCE
where BILLING_DT >= '2022-04-17' and ALLOWANCE_REFLECTED_FLG = 'Y' and SHIPPED_QTY <> 0
)





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
