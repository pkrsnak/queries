---------------------------------------
--turns
---------------------------------------
--netezza gm
SELECT   'SALES_COG' factor,
         fw.FISCAL_WEEK_ID,
         dd.DIVISION_NAME,
         sh.FACILITY_ID,
         sh.SHIP_FACILITY_ID, df.FACILITY_NAME,
         md.DEPT_KEY,
         md.DEPT_NAME,
         sum(sh.TOTAL_SALES_AMT) ext_sales,
         sum(sh.EXT_CASE_COST_AMT) ext_case_cost,
         sum(sh.EXT_CUST_FEE_AMT) ext_cust_fee,
         sum(sh.EXT_PROFIT_AMT) ext_profit,
         sum(sh.EXT_PROFIT_AMT + sh.EXT_CUST_FEE_AMT) gm,
         sum(sh.SHIPPED_QTY) qty_shipped
FROM     WH_OWNER.DC_SALES_HST sh 
         inner join wh_owner.FISCAL_WEEK fw on sh.TRANSACTION_DATE between fw.START_DT and fw.END_DT 
         inner join WH_OWNER.DC_FACILITY df on df.FACILITY_ID = sh.SHIP_FACILITY_ID 
         inner join WH_OWNER.DC_REGION dr on df.REGION_ID = dr.REGION_ID 
         inner join WH_OWNER.DC_DIVISION dd on dr.DIVISION_ID = dd.DIVISION_ID
         inner join wh_owner.MDSE_CLASS mcl on sh.MDSE_CLASS_KEY = mcl.MDSE_CLASS_KEY 
         inner join wh_owner.MDSE_CATEGORY mctg on mcl.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY 
         inner join WH_OWNER.MDSE_GROUP mgrp on mctg.MDSE_GRP_KEY = mgrp.MDSE_GRP_KEY 
         inner join wh_owner.DEPARTMENT md on mgrp.DEPT_KEY = md.DEPT_KEY
WHERE    sh.transaction_date between '03-29-2020' and '06-20-2020'
AND      sh.FACILITY_ID not in (80, 90)
AND      sh.ORDER_TYPE_CD <> 'CR'
AND      sh.ITEM_NBR > 0
GROUP BY fw.FISCAL_WEEK_ID, dd.DIVISION_NAME, sh.FACILITY_ID, 
         sh.SHIP_FACILITY_ID, df.FACILITY_NAME, md.DEPT_KEY, md.DEPT_NAME;


--get inventory from turns above (only open stock and purchasing active
SELECT   FACTOR,
         FACILITY,
         STOCK_FACILITY,
         DEPT,
         DEPT_NAME,
         ITEM,
         SHIP_UNIT_CD,
         PURCH_STATUS,
         AVG_4P_INV
FROM     KPIADMIN.V_KPI_AVG_INVENTORY_4P
;

