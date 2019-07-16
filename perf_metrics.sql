---------------------------------------
--inventory turns
---------------------------------------

--CRM
SELECT   'inventory p3' factor,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
--         int(i.MERCH_DEPT) dept,
         int(i.ITEM_DEPT) dept,
         int(i.ITEM_NBR_HS) item,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD ='R' then i.AVERAGE_WEIGHT else 1 end))) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS
--         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
--WHERE    lh.LAYER_FILE_DTE = '2018-04-21'
WHERE    lh.LAYER_FILE_DTE = '2018-04-21'
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
--AND      i.MERCH_CLASS is not null
--GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, i.MERCH_DEPT
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, i.ITEM_DEPT
, i.ITEM_NBR_HS

union all

SELECT   'inventory p2' factor,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
--         int(i.MERCH_DEPT) dept,
         int(i.ITEM_DEPT) dept,
         int(i.ITEM_NBR_HS) item,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD ='R' then i.AVERAGE_WEIGHT else 1 end))) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS
--         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
--WHERE    lh.LAYER_FILE_DTE = '2018-05-19'
WHERE    lh.LAYER_FILE_DTE = '2018-05-19'
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
--AND      i.MERCH_CLASS is not null
--GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, i.MERCH_DEPT
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, i.ITEM_DEPT
, i.ITEM_NBR_HS

union all

SELECT   'inventory p1' factor,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
--         int(i.MERCH_DEPT) dept,
         int(i.ITEM_DEPT) dept,
         int(i.ITEM_NBR_HS) item,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD ='R' then i.AVERAGE_WEIGHT else 1 end))) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS
--         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
WHERE    lh.LAYER_FILE_DTE = '2018-06-16'
--WHERE    lh.LAYER_FILE_DTE = '2019-06-14'
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
--AND      i.MERCH_CLASS is not null
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, i.ITEM_DEPT
, i.ITEM_NBR_HS
;

--netezza fd
SELECT   'cog_sold' factor,
         max(dsh.transaction_date) max_date,
         dsh.ship_facility_id,
         dsh.facility_id,
         dsh.WHOLESALE_DEPT_ID,
         sum(dsh.ext_case_cost_amt) cog_over_time
FROM     wh_owner.dc_sales_hst dsh 
         inner join wh_owner.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR
--         inner join wh_owner.MDSE_CLASS mcl on i.MDSE_CLASS_KEY = mcl.MDSE_CLASS_KEY
--         inner join wh_owner.MDSE_CATEGORY mctg on mcl.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY
--         inner join WH_OWNER.MDSE_GROUP mgrp on mctg.MDSE_GRP_KEY = mgrp.MDSE_GRP_KEY
--         inner join wh_owner.DEPARTMENT md on mgrp.DEPT_KEY = md.DEPT_KEY
--WHERE    dsh.transaction_date between '03-25-2018' and '06-16-2018'
WHERE    dsh.transaction_date between '03-24-2019' and '06-15-2019'
AND      dsh.facility_id in (1,2,3,8,15,16,40,54,58,61,66,67,71)
--AND      dsh.ORDER_TYPE_CD <> ('CR')
GROUP BY 1, 3, 4, 5
HAVING   sum(dsh.ext_case_cost_amt) <> 0
;

--netezza caito
SELECT   'cog_sold' factor,
         max(dsh.INVOICE_DT) max_date,
--         dsh.ship_facility_id,
         dsh.facility_id,
--         dsh.WHOLESALE_DEPT_ID,
         sum(dsh.EXT_COST_AMT) cog_over_time
FROM     wh_owner.caito_sales_hst dsh 
--         inner join wh_owner.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR
--         inner join wh_owner.MDSE_CLASS mcl on i.MDSE_CLASS_KEY = mcl.MDSE_CLASS_KEY
--         inner join wh_owner.MDSE_CATEGORY mctg on mcl.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY
--         inner join WH_OWNER.MDSE_GROUP mgrp on mctg.MDSE_GRP_KEY = mgrp.MDSE_GRP_KEY
--         inner join wh_owner.DEPARTMENT md on mgrp.DEPT_KEY = md.DEPT_KEY
--WHERE    dsh.transaction_date between '03-25-2018' and '06-16-2018'
--WHERE    dsh.INVOICE_DT between '03-24-2019' and '06-15-2019'
WHERE    dsh.INVOICE_DT between '03-25-2018' and '06-16-2018'
--AND      dsh.facility_id in (1,2,3,8,15,16,40,54,58,61,66,67,71)
--AND      dsh.ORDER_TYPE_CD <> ('CR')
GROUP BY 1, 3 --, 4, 5
HAVING   sum(dsh.ext_cost_amt) <> 0
;


