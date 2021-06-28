SELECT   i.FACILITYID,
         i.ITEM_DEPT,
         i.BUYER_NBR,
         i.ITEM_NBR,
         i.ITEM_NBR_HS,
         i.PURCH_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         nvl(i.LIST_COST,0) LIST_COST,
         i.LV_DESC,
         case 
              when i.LV_DESC is null then 0 
              else (CASE 
                         WHEN left(i.LV_DESC, 3) = 'I/O' OR left(i.LV_DESC, 3) = 'SS ' OR left(i.LV_DESC, 3) = 'BTS' OR left(i.LV_DESC, 2) = 'C-' OR left(i.LV_DESC, 2) = 'H-' OR left(i.LV_DESC, 2) = 'V-' OR left(i.LV_DESC, 2) = 'E-' OR left(i.LV_DESC, 3) = 'S/O' THEN 1 
                         ELSE 0 END) 
                    end I_O_FLAG,
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
         left outer join (SELECT d.FACILITYID, d.ITEM_NBR, sum(d.PROMO_QTY) POQ_QTY FROM CRMADMIN.T_WHSE_DEAL d WHERE d.DATE_DEAL_ARRIVE + 2 days between current date and (current_date + 30 DAY) AND d.PROMO_QTY <> 0 GROUP BY d.FACILITYID, d.ITEM_NBR) poq_30 on i.FACILITYID = poq_30.FACILITYID and i.ITEM_NBR_CD = poq_30.ITEM_NBR 
         left outer join (SELECT d.FACILITYID, d.ITEM_NBR, sum(d.PROMO_QTY) POQ_QTY FROM CRMADMIN.T_WHSE_DEAL d WHERE current date between d.DATE_DEAL_ARRIVE + 2 days and d.DATE_DEAL_ARRIVE + 23 days AND d.PROMO_QTY <> 0 GROUP BY d.FACILITYID, d.ITEM_NBR) poq_curr on i.FACILITYID = poq_curr.FACILITYID and i.ITEM_NBR_CD = poq_curr.ITEM_NBR
WHERE    i.PURCH_STATUS not in 'Z'
;
--poq 
SELECT   d.FACILITYID,
         d.ITEM_NBR,
         asin.LU_CODE asin,
         d.DATE_DEAL_ARRIVE,
         sum(d.PROMO_QTY) POQ_QTY
FROM     CRMADMIN.T_WHSE_DEAL d 
         inner join CRMADMIN.T_WHSE_ITEM i on d.FACILITYID = i.FACILITYID and d.ITEM_NBR = i.ITEM_NBR_HS 
         inner join CRMADMIN.V_AMZ_ASIN asin on asin.ROOT_ITEM_NBR = i.ROOT_ITEM_NBR and asin.LV_ITEM_NBR = i.LV_ITEM_NBR
WHERE    d.DATE_DEAL_ARRIVE + 2 days between current date and (current_date + 30 DAY)
AND      d.PROMO_QTY <> 0
AND      ((i.ITEM_RES28 = 'A'
     AND (left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 6) = 'AMAZON'
        OR  left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 3) = 'AMZ'
        OR  left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 4) = 'AMZN'
        OR  left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 4) = 'MEND'
        OR  left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 8) = 'ITEM ADD'
        OR  left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 8) = 'NEW ITEM'))
or (i.ITEM_RES28 <> 'A'
     AND (left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 6) = 'AMAZON'
        OR  left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 3) = 'AMZ'
        OR  left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 4) = 'AMZN'
        OR  left(trim(case when trim(d.REMRK) = '' then d.REMRK_3 else d.REMRK end), 4) = 'MEND'))
)
GROUP BY d.FACILITYID, d.ITEM_NBR, asin.LU_CODE, d.DATE_DEAL_ARRIVE
;


If ‘REMRK’ is blank, default to ‘REMRK_3’
A Remark that qualifies a POQ on an “A” Flagged (RES_28) AMZ item contains either “AMAZON”, “AMZ”, “AMZN”, “MEND”, “ITEM ADD”, or “NEW ITEM”
A Remark that qualifies a POQ on a non-“A” Flagged (RES_28) AMZ item contains either “AMAZON”, “AMZ”, “AMZN” or “MEND”


--orders
SELECT   od.FACILITYID,
         od.ITEM_NBR_HS,
         asin.LU_CODE asin,
         od.CUSTOMER_NBR_STND,
         od.ORDER_RECVD_DTE,
         od.QTY,
         od.NET_QTY
FROM     CRMADMIN.T_WHSE_ORDER_DTL od 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = od.FACILITYID and i.ITEM_NBR_HS = od.ITEM_NBR_HS 
         inner join CRMADMIN.V_AMZ_ASIN asin on asin.ROOT_ITEM_NBR = i.ROOT_ITEM_NBR and asin.LV_ITEM_NBR = i.LV_ITEM_NBR
where od.ORDER_RECVD_DTE = current date
;