--mdv
--netezza
select count(*) from (
;
SELECT   fd.FISCAL_PERIOD_ID,
         msh.DEPT_CD,
         md.DEPT_DESC, 
         md.DIVISION_CD, 
         md.PRODUCT_GROUP_ID, 
         md.COMMODITY_CD,
         msh.CUSTOMER_NBR,
         c.CUSTOMER_NAME, 
         msh.ORDER_CATGY_CD, 
         oc.ORDER_CATGY_DESC, 
         msh.SALES_CATGY_CODE,
         sc.SALES_CATGY_DESC,
         msh.CASE_UPC_CD,
         i.ITEM_DESC,
         i.ITEM_PACK_QTY,
         i.LBS_MSR,
         i.NET_MSR,
         i.CUBE_MSR,
         sum(msh.ORDER_QTY) cases_ordered,
         sum(msh.ORDER_QTY * i.ITEM_PACK_QTY) rsu_ordered,
         sum(msh.ORDER_QTY * i.CUBE_MSR) cube_ordered,
         sum(msh.ORDER_QTY * i.LBS_MSR) weight_ordered,
         sum(msh.ORDER_QTY * i.NET_MSR) net_weight_ordered,
         sum(msh.SHIP_QTY) cases_shipped,
         sum(msh.SHIP_QTY * i.ITEM_PACK_QTY) rsu_shipped,
         sum(msh.SHIP_QTY * i.CUBE_MSR) cube_shipped,
         sum(msh.SHIP_QTY * i.LBS_MSR) weight_shipped,
         sum(msh.SHIP_QTY * i.NET_MSR) net_weight_shipped,
         sum(msh.EXT_COST_AMT) total_cost,
         sum(msh.TOT_ORDER_LINE_AMT) total_sales,
         sum(msh.EXT_DRAYAGE_AMT) total_drayage
FROM     WH_OWNER.MDVSLS_DY_CUST_ITM msh 
         inner join WH_OWNER.MDV_DEPT md on msh.DEPT_CD = md.DEPT_CD
         inner join WH_OWNER.MDV_CUSTOMER c on msh.CUSTOMER_NBR = c.CUSTOMER_NBR 
         inner join WH_OWNER.MDV_SALES_CATGY sc on msh.SALES_CATGY_CODE = sc.SALES_CATGY_CODE
         inner join WH_OWNER.MDV_ORDER_CATEGORY oc on msh.ORDER_CATGY_CD = oc.ORDER_CATGY_CD
         inner join WH_OWNER.MDV_ITEM i on msh.DEPT_CD = i.DEPT_CD and msh.CASE_UPC_CD = i.CASE_UPC_CD
         inner join WH_OWNER.FISCAL_DAY fd on msh.SHIP_DATE = fd.SALES_DT 
WHERE    msh.SHIP_DATE between '12-29-2019' and '04-18-2020'
--WHERE    dsh.TRANSACTION_DATE between '12-29-2019' and '01-04-2020'
--AND      corp.CORPORATION_ID = 634001
--AND      dsh.FACILITY_ID not in (2, 71)
GROUP BY fd.FISCAL_PERIOD_ID,
         msh.DEPT_CD,
         md.DEPT_DESC, 
         md.DIVISION_CD, 
         md.PRODUCT_GROUP_ID, 
         md.COMMODITY_CD,
         msh.CUSTOMER_NBR,
         c.CUSTOMER_NAME, 
         msh.ORDER_CATGY_CD, 
         oc.ORDER_CATGY_DESC, 
         msh.SALES_CATGY_CODE,
         sc.SALES_CATGY_DESC,
         msh.CASE_UPC_CD,
         i.ITEM_DESC,
         i.ITEM_PACK_QTY,
         i.LBS_MSR,
         i.NET_MSR,
         i.CUBE_MSR
;
) x
;

--mdv
--mdvods
Select dept_cd, case_upc_cd, cube_msr from whmgr.mdv_item
;

--mdv
--crm
--average inventory extract
SELECT   lh.FACILITYID, lh.ITEM_DEPT, 
         lh.UPC_CASE,
         lh.RAND_WGT_CD,
         count(distinct LAYER_FILE_DTE) num_days,
         112 days_between,
         sum(lh.INVENTORY_TURN) ext_inventory_qty,
         sum((lh.INVENTORY_TURN * lh.CORRECT_NET_COST)) ext_inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on lh.FACILITYID = dx.SWAT_ID
WHERE    (dx.ENTERPRISE_KEY = 2 or lh.FACILITYID in ('080', '090'))
AND      lh.LAYER_FILE_DTE between '2019-12-29' and '2020-04-18'
GROUP BY lh.FACILITYID, lh.ITEM_DEPT, lh.UPC_CASE, lh.RAND_WGT_CD
;


--mdv
--mdvods
Select dept_cd, case_upc_cd, cube_msr from whmgr.mdv_item
;

--mdv
--crm
--average inventory extract
SELECT   lh.FACILITYID,
         lh.STOCK_FAC,
         lh.ITEM_DEPT,
         lh.ITEM_NBR_HS,
         lh.ITEM_DESCRIPTION,
         lh.UPC_CASE,
         i.SHIPPING_CASE_CUBE,
         i.ITEM_RES28 AMAZON_RESTRICTION,
         lh.RAND_WGT_CD,
         count(distinct LAYER_FILE_DTE) num_days,
         112 days_between,
         sum(lh.INVENTORY_TURN) ext_turn_qty,
         sum(lh.INVENTORY_PROMOTION) ext_promo_qty,
         sum(lh.INVENTORY_FWD_BUY) ext_fwd_buy_qty,
         sum(lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) ext_inventory_qty,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when lh.RAND_WGT_CD ='R' then lh.SHIPPING_CASE_WEIGHT else 1 end))) ext_inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on lh.FACILITYID = dx.SWAT_ID
WHERE    lh.FACILITYID in ('015', '058', '054', '002', '040')
AND      lh.LAYER_FILE_DTE between '2019-12-29' and '2020-04-18'
GROUP BY lh.FACILITYID, lh.STOCK_FAC, lh.ITEM_DEPT, lh.ITEM_NBR_HS, 
         lh.ITEM_DESCRIPTION, lh.UPC_CASE, i.SHIPPING_CASE_CUBE, i.ITEM_RES28, 
         lh.RAND_WGT_CD
;


SELECT   FACILITYID || ITEM_NBR_HS lookup,
         FACILITYID,
         ITEM_NBR_HS,
         SHIPPING_CASE_CUBE
FROM     CRMADMIN.T_WHSE_ITEM
where FACILITYID in ('015', '058', '054', '002', '040')
order by FACILITYID, ITEM_NBR_HS
;


SELECT   'AVG_4P_INV_CY' FACTOR,
         d.FISCAL_PERIOD,
         lh.LAYER_FILE_DTE,
         int(lh.FACILITYID) facility,
         int(lh.STOCK_FAC) stock_facility,
         int(i.ITEM_DEPT) dept,
         '' dept_name,
         int(i.ITEM_NBR_HS) item,
         i.SHIP_UNIT_CD,
         i.PURCH_STATUS,
         sum((lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) * ((case when lh.CORRECT_NET_COST <> 0 then lh.CORRECT_NET_COST else lh.NET_COST_PER_CASE end) * (case when i.RAND_WGT_CD ='R' then i.AVERAGE_WEIGHT else 1 end))) inventory_value
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_ITEM i on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS
