
--slotted items by buyer
--source:  mdvods

----Comments

SELECT   'buyer' SCORECARD_TYPE,
         'slotted_items' KPI_TYPE,
         'NEED WEEK_END_DATE' DATE_VALUE,  --need to run on Saturday week end date (then plug that value in DATE_VALUE)
         3 DIVISION_ID,
--         FACILITYID FACILITY_ID,
         buyer_id KEY_VALUE,
         count(*) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     whmgr.mdv_item
WHERE   slot_id is not null
AND      slot_id <> ''
GROUP BY buyer_id 
;

--cases ordered by buyer
--source:  eisdw01
SELECT   'buyer' SCORECARD_TYPE,
         'cases_ordered' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         i.BUYER_ID KEY_VALUE,
--         sum(sls.SHIP_QTY) DATA_VALUE,
         sum(sls.ORDER_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) 
WHERE    fw.end_dt = '10-05-2019'  --sales_catgy_code???? est vs final
GROUP BY fw.end_dt, i.buyer_id
;

--cases shipped by buyer
--source:  eisdw01
SELECT   'buyer' SCORECARD_TYPE,
         'cases_shipped' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         i.BUYER_ID KEY_VALUE,
         sum(sls.SHIP_QTY) DATA_VALUE,
--         sum(sls.ORDER_QTY) DATA_VALUE1,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) 
WHERE    fw.end_dt = '10-05-2019'  --sales_catgy_code???? est vs final
GROUP BY fw.end_dt, i.buyer_id
;




--cases out by buyer
--source:  eisdw01
SELECT   'buyer' SCORECARD_TYPE,
         'cases_out' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         i.BUYER_ID KEY_VALUE,
--         sls.ship_error_cd,
         sum(sls.ORDER_QTY - sls.SHIP_QTY) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) 
WHERE    fw.end_dt = '10-05-2019'
  AND    sls.ship_error_cd in ('OOS', 'STK')  --sales_catgy_code???? est vs final
GROUP BY fw.end_dt, i.buyer_id 
;

--cases shipped (promo) by buyer
--source:  eisdw01

--cases ordered (promo) by buyer
--source:  eisdw01

--sales by buyer
--source:  eisdw01
SELECT   'buyer' SCORECARD_TYPE,
         'sales' KPI_TYPE,
         fw.end_dt DATE_VALUE,
         3 DIVISION_ID,
         i.BUYER_ID KEY_VALUE,
--         sls.ship_error_cd,
         sum(sls.tot_order_line_amt) DATA_VALUE,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
FROM     MDVSLS_DY_CUST_ITM sls 
         join fiscal_day fd on (sls.SHIP_DATE = fd.SALES_DT) 
         join MDV_ITEM i on (sls.CASE_UPC_CD = i.CASE_UPC_CD and sls.DEPT_CD = i.DEPT_CD) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID) 
WHERE    fw.end_dt = '10-05-2019'
  AND    sls.ship_error_cd in ('NEW', 'OOS', 'TMP')  --sales_catgy_code???? est vs final
GROUP BY fw.end_dt, i.buyer_id 
;


--starting inventory
--source:  CRM

--see fd file



--ending inventory
--source:  CRM

--see fd file

--po lines
--source:  CRM
Select 'buyer' SCORECARD_TYPE,
         'po_lines' KPI_TYPE,
         '2019-10-05' DATE_VALUE,   --need to run on Saturday week end date (then plug that value in DATE_VALUE)
         3 DIVISION_ID,
--         i.FACILITYID FACILITY_ID,
         buyer_id KEY_VALUE,
         sum(item_count) KEY_DATA,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY 
from whmgr.mdv_po_hdr
where order_date between '11-10-2019' and '11-16-2019'
group by buyer_id
;

--excess inventory
Select 'buyer' SCORECARD_TYPE,
         'excess_inventory' KPI_TYPE,
         '2019-10-05' DATE_VALUE,   --need to run on Saturday week end date (then plug that value in DATE_VALUE)
         3 DIVISION_ID,
--         i.FACILITYID FACILITY_ID,
         factor.buyer_id KEY_VALUE,
         sum(factor.excess_inventory) KEY_DATA,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY 
