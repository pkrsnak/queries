create or replace view kpiadmin.V_KPI_ITEM_FACTORS as 
SELECT   i.FACILITYID,
         i.BUYER_NBR,
         i.ITEM_NBR,
         i.ITEM_NBR_HS, i.PURCH_STATUS, i.BILLING_STATUS_BACKSCREEN, i.LIST_COST,
         i.LV_DESC,
--         left(i.LV_DESC, 3) LV_PRE,
         CASE 
              WHEN left(i.LV_DESC, 3) = 'I/O' OR left(i.LV_DESC, 3) = 'SS ' OR left(i.LV_DESC, 3) = 'BTS' OR left(i.LV_DESC, 2) = 'C-' OR left(i.LV_DESC, 2) = 'H-' OR left(i.LV_DESC, 2) = 'V-' OR left(i.LV_DESC, 2) = 'E-' OR left(i.LV_DESC, 3) = 'S/O' THEN 1 
              ELSE 0 
         END I_O_FLAG,
         i.SAFETY_STOCK,
         i.CYCLE_STOCK,
         i.ORDER_INTERVAL_WEEKS,
         i.CASES_PER_WEEK,
         i.WHSE_TIE,
         i.WHSE_TIER,
         i.VENDOR_TIE,
         i.VENDOR_TIER,
         i.INVENTORY_TOTAL,
         i.IN_PROCESS_REGULAR, i.IN_PROCESS_PROMO,
         i.RESERVE_COMMITTED,
         i.RESERVE_UNCOMMITTED,
         i.STORAGE_COMMITTED,
         i.STORAGE_UNCOMMITTED,
         i.ORDER_POINT,
         i.INVENTORY_TURN,
         i.INVENTORY_PROMOTION,
         i.INVENTORY_FWD_BUY,
         i.ON_ORDER_TOTAL,
         CASE 
              WHEN i.VENDOR_PALLET_FACTOR = 'C' THEN -1 
              WHEN i.VENDOR_PALLET_FACTOR = 'L' THEN i.WHSE_TIE 
              WHEN i.VENDOR_PALLET_FACTOR = 'N' THEN 0 
              WHEN i.VENDOR_PALLET_FACTOR = 'P' THEN i.VENDOR_TIE * i.VENDOR_TIER 
              WHEN i.VENDOR_PALLET_FACTOR = 'T' THEN i.VENDOR_TIE 
              WHEN i.VENDOR_PALLET_FACTOR = 'U' THEN 1 
              WHEN i.VENDOR_PALLET_FACTOR = 'W' THEN i.WHSE_TIE * i.WHSE_TIER 
              ELSE -99 
         END mfg_min_order_qty,
         i.PRODUCT_DATING,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS, 
         (ceiling(((i.ORDER_INTERVAL_WEEKS * 7) * (double(i.CASES_PER_WEEK) / 7)))) + i.CYCLE_STOCK + i.SAFETY_STOCK max1, 
         max((ceiling(((i.ORDER_INTERVAL_WEEKS * 7) * (double(i.CASES_PER_WEEK) / 7)))) + i.CYCLE_STOCK + i.SAFETY_STOCK, 
         (CASE 
              WHEN i.VENDOR_PALLET_FACTOR = 'C' THEN -1 
              WHEN i.VENDOR_PALLET_FACTOR = 'L' THEN i.WHSE_TIE 
              WHEN i.VENDOR_PALLET_FACTOR = 'N' THEN 0 
              WHEN i.VENDOR_PALLET_FACTOR = 'P' THEN i.VENDOR_TIE * i.VENDOR_TIER 
              WHEN i.VENDOR_PALLET_FACTOR = 'T' THEN i.VENDOR_TIE 
              WHEN i.VENDOR_PALLET_FACTOR = 'U' THEN 1 
              WHEN i.VENDOR_PALLET_FACTOR = 'W' THEN i.WHSE_TIE * i.WHSE_TIER 
              ELSE -99 
         END) + i.SAFETY_STOCK) MAX_INVENTORY
FROM     CRMADMIN.T_WHSE_ITEM i
where i.PURCH_STATUS not in 'Z'
;


