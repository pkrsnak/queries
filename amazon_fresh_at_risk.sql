SELECT   lc.FACILITYID,
         dx.DIV_NAME,
         i.STOCK_FAC,
         i.ITEM_ADDED_DATE,
         i.FIRST_RECEIVED_DATE,
         i.LAST_RECEIVED_DATE,
         i.ITEM_DEPT,
         d.DEPT_DESCRIPTION,
         i.PRODUCT_GROUP,
         pg.PROD_GROUP_DESC,
         lc.ITEM_NBR_HS,
         lc.ITEM_DESCRIPTION,
         i.PRIVATE_LABEL_INDICATOR,
         i.UPC_UNIT,
         i.UPC_CASE,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.ITEM_RES28 NATIONAL_ACCOUNTS,
         lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY total_on_hand_inventory,
         i.ON_ORDER_TOTAL,
         lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY + i.ON_ORDER_TOTAL total_inventory,
         i.LIST_COST,
         i.CASES_PER_WEEK,
         v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         tu.LU_CODE ASIN,
         lc.PO_NBR,
         lc.PO_RECEIPT_DTE,
         i.SHELF_LIFE,
         i.CODE_DATE_FLAG,
         i.CODE_DATE_MIN,
         i.CODE_DATE_MAX,
         eid.CDE_DT,
         i.DISTRESS_DAYS system_distress_days,
         tfc.DISTRESS_DAYS override_distress_days,
         i.CODE_DATE_MIN - (case when tfc.DISTRESS_DAYS > 0 then tfc.DISTRESS_DAYS else i.DISTRESS_DAYS end) DC_SHELF_LIFE,
         eid.CDE_DT - (case when tfc.DISTRESS_DAYS > 0 then tfc.DISTRESS_DAYS else i.DISTRESS_DAYS end) days pull_date,
         case when round((lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY) - ((i.CASES_PER_WEEK/7) * (days(eid.CDE_DT - (case when tfc.DISTRESS_DAYS > 0 then tfc.DISTRESS_DAYS else i.DISTRESS_DAYS end)days) - days(current date - 1 day))) + 1) < 0 then 0 else round((lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY) - ((i.CASES_PER_WEEK/7) * (days(eid.CDE_DT - (case when tfc.DISTRESS_DAYS > 0 then tfc.DISTRESS_DAYS else i.DISTRESS_DAYS end)days) - days(current date - 1 day))) + 1) end at_risk_qty
FROM     CRMADMIN.T_WHSE_LAYER_CURRENT lc 
         inner join CRMADMIN.T_WHSE_ITEM i on lc.FACILITYID = i.FACILITYID and lc.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on dx.SWAT_ID = i.FACILITYID 
         inner join CRMADMIN.T_WHSE_DEPT d on i.ITEM_DEPT = d.DEPT_CODE 
         inner join CRMADMIN.T_WHSE_PROD_GROUP pg on pg.FACILITY = i.FACILITYID and pg.PROD_GROUP = i.PRODUCT_GROUP 
         inner join CRMADMIN.T_WHSE_PROD_SUBGROUP psg on psg.FACILITY = i.FACILITYID and psg.PROD_SUBGROUP = i.PRODUCT_SUB_GROUP 
         inner join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join ETLADMIN.T_TEMP_FAC_SUBGROUP tfc on i.FACILITYID = tfc.FACILITYID and i.PRODUCT_SUB_GROUP = tfc.PROD_SUBGROUP 
         left outer join (SELECT Distinct FACILITYID, PO_NBR, ITEM_NBR_HS, CDE_DT FROM CRMADMIN.T_WHSE_EXE_INV_DTL) eid on lc.FACILITYID = eid.FACILITYID and lc.ITEM_NBR_HS = eid.ITEM_NBR_HS and lc.PO_NBR = eid.PO_NBR
WHERE    lc.FACILITYID in ('008', '015', '040', '058', '085', '086')
AND      lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY > 0
;

--         (lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY + i.ON_ORDER_TOTAL) * i.LIST_COST inventory_value,
--         case 
--              when i.CASES_PER_WEEK = 0 then 0 
--              else ((lc.INVENTORY_TURN + lc.INVENTORY_PROMOTION + lc.INVENTORY_FWD_BUY + i.ON_ORDER_TOTAL) / i.CASES_PER_WEEK) 
--         end total_weeks,
SELECT   FACILITYID,
         LIC_PLT_ID,
         WAREHOUSE_ID,
         ITEM_NBR_HS,
         PO_NBR,
         PROD_QTY,
         CSE_LAYER_QTY,
         CDE_DT,
         RECEIPT_DTIM FR;

