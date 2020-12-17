---actual report-----
SELECT   eia.FACILITYID,
         eia.WHSE_ID,
         i.ITEM_DEPT,
         i.RETAIL_DEPT,
         i.ITEM_NBR_HS,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_RES28 AMAZON_RES28,
         lh.RAND_WGT_CD,
         lh.SHIPPING_CASE_WEIGHT,
         eia.LOC_ID,
         eia.IARC_ID ADJ_TYPE,
         eia.ADJ_QTY,
         (eia.ADJ_QTY / i.PACK_CASE) ADJ_CASE_QTY,
         lh.LAYER_COST,
         case lh.RAND_WGT_CD 
              when 'R' then lh.SHIPPING_CASE_WEIGHT 
              else 1 
         end * lh.layer_cost * (eia.ADJ_QTY / i.PACK_CASE) EXT_LAYER_COST,
         date(eia.CREATE_DTIM) create_date,
         date(eia.EXTR_DATE) extract_date,
         eia.CREATE_USER,
         eia.SEL_LOC_ID,
         lh.PO_NBR,
         po.DATE_ORDERED,
         lh.PO_RECEIPT_DTE,
         lh.FISCAL_WEEK,
         i.VENDOR_NBR,
         CASE 
              WHEN i.VENDOR_PALLET_FACTOR = 'C' THEN nvl(i.SAFETY_STOCK, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'L' THEN nvl(i.WHSE_TIE, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'N' THEN 0 
              WHEN i.VENDOR_PALLET_FACTOR = 'P' THEN nvl(i.VENDOR_TIE, 0) * nvl(i.VENDOR_TIER, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'T' THEN nvl(i.VENDOR_TIE, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'U' THEN 1 
              WHEN i.VENDOR_PALLET_FACTOR = 'W' THEN nvl(i.WHSE_TIE, 0) * nvl(i.WHSE_TIER, 0) 
              ELSE -99 
         END mfg_min_order_qty,
         eia.LIC_PLT_ID
FROM     CRMADMIN.T_WHSE_EXE_IIALG eia 
         inner join CRMADMIN.T_WHSE_ITEM i on eia.FACILITYID = i.FACILITYID and int(eia.PROD_ID) = i.ITEM_NBR_HS 
         inner join ( SELECT ROW_NUMBER() OVER(partition by LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS) row_num, LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_NBR, PO_RECEIPT_DTE, RAND_WGT_CD, lh.SHIPPING_CASE_WEIGHT, fc.FISCAL_WEEK,(lh.INVENTORY_TURN + lh.TURN_QTY_SOLD + lh.INVENTORY_PROMOTION + lh.PROMO_QTY_SOLD + lh.INVENTORY_FWD_BUY + lh.FWD_BUY_SOLD) po_received_qty, (case when CORRECT_NET_COST <> 0 then CORRECT_NET_COST else NET_COST_PER_CASE end) layer_cost FROM CRMADMIN.T_WHSE_LAYER_HISTORY lh inner join CRMADMIN.V_FISCAL_CALENDAR fc on lh.LAYER_FILE_DTE = fc.DATE_KEY and lh.LAYER_FILE_DTE between current date - #prompt('start_days_back', 'integer')# days and current date - #prompt('end_days_back', 'integer')# days ORDER BY LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_RECEIPT_DTE, PO_NBR ) lh on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS and lh.LAYER_FILE_DTE = eia.EXTR_DATE --and lh.row_num = 1 
         left outer join (SELECT poh.FACILITYID, poh.PO_NBR, max(poh.DATE_ORDERED) date_ordered FROM CRMADMIN.T_WHSE_PO_HDR poh group BY poh.FACILITYID, poh.PO_NBR) po on lh.FACILITYID = po.FACILITYID and lh.PO_NBR = po.PO_NBR
WHERE    eia.IARC_ID = 'SD'
;




SELECT   ROW_NUMBER() OVER(partition by LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS) row_num,
         LAYER_FILE_DTE,
         FACILITYID,
         ITEM_NBR_HS,
         PO_NBR,
         PO_RECEIPT_DTE,
         RAND_WGT_CD,
         lh.SHIPPING_CASE_WEIGHT,
         fc.FISCAL_WEEK,
         (lh.INVENTORY_TURN + lh.TURN_QTY_SOLD + lh.INVENTORY_PROMOTION + lh.PROMO_QTY_SOLD + lh.INVENTORY_FWD_BUY + lh.FWD_BUY_SOLD) po_received_qty,
         (case when CORRECT_NET_COST <> 0 then CORRECT_NET_COST else NET_COST_PER_CASE end) layer_cost
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.V_FISCAL_CALENDAR fc on lh.LAYER_FILE_DTE = fc.DATE_KEY and lh.LAYER_FILE_DTE between current date - 1 days and current date - 1 days
ORDER BY LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_RECEIPT_DTE, PO_NBR
--having row_num = 1 
;

select * from CRMADMIN.T_WHSE_LAYER_CURRENT where FACILITYID = '003'