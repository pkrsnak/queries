SELECT   dsh.transaction_date,
         dsh.facility_id,
         dsh.customer_nbr,
         dsh.item_nbr,
         di.root_item_nbr,
         di.root_item_desc,
         di.log_var_item_nbr,
         di.log_var_item_desc,
         mdpt.dept_key,
         mdpt.dept_name,
         mgrp.mdse_grp_key,
         mgrp.mdse_grp_name,
         mctg.mdse_catgy_key,
         mctg.mdse_catgy_name,
         mcls.mdse_class_key,
         mcls.mdse_class_name,
         di.purch_status_cd,
         di.billing_status_cd,
         dsh.order_type_cd, di.master_pack_qty, di.case_pack_qty, di.retail_pack_qty, 
         dsh.ordered_qty,
         dsh.adjusted_qty,
         dsh.subbed_qty,
         dsh.shipped_qty,
         dsh.out_of_stock_qty,
         dsh.ext_rsu_cnt,
         dsh.origin_id,
         dsh.load_batch_id,
         di.mdse_class_key
FROM     whmgr.dc_sales_hst dsh 
         inner join whmgr.dc_item di on di.facility_id = dsh.facility_id and di.item_nbr = dsh.item_nbr 
         inner join whmgr.mdse_class mcls on di.mdse_class_key = mcls.mdse_class_key 
         inner join whmgr.mdse_catgy mctg on mcls.mdse_catgy_key = mctg.mdse_catgy_key 
         inner join whmgr.mdse_group mgrp on mctg.mdse_grp_key = mgrp.mdse_grp_key 
         inner join whmgr.mdse_dept mdpt on mgrp.dept_key = mdpt.dept_key
WHERE    dsh.transaction_date between '12-30-2018' and '01-05-2019'
AND      dsh.facility_id = 1
--AND      dsh.item_nbr = 703967
--AND      di.root_item_nbr = 703967
AND      di.root_item_nbr = 21401
;


SELECT   facility_id,
         order_type_cd, sales_type_cd, 
         count(*)
FROM     whmgr.dc_sales_hst
WHERE    transaction_date > '03-15-2019'
GROUP BY facility_id, order_type_cd, sales_type_cd ;


SELECT   dsh.transaction_date,
         dsh.facility_id,
         dsh.customer_nbr,
         dc.customer_name,
         dsh.vendor_nbr,
         dv.vendor_name,
         dsh.item_nbr,
         di.root_item_nbr,
         di.root_item_desc,
         dsh.invoice_nbr,
         dsh.order_type_cd,
         dsh.shipped_qty,
         dsh.total_sales_amt
FROM     whmgr.dc_sales_hst dsh 
         inner join whmgr.dc_customer dc on dsh.facility_id = dc.facility_id and dsh.customer_nbr = dc.customer_nbr 
         inner join whmgr.dc_vendor dv on dsh.facility_id = dv.facility_id and dsh.vendor_nbr = dv.vendor_nbr 
         inner join whmgr.dc_item di on dsh.facility_id = di.facility_id and dsh.item_nbr = di.item_nbr
WHERE    dsh.transaction_date between '03-01-2019' and '03-26-2019'
AND      dsh.order_type_cd = '3'
AND      dsh.facility_id = 1
;


SELECT   dsh.ship_facility_id,
--         dsh.transaction_date,
         dsh.customer_nbr,
         di.root_item_nbr,
--         max(di.log_var_item_nbr) as log_var_item_nbr,
         di.log_var_item_nbr,
         sum(dsh.shipped_qty * di.case_pack_qty) as shipped_qty,
         sum(dsh.ordered_qty * di.case_pack_qty) as ordered_qty
FROM     whmgr.dc_sales_hst dsh 
         inner join whmgr.dc_item di on dsh.facility_id = di.facility_id and dsh.item_nbr = di.item_nbr 
         inner join whmgr.mdse_class mclass on di.mdse_class_key = mclass.mdse_class_key 
         inner join whmgr.mdse_catgy mcat on mclass.mdse_catgy_key = mcat.mdse_catgy_key 
         inner join whmgr.mdse_group mgrp on mcat.mdse_grp_key = mgrp.mdse_grp_key 
         inner join whmgr.mdse_dept mdept on mgrp.dept_key = mdept.dept_key
WHERE    dsh.transaction_date Between '12-09-2018' and '12-15-2018'
AND      dsh.ship_facility_id in (1)
AND      dsh.sales_type_cd = 1
AND      mdept.dept_key in (10,11,13,40,41,45,60,90)
AND      di.item_added_date <= dsh.transaction_date
AND      (dsh.shipped_qty + dsh.ordered_qty) <> 0
AND      not(di.root_item_nbr is null
     OR  di.root_item_nbr = -999999999)