insert into ETLADMIN.T_TEMP_FAC_SUBGROUP
SELECT   i.FACILITYID,
         i.PRODUCT_SUB_GROUP,
         0 dummy
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DEPT d on i.ITEM_DEPT = d.DEPT_CODE 
         inner join CRMADMIN.T_WHSE_PROD_GROUP pg on pg.FACILITY = i.FACILITYID and pg.PROD_GROUP = i.PRODUCT_GROUP 
         inner join CRMADMIN.T_WHSE_PROD_SUBGROUP psg on psg.FACILITY = i.FACILITYID and psg.PROD_SUBGROUP = i.PRODUCT_SUB_GROUP 
         inner join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR
WHERE    i.FACILITYID in ('008', '015', '040', '058', '085', '086')
AND      i.purch_status not in ('D', 'Z')
AND      i.item_dept not in ('010', '072', '030', '035', '020', '025', '080', '084', '086')
GROUP BY i.FACILITYID, i.PRODUCT_SUB_GROUP;

SELECT   'Waved',
         aseld.FACILITYID,
         aseld.whse_id,
         swhse.WAREHOUSE_CODE_DESC_FAC,
         sum(prod_qty/unit_ship_cse)
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld,
         CRMADMIN.T_WHSE_WAREHOUSE_CODE swhse
WHERE    aseld.create_dtim between current date - 1 day and current date
AND      aseld.create_user <> 'VVSPA'
AND      aseld.FACILITYID = swhse.FACILITYID
AND      aseld.whse_id = int(swhse.WAREHOUSE_CODE)
GROUP BY aseld.FACILITYID, aseld.whse_id, swhse.WAREHOUSE_CODE_DESC_FAC
UNION 
SELECT   'Re-Selected',
         aseld.FACILITYID,
         aseld.whse_id,
         swhse.WAREHOUSE_CODE_DESC_FAC,
         sum(aseld.prod_qty/aseld.unit_ship_cse)
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld,
         CRMADMIN.T_WHSE_WAREHOUSE_CODE swhse
WHERE    aseld.create_dtim between current date - 1 day and current date
AND      aseld.create_user = 'VVSPA'
AND      aseld.dc_id = swhse.FACILITYID
AND      aseld.whse_id = int(swhse.WAREHOUSE_CODE)
GROUP BY aseld.FACILITYID, aseld.whse_id, swhse.WAREHOUSE_CODE_DESC_FAC
UNION 
SELECT   'GoBack',
         aseld.FACILITYID,
         aseld.whse_id,
         swhse.WAREHOUSE_CODE_DESC_FAC,
         sum(aseld.act_pick_qty/aseld.unit_ship_cse)
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld 
         inner join CRMADMIN.T_WHSE_EXE_ASELD aseld2 on aseld.FACILITYID = aseld2.FACILITYID AND aseld.whse_id = aseld2.whse_id AND aseld.ord_id = aseld2.ord_id AND aseld.sgmt_id = aseld2.sgmt_id AND aseld.ordd_id = aseld2.ordd_id AND aseld.prod_id = aseld2.prod_id AND aseld.prdd_id = aseld2.prdd_id 
         inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE swhse on aseld.FACILITYID = swhse.FACILITYID AND aseld.whse_id = int(swhse.WAREHOUSE_CODE)
WHERE    aseld.create_dtim between current date - 1 day and current date
AND      aseld2.create_dtim between current date - 1 day and current date
AND      aseld.prod_qty <> aseld2.prod_qty
AND      aseld.act_pick_qty <> 0
GROUP BY aseld.FACILITYID, aseld.whse_id, swhse.WAREHOUSE_CODE_DESC_FAC
ORDER BY 1, 2, 3;

SELECT   tfs.FACILITYID,
         tfs.PROD_SUBGROUP,
         psg.PROD_SUBGROUP_DESC,
         tfs.DISTRESS_DAYS
FROM     ETLADMIN.T_TEMP_FAC_SUBGROUP tfs 
         inner join CRMADMIN.T_WHSE_PROD_SUBGROUP psg on psg.FACILITY = tfs.FACILITYID and psg.PROD_SUBGROUP = tfs.PROD_SUBGROUP