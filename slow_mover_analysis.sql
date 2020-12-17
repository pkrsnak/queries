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
         us.FACILITY_NAME US_FACILITY,
         dsh.customer_nbr,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         v.MSTR_VENDOR_NBR,
         v.MSTR_VENDOR_NAME,
         dsh.WHSE_CMDTY_ID,
--         mdg.DEPT_GRP_KEY,
--         mdg.DEPT_GRP_NAME,
--         md.DEPT_KEY,
--         md.DEPT_NAME,
--         mgrp.MDSE_GRP_KEY,
--         mgrp.MDSE_GRP_NAME,
--         mctg.MDSE_CATGY_KEY,
--         mctg.MDSE_CATGY_NAME,
--         dsh.MDSE_CLASS_KEY,
--         mcl.MDSE_CLASS_NAME,
         i.ITEM_RANK_CD,
         i.SHIP_UNIT_CD,
         i.ITEM_RES28_CD,
         dsh.ITEM_NBR,
         i.CASE_UPC_NBR,
         i.UNIT_UPC_NBR,
         i.ROOT_ITEM_DESC,
         i.CASE_PACK_QTY,
         i.MASTER_PACK_QTY,
         i.RETAIL_PACK_QTY,
         i.ITEM_SIZE_MSR,
         i.ITEM_SIZE_UOM_CD,
         i.SEASONAL_ITEM_FLG,
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
         i.SHIP_CASE_HGHT_MSR,
         i.PURCH_STATUS_CD, 
         i.BILLING_STATUS_CD,
         count(distinct dsh.CUSTOMER_NBR) cust_count,
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
         sum(case when fd.FISCAL_WEEK_ID = 202008 then dsh.SHIPPED_QTY else 0 end) cases_202008,
         sum(case when fd.FISCAL_WEEK_ID = 202009 then dsh.SHIPPED_QTY else 0 end) cases_202009,
         sum(case when fd.FISCAL_WEEK_ID = 202010 then dsh.SHIPPED_QTY else 0 end) cases_202010,
         sum(case when fd.FISCAL_WEEK_ID = 202011 then dsh.SHIPPED_QTY else 0 end) cases_202011,
         sum(case when fd.FISCAL_WEEK_ID = 202012 then dsh.SHIPPED_QTY else 0 end) cases_202012,
         sum(case when fd.FISCAL_WEEK_ID = 202013 then dsh.SHIPPED_QTY else 0 end) cases_202013,
         sum(case when fd.FISCAL_WEEK_ID = 202014 then dsh.SHIPPED_QTY else 0 end) cases_202014,
         sum(case when fd.FISCAL_WEEK_ID = 202015 then dsh.SHIPPED_QTY else 0 end) cases_202015,
         sum(case when fd.FISCAL_WEEK_ID = 202016 then dsh.SHIPPED_QTY else 0 end) cases_202016,
         sum(case when fd.FISCAL_WEEK_ID = 202017 then dsh.SHIPPED_QTY else 0 end) cases_202017,
         sum(case when fd.FISCAL_WEEK_ID = 202018 then dsh.SHIPPED_QTY else 0 end) cases_202018,
         sum(case when fd.FISCAL_WEEK_ID = 202019 then dsh.SHIPPED_QTY else 0 end) cases_202019,
         sum(case when fd.FISCAL_WEEK_ID = 202020 then dsh.SHIPPED_QTY else 0 end) cases_202020,
         sum(case when fd.FISCAL_WEEK_ID = 202021 then dsh.SHIPPED_QTY else 0 end) cases_202021,
         sum(case when fd.FISCAL_WEEK_ID = 202022 then dsh.SHIPPED_QTY else 0 end) cases_202022,
         sum(case when fd.FISCAL_WEEK_ID = 202023 then dsh.SHIPPED_QTY else 0 end) cases_202023,
         sum(case when fd.FISCAL_WEEK_ID = 202024 then dsh.SHIPPED_QTY else 0 end) cases_202024,
         sum(case when fd.FISCAL_WEEK_ID = 202025 then dsh.SHIPPED_QTY else 0 end) cases_202025,
         sum(case when fd.FISCAL_WEEK_ID = 202026 then dsh.SHIPPED_QTY else 0 end) cases_202026,
         sum(case when fd.FISCAL_WEEK_ID = 202027 then dsh.SHIPPED_QTY else 0 end) cases_202027,
         sum(case when fd.FISCAL_WEEK_ID = 202028 then dsh.SHIPPED_QTY else 0 end) cases_202028,
         sum(case when fd.FISCAL_WEEK_ID = 202029 then dsh.SHIPPED_QTY else 0 end) cases_202029,
         sum(case when fd.FISCAL_WEEK_ID = 202030 then dsh.SHIPPED_QTY else 0 end) cases_202030,
         sum(case when fd.FISCAL_WEEK_ID = 202031 then dsh.SHIPPED_QTY else 0 end) cases_202031,
         sum(case when fd.FISCAL_WEEK_ID = 202032 then dsh.SHIPPED_QTY else 0 end) cases_202032,
         sum(case when fd.FISCAL_WEEK_ID = 202033 then dsh.SHIPPED_QTY else 0 end) cases_202033,
         sum(case when fd.FISCAL_WEEK_ID = 202034 then dsh.SHIPPED_QTY else 0 end) cases_202034,
         sum(case when fd.FISCAL_WEEK_ID = 202035 then dsh.SHIPPED_QTY else 0 end) cases_202035,
         sum(case when fd.FISCAL_WEEK_ID = 202036 then dsh.SHIPPED_QTY else 0 end) cases_202036,
         sum(case when fd.FISCAL_WEEK_ID = 202037 then dsh.SHIPPED_QTY else 0 end) cases_202037,
         sum(case when fd.FISCAL_WEEK_ID = 202038 then dsh.SHIPPED_QTY else 0 end) cases_202038,
         sum(case when fd.FISCAL_WEEK_ID = 202039 then dsh.SHIPPED_QTY else 0 end) cases_202039,
         sum(case when fd.FISCAL_WEEK_ID = 202040 then dsh.SHIPPED_QTY else 0 end) cases_202040,
         sum(case when fd.FISCAL_WEEK_ID = 202041 then dsh.SHIPPED_QTY else 0 end) cases_202041,
         sum(case when fd.FISCAL_WEEK_ID = 202042 then dsh.SHIPPED_QTY else 0 end) cases_202042,
         sum(case when fd.FISCAL_WEEK_ID = 202043 then dsh.SHIPPED_QTY else 0 end) cases_202043,
         sum(case when fd.FISCAL_WEEK_ID = 202044 then dsh.SHIPPED_QTY else 0 end) cases_202044,
         sum(case when fd.FISCAL_WEEK_ID = 202045 then dsh.SHIPPED_QTY else 0 end) cases_202045,
         sum(case when fd.FISCAL_WEEK_ID = 202046 then dsh.SHIPPED_QTY else 0 end) cases_202046,
         sum(case when fd.FISCAL_WEEK_ID = 202047 then dsh.SHIPPED_QTY else 0 end) cases_202047,
         sum(case when fd.FISCAL_WEEK_ID = 202048 then dsh.SHIPPED_QTY else 0 end) cases_202048