--AND      dsh.customer_nbr = 758
--AND      di.root_item_nbr = 724457
and dsh.item_nbr = 461442
GROUP BY dsh.ship_facility_id, dsh.customer_nbr, 
         di.root_item_nbr, di.log_var_item_nbr
ORDER BY dsh.ship_facility_id, dsh.customer_nbr, 
         di.root_item_nbr, di.log_var_item_nbr
;


SELECT   dsh.transaction_date,
         dsh.facility_id,
         dsh.invoice_nbr,
         dsh.order_type_cd,
         dsh.item_nbr,
         dsh.ordered_qty,
         dsh.adjusted_qty,
         dsh.subbed_qty,
         dsh.shipped_qty,
         nvl(x.ordqty,0) 3ordqty,
         nvl(x.adjqty,0) 3adjqty,
         nvl(x.shipqty,0) 3shipqty
FROM     wh_owner.dc_sales_hst dsh 
         inner join ( SELECT facility_id, 
invoice_nbr, 
transaction_date, 
item_nbr, 
sum(ordered_qty) as ordqty, 
sum(adjusted_qty) as adjqty, 
sum(shipped_qty) as shipqty 
FROM wh_owner.dc_sales_hst 
WHERE facility_id = 1 
AND transaction_date between '03-31-2019' and '04-06-2019' 
AND order_type_cd = '3 ' 
GROUP BY facility_id, invoice_nbr, transaction_date, item_nbr ) x 
on dsh.facility_id = x.facility_id 
and dsh.invoice_nbr = x.invoice_nbr 
and dsh.transaction_date = x.transaction_date 
and dsh.item_nbr = x.item_nbr
WHERE    dsh.facility_id = 1
AND dsh.transaction_date between '03-31-2019' and '04-06-2019' 
--AND      dsh.order_type_cd = '0 '
AND      (dsh.order_type_cd <> '3 ')
;



SELECT   dsh.transaction_date,
         dsh.facility_id,
         dsh.invoice_nbr,
--         dsh.order_type_cd,
--         dsh.item_nbr,
         sum(dsh.ordered_qty),
         sum(dsh.adjusted_qty),
         sum(dsh.subbed_qty),
         sum(dsh.shipped_qty),
         sum(nvl(x.ordqty,0)),
         sum(nvl(x.adjqty,0)),
         sum(nvl(x.shipqty,0))
FROM     wh_owner.dc_sales_hst dsh 
         left outer join ( SELECT facility_id, 
invoice_nbr, 
transaction_date, 
item_nbr, 
sum(ordered_qty) as ordqty, 
sum(adjusted_qty) as adjqty, 
sum(shipped_qty) as shipqty 
FROM wh_owner.dc_sales_hst 
WHERE facility_id = 1 
AND transaction_date between '03-31-2019' and '04-06-2019' 
AND order_type_cd = '3 ' 
GROUP BY facility_id, invoice_nbr, transaction_date, item_nbr ) x 
on dsh.facility_id = x.facility_id 
and dsh.invoice_nbr = x.invoice_nbr 
and dsh.transaction_date = x.transaction_date 
and dsh.item_nbr = x.item_nbr
WHERE    dsh.facility_id = 1
AND dsh.transaction_date between '03-31-2019' and '04-06-2019' 
--AND      dsh.order_type_cd = '0 '
AND      (dsh.order_type_cd <> '3 ')
group by dsh.transaction_date,
         dsh.facility_id,
         dsh.invoice_nbr
;


SELECT   dsh.transaction_date,
         dsh.facility_id,
         dsh.invoice_nbr,
         dsh.order_type_cd,
         dsh.item_nbr,
         dsh.ordered_qty,
         nvl(x.ordqty,0) as ordqty3,
         dsh.shipped_qty,
         nvl(x.shipqty,0) as shipqty3
FROM     wh_owner.dc_sales_hst dsh 
         inner join ( SELECT facility_id, invoice_nbr, transaction_date, item_nbr, sum(ordered_qty) as ordqty, sum(adjusted_qty) as adjqty, sum(shipped_qty) as shipqty FROM wh_owner.dc_sales_hst WHERE facility_id = 1 AND transaction_date between '03-31-2019' and '04-06-2019' AND order_type_cd = '3 ' GROUP BY facility_id, invoice_nbr, transaction_date, item_nbr) x on dsh.facility_id = x.facility_id and dsh.invoice_nbr = x.invoice_nbr and dsh.transaction_date = x.transaction_date and dsh.item_nbr = x.item_nbr
WHERE    dsh.facility_id = 1
AND      dsh.transaction_date between '03-31-2019' and '04-06-2019'
AND      (dsh.order_type_cd <> '3 ')
--GROUP BY dsh.transaction_date, dsh.facility_id, dsh.invoice_nbr, 
--         dsh.order_type_cd, dsh.item_nbr;

