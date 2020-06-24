---------------------------------------
--inventory value / woh
---------------------------------------
SELECT   lc.LAYER_FILE_DTE,
         i.FACILITYID,
         i.WAREHOUSE_CODE,
         wc.WAREHOUSE_CODE_DESC,
         mh.DEPT_GRP_CODE,
         mh.DEPT_GRP_CODE_DESC,
         mh.DEPT_CODE,
         mh.DEPT_CODE_DESC,
--         mh.MDSE_GRP_CODE,
--         mh.MDSE_GRP_CODE_DESC,
--         mh.MDSE_CAT_CODE,
--         mh.MDSE_CAT_CODE_DESC,
--         mh.MDSE_CLS_CODE,
--         mh.MDSE_CLS_CODE_DESC,
         sum(lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY) total_inventory,
         sum((lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY) * ((case when (lc.CORRECT_NET_COST <> 0) then lc.CORRECT_NET_COST else lc.NET_COST_PER_CASE end) * (case when lc.RAND_WGT_CD = 'R' then lc.SHIPPING_CASE_WEIGHT else 1 end ))) total_inventory_value
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_LAYER_HISTORY lc on lc.FACILITYID = i.FACILITYID AND lc.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mh on i.MERCH_CLASS = mh.MDSE_CLS_CODE 
         inner join CRMADMIN.V_FISCAL_CALENDAR d on lc.LAYER_FILE_DTE = d.DATE_KEY and d.FISCAL_YEAR = 2020
         left outer join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc on wc.FACILITYID = i.FACILITYID and wc.WAREHOUSE_CODE = i.WAREHOUSE_CODE 
GROUP BY lc.LAYER_FILE_DTE, i.FACILITYID, i.WAREHOUSE_CODE, 
         wc.WAREHOUSE_CODE_DESC, mh.DEPT_GRP_CODE, mh.DEPT_GRP_CODE_DESC, 
         mh.DEPT_CODE, mh.DEPT_CODE_DESC --, mh.MDSE_GRP_CODE, 
--         mh.MDSE_GRP_CODE_DESC, mh.MDSE_CAT_CODE, mh.MDSE_CAT_CODE_DESC, mh.MDSE_CLS_CODE, mh.MDSE_CLS_CODE_DESC
HAVING   sum(lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY) <> 0;