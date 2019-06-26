---------------------------------------
--inventory turns
---------------------------------------

--CRM
SELECT   'starting inventory' factor,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
         int(mh.DEPT_CODE_DESC) dept,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * lh.CORRECT_NET_COST) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS
         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
WHERE    lh.LAYER_FILE_DTE = '2019-04-20'
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
AND      i.MERCH_CLASS is not null
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, mh.DEPT_CODE_DESC

union all

SELECT   'ending inventory' factor,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
         int(mh.DEPT_CODE_DESC) dept,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * lh.CORRECT_NET_COST) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS
         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE
WHERE    lh.LAYER_FILE_DTE = '2019-05-18'
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
AND      i.MERCH_CLASS is not null
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, mh.DEPT_CODE_DESC
;

--dw02
SELECT   'cog_sold' factor,
         max(dsh.transaction_date) max_date,
         dsh.ship_facility_id,
         dsh.facility_id,
         md.DEPT_NAME,
         sum(dsh.ext_case_cost_amt) cog_over_time
FROM     wh_owner.dc_sales_hst dsh 
         inner join wh_owner.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR
         inner join wh_owner.MDSE_CLASS mcl on i.MDSE_CLASS_KEY = mcl.MDSE_CLASS_KEY
         inner join wh_owner.MDSE_CATEGORY mctg on mcl.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY
         inner join WH_OWNER.MDSE_GROUP mgrp on mctg.MDSE_CATGY_KEY = mgrp.MDSE_GRP_KEY
         inner join wh_owner.DEPARTMENT md on mgrp.DEPT_KEY = md.DEPT_KEY
WHERE    dsh.transaction_date between '04-21-2019' and '05-18-2019'
AND      dsh.facility_id in (2,3,8,15,16,40,54,58,61,66,67,71)
AND      dsh.ORDER_TYPE_CD <> ('CR')
GROUP BY 1, 3, 4, 5
HAVING   sum(dsh.ext_case_cost_amt) <> 0
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
AND      i.PURCH_STATUS not in ('D', 'Z');

SELECT   FACILITYID,
         ITEM_NBR_HS,
         sum(QTY_SOLD - QTY_SCRATCHED) qty_shipped
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd
WHERE    FACILITYID = '058'
AND      BILLING_DATE between current date - 91 days and current date
GROUP BY FACILITYID, ITEM_NBR_HS;