FROM     dssprd.WH_OWNER.DC_SALES_HST dsh
         inner join dssprd.WH_OWNER.DC_FACILITY ds on dsh.FACILITY_ID = ds.FACILITY_ID 
         inner join dssprd.WH_OWNER.DC_FACILITY us on dsh.SHIP_FACILITY_ID = us.FACILITY_ID 
         inner join dssprd.WH_OWNER.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR 
         inner join T_TEMP_UPC tu on tu.UPC_NBR =  i.UNIT_UPC_NBR
         inner join dssprd.WH_OWNER.DC_VENDOR v on i.VENDOR_NBR = v.VENDOR_NBR and i.FACILITY_ID = v.FACILITY_ID
         inner join dssprd.WH_OWNER.DC_CUSTOMER cust on dsh.FACILITY_ID = cust.FACILITY_ID and dsh.CUSTOMER_NBR = cust.CUSTOMER_NBR 
         inner join dssprd.WH_OWNER.DC_CORPORATION corp on cust.CORPORATION_ID = corp.CORPORATION_ID 
         inner join dssprd.WH_OWNER.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT 
--         inner join dssprd.wh_owner.MDSE_CLASS mcl on dsh.MDSE_CLASS_KEY = mcl.MDSE_CLASS_KEY 
--         inner join dssprd.wh_owner.MDSE_CATEGORY mctg on mcl.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY 
--         inner join dssprd.WH_OWNER.MDSE_GROUP mgrp on mctg.MDSE_GRP_KEY = mgrp.MDSE_GRP_KEY 
--         inner join dssprd.wh_owner.DEPARTMENT md on mgrp.DEPT_KEY = md.DEPT_KEY 
--         inner join dssprd.WH_OWNER.DEPARTMENT_GROUP mdg on md.DEPT_GRP_KEY = mdg.DEPT_GRP_KEY
WHERE    dsh.TRANSACTION_DATE between '10-06-2019' and '12-01-2020'
AND      dsh.FACILITY_ID not in (2, 5, 71)
AND      dsh.WHSE_CMDTY_ID in (10, 40, 5, 6)
--AND      dsh.FACILITY_ID = 1
--AND      dsh.ITEM_NBR = 629220
GROUP BY --fd.FISCAL_WEEK_ID,
         dsh.FACILITY_ID,
         ds.FACILITY_NAME,
         dsh.SHIP_FACILITY_ID,
         dsh.customer_nbr,
         us.FACILITY_NAME, v.VENDOR_NBR, v.VENDOR_NAME, v.MSTR_VENDOR_NBR, v.MSTR_VENDOR_NAME, 
         dsh.WHSE_CMDTY_ID,
