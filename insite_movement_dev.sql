SELECT dc.customer_nbr,
dsh.facility_id,
dsh.commodity_code,
md.dept_grp_key,
di.item_nbr,
sum(dsh.ext_whse_sales_amt) as ext_whse_sales_amt,
sum(dsh.ext_retail_amt) as ext_retail_amt,
sum(dsh.ext_promo_allw_amt) as ext_promo_allw_amt,
sum(dsh.ext_cash_disc_amt) as ext_cash_disc_amt,
sum(dsh.ext_profit_amt) as ext_profit_amt,
sum(dsh.ext_cust_fee_amt) as ext_cust_fee_amt,
sum(dsh.ext_net_cost_amt) as ext_net_cost_amt,
sum(dsh.ext_case_cost_amt) as ext_case_cost_amt,
sum(dsh.ext_net_price_amt) as ext_net_price_amt,
sum(dsh.ext_movement_wt) as ext_movement_wt,
sum(dsh.shipped_qty) as shipped_qty
FROM datawhse02@dss_lnk:dc_sales_hst dsh,
datawhse02@dss_lnk:dc_customer dc,
datawhse02@dss_lnk:dc_item di,
datawhse02@dss_lnk:mdse_class mc,
datawhse02@dss_lnk:mdse_catgy mcat,
datawhse02@dss_lnk:mdse_group mg,
datawhse02@dss_lnk:mdse_dept md
WHERE dsh.facility_id = dc.facility_id
AND dsh.customer_nbr = dc.customer_nbr
AND dsh.facility_id = di.facility_id
AND dsh.item_nbr = di.item_nbr
AND di.mdse_class_key = mc.mdse_class_key
AND mc.mdse_catgy_key = mcat.mdse_catgy_key
AND mcat.mdse_grp_key = mg.mdse_grp_key
AND mg.dept_key = md.dept_key
AND dsh.transaction_date BETWEEN '02/12/2017' AND '02/18/2017'
group by 1,2,3,4,5
order by 1,2,3,4,5,6
;

--UPC
SELECT 
	customer_key, 
	start_dt, 
	SUM(ext_rsu_cnt) as Qty

FROM 
	entods:whmgr.dcsal_wk_cust_upc, 
	entods:whmgr.fiscal_week 

WHERE 
	whmgr.dcsal_wk_cust_upc.fiscal_week_id = whmgr.fiscal_week.fiscal_week_id AND
	upc_cd = " + "@@variable containing UPC goes here" + " AND
	customer_key IN ("@@variable with list of customer keys goes here")

GROUP BY customer_key, start_dt
ORDER BY customer_key, start_dt";


--Orderable item key
SELECT 
	customer_key, 
	start_dt, 
	SUM(whse_mvmt_qty) as Qty

FROM 
	entods:whmgr.dcsal_wk_cust_item, 
	entods:whmgr.fiscal_week 

WHERE 
	whmgr.dcsal_wk_cust_item.fiscal_week_id = whmgr.fiscal_week.fiscal_week_id AND
	orderable_item_key = " + "@@variable containing orderable item key goes here" + " AND
	customer_key IN ("@@variable with list of customer keys goes here")

GROUP BY customer_key, start_dt
ORDER BY customer_key, start_dt";


--UPC
SELECT 
	customer_key, 
	start_dt, 
	SUM(ext_rsu_cnt) as Qty

FROM 
	entods:whmgr.dcsal_wk_cust_upc, 
	entods:whmgr.fiscal_week 

WHERE 
	whmgr.dcsal_wk_cust_upc.fiscal_week_id = whmgr.fiscal_week.fiscal_week_id AND
	upc_cd = " + "@@variable containing UPC goes here" + " AND
	customer_key IN ("@@variable with list of customer keys goes here")

GROUP BY customer_key, start_dt
ORDER BY customer_key, start_dt
;


--Orderable item key
SELECT 
	customer_key, 
	start_dt, 
	SUM(whse_mvmt_qty) as Qty

FROM 
	entods:whmgr.dcsal_wk_cust_item, 
	entods:whmgr.fiscal_week 

WHERE 
	whmgr.dcsal_wk_cust_item.fiscal_week_id = whmgr.fiscal_week.fiscal_week_id AND
	orderable_item_key = " + "@@variable containing orderable item key goes here" + " AND
	customer_key IN ("@@variable with list of customer keys goes here")

GROUP BY customer_key, start_dt
ORDER BY customer_key, start_dt";



--UPC
SELECT 
	customer_nbr, 
	start_dt, 
	SUM(ext_rsu_cnt) as Qty

FROM 
	whmgr.dc_sales_hst dsh inner join entods:whmgr.fiscal_day fd on dsh.transaction_date = fd.sales_dt
	entods:whmgr.fiscal_week
     

WHERE 
	whmgr.dcsal_wk_cust_upc.fiscal_week_id = whmgr.fiscal_week.fiscal_week_id AND
	upc_cd = " + "@@variable containing UPC goes here" + " AND
	customer_key IN ("@@variable with list of customer keys goes here")

GROUP BY customer_key, start_dt
ORDER BY customer_key, start_dt
;