from (SELECT i.dept_cd, i.case_upc_cd, i.buyer_id, i.case_cost_amt, i.item_desc, i.season_cd, case when i.rstr_subst_list_cd in ('O1', 'O2', 'O3', 'O4', 'O5') THEN 1 else 0 end I_O_FLG, i.lead_time_id, i.safety_stock_qty, i.forecast_qty, i.on_hand_qty, i.on_order_qty, i.reserved_qty, i.advanced_order_qty, i.order_point_qty, i.on_order_qty, i.econ_order_qty, i.eff_econ_order_qty moq, i.xdock_on_order_qty, i.deal_qty, i.shelf_life_nbr, i.deal_qty poq, case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end MAX_INVENTORY_CASES, case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end * i.case_cost_amt MAX_INVENTORY, ((i.on_hand_qty + i.on_order_qty) - (case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end)) - trunc((i.forecast_qty * .5) + 1) EXCESS_INVENTORY_CASES_CHK, case when i.on_hand_qty - (case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end) < 1 then 0 else i.on_hand_qty - (case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end) end EXCESS_INVENTORY_CASES, case when i.on_hand_qty - (case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end) < 1 then 0 else i.on_hand_qty - (case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end) end * i.case_cost_amt EXCESS_INVENTORY FROM whmgr.mdv_item i) factor
group by 3,5
;

--po exception daily
Select 'buyer' SCORECARD_TYPE,
         'po_exceptions' KPI_TYPE,
         '2019-10-05' DATE_VALUE,   --daily date (current date - 1?)
         3 DIVISION_ID,
--         i.FACILITYID FACILITY_ID,
         xc.buyer_id KEY_VALUE,
         sum(case when (xc.excess_check + xc.code_date_check + xc.i_o_check) > 0 then 1 else 0 end) KEY_DATA,
         'B' DATA_GRANULARITY,
         'W' TIME_GRANULARITY 
from (SELECT mi.dept_cd, mi.case_upc_cd, mi.buyer_id, mi.case_cost_amt, mi.item_desc, mi.season_cd, mi.i_o_flg, mi.lead_time_id, mi.safety_stock_qty, mi.forecast_qty, mi.on_hand_qty, mi.reserved_qty, mi.advanced_order_qty, mi.order_point_qty, mi.on_order_qty, mi.econ_order_qty, mi.moq, mi.shelf_life_nbr, mi.poq, mi.max_inventory_cases, mi.max_inventory, mi.excess_inventory_cases_chk, pod.input_date, pod.line_nbr, pod.order_nbr, pod.order_status_cd, pod.case_pack_msr, pod.order_qty, pod.reference_cd, pod.line_weight_msr, case when mi.i_o_flg = 1 then 0 else case when mi.excess_inventory_cases_chk - mi.max_inventory_cases > 0 then 1 else 0 end end excess_check, case when mi.forecast_qty = 0 then 0 else case when ((pod.order_qty - (mi.advanced_order_qty + mi.reserved_qty + mi.xdock_on_order_qty + mi.deal_qty)) / mi.forecast_qty) > mi.shelf_life_nbr then case when pod.order_qty > mi.moq then 1 else 0 end else 0 end end code_date_check, case when mi.i_o_flg = 1 AND (mi.on_hand_qty + mi.on_order_qty - pod.order_qty) - (mi.reserved_qty + mi.advanced_order_qty + mi.xdock_on_order_qty + mi.xdock_on_hand_qty + mi.deal_qty) > 0 THEN 1 ELSE 0 END i_o_check FROM whmgr.mdv_po_dtl pod inner join (SELECT i.dept_cd, i.case_upc_cd, i.buyer_id, i.case_cost_amt, i.item_desc, i.season_cd, case when i.rstr_subst_list_cd in ('O1', 'O2', 'O3', 'O4', 'O5') THEN 1 else 0 end I_O_FLG, i.lead_time_id, i.safety_stock_qty, i.forecast_qty, i.on_hand_qty, i.reserved_qty, i.advanced_order_qty, i.order_point_qty, i.on_order_qty, i.econ_order_qty, i.eff_econ_order_qty moq, i.xdock_on_order_qty, i.xdock_on_hand_qty, i.deal_qty, i.shelf_life_nbr, i.deal_qty poq, case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end MAX_INVENTORY_CASES, case when i.eff_econ_order_qty > trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) then i.eff_econ_order_qty else trunc((i.reserved_qty + i.advanced_order_qty + i.order_point_qty + i.deal_qty + i.xdock_on_hand_qty + ((i.lead_time_id / 7)) * i.forecast_qty) + 1) end * i.case_cost_amt MAX_INVENTORY, ((i.on_hand_qty + i.on_order_qty) - (i.order_point_qty + i.deal_qty + i.advanced_order_qty + i.xdock_on_hand_qty + i.xdock_on_order_qty + i.reserved_qty)) - trunc((i.forecast_qty * .5) + 1) EXCESS_INVENTORY_CASES_CHK FROM whmgr.mdv_item i) mi on pod.dept_cd = mi.dept_cd and pod.case_upc_cd = mi.case_upc_cd WHERE pod.input_date = '01-09-2020') xc
group by 3, 5
