--select count(*) from (
SELECT   dsh.FACILITY_ID,
         dsh.SHIP_FACILITY_ID,
         dsh.ITEM_NBR,
         dsh.MDSE_CLASS_KEY,
         count(distinct dsh.CUSTOMER_NBR),
         sum(dsh.SHIPPED_QTY)
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT
WHERE    dsh.TRANSACTION_DATE between '02-24-2019' and '02-22-2020'
AND      dsh.ITEM_NBR > 0
GROUP BY dsh.FACILITY_ID, dsh.SHIP_FACILITY_ID, dsh.ITEM_NBR, 
         dsh.MDSE_CLASS_KEY
--) x
;


select count(*) from (
;
SELECT   --fd.FISCAL_WEEK_ID,
         dsh.FACILITY_ID,
         ds.FACILITY_NAME DS_FACILITY,
         dsh.SHIP_FACILITY_ID,
         us.FACILITY_NAME US_FACILITY, v.VENDOR_NBR, v.VENDOR_NAME, v.MSTR_VENDOR_NBR, v.MSTR_VENDOR_NAME, 
         dsh.WHSE_CMDTY_ID,
         mdg.DEPT_GRP_KEY,
         mdg.DEPT_GRP_NAME,
         md.DEPT_KEY,
         md.DEPT_NAME,
         mgrp.MDSE_GRP_KEY,
         mgrp.MDSE_GRP_NAME,
         mctg.MDSE_CATGY_KEY,
         mctg.MDSE_CATGY_NAME,
         dsh.MDSE_CLASS_KEY,
         mcl.MDSE_CLASS_NAME, 
         i.ITEM_RANK_CD, i.SHIP_UNIT_CD, i.ITEM_RES28_CD, 
         dsh.ITEM_NBR,
         i.CASE_UPC_NBR,
         i.UNIT_UPC_NBR,
         i.ROOT_ITEM_DESC, i.CASE_PACK_QTY, i.MASTER_PACK_QTY, i.RETAIL_PACK_QTY, i.ITEM_SIZE_MSR, i.ITEM_SIZE_UOM_CD, i.SEASONAL_ITEM_FLG, 
         i.VENDOR_TIE_MSR,
         i.VENDOR_TIER_MSR,
         i.WHSE_TIE_MSR,
         i.WHSE_TIER_MSR,
         i.MSTR_CASE_LEN_MSR,
         i.MSTR_CASE_WGHT_MSR,
         i.MSTR_CASE_CUBE_MSR,
         i.MSTR_CASE_HGHT_MSR,
         i.SHIP_CASE_LEN_MSR,
         i.SHIP_CASE_WGHT_MSR,
         i.SHIP_CASE_CUBE_MSR,
         i.SHIP_CASE_HGHT_MSR, i.PURCH_STATUS_CD, i.BILLING_STATUS_CD, 
         count(distinct dsh.CUSTOMER_NBR) cust_count,
         sum(case when fd.FISCAL_WEEK_ID = 201909 then dsh.SHIPPED_QTY else 0 end) cases_201909,
         sum(case when fd.FISCAL_WEEK_ID = 201910 then dsh.SHIPPED_QTY else 0 end) cases_201910,
         sum(case when fd.FISCAL_WEEK_ID = 201911 then dsh.SHIPPED_QTY else 0 end) cases_201911,
         sum(case when fd.FISCAL_WEEK_ID = 201912 then dsh.SHIPPED_QTY else 0 end) cases_201912,
         sum(case when fd.FISCAL_WEEK_ID = 201913 then dsh.SHIPPED_QTY else 0 end) cases_201913,
         sum(case when fd.FISCAL_WEEK_ID = 201914 then dsh.SHIPPED_QTY else 0 end) cases_201914,
         sum(case when fd.FISCAL_WEEK_ID = 201915 then dsh.SHIPPED_QTY else 0 end) cases_201915,
         sum(case when fd.FISCAL_WEEK_ID = 201916 then dsh.SHIPPED_QTY else 0 end) cases_201916,
         sum(case when fd.FISCAL_WEEK_ID = 201917 then dsh.SHIPPED_QTY else 0 end) cases_201917,
         sum(case when fd.FISCAL_WEEK_ID = 201918 then dsh.SHIPPED_QTY else 0 end) cases_201918,
         sum(case when fd.FISCAL_WEEK_ID = 201919 then dsh.SHIPPED_QTY else 0 end) cases_201919,
         sum(case when fd.FISCAL_WEEK_ID = 201920 then dsh.SHIPPED_QTY else 0 end) cases_201920,
         sum(case when fd.FISCAL_WEEK_ID = 201921 then dsh.SHIPPED_QTY else 0 end) cases_201921,
         sum(case when fd.FISCAL_WEEK_ID = 201922 then dsh.SHIPPED_QTY else 0 end) cases_201922,
         sum(case when fd.FISCAL_WEEK_ID = 201923 then dsh.SHIPPED_QTY else 0 end) cases_201923,
         sum(case when fd.FISCAL_WEEK_ID = 201924 then dsh.SHIPPED_QTY else 0 end) cases_201924,
         sum(case when fd.FISCAL_WEEK_ID = 201925 then dsh.SHIPPED_QTY else 0 end) cases_201925,
         sum(case when fd.FISCAL_WEEK_ID = 201926 then dsh.SHIPPED_QTY else 0 end) cases_201926,
         sum(case when fd.FISCAL_WEEK_ID = 201927 then dsh.SHIPPED_QTY else 0 end) cases_201927,
         sum(case when fd.FISCAL_WEEK_ID = 201928 then dsh.SHIPPED_QTY else 0 end) cases_201928,
         sum(case when fd.FISCAL_WEEK_ID = 201929 then dsh.SHIPPED_QTY else 0 end) cases_201929,
         sum(case when fd.FISCAL_WEEK_ID = 201930 then dsh.SHIPPED_QTY else 0 end) cases_201930,
         sum(case when fd.FISCAL_WEEK_ID = 201931 then dsh.SHIPPED_QTY else 0 end) cases_201931,
         sum(case when fd.FISCAL_WEEK_ID = 201932 then dsh.SHIPPED_QTY else 0 end) cases_201932,
         sum(case when fd.FISCAL_WEEK_ID = 201933 then dsh.SHIPPED_QTY else 0 end) cases_201933,
         sum(case when fd.FISCAL_WEEK_ID = 201934 then dsh.SHIPPED_QTY else 0 end) cases_201934,
         sum(case when fd.FISCAL_WEEK_ID = 201935 then dsh.SHIPPED_QTY else 0 end) cases_201935,
         sum(case when fd.FISCAL_WEEK_ID = 201936 then dsh.SHIPPED_QTY else 0 end) cases_201936,
         sum(case when fd.FISCAL_WEEK_ID = 201937 then dsh.SHIPPED_QTY else 0 end) cases_201937,
         sum(case when fd.FISCAL_WEEK_ID = 201938 then dsh.SHIPPED_QTY else 0 end) cases_201938,
         sum(case when fd.FISCAL_WEEK_ID = 201939 then dsh.SHIPPED_QTY else 0 end) cases_201939,
         sum(case when fd.FISCAL_WEEK_ID = 201940 then dsh.SHIPPED_QTY else 0 end) cases_201940,
         sum(case when fd.FISCAL_WEEK_ID = 201941 then dsh.SHIPPED_QTY else 0 end) cases_201941,
         sum(case when fd.FISCAL_WEEK_ID = 201942 then dsh.SHIPPED_QTY else 0 end) cases_201942,
         sum(case when fd.FISCAL_WEEK_ID = 201943 then dsh.SHIPPED_QTY else 0 end) cases_201943,
         sum(case when fd.FISCAL_WEEK_ID = 201944 then dsh.SHIPPED_QTY else 0 end) cases_201944,
         sum(case when fd.FISCAL_WEEK_ID = 201945 then dsh.SHIPPED_QTY else 0 end) cases_201945,
         sum(case when fd.FISCAL_WEEK_ID = 201946 then dsh.SHIPPED_QTY else 0 end) cases_201946,
         sum(case when fd.FISCAL_WEEK_ID = 201947 then dsh.SHIPPED_QTY else 0 end) cases_201947,
         sum(case when fd.FISCAL_WEEK_ID = 201948 then dsh.SHIPPED_QTY else 0 end) cases_201948,
         sum(case when fd.FISCAL_WEEK_ID = 201949 then dsh.SHIPPED_QTY else 0 end) cases_201949,
         sum(case when fd.FISCAL_WEEK_ID = 201950 then dsh.SHIPPED_QTY else 0 end) cases_201950,
         sum(case when fd.FISCAL_WEEK_ID = 201951 then dsh.SHIPPED_QTY else 0 end) cases_201951,
         sum(case when fd.FISCAL_WEEK_ID = 201952 then dsh.SHIPPED_QTY else 0 end) cases_201952,
         sum(case when fd.FISCAL_WEEK_ID = 202001 then dsh.SHIPPED_QTY else 0 end) cases_202001,
         sum(case when fd.FISCAL_WEEK_ID = 202002 then dsh.SHIPPED_QTY else 0 end) cases_202002,
         sum(case when fd.FISCAL_WEEK_ID = 202003 then dsh.SHIPPED_QTY else 0 end) cases_202003,
         sum(case when fd.FISCAL_WEEK_ID = 202004 then dsh.SHIPPED_QTY else 0 end) cases_202004,
         sum(case when fd.FISCAL_WEEK_ID = 202005 then dsh.SHIPPED_QTY else 0 end) cases_202005,
         sum(case when fd.FISCAL_WEEK_ID = 202006 then dsh.SHIPPED_QTY else 0 end) cases_202006,
         sum(case when fd.FISCAL_WEEK_ID = 202007 then dsh.SHIPPED_QTY else 0 end) cases_202007,
         sum(case when fd.FISCAL_WEEK_ID = 202008 then dsh.SHIPPED_QTY else 0 end) cases_202008
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.DC_FACILITY ds on dsh.FACILITY_ID = ds.FACILITY_ID 
         inner join WH_OWNER.DC_FACILITY us on dsh.SHIP_FACILITY_ID = us.FACILITY_ID 
         inner join WH_OWNER.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR 
         inner join WH_OWNER.DC_VENDOR v on i.VENDOR_NBR = v.VENDOR_NBR and i.FACILITY_ID = v.FACILITY_ID
         inner join WH_OWNER.DC_CUSTOMER cust on dsh.FACILITY_ID = cust.FACILITY_ID and dsh.CUSTOMER_NBR = cust.CUSTOMER_NBR 
         inner join WH_OWNER.DC_CORPORATION corp on cust.CORPORATION_ID = corp.CORPORATION_ID 
         inner join WH_OWNER.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT 
         inner join wh_owner.MDSE_CLASS mcl on dsh.MDSE_CLASS_KEY = mcl.MDSE_CLASS_KEY 
         inner join wh_owner.MDSE_CATEGORY mctg on mcl.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY 
         inner join WH_OWNER.MDSE_GROUP mgrp on mctg.MDSE_GRP_KEY = mgrp.MDSE_GRP_KEY 
         inner join wh_owner.DEPARTMENT md on mgrp.DEPT_KEY = md.DEPT_KEY 
         inner join WH_OWNER.DEPARTMENT_GROUP mdg on md.DEPT_GRP_KEY = mdg.DEPT_GRP_KEY
WHERE    dsh.TRANSACTION_DATE between '02-24-2019' and '02-22-2020'
AND      dsh.FACILITY_ID not in (2, 5, 71)
GROUP BY --fd.FISCAL_WEEK_ID,
         dsh.FACILITY_ID,
         ds.FACILITY_NAME,
         dsh.SHIP_FACILITY_ID,
         us.FACILITY_NAME, v.VENDOR_NBR, v.VENDOR_NAME, v.MSTR_VENDOR_NBR, v.MSTR_VENDOR_NAME, 
         dsh.WHSE_CMDTY_ID,
         mdg.DEPT_GRP_KEY,
         mdg.DEPT_GRP_NAME,
         md.DEPT_KEY,
         md.DEPT_NAME,
         mgrp.MDSE_GRP_KEY,
         mgrp.MDSE_GRP_NAME,
         mctg.MDSE_CATGY_KEY,
         mctg.MDSE_CATGY_NAME,
         dsh.MDSE_CLASS_KEY,
         mcl.MDSE_CLASS_NAME, 
         i.ITEM_RANK_CD, i.SHIP_UNIT_CD, i.ITEM_RES28_CD, 
         dsh.ITEM_NBR,
         i.CASE_UPC_NBR,
         i.UNIT_UPC_NBR,
         i.ROOT_ITEM_DESC, i.CASE_PACK_QTY, i.MASTER_PACK_QTY, i.RETAIL_PACK_QTY, i.ITEM_SIZE_MSR, i.ITEM_SIZE_UOM_CD, i.SEASONAL_ITEM_FLG, 
         i.VENDOR_TIE_MSR,
         i.VENDOR_TIER_MSR,
         i.WHSE_TIE_MSR,
         i.WHSE_TIER_MSR,
         i.MSTR_CASE_LEN_MSR,
         i.MSTR_CASE_WGHT_MSR,
         i.MSTR_CASE_CUBE_MSR,
         i.MSTR_CASE_HGHT_MSR,
         i.SHIP_CASE_LEN_MSR,
         i.SHIP_CASE_WGHT_MSR,
         i.SHIP_CASE_CUBE_MSR,
         i.SHIP_CASE_HGHT_MSR, i.PURCH_STATUS_CD, i.BILLING_STATUS_CD
;
) x
;

SELECT   FACILITYID || ITEM_NBR_HS lookup,
         FACILITYID,
         ITEM_NBR_HS,
         GTIN, UPC_CASE, UPC_UNIT, SHIPPING_CASE_HEIGHT, SHIPPING_CASE_WIDTH, SHIPPING_CASE_WIDTH, SHIPPING_CASE_WEIGHT, VENDOR_TIE, VENDOR_TIER, WHSE_TIE, WHSE_TIER
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    FACILITYID not in ('002', '005', '071')
AND      trim(GTIN) not in ('0', '00000000000000000')