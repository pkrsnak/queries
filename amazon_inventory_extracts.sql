SELECT   d.FISCAL_WEEK,
         lh.LAYER_FILE_DTE,
         lh.FACILITYID,
         lh.PO_NBR,
         lh.PO_RECEIPT_DTE,
         lh.STOCK_FAC,
         lh.VENDOR_NBR,
         lh.VENDOR_NAME,
         i.ITEM_DEPT, i.item_res28,
         dept.DEPT_DESCRIPTION,
         i.WAREHOUSE_CODE,
         wc.WAREHOUSE_CODE_DESC,
         i.ITEM_NBR_HS,
         lh.UPC_UNIT,
         lh.ITEM_DESCRIPTION,
         lh.STORE_PACK,
         i.PURCH_STATUS,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS,
         lh.IN_PROCESS_REGULAR,
         lh.IN_PROCESS_PROMO,
         (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) inventory_qty,
         (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * (case when lh.RAND_WGT_CD ='R' then lh.SHIPPING_CASE_WEIGHT else 0 end) inventory_weight,
         (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD ='R' then lh.SHIPPING_CASE_WEIGHT else 1 end)) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join (select ((COMPANY_YEAR_ID * 100) + COMPANY_WEEK_ID) FISCAL_WEEK, max(DATE_KEY) date_join from CRMADMIN.T_DATE where COMPANY_YEAR_ID = 2019 and COMPANY_WEEK_ID between 49 and 52 group by COMPANY_YEAR_ID, COMPANY_WEEK_ID) d on lh.LAYER_FILE_DTE = d.DATE_JOIN 
         inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc on wc.WAREHOUSE_CODE = i.WAREHOUSE_CODE and wc.FACILITYID = i.FACILITYID 
         inner join CRMADMIN.T_WHSE_DEPT dept on dept.DEPT_CODE = lh.ITEM_DEPT
WHERE    lh.FACILITYID in ('015', '040') --, '015')
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
;


SELECT   d.FISCAL_WEEK,
         lh.LAYER_FILE_DTE,
         lh.FACILITYID,
         lh.PO_NBR,
         lh.PO_RECEIPT_DTE,
         lh.STOCK_FAC,
         lh.VENDOR_NBR,
         lh.VENDOR_NAME,
         i.ITEM_DEPT, i.item_res28,
         dept.DEPT_DESCRIPTION,
         i.WAREHOUSE_CODE,
         wc.WAREHOUSE_CODE_DESC,
         i.ITEM_NBR_HS,
         lh.UPC_UNIT,
         lh.ITEM_DESCRIPTION,
         lh.STORE_PACK,
         i.PURCH_STATUS,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS,
         lh.IN_PROCESS_REGULAR,
         lh.IN_PROCESS_PROMO,
         (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) inventory_qty,
         (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * (case when lh.RAND_WGT_CD ='R' then lh.SHIPPING_CASE_WEIGHT else 0 end) inventory_weight,
         (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD ='R' then lh.SHIPPING_CASE_WEIGHT else 1 end)) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join (select ((COMPANY_YEAR_ID * 100) + COMPANY_WEEK_ID) FISCAL_WEEK, DATE_KEY date_join from CRMADMIN.T_DATE where COMPANY_YEAR_ID = 2020 and COMPANY_WEEK_ID between 1 and 28) d on lh.LAYER_FILE_DTE = d.DATE_JOIN 
         inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc on wc.WAREHOUSE_CODE = i.WAREHOUSE_CODE and wc.FACILITYID = i.FACILITYID 
         inner join CRMADMIN.T_WHSE_DEPT dept on dept.DEPT_CODE = lh.ITEM_DEPT
WHERE    lh.FACILITYID in ('015') --, '015') --('040') --, '015')
AND      (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0
and i.ITEM_DEPT in ('070', '075')
;


select i.FACILITYID, i.ITEM_NBR_HS, i.ITEM_RES28 
from CRMADMIN.T_WHSE_ITEM i
where i.ITEM_RES28 in ('A', 'C')
and i.FACILITYID in ('040', '015')