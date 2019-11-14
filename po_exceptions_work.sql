SELECT   i.FACILITYID,
         pod.PO_NBR,
         pod.DATE_ORDERED,
         i.ITEM_NBR_HS,
         pod.BUYER_NBR, i.INVENTORY_TOTAL, i.ON_ORDER_TOTAL,
         (i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) inv_oh_oo, i.ORDER_POINT, i.SAFETY_STOCK, i.CYCLE_STOCK,
         (i.ORDER_POINT + i.SAFETY_STOCK + i.CYCLE_STOCK) op_ss_cc, pod.PROMOTION, pod.FORWARD_BUY,
         pod.PROMOTION + pod.FORWARD_BUY po_pr_fb, i.INVENTORY_PROMOTION, i.INVENTORY_FWD_BUY,
         i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY inv_pr_fb, i.IN_PROCESS_REGULAR, i.RESERVE_COMMITTED, i.RESERVE_UNCOMMITTED, i.STORAGE_COMMITTED, i.STORAGE_UNCOMMITTED,
         i.IN_PROCESS_REGULAR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED res_storage,
         ((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - ((i.ORDER_POINT + i.SAFETY_STOCK + i.CYCLE_STOCK) + (pod.PROMOTION + pod.FORWARD_BUY + i.IN_PROCESS_REGULAR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY))) inventory_stuff,
         max(((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - ((i.ORDER_POINT + i.SAFETY_STOCK + i.CYCLE_STOCK) + (pod.PROMOTION + pod.FORWARD_BUY + i.IN_PROCESS_REGULAR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY))),0) inventory_stuff_fixed, i.ON_ORDER_TOTAL, MFG_MIN_ORDER_QTY,
         case 
                                                                                                                                                                                                                                                                                                                                                                   when i.ON_ORDER_TOTAL > MFG_MIN_ORDER_QTY then 1 
                                                                                                                                                                                                                                                                                                                                                                   else 0 end other_half, i.CASES_PER_WEEK,
         ceiling(0.5 * i.CASES_PER_WEEK) half_week_fcst,
         i.ON_ORDER_TOTAL, MFG_MIN_ORDER_QTY,
         case 
              when (max((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - ((i.ORDER_POINT + i.SAFETY_STOCK + i.CYCLE_STOCK) + (pod.PROMOTION + pod.FORWARD_BUY + i.IN_PROCESS_REGULAR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY)),0)) > ceiling(0.5 * i.CASES_PER_WEEK) then (case 
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
where pod.DATE_ORDERED = current date - 3 days
