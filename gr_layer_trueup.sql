SELECT   'AVG_4P_INV_CY' FACTOR,
--         d.FISCAL_PERIOD,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
         int(i.ITEM_DEPT) dept, i.COMMODITY_XREF,
         '' dept_name,
         int(i.ITEM_NBR_HS) item,
         i.SHIP_UNIT_CD,
         i.PURCH_STATUS,
         (case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) cost,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * (case when lh.RAND_WGT_CD ='R' then lh.SHIPPING_CASE_WEIGHT else 1 end)) inventory,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD ='R' then lh.SHIPPING_CASE_WEIGHT else 1 end))) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS 
--         inner join (SELECT (COMPANY_YEAR_ID * 100) + COMPANY_PERIOD_ID FISCAL_PERIOD, min(DATE_KEY) PERIOD_START_DATE, max(DATE_KEY) PERIOD_END_DATE FROM CRMADMIN.T_DATE GROUP BY COMPANY_YEAR_ID, COMPANY_PERIOD_ID HAVING (current date - 112 days between min(DATE_KEY) and max(DATE_KEY))) d on lh.LAYER_FILE_DTE = d.PERIOD_END_DATE
WHERE    (lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) <> 0 and lh.LAYER_FILE_DTE = '2019-08-30' and lh.FACILITYID = '001'
GROUP BY lh.LAYER_FILE_DTE, lh.FACILITYID, lh.STOCK_FAC, 
         i.ITEM_DEPT, i.COMMODITY_XREF, i.ITEM_NBR_HS, i.SHIP_UNIT_CD, i.PURCH_STATUS, (case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end)