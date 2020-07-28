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
WHERE    dsh.TRANSACTION_DATE between '12-30-2018' and '12-28-2019'
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
 