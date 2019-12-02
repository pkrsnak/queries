SELECT   mi.dept_cd,
         mi.case_upc_cd,
         mi.buyer_id,
         mi.case_cost_amt,
         mi.item_desc,
         mi.season_cd,
         mi.i_o_flg,
         mi.lead_time_id,
         mi.safety_stock_qty,
         mi.forecast_qty,
         mi.on_hand_qty,
         mi.reserved_qty,
         mi.advanced_order_qty,
         mi.order_point_qty,
         mi.on_order_qty,
         mi.econ_order_qty,
         mi.moq,
         mi.shelf_life_nbr,
         mi.poq,
         mi.max_inventory_cases,
         mi.max_inventory,
         mi.excess_inventory_cases_chk,
         pod.input_date,
         pod.line_nbr,
         pod.order_nbr,
         pod.order_status_cd,
         pod.case_pack_msr,
         pod.order_qty,
         pod.reference_cd,
         pod.line_weight_msr, 
        case when mi.i_o_flg = 1 then 0 else case when mi.excess_inventory_cases_chk - mi.max_inventory_cases > 0 then 1 else 0 end end excess_check, 
        case when mi.forecast_qty = 0 then 0 else case when ((pod.order_qty - (mi.advanced_order_qty + mi.reserved_qty + mi.xdock_on_order_qty + mi.deal_qty)) / mi.forecast_qty) > mi.shelf_life_nbr then case when pod.order_qty > mi.moq then 1 else 0 end else 0 end end code_date_check,
        case when mi.i_o_flg = 1 AND (mi.on_hand_qty + mi.on_order_qty - pod.order_qty) - (mi.reserved_qty + mi.advanced_order_qty + mi.xdock_on_order_qty + mi.xdock_on_hand_qty + mi.deal_qty) > 0  THEN 1 ELSE 0 END i_o_check
FROM     whmgr.mdv_po_dtl pod 
         inner join (SELECT i.dept_cd, i.case_upc_cd, i.buyer_id, i.case_cost_amt, i.item_desc, i.season_cd, case when i.rstr_subst_list_cd in ('O1', 'O2', 'O3', 'O4', 'O5') THEN 1 else 0 end I_O_FLG, i.lead_time_id, i.safety_stock_qty, i.forecast_qty, i.on_hand_qty, i.reserved_qty, i.advanced_order_qty, i.order_point_qty, i.on_order_qty, i.econ_order_qty, i.eff_econ_order_qty moq, i.xdock_on_order_qty, i.xdock_on_hand_qty, i.deal_qty, i.shelf_life_nbr, i.deal_qty poq, (i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) MAX_INVENTORY_CASES, (i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7) * i.forecast_qty)) * i.case_cost_amt MAX_INVENTORY, ((i.on_hand_qty + i.on_order_qty) - (i.order_point_qty + i.deal_qty + i.advanced_order_qty + i.xdock_on_hand_qty + i.xdock_on_order_qty + i.reserved_qty)) - (i.forecast_qty * .5) EXCESS_INVENTORY_CASES_CHK FROM whmgr.mdv_item i) mi on pod.dept_cd = mi.dept_cd and pod.case_upc_cd = mi.case_upc_cd
WHERE    pod.input_date = '11-15-2019'
;


SELECT   i.dept_cd,
         i.case_upc_cd,
         i.buyer_id,
         i.case_cost_amt,
         i.item_desc,
         i.season_cd,
         case 
              when i.rstr_subst_list_cd in ('O1', 'O2', 'O3', 'O4', 'O5') THEN 1 
              else 0 
         end I_O_FLG,
         i.lead_time_id,
         i.safety_stock_qty,
         i.forecast_qty,
         i.on_hand_qty, i.on_order_qty,
         i.reserved_qty,
         i.advanced_order_qty,
         i.order_point_qty,
         i.on_order_qty,
         i.econ_order_qty,
         i.eff_econ_order_qty moq,
         i.xdock_on_order_qty, i.xdock_on_hand_qty,
         i.deal_qty,
         i.shelf_life_nbr,
         i.deal_qty poq,
         (i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) MAX_INVENTORY_CASES,
         (i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7) * i.forecast_qty)) * i.case_cost_amt MAX_INVENTORY,
         ((i.on_hand_qty + i.on_order_qty) - (i.order_point_qty + i.deal_qty + i.advanced_order_qty + i.xdock_on_hand_qty + i.xdock_on_order_qty + i.reserved_qty)) - (i.forecast_qty * .5) EXCESS_INVENTORY_CASES_CHK,
         case when ((i.on_hand_qty) - (i.order_point_qty + i.deal_qty + i.advanced_order_qty + i.xdock_on_hand_qty + i.reserved_qty)) - (i.forecast_qty * .5) > 0 then ((i.on_hand_qty) - (i.order_point_qty + i.deal_qty + i.advanced_order_qty + i.xdock_on_hand_qty + i.reserved_qty)) - (i.forecast_qty * .5) else 0 end EXCESS_INVENTORY_CASES,
         case when ((i.on_hand_qty) - (i.order_point_qty + i.deal_qty + i.advanced_order_qty + i.xdock_on_hand_qty + i.reserved_qty)) - (i.forecast_qty * .5) > 0 then ((i.on_hand_qty) - (i.order_point_qty + i.deal_qty + i.advanced_order_qty + i.xdock_on_hand_qty + i.reserved_qty)) - (i.forecast_qty * .5) else 0 end * i.case_cost_amt EXCESS_INVENTORY_CASES
