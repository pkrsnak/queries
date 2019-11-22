Select * from KPIADMIN.V_KPI_PO_EXCEPTIONS where DATE_ORDERED = current date - 1 days
;

create or replace view kpiadmin.V_KPI_ITEM_FACTORS as 
SELECT   i.FACILITYID, i.ITEM_DEPT,
         i.BUYER_NBR,
         i.ITEM_NBR,
         i.ITEM_NBR_HS,
         i.PURCH_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         nvl(i.LIST_COST,0) LIST_COST,
         i.LV_DESC,
         case when i.LV_DESC is null then 0 else (CASE WHEN left(i.LV_DESC, 3) = 'I/O' OR left(i.LV_DESC, 3) = 'SS ' OR left(i.LV_DESC, 3) = 'BTS' OR left(i.LV_DESC, 2) = 'C-' OR left(i.LV_DESC, 2) = 'H-' OR left(i.LV_DESC, 2) = 'V-' OR left(i.LV_DESC, 2) = 'E-' OR left(i.LV_DESC, 3) = 'S/O' THEN 1 ELSE 0 END) end I_O_FLAG,
         nvl(i.SAFETY_STOCK, 0) SAFETY_STOCK,
         nvl(i.CYCLE_STOCK, 0) CYCLE_STOCK,
         nvl(i.ORDER_INTERVAL_WEEKS, 0) ORDER_INTERVAL_WEEKS,
         nvl(i.CASES_PER_WEEK, 0) CASES_PER_WEEK,
         nvl(i.WHSE_TIE, 0) WHSE_TIE,
         nvl(i.WHSE_TIER, 0) WHSE_TIER,
         nvl(i.VENDOR_TIE, 0) VENDOR_TIE,
         nvl(i.VENDOR_TIER, 0 ) VENDOR_TIER,
         nvl(i.INVENTORY_TOTAL, 0) INVENTORY_TOTAL,
         nvl(i.IN_PROCESS_REGULAR, 0) IN_PROCESS_REGULAR,
         nvl(i.IN_PROCESS_PROMO, 0) IN_PROCESS_PROMO,
         nvl(i.RESERVE_COMMITTED, 0) RESERVE_COMMITTED,
         nvl(i.RESERVE_UNCOMMITTED, 0) RESERVE_UNCOMMITTED,
         nvl(i.STORAGE_COMMITTED, 0) STORAGE_COMMITTED,
         nvl(i.STORAGE_UNCOMMITTED, 0) STORAGE_UNCOMMITTED,
         nvl(poq_30.POQ_QTY, 0) POQ_30,
         nvl(poq_curr.POQ_QTY, 0) POQ_CURR,
         nvl(i.ORDER_POINT, 0) ORDER_POINT,
         nvl(i.INVENTORY_TURN, 0) INVENTORY_TURN,
         nvl(i.INVENTORY_PROMOTION, 0) INVENTORY_PROMOTION,
         nvl(i.INVENTORY_FWD_BUY, 0) INVENTORY_FWD_BUY,
         nvl(i.ON_ORDER_TOTAL, 0) ON_ORDER_TOTAL,
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
         nvl(i.PRODUCT_DATING, 0) PRODUCT_DATING,
         nvl(i.SHELF_LIFE, 0) SHELF_LIFE,
         nvl(i.DISTRESS_DAYS, 0) DISTRESS_DAYS,
         (nvl(i.SAFETY_STOCK, 0) + nvl(i.CYCLE_STOCK, 0) + (ceiling((nvl(case when nvl(i.ORDER_INTERVAL_WEEKS, 0) = 0 then 1 else nvl(i.ORDER_INTERVAL_WEEKS, 0) end, 0) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) + nvl(i.IN_PROCESS_REGULAR, 0) + nvl(i.IN_PROCESS_PROMO, 0) + nvl(i.RESERVE_COMMITTED, 0) + nvl(i.RESERVE_UNCOMMITTED, 0) + nvl(i.STORAGE_COMMITTED, 0) + nvl(i.STORAGE_UNCOMMITTED, 0) + nvl(i.ORDER_POINT, 0) + nvl(poq_30.poq_qty, 0) + ceiling((nvl(i.CASES_PER_WEEK, 0) * .5))) MAX_INVENTORY_CASES,
         (nvl(i.SAFETY_STOCK, 0) + nvl(i.CYCLE_STOCK, 0) + (ceiling((nvl(case when nvl(i.ORDER_INTERVAL_WEEKS, 0) = 0 then 1 else nvl(i.ORDER_INTERVAL_WEEKS, 0) end, 0) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) + nvl(i.IN_PROCESS_REGULAR, 0) + nvl(i.IN_PROCESS_PROMO, 0) + nvl(i.RESERVE_COMMITTED, 0) + nvl(i.RESERVE_UNCOMMITTED, 0) + nvl(i.STORAGE_COMMITTED, 0) + nvl(i.STORAGE_UNCOMMITTED, 0) + nvl(i.ORDER_POINT, 0) + nvl(poq_30.poq_qty, 0) + ceiling((nvl(i.CASES_PER_WEEK, 0) * .5))) * nvl(i.LIST_COST, 0) MAX_INVENTORY
FROM     CRMADMIN.T_WHSE_ITEM i
         left outer join (SELECT d.FACILITYID, d.ITEM_NBR, sum(d.PROMO_QTY) POQ_QTY FROM CRMADMIN.T_WHSE_DEAL d WHERE d.DATE_START >= (current_date + -30 DAY) AND d.PROMO_QTY <> 0 GROUP BY d.FACILITYID, d.ITEM_NBR) poq_30 on i.FACILITYID = poq_30.FACILITYID and i.ITEM_NBR_HS = poq_30.ITEM_NBR
         left outer join (SELECT d.FACILITYID, d.ITEM_NBR, sum(d.PROMO_QTY) POQ_QTY FROM CRMADMIN.T_WHSE_DEAL d WHERE current date between d.DATE_START and d.DATE_END AND d.PROMO_QTY <> 0 GROUP BY d.FACILITYID, d.ITEM_NBR) poq_curr on i.FACILITYID = poq_curr.FACILITYID and i.ITEM_NBR_HS = poq_curr.ITEM_NBR
WHERE    i.PURCH_STATUS not in 'Z'
;


--po exceptions
--run daily, accumulate weekly
create or replace view KPIADMIN.V_KPI_PO_EXCEPTIONS
as

SELECT   i.FACILITYID, i.ITEM_DEPT,
         pod.PO_NBR,
         pod.DATE_ORDERED,
         i.ITEM_NBR_HS,
         pod.BUYER_NBR, i.LIST_COST, i.LV_DESC, i.I_O_FLAG, i.SAFETY_STOCK, i.CYCLE_STOCK, i.ORDER_INTERVAL_WEEKS, i.CASES_PER_WEEK, i.WHSE_TIE, i.WHSE_TIER, i.VENDOR_TIE, i.VENDOR_TIER, i.INVENTORY_TOTAL, i.IN_PROCESS_REGULAR, i.IN_PROCESS_PROMO, i.RESERVE_COMMITTED, i.RESERVE_UNCOMMITTED, i.STORAGE_COMMITTED, i.STORAGE_UNCOMMITTED, i.POQ_30, i.POQ_CURR, i.ORDER_POINT, i.INVENTORY_TURN, i.INVENTORY_PROMOTION, i.INVENTORY_FWD_BUY,  i.ON_ORDER_TOTAL, i.MFG_MIN_ORDER_QTY, i.PRODUCT_DATING, i.MAX_INVENTORY_CASES, i.MAX_INVENTORY, i.SHELF_LIFE, i.DISTRESS_DAYS, pod.TURN po_turn, pod.PROMOTION po_promo, pod.FORWARD_BUY po_fwd_buy,
         max(((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - (i.ORDER_POINT + i.IN_PROCESS_REGULAR + i.IN_PROCESS_PROMO + i.POQ_CURR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + (ceiling(((case when i.ORDER_INTERVAL_WEEKS = 0 then 1 else i.ORDER_INTERVAL_WEEKS end) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY + pod.FORWARD_BUY + pod.PROMOTION)) - ceiling(i.CASES_PER_WEEK * .5), 0) EXCESS_INVENTORY_CASES_CHK,
         max(((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - (i.ORDER_POINT + i.IN_PROCESS_REGULAR + i.IN_PROCESS_PROMO + i.POQ_CURR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + (ceiling(((case when i.ORDER_INTERVAL_WEEKS = 0 then 1 else i.ORDER_INTERVAL_WEEKS end) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY + pod.FORWARD_BUY + pod.PROMOTION)) - ceiling(i.CASES_PER_WEEK * .5), 0) * i.LIST_COST EXCESS_INVENTORY_CHK,
         case when i.I_O_FLAG = 1 then 0 else case when max(((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - (i.ORDER_POINT + i.IN_PROCESS_REGULAR + i.IN_PROCESS_PROMO + i.POQ_CURR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + (ceiling(((case when i.ORDER_INTERVAL_WEEKS = 0 then 1 else i.ORDER_INTERVAL_WEEKS end) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY + pod.FORWARD_BUY)) - ceiling(i.CASES_PER_WEEK * .5), 0) > 0 then (case when i.ON_ORDER_TOTAL > (i.MFG_MIN_ORDER_QTY + i.SAFETY_STOCK) then 1 else 0 end) else 0 end end excess_check,
         case when (case when i.I_O_FLAG = 1 then 0 else case when max(((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - (i.ORDER_POINT + i.IN_PROCESS_REGULAR + i.IN_PROCESS_PROMO + i.POQ_CURR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + (ceiling(((case when i.ORDER_INTERVAL_WEEKS = 0 then 1 else i.ORDER_INTERVAL_WEEKS end) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY + pod.FORWARD_BUY + pod.PROMOTION)) - ceiling(i.CASES_PER_WEEK * .5), 0) > 0 then (case when i.ON_ORDER_TOTAL > (i.MFG_MIN_ORDER_QTY + i.SAFETY_STOCK) then 1 else 0 end) else 0 end end) = 1 then case when max(((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - (i.ORDER_POINT + i.IN_PROCESS_REGULAR + i.IN_PROCESS_PROMO + i.POQ_CURR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + (ceiling(((case when i.ORDER_INTERVAL_WEEKS = 0 then 1 else i.ORDER_INTERVAL_WEEKS end) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY + pod.FORWARD_BUY + pod.PROMOTION)) - ceiling(i.CASES_PER_WEEK * .5), 0) > i.MFG_MIN_ORDER_QTY then 1 else 0 end else 0 end excess_check_new,
--         case when (case when i.CASES_PER_WEEK = 0 or i.CASES_PER_WEEK is null then 0 else (case when (((pod.TURN + pod.FORWARD_BUY) - i.IN_PROCESS_REGULAR - i.RESERVE_COMMITTED - i.RESERVE_UNCOMMITTED - i.STORAGE_COMMITTED - i.STORAGE_UNCOMMITTED - poq_curr) / (double(i.CASES_PER_WEEK) / 7) > i.PRODUCT_DATING) then 1 else 0 end) end) = 1 then (case when MFG_MIN_ORDER_QTY = 0 then 0 else (case when int((pod.TURN + pod.PROMOTION + pod.FORWARD_BUY) / MFG_MIN_ORDER_QTY) <> 1 then 0 else 1 end) end) else 0 end code_date_check,

--case when i.CASES_PER_WEEK = 0 then 0 else floor(((pod.TURN + pod.FORWARD_BUY) - i.IN_PROCESS_REGULAR - i.RESERVE_COMMITTED - i.RESERVE_UNCOMMITTED - i.STORAGE_COMMITTED - i.STORAGE_UNCOMMITTED - poq_curr) / (double(i.CASES_PER_WEEK) / 7)) end code_date_p1, 

--i.PRODUCT_DATING dating_chk,

--(case when MFG_MIN_ORDER_QTY = 0 then 0 else int((pod.TURN + pod.FORWARD_BUY) / MFG_MIN_ORDER_QTY) end) code_date_p2,

         case when (case when nvl(i.CASES_PER_WEEK, 0) = 0 then 0 else (case when (floor(((pod.TURN + pod.FORWARD_BUY) - i.IN_PROCESS_REGULAR - i.IN_PROCESS_PROMO - i.RESERVE_COMMITTED - i.RESERVE_UNCOMMITTED - i.STORAGE_COMMITTED - i.STORAGE_UNCOMMITTED - poq_curr) / (double(i.CASES_PER_WEEK) / 7)) > i.PRODUCT_DATING) then 1 else 0 end) end) = 1 then (case when MFG_MIN_ORDER_QTY = 0 then 0 else (case when int((pod.TURN + pod.FORWARD_BUY) / MFG_MIN_ORDER_QTY) <> 1 then 1 else 0 end) end) else 0 end code_date_check,
         CASE WHEN i.I_O_FLAG = 1 AND pod.PROMOTION > i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED AND i.FACILITYID not in ('001', '066', '067') THEN 1 ELSE 0 END i_o_check
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join KPIADMIN.V_KPI_ITEM_FACTORS i on pod.FACILITYID = i.FACILITYID and pod.ITEM_NBR = i.ITEM_NBR 
--where pod.DATE_ORDERED = current date - 2 day
;



SELECT   shd.facilityid,
         shd.ITEM_NBR_HS,
         sum(case when shd.territory_no = 29 then 0 else (case when (shd.ORDER_TYPE = 'GB' or (div.PLATFORM_TYPE = 'LEGACY' and shd.QTY_SOLD = 0)) then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) end) ext_12wk_mvmt,
         ceiling((sum(case when shd.territory_no = 29 then 0 else (case when (shd.ORDER_TYPE = 'GB' or (div.PLATFORM_TYPE = 'LEGACY' and shd.QTY_SOLD = 0)) then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) end) / 12.0)) avg_12wk_mvmt,
         sum(case when shd.territory_no = 29 then (case when (shd.ORDER_TYPE = 'GB' or (div.PLATFORM_TYPE = 'LEGACY' and shd.QTY_SOLD = 0)) then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) else 0 end) ext_12wk_xfer_mvmt,
         ceiling((sum(case when shd.territory_no = 29 then (case when (shd.ORDER_TYPE = 'GB' or (div.PLATFORM_TYPE = 'LEGACY' and shd.QTY_SOLD = 0)) then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) else 0 end) / 12.0)) avg_12wk_xfer_mvmt
FROM     crmadmin.t_whse_sales_history_dtl shd 
         inner join crmadmin.t_whse_div_xref div on div.swat_id = shd.facilityid
WHERE    shd.billing_date between ((current date - dayofweek(current date) days) - 83 days) and (current date - dayofweek(current date) days)
AND      shd.order_source <> 'I'
AND      shd.out_reason_code not in ('004','011')
AND      shd.no_chrge_itm_cde <> '*'
AND      shd.order_type <> 'CR'
AND      shd.territory_no not in (14)
AND      shd.ITEM_NBR_HS not in ('0000000')
GROUP BY shd.facilityid, shd.ITEM_NBR_HS