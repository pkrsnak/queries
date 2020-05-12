select count(*) from (
;
SELECT   fd.FISCAL_PERIOD_ID,
         dsh.FACILITY_ID,
         ds.FACILITY_NAME DS_FACILITY,
         dsh.SHIP_FACILITY_ID,
         us.FACILITY_NAME US_FACILITY,
         cust.CORPORATION_ID,
         corp.CORPORATION_NAME,
         dsh.CUSTOMER_NBR,
         cust.CUSTOMER_NAME, 
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
--         dsh.ITEM_NBR,
--         i.ROOT_ITEM_DESC,
--         i.CASE_PACK_QTY,
--         i.SHIP_CASE_WGHT_MSR,
--         i.SHIP_CASE_CUBE_MSR,
         sum(dsh.ORDERED_QTY) cases_ordered,
         sum(dsh.ORDERED_QTY * i.CASE_PACK_QTY) rsu_ordered,
         sum(dsh.ORDERED_QTY * i.SHIP_CASE_CUBE_MSR) cube_ordered,
         sum(dsh.ORDERED_QTY * i.SHIP_CASE_WGHT_MSR) weight_ordered,
         sum(dsh.ADJUSTED_QTY) cases_adjusted,
         sum(dsh.ADJUSTED_QTY * i.CASE_PACK_QTY) rsu_adjusted,
         sum(dsh.ADJUSTED_QTY * i.SHIP_CASE_CUBE_MSR) cube_adjusted,
         sum(dsh.ADJUSTED_QTY * i.SHIP_CASE_WGHT_MSR) weight_adjusted,
         sum(dsh.SHIPPED_QTY) cases_shipped,
         sum(dsh.SHIPPED_QTY * i.CASE_PACK_QTY) rsu_shipped,
         sum(dsh.SHIPPED_QTY * i.SHIP_CASE_CUBE_MSR) cube_shipped,
         sum(dsh.SHIPPED_QTY * i.SHIP_CASE_WGHT_MSR) weight_shipped,
         sum(dsh.EXT_CASE_COST_AMT) total_cost,
         sum(dsh.TOTAL_SALES_AMT) total_sales
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.DC_FACILITY ds on dsh.FACILITY_ID = ds.FACILITY_ID 
         inner join WH_OWNER.DC_FACILITY us on dsh.SHIP_FACILITY_ID = us.FACILITY_ID 
         inner join WH_OWNER.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR 
         inner join WH_OWNER.DC_CUSTOMER cust on dsh.FACILITY_ID = cust.FACILITY_ID and dsh.CUSTOMER_NBR = cust.CUSTOMER_NBR 
         inner join WH_OWNER.DC_CORPORATION corp on cust.CORPORATION_ID = corp.CORPORATION_ID 
         inner join WH_OWNER.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT 
         inner join wh_owner.MDSE_CLASS mcl on dsh.MDSE_CLASS_KEY = mcl.MDSE_CLASS_KEY 
         inner join wh_owner.MDSE_CATEGORY mctg on mcl.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY 
         inner join WH_OWNER.MDSE_GROUP mgrp on mctg.MDSE_GRP_KEY = mgrp.MDSE_GRP_KEY 
         inner join wh_owner.DEPARTMENT md on mgrp.DEPT_KEY = md.DEPT_KEY 
         inner join WH_OWNER.DEPARTMENT_GROUP mdg on md.DEPT_GRP_KEY = mdg.DEPT_GRP_KEY
WHERE    dsh.TRANSACTION_DATE between '12-29-2019' and '04-18-2020'
--WHERE    dsh.TRANSACTION_DATE between '12-29-2019' and '01-04-2020'
AND      corp.CORPORATION_ID = 634001
AND      dsh.FACILITY_ID not in (2, 71)
GROUP BY fd.FISCAL_PERIOD_ID,
         dsh.FACILITY_ID,
         ds.FACILITY_NAME,
         dsh.SHIP_FACILITY_ID,
         us.FACILITY_NAME,
         cust.CORPORATION_ID,
         corp.CORPORATION_NAME,
         dsh.CUSTOMER_NBR,
         cust.CUSTOMER_NAME, 
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
         mcl.MDSE_CLASS_NAME --,
--         dsh.ITEM_NBR,
--         i.ROOT_ITEM_DESC,
--         i.CASE_PACK_QTY,
--         i.SHIP_CASE_WGHT_MSR,
--         i.SHIP_CASE_CUBE_MSR
;
) x