FROM     whmgr.mdv_item i
;


--         max(((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - (i.ORDER_POINT + i.IN_PROCESS_REGULAR + i.IN_PROCESS_PROMO + i.POQ_CURR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + (ceiling(((case when i.ORDER_INTERVAL_WEEKS = 0 then 1 else i.ORDER_INTERVAL_WEEKS end) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY + pod.FORWARD_BUY + pod.PROMOTION)) - ceiling(i.CASES_PER_WEEK * .5), 0) * i.LIST_COST EXCESS_INVENTORY_CHK,

--        case when i.I_O_FLAG = 1 then 0 else case when ( max(((i.INVENTORY_TOTAL + i.ON_ORDER_TOTAL) - (i.ORDER_POINT + i.IN_PROCESS_REGULAR + i.IN_PROCESS_PROMO + i.POQ_CURR + i.RESERVE_COMMITTED + i.RESERVE_UNCOMMITTED + i.STORAGE_COMMITTED + i.STORAGE_UNCOMMITTED + (ceiling(((case when i.ORDER_INTERVAL_WEEKS = 0 then 1 else i.ORDER_INTERVAL_WEEKS end) * 7) * (double(nvl(i.CASES_PER_WEEK, 0)) / 7))) + i.INVENTORY_PROMOTION + i.INVENTORY_FWD_BUY + pod.FORWARD_BUY + pod.PROMOTION)) - ceiling(i.CASES_PER_WEEK * .5), 0) - i.MAX_INVENTORY_CASES) > 0 then 1 else 0 end end excess_check,

--case when (po.on_order_qty - (i.advanced_order_qty + i.reserved_qty + i.xdock_on_order_qty + i.deal_qty) / i.forecast_qty) > i.shelf_life_nbr then case when po.on_order_qty > i.eff_econ_order_qty then 1 else 0 end code_date_check,


         case when (case when nvl(i.CASES_PER_WEEK, 0) = 0 then 0 else (case when (floor(((pod.TURN + pod.FORWARD_BUY) - i.IN_PROCESS_REGULAR - i.IN_PROCESS_PROMO - i.RESERVE_COMMITTED - i.RESERVE_UNCOMMITTED - i.STORAGE_COMMITTED - i.STORAGE_UNCOMMITTED - poq_curr) / (double(i.CASES_PER_WEEK) / 7)) > i.PRODUCT_DATING) then 1 else 0 end) end) = 1 then (case when MFG_MIN_ORDER_QTY = 0 then 0 else (case when int((pod.TURN + pod.FORWARD_BUY) / MFG_MIN_ORDER_QTY) <> 1 then 1 else 0 end) end) else 0 end code_date_check,

         CASE WHEN i.I_O_FLAG = 1 AND (i.on_hand_qty + i.on_order_qty - po.on_order_qty) - (i.reserved_qty + i.advanced_order_qty + i.xdock_on_order_qty + i.xdock_on_hand_qty + i.deal_qty) > 0  THEN 1 ELSE 0 END i_o_check






SELECT i.dept_cd, i.case_upc_cd, i.buyer_id, i.case_cost_amt, i.item_desc, i.season_cd, case when i.rstr_subst_list_cd in ('O1', 'O2', 'O3', 'O4', 'O5') THEN 1 else 0 end I_O_FLG, i.lead_time_id, i.safety_stock_qty, i.forecast_qty, i.on_hand_qty, i.reserved_qty, i.advanced_order_qty, i.order_point_qty, i.on_order_qty, i.econ_order_qty, i.eff_econ_order_qty moq, i.shelf_life_nbr, i.deal_qty poq, (i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) MAX_INVENTORY_CASES, (i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7) * i.forecast_qty)) * i.case_cost_amt MAX_INVENTORY, ((i.on_hand_qty + i.on_order_qty) - (i.order_point_qty + i.deal_qty + i.advanced_order_qty + i.xdock_on_hand_qty + i.xdock_on_order_qty + i.reserved_qty)) - (i.forecast_qty * .5) EXCESS_INVENTORY_CASES_CHK FROM whmgr.mdv_item i