---------------------------------------
--item movement performance
---------------------------------------

SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.PURCH_STATUS,
         i.ITEM_ADDED_DATE,
         i.FIRST_RECEIVED_DATE,
         case 
              when sh.QTY_SHIPPED is null then 0 
              else sh.QTY_SHIPPED 
         end shipped_qty_13wk,
         case 
              when i.FIRST_RECEIVED_DATE between current date - 140 days and current date - 56 days then '1_NEW_MEASURED' 
              when i.FIRST_RECEIVED_DATE is null or i.FIRST_RECEIVED_DATE between current date - 55 days and current date then '0_NEW_NOT_MEASURED' 
              else '2_MATURE' 
         end measure_group
FROM     CRMADMIN.T_WHSE_ITEM i 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, sum(QTY_SOLD - QTY_SCRATCHED) qty_shipped FROM CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd WHERE FACILITYID = '058' AND BILLING_DATE between current date - 91 days and current date group by FACILITYID, ITEM_NBR_HS) sh on i.FACILITYID = sh.FACILITYID and i.ITEM_NBR_HS = sh.ITEM_NBR_HS
WHERE    i.FACILITYID = '058'
AND      i.PURCH_STATUS not in ('D', 'Z')
;

SELECT   FACILITYID,
         ITEM_NBR_HS,
         sum(QTY_SOLD - QTY_SCRATCHED) qty_shipped
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd
WHERE    FACILITYID = '058'
AND      BILLING_DATE between current date - 91 days and current date
GROUP BY FACILITYID, ITEM_NBR_HS
;


---------------------------------------
--inventory value / woh
---------------------------------------

SELECT   i.FACILITYID,
         i.WAREHOUSE_CODE,
         wc.WAREHOUSE_CODE_DESC,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.ITEM_TYPE_CD,
         i.PURCH_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.CASES_PER_WEEK,
         i.CASES_PER_WEEK_DESEASONED,
         sum(lc.INVENTORY_TURN) turn_inventory,
         sum((lc.INVENTORY_TURN) * ((case when (lc.CORRECT_NET_COST <> 0) then lc.CORRECT_NET_COST else lc.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD = 'R' then i.AVERAGE_WEIGHT else 1 end ))) turn_inventory_value,
         sum(lc.INVENTORY_TURN / nullif(i.CASES_PER_WEEK, 0)) turn_inventory_woh,
         sum(lc.INVENTORY_PROMOTION) promo_inventory,
         sum((lc.INVENTORY_PROMOTION) * ((case when (lc.CORRECT_NET_COST <> 0) then lc.CORRECT_NET_COST else lc.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD = 'R' then i.AVERAGE_WEIGHT else 1 end ))) promo_inventory_value,
         sum(lc.INVENTORY_PROMOTION / nullif(i.CASES_PER_WEEK, 0)) promo_inventory_woh,
         sum(lc.INVENTORY_FWD_BUY) fwd_buy_inventory,
         sum((lc.INVENTORY_FWD_BUY) * ((case when (lc.CORRECT_NET_COST <> 0) then lc.CORRECT_NET_COST else lc.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD = 'R' then i.AVERAGE_WEIGHT else 1 end ))) fwd_buy_inventory_value,
         sum(lc.INVENTORY_FWD_BUY / nullif(i.CASES_PER_WEEK, 0)) fwd_buy_inventory_woh,
         sum(lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY) total_inventory,
         sum((lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY) * ((case when (lc.CORRECT_NET_COST <> 0) then lc.CORRECT_NET_COST else lc.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD = 'R' then i.AVERAGE_WEIGHT else 1 end ))) total_inventory_value,
         sum((lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY) / nullif(i.CASES_PER_WEEK, 0)) total_inventory_woh
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_LAYER_CURRENT lc on lc.FACILITYID = i.FACILITYID AND lc.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc on wc.FACILITYID = i.FACILITYID and wc.WAREHOUSE_CODE = i.WAREHOUSE_CODE
GROUP BY i.FACILITYID, i.WAREHOUSE_CODE, wc.WAREHOUSE_CODE_DESC, 
         i.ITEM_NBR_HS, i.ITEM_DESCRIP, i.ITEM_TYPE_CD, i.PURCH_STATUS, 
         i.BILLING_STATUS_BACKSCREEN, i.CASES_PER_WEEK, 
         i.CASES_PER_WEEK_DESEASONED
;

---------------------------------------
--gmroi
---------------------------------------
--parent/child
SELECT   FACILITYID_CHILD,
         ITEM_NBR_HS_CHILD,
         FACILITYID_PARENT,
         ITEM_NBR_HS_PARENT