--         mdg.DEPT_GRP_KEY, mdg.DEPT_GRP_NAME, md.DEPT_KEY, md.DEPT_NAME, mgrp.MDSE_GRP_KEY, mgrp.MDSE_GRP_NAME, mctg.MDSE_CATGY_KEY, mctg.MDSE_CATGY_NAME, dsh.MDSE_CLASS_KEY, mcl.MDSE_CLASS_NAME, 
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

SELECT   i.FACILITYID || i.ITEM_NBR_HS key_code,
         i.FACILITYID,
         i.ITEM_NBR_HS,
         i.GTIN,
         i.LIST_COST,
         i.CATALOG_PRICE
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
order by i.FACILITYID, i.ITEM_NBR_HS

;

--MDV
select count(*) from (
;
SELECT   i.DEPT_CD,
         d.DEPT_DESC,
         d.DIVISION_CD, sls.CUSTOMER_NBR, sls.SHIP_TO_ID, 
         d.COMMODITY_CD,
         i.CASE_UPC_CD,
         i.VENDOR_ID,
         v.VENDOR_NAME,
         i.ITEM_DESC,
         i.ITEM_PACK_QTY,
         i.ITEM_SIZE_DESC,
--         i.PRIVATE_LABEL_ID,
--         i.PRODUCT_GROUP_ID,
         i.LBS_MSR,
         i.NET_MSR,
         i.CUBE_MSR,
         i.ITEM_STATUS_CD,
         i.UOM_CD,
         i.CATCH_WGT_FLG,
         i.CASE_COST_AMT,
         i.SELL_PRICE_AMT,
         i.FEE_AMT,
         i.FEE_METHOD_CD,
--         i.ITEM_RANK_CD,
--         sls.SHIP_QTY,
         count(distinct sls.CUSTOMER_NBR) cust_count,
         sum(case when fd.FISCAL_WEEK_ID = 201941 then sls.SHIP_QTY else 0 end) cases_201941,
         sum(case when fd.FISCAL_WEEK_ID = 201942 then sls.SHIP_QTY else 0 end) cases_201942,
         sum(case when fd.FISCAL_WEEK_ID = 201943 then sls.SHIP_QTY else 0 end) cases_201943,
         sum(case when fd.FISCAL_WEEK_ID = 201944 then sls.SHIP_QTY else 0 end) cases_201944,
         sum(case when fd.FISCAL_WEEK_ID = 201945 then sls.SHIP_QTY else 0 end) cases_201945,
         sum(case when fd.FISCAL_WEEK_ID = 201946 then sls.SHIP_QTY else 0 end) cases_201946,
         sum(case when fd.FISCAL_WEEK_ID = 201947 then sls.SHIP_QTY else 0 end) cases_201947,
         sum(case when fd.FISCAL_WEEK_ID = 201948 then sls.SHIP_QTY else 0 end) cases_201948,
         sum(case when fd.FISCAL_WEEK_ID = 201949 then sls.SHIP_QTY else 0 end) cases_201949,
         sum(case when fd.FISCAL_WEEK_ID = 201950 then sls.SHIP_QTY else 0 end) cases_201950,
         sum(case when fd.FISCAL_WEEK_ID = 201951 then sls.SHIP_QTY else 0 end) cases_201951,
         sum(case when fd.FISCAL_WEEK_ID = 201952 then sls.SHIP_QTY else 0 end) cases_201952,
         sum(case when fd.FISCAL_WEEK_ID = 202001 then sls.SHIP_QTY else 0 end) cases_202001,
         sum(case when fd.FISCAL_WEEK_ID = 202002 then sls.SHIP_QTY else 0 end) cases_202002,
         sum(case when fd.FISCAL_WEEK_ID = 202003 then sls.SHIP_QTY else 0 end) cases_202003,
         sum(case when fd.FISCAL_WEEK_ID = 202004 then sls.SHIP_QTY else 0 end) cases_202004,
         sum(case when fd.FISCAL_WEEK_ID = 202005 then sls.SHIP_QTY else 0 end) cases_202005,
         sum(case when fd.FISCAL_WEEK_ID = 202006 then sls.SHIP_QTY else 0 end) cases_202006,
         sum(case when fd.FISCAL_WEEK_ID = 202007 then sls.SHIP_QTY else 0 end) cases_202007,
         sum(case when fd.FISCAL_WEEK_ID = 202008 then sls.SHIP_QTY else 0 end) cases_202008,
         sum(case when fd.FISCAL_WEEK_ID = 202009 then sls.SHIP_QTY else 0 end) cases_202009,
         sum(case when fd.FISCAL_WEEK_ID = 202010 then sls.SHIP_QTY else 0 end) cases_202010,
         sum(case when fd.FISCAL_WEEK_ID = 202011 then sls.SHIP_QTY else 0 end) cases_202011,
         sum(case when fd.FISCAL_WEEK_ID = 202012 then sls.SHIP_QTY else 0 end) cases_202012,
         sum(case when fd.FISCAL_WEEK_ID = 202013 then sls.SHIP_QTY else 0 end) cases_202013,
         sum(case when fd.FISCAL_WEEK_ID = 202014 then sls.SHIP_QTY else 0 end) cases_202014,
         sum(case when fd.FISCAL_WEEK_ID = 202015 then sls.SHIP_QTY else 0 end) cases_202015,
         sum(case when fd.FISCAL_WEEK_ID = 202016 then sls.SHIP_QTY else 0 end) cases_202016,
         sum(case when fd.FISCAL_WEEK_ID = 202017 then sls.SHIP_QTY else 0 end) cases_202017,
         sum(case when fd.FISCAL_WEEK_ID = 202018 then sls.SHIP_QTY else 0 end) cases_202018,
         sum(case when fd.FISCAL_WEEK_ID = 202019 then sls.SHIP_QTY else 0 end) cases_202019,
         sum(case when fd.FISCAL_WEEK_ID = 202020 then sls.SHIP_QTY else 0 end) cases_202020,
         sum(case when fd.FISCAL_WEEK_ID = 202021 then sls.SHIP_QTY else 0 end) cases_202021,
         sum(case when fd.FISCAL_WEEK_ID = 202022 then sls.SHIP_QTY else 0 end) cases_202022,
         sum(case when fd.FISCAL_WEEK_ID = 202023 then sls.SHIP_QTY else 0 end) cases_202023,
         sum(case when fd.FISCAL_WEEK_ID = 202024 then sls.SHIP_QTY else 0 end) cases_202024,
         sum(case when fd.FISCAL_WEEK_ID = 202025 then sls.SHIP_QTY else 0 end) cases_202025,
         sum(case when fd.FISCAL_WEEK_ID = 202026 then sls.SHIP_QTY else 0 end) cases_202026,
         sum(case when fd.FISCAL_WEEK_ID = 202027 then sls.SHIP_QTY else 0 end) cases_202027,
         sum(case when fd.FISCAL_WEEK_ID = 202028 then sls.SHIP_QTY else 0 end) cases_202028,
         sum(case when fd.FISCAL_WEEK_ID = 202029 then sls.SHIP_QTY else 0 end) cases_202029,
         sum(case when fd.FISCAL_WEEK_ID = 202030 then sls.SHIP_QTY else 0 end) cases_202030,
         sum(case when fd.FISCAL_WEEK_ID = 202031 then sls.SHIP_QTY else 0 end) cases_202031,
         sum(case when fd.FISCAL_WEEK_ID = 202032 then sls.SHIP_QTY else 0 end) cases_202032,
         sum(case when fd.FISCAL_WEEK_ID = 202033 then sls.SHIP_QTY else 0 end) cases_202033,
         sum(case when fd.FISCAL_WEEK_ID = 202034 then sls.SHIP_QTY else 0 end) cases_202034,
         sum(case when fd.FISCAL_WEEK_ID = 202035 then sls.SHIP_QTY else 0 end) cases_202035,
         sum(case when fd.FISCAL_WEEK_ID = 202036 then sls.SHIP_QTY else 0 end) cases_202036,
         sum(case when fd.FISCAL_WEEK_ID = 202037 then sls.SHIP_QTY else 0 end) cases_202037,
         sum(case when fd.FISCAL_WEEK_ID = 202038 then sls.SHIP_QTY else 0 end) cases_202038,
         sum(case when fd.FISCAL_WEEK_ID = 202039 then sls.SHIP_QTY else 0 end) cases_202039,
         sum(case when fd.FISCAL_WEEK_ID = 202040 then sls.SHIP_QTY else 0 end) cases_202040,
         sum(case when fd.FISCAL_WEEK_ID = 202041 then sls.SHIP_QTY else 0 end) cases_202041,
         sum(case when fd.FISCAL_WEEK_ID = 202042 then sls.SHIP_QTY else 0 end) cases_202042,
         sum(case when fd.FISCAL_WEEK_ID = 202043 then sls.SHIP_QTY else 0 end) cases_202043,
         sum(case when fd.FISCAL_WEEK_ID = 202044 then sls.SHIP_QTY else 0 end) cases_202044,
         sum(case when fd.FISCAL_WEEK_ID = 202045 then sls.SHIP_QTY else 0 end) cases_202045,
         sum(case when fd.FISCAL_WEEK_ID = 202046 then sls.SHIP_QTY else 0 end) cases_202046,
         sum(case when fd.FISCAL_WEEK_ID = 202047 then sls.SHIP_QTY else 0 end) cases_202047,
         sum(case when fd.FISCAL_WEEK_ID = 202048 then sls.SHIP_QTY else 0 end) cases_202048
FROM     dssprd.WH_OWNER.MDVSLS_DY_CUST_ITM sls 
         inner join WH_OWNER.MDV_ITEM i on sls.DEPT_CD = i.DEPT_CD and sls.CASE_UPC_CD = i.CASE_UPC_CD 
         inner join T_TEMP_UPC tu on tu.UPC_NBR =  i.ITEM_UPC_CD
         inner join dssprd.WH_OWNER.MDV_VENDOR v on v.VENDOR_ID = i.VENDOR_ID 
         inner join dssprd.WH_OWNER.FISCAL_DAY fd on sls.SHIP_DATE = fd.SALES_DT 
         inner join dssprd.WH_OWNER.MDV_DEPT d on d.DEPT_CD = sls.DEPT_CD
WHERE    sls.SHIP_DATE between '10-06-2019' and '12-01-2020'
group by i.DEPT_CD,
         d.DEPT_DESC,
         d.DIVISION_CD, sls.CUSTOMER_NBR, sls.SHIP_TO_ID, 
         d.COMMODITY_CD,
         i.CASE_UPC_CD,
         i.VENDOR_ID,
         v.VENDOR_NAME,
         i.ITEM_DESC,
         i.ITEM_PACK_QTY,
         i.ITEM_SIZE_DESC,
--         i.PRIVATE_LABEL_ID,
--         i.PRODUCT_GROUP_ID,
         i.LBS_MSR,
         i.NET_MSR,
         i.CUBE_MSR,
         i.ITEM_STATUS_CD,
         i.UOM_CD,
         i.CATCH_WGT_FLG,
         i.CASE_COST_AMT,
         i.SELL_PRICE_AMT,
         i.FEE_AMT,
         i.FEE_METHOD_CD --,
--         i.ITEM_RANK_CD
;
) x
;


