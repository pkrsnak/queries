SELECT customer_nbr , start_dt, sum(ext_rsu_cnt) as QTY
FROM whmgr.dc_sales_wk_cust_upc, whmgr.fiscal_week
WHERE whmgr.dc_sales_wk_cust_upc.fiscal_week_id = whmgr.fiscal_week.fiscal_week_id
AND whmgr.dc_sales_wk_cust_upc.fiscal_week_id = '201748'
AND unit_upc_nbr = '01300000605'
--AND unit_upc_nbr = '04300028521'
AND customer_nbr =  '29600'
GROUP BY 1,2
ORDER BY 1,2
;


SELECT  fd.fiscal_week_id,
        fd.sales_dt,
        dsh.facility_id,
        dsh.customer_nbr,
        --dsh.units_lbs_whse_qty,
        i.unit_upc_nbr,
        sum(dsh.units_lbs_whse_qty) as sum
FROM  whmgr.dc_sales_hst dsh
        inner join whmgr.dc_item i on dsh.facility_id = i.facility_id and dsh.item_nbr = i.item_nbr
        inner join whmgr.fiscal_day fd on dsh.transaction_date = fd.sales_dt
where dsh.units_lbs_whse_qty <> 0
and i.unit_upc_nbr  = '01300000605'
--and i.unit_upc_nbr  = '04300028521'
--and fd.sales_dt = '2017-11-26'
and dsh.customer_nbr = '29600'
and fd.fiscal_week_id ='201748'
group by dsh.customer_nbr,dsh.facility_id,fd.fiscal_week_id,i.unit_upc_nbr,fd.sales_dt
order by dsh.customer_nbr,dsh.facility_id,fd.fiscal_week_id,i.unit_upc_nbr
;

