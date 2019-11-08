--po exceptions
--run daily, accumulate weekly
create or replace view KPIADMIN.T_KPI_PO_EXCEPTIONS
as
SELECT   i.FACILITYID,
         pod.PO_NBR,
         i.ITEM_NBR_HS,
         pod.BUYER_NBR,
         case 
              when ((i.ORDER_POINT + i.SAFETY_STOCK + i.CYCLE_STOCK) + (pod.PROMOTION + pod.FORWARD_BUY + i.IN_PROCESS_REGULAR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY) - (i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL)) > (case 
                                                                                                                                                                                                                                                                                                                            when (i.SAFETY_STOCK + i.CYCLE_STOCK + floor(i.ORDER_INTERVAL_WEEKS * i.CASES_PER_WEEK) > MFG_MIN_ORDER_QTY) then (i.SAFETY_STOCK + i.CYCLE_STOCK + floor(i.ORDER_INTERVAL_WEEKS * i.CASES_PER_WEEK)) 
                                                                                                                                                                                                                                                                                                                            else MFG_MIN_ORDER_QTY 
                                                                                                                                                                                                                                                                                                                       end ) then 1 
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


--         case 
--              when (i.SAFETY_STOCK + i.CYCLE_STOCK + ROUND(i.ORDER_INTERVAL_WEEKS * i.CASES_PER_WEEK + 0.5,0) > MFG_MIN_ORDER_QTY) then (i.SAFETY_STOCK + i.CYCLE_STOCK + ROUND(i.ORDER_INTERVAL_WEEKS * i.CASES_PER_WEEK + 0.5,0)) 
--              else MFG_MIN_ORDER_QTY 
--         end inventory_max,
--         (case when poq.POQ_QTY is null then 0 else poq.POQ_QTY end) poq_qty,
--         case 
--              when ((i.INVENTORY_TOTAL - IN_PROCESS_REGULAR - RESERVE_COMMITTED - RESERVE_UNCOMMITTED - STORAGE_COMMITTED - STORAGE_UNCOMMITTED) - (case 
--                                                                                                                                                         when poq.POQ_QTY is null then 0 
--                                                                                                                                                         else poq.POQ_QTY end) > (ORDER_POINT * 1.17)) then 1 
--                                                                                                                                                         else 0 
--                                                                                                                                                    end order_point_chk,



--poq
(SELECT   d.FACILITYID,
         d.ITEM_NBR,
         sum(d.PROMO_QTY) PROMO_QTY
FROM     CRMADMIN.T_WHSE_DEAL d 
WHERE    d.DATE_START >= (current_date + -30 DAY)
AND      d.PROMO_QTY <> 0
GROUP BY d.FACILITYID, d.ITEM_NBR) poq
;








  [EXCESS CHECK] <> ''
OR
  [I/O CHECK] <> ''
OR
  [OP CHECK] <> ''
OR
  [CODE DT CHECK] <> ''
OR
  [MOQ CHECK] <> ''
;

