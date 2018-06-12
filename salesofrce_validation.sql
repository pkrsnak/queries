SELECT   sum(s.total_sales_amt) AS Actuals,
         sum(s.ext_cust_fee_amt) ext_cust_fee_amt,
         sum(s.ext_whse_sales_amt) ext_whse_sales_amt,
         sum(s.ext_lost_sales_amt) ext_lost_sales_amt,
         sum(s.ext_retail_amt) ext_retail_amt,
         sum(s.ext_freight_amt) ext_freight_amt,
         sum(s.ext_palt_disc_amt) ext_palt_disc_amt,
         sum(s.ext_reflect_amt) ext_reflect_amt,
         sum(s.ext_promo_allw_amt) ext_promo_allw_amt,
         sum(s.ext_fuel_chrge_amt) ext_fuel_chrge_amt,
         sum(s.ext_leakage_amt) ext_leakage_amt,
         sum(s.ext_cash_disc_amt) ext_cash_disc_amt,
         sum(s.ext_profit_amt) ext_profit_amt,
         sum(s.ext_fwd_price_amt) ext_fwd_price_amt,
         sum(s.ext_fwd_cost_amt) ext_fwd_cost_amt,
         sum(s.ext_arda_amt) ext_arda_amt,
         sum(s.ext_admin_fee_amt) ext_admin_fee_amt,
         sum(s.ext_price_adj_amt) ext_price_adj_amt,
         sum(s.ext_excise_tax_amt) ext_excise_tax_amt,
         sum(s.ext_cig_tax_amt) ext_cig_tax_amt,
         s.commodity_code AS Commodity,
         s.customer_nbr AS Customer_Number,
         s.transaction_date AS DATE,
         i.item_dept_cd AS Department,
         s.facility_id AS Distribution_Center_Number,
         s.invoice_nbr AS Invoice_Number,
         dpt.dept_key AS Merchandise_Dept,
         fd.fiscal_period_id AS Period,
         s.private_label_flg AS Private_Label_Flag,
         sum(CASE WHEN s.facility_id = 1 THEN s.ordered_qty ELSE s.adjusted_qty END) AS Qty_Ordered,
         sum(s.shipped_qty) AS Qty_Shipped,
         'Actual' AS Type,
         fd.fiscal_week_id AS Week,
         fd.fiscal_year_id AS Year
FROM     whmgr.dc_sales_hst s 
         INNER JOIN whmgr.fiscal_day fd ON s.transaction_date = fd.sales_dt 
         LEFT JOIN whmgr.dc_item i ON s.facility_id = i.facility_id AND s.item_nbr = i.item_nbr 
         LEFT JOIN whmgr.mdse_class cls ON i.mdse_class_key = cls.mdse_class_key 
         LEFT JOIN whmgr.mdse_catgy ctg ON cls.mdse_catgy_key = ctg.mdse_catgy_key 
         LEFT JOIN whmgr.mdse_group grp ON ctg.mdse_grp_key = grp.mdse_grp_key 
         LEFT JOIN whmgr.mdse_dept dpt ON grp.dept_key = dpt.dept_key
WHERE    s.transaction_date = '10-05-2016'
AND      s.sales_type_cd = 1
AND      s.invoice_nbr = '1346041'
GROUP BY fd.fiscal_year_id, fd.fiscal_period_id, fd.fiscal_week_id, 
         s.transaction_date, s.facility_id, s.customer_nbr, i.item_dept_cd, 
         s.commodity_code, s.invoice_nbr, dpt.dept_key, s.private_label_flg
ORDER BY fd.fiscal_year_id, fd.fiscal_period_id, fd.fiscal_week_id, 
         s.transaction_date, s.facility_id, s.customer_nbr, i.item_dept_cd, 
         s.commodity_code, s.invoice_nbr, dpt.dept_key, s.private_label_flg