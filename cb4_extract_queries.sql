--Query 1:  Sale Table 

SELECT   f.start_dt,
         s.store_nbr,
         s.item_id,
         sum(total_sales_amt),
         sum(total_sales_qty),
         s.list_unit_prc_amt,
         '' out_of_stock_days,
         '' returned_units,
         '' promotion_days
FROM     entods@ods_prd_tcp:str_trans_dtl s,
         entods@ods_prd_tcp:fiscal_week f
WHERE    s.sales_date >= f.start_dt
AND      s.sales_date <= f.end_dt
AND      f.fiscal_week_id = 201942
GROUP BY 1, 2, 3, 6
;

--Query 2: Product Table
SELECT   m.item_id,
         m.item_description,
         mc.mdse_class_name,
         mct.mdse_catgy_name,
         '' unit_cost,
         '' product_key
FROM     eisdw01@dss_prd_tcp:mdse_item m,
         eisdw01@dss_prd_tcp:mdse_class mc,
         eisdw01@dss_prd_tcp:mdse_category mct
WHERE    m.mdse_class_key = mc.mdse_class_key
AND      mc.mdse_catgy_key = mct.mdse_catgy_key
;

--Query 3: Store Table
/*
SELECT   store_nbr,
         sales_line_desc,
         format_type_id,
         '' store_category_n,
         0 is_dc,
         '' store_address
FROM     eisdw01@dss_prd_tcp:line
;
*/
SELECT   store_nbr,
         sales_line_desc,
         format_type_id,
         '' store_category_n,
         0 is_dc,
         c.cust_st1_addr store_address,
         c.city_name store_city,
         c.state_cd store_state_code
FROM     eisdw01@dss_prd_tcp:line l 
         left outer join datawhse02@dss_prd_tcp:customer c on l.store_nbr = c.customer_nbr;
