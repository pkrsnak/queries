Select * from whmgr.dc_sales_wk_cust_item;

SELECT   FACILITYID, ITEM_NBR_HS , PACK_CASE 
FROM     CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE
WHERE    UPC_UNIT = '00000000000004011'
;


SELECT   *
FROM     CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE
WHERE UPC_UNIT in
('00000007548608986',
'00000007548608987',
'00000007548608988',
'00000007548608989',
'00000007548609114',
'00000007548609117')
;



Select D.CAL_YEAR_ID, D.DATE_KEY, D.DAY_OF_WEEK_ID, D.DAY_DESC
  from CRMADMIN.T_DATE D
 where (D.COMPANY_YEAR_ID,  D.DATE_KEY) in ( VALUES ('2002','2002-07-16'),
                                                    ('2002','2002-07-23'),
                                                    ('2002','2002-07-30'),
                                                    ('2002','2002-07-02'),
                                                    ('2002','2002-05-21')
                                           ); 



SELECT   fiscal_week_id,
         customer_nbr,
         facility_id,
         item_nbr,
         sum(ext_movement_wt) as ext_movement,
         sum(whse_mvmt_qty) as ext_whse_mvmt
FROM     whmgr.dc_sales_wk_cust_item
WHERE    (facility_id, item_nbr) in ((1, 87015), (1, 125799), (15, 208017), (58, 208017), (71, 224709), (15, 581157), (58, 581157), (71, 581157), (54, 7527104), (54, 7548266) )
GROUP BY fiscal_week_id, customer_nbr, facility_id, item_nbr;


SELECT   fiscal_week_id,
         customer_nbr,
         facility_id,
         item_nbr,
         sum(ext_movement_wt) as ext_movement,
         sum(whse_mvmt_qty) as ext_whse_mvmt
FROM     whmgr.dc_sales_wk_cust_item
WHERE customer_nbr = 800
and ((facility_id = 1 and item_nbr = 87015)
or  (facility_id = 1 and item_nbr = 125799)
or  (facility_id = 15 and item_nbr = 208017)
or  (facility_id = 58 and item_nbr = 208017)
or  (facility_id = 71 and item_nbr = 224709)
or  (facility_id = 15 and item_nbr = 581157)
or  (facility_id = 58 and item_nbr = 581157)
or  (facility_id = 71 and item_nbr = 581157)
or  (facility_id = 54 and item_nbr = 7527104)
or  (facility_id = 54 and item_nbr = 7548266)
)
GROUP BY fiscal_week_id, customer_nbr, facility_id, item_nbr;


SELECT   fiscal_week_id,
         customer_nbr,
         facility_id,
         item_nbr,
         sum(ext_movement_wt) as ext_movement,
         sum(whse_mvmt_qty) as ext_whse_mvmt
FROM     whmgr.dc_sales_wk_cust_item
WHERE customer_nbr = 936
and (
    (facility_id = 1 and item_nbr = 869)
or  (facility_id = 71 and item_nbr = 189464)
or  (facility_id = 58 and item_nbr = 373720)
or  (facility_id = 15 and item_nbr = 706986)

 
)
GROUP BY fiscal_week_id, customer_nbr, facility_id, item_nbr;
