select * from (
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
         pod.case_pack_msr, pod.order_qty, pod.distributed_qty, pod.load_batch_id,
         (case when pod.distributed_qty > pod.order_qty then 0 else (pod.order_qty - pod.distributed_qty) end) order_qty_less_dis,
         pod.reference_cd,
         pod.line_weight_msr,
         case 
              when mi.i_o_flg = 1 then 0 
              else case 
                        when mi.excess_inventory_cases_chk - mi.max_inventory_cases > 0 then 1 
                        else 0 
                   end 
         end excess_check,
         case 
              when mi.forecast_qty = 0 then 0 
              else case 
                        when (((case when pod.distributed_qty > pod.order_qty then 0 else (pod.order_qty - pod.distributed_qty) end) - (mi.advanced_order_qty + mi.reserved_qty + mi.xdock_on_order_qty + mi.deal_qty)) / mi.forecast_qty) > mi.shelf_life_nbr then case 
                                                                                                                                                                                                         when (case when pod.distributed_qty > pod.order_qty then 0 else (pod.order_qty - pod.distributed_qty) end) > mi.moq then 1 
                                                                                                                                                                                                         else 0 
                                                                                                                                                                                                    end 
                        else 0 
                   end 
         end code_date_check,
         case 
              when mi.i_o_flg = 1 AND (mi.on_hand_qty + mi.on_order_qty - (case when pod.distributed_qty > pod.order_qty then 0 else (pod.order_qty - pod.distributed_qty) end)) - (mi.reserved_qty + mi.advanced_order_qty + mi.xdock_on_order_qty + mi.xdock_on_hand_qty + mi.deal_qty) > 0 THEN 1 
              ELSE 0 
         END i_o_check
FROM     whmgr.mdv_po_dtl pod 
         inner join (SELECT i.dept_cd, i.case_upc_cd, i.buyer_id, i.item_status_cd, i.case_cost_amt, i.item_desc, i.season_cd, case when i.rstr_subst_list_cd in ('O1', 'O2', 'O3', 'O4', 'O5') THEN 1 else 0 end I_O_FLG, i.lead_time_id, i.safety_stock_qty, i.forecast_qty, i.on_hand_qty, i.reserved_qty, i.advanced_order_qty, i.order_point_qty, i.on_order_qty, i.econ_order_qty, i.eff_econ_order_qty moq, i.xdock_on_order_qty, i.xdock_on_hand_qty, i.deal_qty, i.shelf_life_nbr, i.deal_qty poq, case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end MAX_INVENTORY_CASES, case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end * i.case_cost_amt MAX_INVENTORY, ((i.on_hand_qty + i.on_order_qty) - (i.order_point_qty + i.deal_qty + i.advanced_order_qty + i.xdock_on_hand_qty + i.xdock_on_order_qty + i.reserved_qty)) - trunc((i.forecast_qty * .5) + 1) EXCESS_INVENTORY_CASES_CHK FROM whmgr.mdv_item i) mi on pod.dept_cd = mi.dept_cd and pod.case_upc_cd = mi.case_upc_cd
WHERE    mi.item_status_cd not in ('new')
--AND      pod.input_date = '01-29-2020'
AND      pod.input_date between '01-28-2020' and '01-29-2020'
) x
--where distributed_qty <> order_qty and distributed_qty > 0
where (code_date_check + i_o_check + excess_check) > 0
order by input_date, dept_cd, buyer_id, case_upc_cd
;



--excess inventory
select * from (
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
         i.on_hand_qty,
         i.on_order_qty,
         i.reserved_qty,
         i.advanced_order_qty,
         i.order_point_qty,
         i.on_order_qty,
         i.econ_order_qty,
         i.eff_econ_order_qty moq,
         i.xdock_on_order_qty,
         i.deal_qty,
         i.shelf_life_nbr,
         i.deal_qty poq,
         case 
              when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty 
              else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) 
         end MAX_INVENTORY_CASES,
         case 
              when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty 
              else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) 
         end * i.case_cost_amt MAX_INVENTORY,
         ((i.on_hand_qty + i.on_order_qty) - (case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end)) - trunc((i.forecast_qty * .5) + 1) EXCESS_INVENTORY_CASES_CHK,
         case 
              when i.on_hand_qty - (case 
                                         when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty 
                                         else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end) < 1 then 0 
                                         else i.on_hand_qty - (case 
                                                                    when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty 
                                                                    else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end) 
                                                               end EXCESS_INVENTORY_CASES,
         case 
              when i.on_hand_qty - (case 
                                         when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty 
                                         else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end) < 1 then 0 
                                         else i.on_hand_qty - (case 
                                                                    when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty 
                                                                    else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end) 
                                                               end * i.case_cost_amt EXCESS_INVENTORY
FROM     whmgr.mdv_item i
)
where EXCESS_INVENTORY <> 0
;