MOQ	"IF([Ord Restriction] = ""L"", [Whse Tie] 
  , IF( [Ord Restriction] = ""N"", 1 
    , IF( [Ord Restriction] = ""C"", -1 
      , IF( [Ord Restriction] = ""P"", [Vend Tie] * [Vend Tier] 
        , IF( [Ord Restriction] = ""T"", [Vend Tie] 
          , IF( [Ord Restriction] = ""U"", 1 
            , IF( [Ord Restriction] = ""W"", [Whse Tie] * [Whse Tier] 
            , -99 ) ) ) ) ) ) )"

Avail Inv $	[Available Inventory] * [@List]
Max  Inventory	MAX([Ord Intvl Day CS] + [Cycle Stock CS] + [Safety Stock CS], [MOQ] + [Safety Stock CS])



Max Excess $	[Max Excess Cases]*[List]
OP $	[Order Pt] * [List]
OH $	[Total OH] * [List]
Max Excess Cases	MAX([Available Inventory] - [Max  Inventory], 0)
Available Inventory	MAX([Total OH] - [Promo] - [Fwd Buy] - [Reserves] - [In Process Reg] - [In Process Promo], 0)
--Ord Intvl Day CS	ROUNDUP(([Order Intvl Wks] * 7) * [Daily Fcst], 0)
;


--po exceptions
--run daily, accumulate weekly
create or replace view KPIADMIN.V_KPI_PO_EXCEPTIONS
as
SELECT   i.FACILITYID,
         pod.PO_NBR,
         pod.DATE_ORDERED,
         i.ITEM_NBR_HS,
         pod.BUYER_NBR,
         case 
              when ((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - ((i.ORDER_POINT + i.SAFETY_STOCK + i.CYCLE_STOCK) + (pod.PROMOTION + pod.FORWARD_BUY + i.IN_PROCESS_REGULAR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY))) > ceiling(0.5 * i.CASES_PER_WEEK) then (case 
                                                                                                                                                                                                                                                                                                                                                                   when i.ON_ORDER_TOTAL > MFG_MIN_ORDER_QTY then 1 
                                                                                                                                                                                                                                                                                                                                                                   else 0 end) 
                                                                                                                                                                                                                                                                                                                                                                   else 0 
                                                                                                                                                                                                                                                                                                                                                              end excess_check,
         case 
              when (case 
                         when i.CASES_PER_WEEK = 0 or i.CASES_PER_WEEK is null then 0 
                         else ( case 
                                     when (((pod.TURN + pod.FORWARD_BUY) - i.IN_PROCESS_REGULAR - i.RESERVE_COMMITTED - i.RESERVE_UNCOMMITTED - i.STORAGE_COMMITTED - i.STORAGE_UNCOMMITTED) / (double(i.CASES_PER_WEEK) / 7) > i.PRODUCT_DATING) then 1 
                                     else 0 end) end) = 1 then (case 
                                                                     when MFG_MIN_ORDER_QTY = 0 then 0 
                                                                     else (case 
                                                                                when int((pod.TURN + pod.PROMOTION + pod.FORWARD_BUY) / MFG_MIN_ORDER_QTY) <> 1 then 0 
                                                                                else 1 end) end) 
                                                                                else 0 
                                                                           end code_date_check,
         CASE 
              WHEN i.I_O_FLAG = 1 AND pod.PROMOTION > i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED AND i.FACILITYID <> '001' THEN 1 
              ELSE 0 
         END i_o_check
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join KPIADMIN.V_KPI_ITEM_FACTORS i on pod.FACILITYID = i.FACILITYID and pod.ITEM_NBR = i.ITEM_NBR 
         left outer join (SELECT d.FACILITYID, d.ITEM_NBR, sum(d.PROMO_QTY) POQ_QTY FROM CRMADMIN.T_WHSE_DEAL d WHERE d.DATE_START >= (current_date + -30 DAY) AND d.PROMO_QTY <> 0 GROUP BY d.FACILITYID, d.ITEM_NBR) poq on i.FACILITYID = poq.FACILITYID and i.ITEM_NBR_HS = poq.ITEM_NBR
--WHERE    pod.DATE_ORDERED between '2019-10-27' and '2019-11-02'
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