FROM     CRMADMIN.T_WHSE_ITEM_PARENTCHILD
;

--netezza
SELECT   'GM' factor,
         max(sh.TRANSACTION_DATE) file_date,
         i.FACILITY_ID,
         i.SHIP_FACILITY_ID,
         sh.WHOLESALE_DEPT_ID dept,
         i.ITEM_NBR,
         count(distinct fw.FISCAL_WEEK_ID) num_weeks,
         sum(sh.TOTAL_SALES_AMT) sales,
         sum(sh.EXT_CASE_COST_AMT) case_cost,
--         sum(sh.EXT_CASH_DISC_AMT) cash_discount,
--         sum(sh.EXT_REFLECT_AMT) oi,
         sum(sh.EXT_PROMO_ALLW_AMT) pa,
--         sum(sh.EXT_NET_COST_AMT) net_cost,
         sum((sh.TOTAL_SALES_AMT + sh.EXT_PROMO_ALLW_AMT) - sh.EXT_CASE_COST_AMT) gm
FROM     WH_OWNER.DC_ITEM i 
         inner join WH_OWNER.DC_SALES_HST sh on i.FACILITY_ID = sh.FACILITY_ID and i.ITEM_NBR = sh.ITEM_NBR
         inner join wh_owner.FISCAL_WEEK fw on sh.TRANSACTION_DATE between fw.START_DT and fw.END_DT
--         inner join wh_owner.MDSE_CLASS mcl on sh.MDSE_CLASS_KEY = mcl.MDSE_CLASS_KEY
--         inner join wh_owner.MDSE_CATEGORY mctg on mcl.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY
--         inner join WH_OWNER.MDSE_GROUP mgrp on mctg.MDSE_GRP_KEY = mgrp.MDSE_GRP_KEY
--         inner join wh_owner.DEPARTMENT md on mgrp.DEPT_KEY = md.DEPT_KEY
WHERE    sh.TRANSACTION_DATE between '06-17-2018' and '06-15-2019'
AND      i.FACILITY_ID <> 1 
AND      sh.ORDER_TYPE_CD <> 'CR'
AND      sh.EXT_CASE_COST_AMT <> 0
AND      i.ITEM_NBR > 0
GROUP BY i.FACILITY_ID, i.SHIP_FACILITY_ID, sh.WHOLESALE_DEPT_ID, i.ITEM_NBR 
;


--CRM
SELECT   '3p inventory' factor,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
         int(i.MERCH_DEPT) dept,
         int(i.ITEM_NBR_HS) item,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD ='R' then i.AVERAGE_WEIGHT else 1 end))) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS
         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
WHERE    lh.LAYER_FILE_DTE = '2019-04-20'
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
AND      i.MERCH_CLASS is not null
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, i.MERCH_DEPT, i.ITEM_NBR_HS

union all

SELECT   '2p inventory' factor,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
         int(i.MERCH_DEPT) dept,
         int(i.ITEM_NBR_HS) item,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD ='R' then i.AVERAGE_WEIGHT else 1 end))) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS
         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
WHERE    lh.LAYER_FILE_DTE = '2019-05-18'
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
AND      i.MERCH_CLASS is not null
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, i.MERCH_DEPT, i.ITEM_NBR_HS

union all

SELECT   '1p inventory' factor,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
         int(i.MERCH_DEPT) dept,
         int(i.ITEM_NBR_HS) item,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD ='R' then i.AVERAGE_WEIGHT else 1 end))) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS
         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
WHERE    lh.LAYER_FILE_DTE = '06-15-2019'
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
AND      i.MERCH_CLASS is not null
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, i.MERCH_DEPT, i.ITEM_NBR_HS
;


---------------------------------
--inventory value tie-out
---------------------------------


SELECT   'ods' type, lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility, 
         int(lh.ITEM_NBR_HS) item, i.ITEM_DESCRIP,
         int(lh.ITEM_DEPT) dept, d.DEPT_DESCRIPTION,
--i.RAND_WGT_CD,
--         lh.STORE_PACK,
--         lh.SIZE,
--         avg(case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) layer_cost,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY)) on_hand,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD ='R' then i.SHIPPING_CASE_WEIGHT else 1 end))) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_DEPT d on i.ITEM_DEPT = d.DEPT_CODE
--         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
WHERE    lh.LAYER_FILE_DTE in ('2019-06-14', '2019-06-15')
AND      lh.FACILITYID = '015'
and (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0 
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.ITEM_DEPT --, i.RAND_WGT_CD
, lh.ITEM_NBR_HS, i.ITEM_DESCRIP, d.DEPT_DESCRIPTION
--, lh.STORE_PACK, lh.SIZE