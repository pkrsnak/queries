SELECT   al1.item_nbr, al2.case_upc, al2.description, al2.pack, al2.item_size, 
         al2.uom, al2.dept, SUM (al1.qty_shipped) 
    FROM dbo.mf_sumby_cust_item_summary al1, dbo.v_item_master al2 
   WHERE (al1.item_nbr = al2.item_nbr AND al1.branch_nbr = al2.dc) 
     AND (al1.branch_nbr = '058'      
     AND al1.wk_end_date > '01-jan-2006'  AND al2.dc = '058') 
GROUP BY al1.item_nbr, 
         al2.case_upc, 
         al2.description, 
         al2.pack, 
         al2.item_size, 
         al2.uom,
	 al2.dept