SELECT   i.FACILITYID,
         i.STOCK_FAC,
         i.FULFILL_FACILITYID, 
         i.FULFILL_DC_AREA_ID,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC, 
         v.CURRENT_BKT_NUMBER, 
         v.CURRENT_BKT_TYPE,
         v.CURRENT_BKT_QUANTITY, 
         v.BKT_TYPE,
         v.BKT_QUANTITY,
         v.BKT_TYPE_2,
         v.BKT_QUANTITY_2,
         v.BKT_TYPE_3,
         v.BKT_QUANTITY_3,
         v.BKT_TYPE_4,
         v.BKT_QUANTITY_4,
         v.BKT_TYPE_5,
         v.BKT_QUANTITY_5,
         v.BKT_TYPE_6,
         v.BKT_QUANTITY_6,
         v.BKT_TYPE_7,
         v.BKT_QUANTITY_7, 
         v.LEAD_TIME_STATED_WEEKS, 
         v.LEAD_TIME_AVERAGE_WEEKS, 
         i.ORDER_INTERVAL_WEEKS, 
         i.CASES_PER_WEEK FORECAST_CASES_PER_WEEK,
         (ceiling((nvl(case when nvl(i.ORDER_INTERVAL_WEEKS, 0) = 0 then 1 else nvl(i.ORDER_INTERVAL_WEEKS, 0) end, 0) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) order_point,
         mh.DEPT_GRP_CODE, 
         mh.DEPT_GRP_CODE_DESC, 
         mh.DEPT_CODE, 
         mh.DEPT_CODE_DESC, 
         mh.MDSE_GRP_CODE, 
         mh.MDSE_GRP_CODE_DESC, 
         mh.MDSE_CAT_CODE, 
         mh.MDSE_CAT_CODE_DESC, 
         mh.MDSE_CLS_CODE, 
         mh.MDSE_CLS_CODE_DESC, 
         i.ITEM_NBR_HS, 
         i.ROOT_ITEM_NBR, 
         i.ROOT_DESC,
         i.LV_ITEM_NBR,
         i.GTIN, 
         i.UPC_CASE, 
         i.UPC_UNIT, 
         i.ITEM_SIZE, 
         i.ITEM_SIZE_UOM, 
         i.MASTER_PACK,
         i.RETAIL_PACK, 
         i.PACK_CASE,
         i.MASTER_CASE_LENGTH, 
         i.MASTER_CASE_WIDTH, 
         i.MASTER_CASE_HEIGHT, 
         i.MASTER_CASE_WEIGHT, 
         i.MASTER_CASE_CUBE,
         i.SHIPPING_CASE_LENGTH, 
         i.SHIPPING_CASE_WIDTH, 
         i.SHIPPING_CASE_HEIGHT, 
         i.SHIPPING_CASE_WEIGHT, 
         i.SHIPPING_CASE_CUBE,
         i.VENDOR_TIE, 
         i.VENDOR_TIER, 
         i.WHSE_TIE, 
         i.WHSE_TIER, 
         i.PURCH_STATUS, 
         i.BILLING_STATUS_BACKSCREEN,
         i.SHIP_UNIT_CD,
         i.ITEM_RES28, 
         i.SERVICE_LEVEL_CODE, 
         i.INVENTORY_TOTAL, 
         i.INVENTORY_TURN, 
         i.INVENTORY_PROMOTION, 
         i.INVENTORY_FWD_BUY, 
         i.SAFETY_STOCK, 
         i.SHELF_LIFE, 
         i.DISTRESS_DAYS, 
         case when i.LV_DESC is null then 0 else (CASE WHEN left(i.LV_DESC, 3) = 'I/O' OR left(i.LV_DESC, 3) = 'SS ' OR left(i.LV_DESC, 3) = 'BTS' OR left(i.LV_DESC, 2) = 'C-' OR left(i.LV_DESC, 2) = 'H-' OR left(i.LV_DESC, 2) = 'V-' OR left(i.LV_DESC, 2) = 'E-' OR left(i.LV_DESC, 3) = 'S/O' THEN 1 ELSE 0 END) end I_O_FLAG,
         CASE 
              WHEN i.VENDOR_PALLET_FACTOR = 'C' THEN nvl(i.SAFETY_STOCK, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'L' THEN nvl(i.WHSE_TIE, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'N' THEN 0 
              WHEN i.VENDOR_PALLET_FACTOR = 'P' THEN nvl(i.VENDOR_TIE, 0) * nvl(i.VENDOR_TIER, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'T' THEN nvl(i.VENDOR_TIE, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'U' THEN 1 
              WHEN i.VENDOR_PALLET_FACTOR = 'W' THEN nvl(i.WHSE_TIE, 0) * nvl(i.WHSE_TIER, 0) 
              ELSE -99 
         END mfg_min_order_qty
FROM     CRMADMIN.T_WHSE_ITEM i
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR
         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
--AND      trim(i.GTIN) not in ('0', '00000000000000000')

;

select count(*) from (
SELECT   fd.FISCAL_WEEK_ID,
--         fd.SALES_DT,
         dsh.FACILITY_ID,
         ds.FACILITY_NAME DS_FACILITY,
         dsh.SHIP_FACILITY_ID,
         us.FACILITY_NAME US_FACILITY,
         dsh.WHSE_CMDTY_ID,
         dsh.CUSTOMER_NBR,
         dsh.ITEM_NBR,
         count(distinct dsh.CUSTOMER_NBR) cust_count,
         sum(dsh.ORDERED_QTY) ext_ordered_cases,
         sum(dsh.SHIPPED_QTY) ext_shipped_cases,
         sum(dsh.EXT_CASE_COST_AMT) ext_cost,
         sum(dsh.TOTAL_SALES_AMT) ext_sales
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.DC_FACILITY ds on dsh.FACILITY_ID = ds.FACILITY_ID 
         inner join WH_OWNER.DC_FACILITY us on dsh.SHIP_FACILITY_ID = us.FACILITY_ID 
         inner join WH_OWNER.DC_CUSTOMER cust on dsh.FACILITY_ID = cust.FACILITY_ID and dsh.CUSTOMER_NBR = cust.CUSTOMER_NBR 
         inner join WH_OWNER.DC_CORPORATION corp on cust.CORPORATION_ID = corp.CORPORATION_ID 
         inner join WH_OWNER.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT 
WHERE    dsh.TRANSACTION_DATE between '10-06-2019' and '12-01-2020'
AND      dsh.FACILITY_ID not in (2, 5, 71)
AND      dsh.WHSE_CMDTY_ID in (10, 40, 5, 6)
GROUP BY fd.FISCAL_WEEK_ID,
--         fd.SALES_DT,
         dsh.FACILITY_ID,
         ds.FACILITY_NAME,
         dsh.SHIP_FACILITY_ID,
         us.FACILITY_NAME,
         dsh.WHSE_CMDTY_ID,
         dsh.CUSTOMER_NBR,
         dsh.ITEM_NBR
--;
) x;

--snowflake version
select count(*) from (
SELECT   fd.FISCAL_WEEK_ID,
--         fd.SALES_DT,
         dsh.FACILITY_ID,
         ds.FACILITY_NAME DS_FACILITY,
         dsh.SHIP_FACILITY_ID,
         us.FACILITY_NAME US_FACILITY,
         dsh.WHSE_CMDTY_ID,
         dsh.CUSTOMER_NBR,
         dsh.ITEM_NBR,
         count(distinct dsh.CUSTOMER_NBR) cust_count,
         sum(dsh.ORDERED_QTY) ext_ordered_cases,
         sum(dsh.SHIPPED_QTY) ext_shipped_cases,
         sum(dsh.EXT_CASE_COST_AMT) ext_cost,
         sum(dsh.TOTAL_SALES_AMT) ext_sales
FROM     SBX_IT.PATRICK_KRSNAK.DC_SALES_HST dsh 
         INNER JOIN SBX_IT.PATRICK_KRSNAK.T_TEMP_FAC_ITEM tfi ON tfi.FACILITYID  = dsh.FACILITY_ID  AND tfi.ITEM_NBR  = dsh.ITEM_NBR 
         inner join SBX_IT.PATRICK_KRSNAK.DC_FACILITY ds on dsh.FACILITY_ID = ds.FACILITY_ID 
         inner join SBX_IT.PATRICK_KRSNAK.DC_FACILITY us on dsh.SHIP_FACILITY_ID = us.FACILITY_ID 
         inner join SBX_IT.PATRICK_KRSNAK.DC_CUSTOMER cust on dsh.FACILITY_ID = cust.FACILITY_ID and dsh.CUSTOMER_NBR = cust.CUSTOMER_NBR 
         inner join SBX_IT.PATRICK_KRSNAK.DC_CORPORATION corp on cust.CORPORATION_ID = corp.CORPORATION_ID 
         inner join SBX_IT.PATRICK_KRSNAK.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT 
WHERE    dsh.TRANSACTION_DATE between '2018-12-30' and '2019-12-28'
AND      dsh.FACILITY_ID not in (2, 5, 71)
GROUP BY fd.FISCAL_WEEK_ID,
--         fd.SALES_DT,
         dsh.FACILITY_ID,
         ds.FACILITY_NAME,
         dsh.SHIP_FACILITY_ID,
         us.FACILITY_NAME,
         dsh.WHSE_CMDTY_ID,
         dsh.CUSTOMER_NBR,
         dsh.ITEM_NBR
--;
) x;

SELECT count(*) FROM SBX_IT.PATRICK_KRSNAK.T_TEMP_FAC_ITEM

SELECT   FACILITYID,
         SCHED_LIKE_DC_AREA_ID,
         CUSTOMER_NBR_STND,
         DUE_IN_TIMESTAMP_UTC,
         DUE_IN_DATE,
         DUE_IN_TIME,
         DELIVERY_DATE
FROM     CRMADMIN.V_WEB_ORDERS_DELIVSCHED
--where CUSTOMER_NBR_STND = 3253
;


--parent/child
SELECT   ip.FACILITYID_CHILD, 
         ip.ITEM_NBR_HS_CHILD,
         ip.FACILITYID_PARENT,
         ip.ITEM_NBR_HS_PARENT
FROM     CRMADMIN.T_WHSE_ITEM_PARENTCHILD ip 
ORDER BY ip.FACILITYID_CHILD, ip.ITEM_NBR_HS_CHILD
;
 