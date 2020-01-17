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
         entods@ods_prd_tcp:fiscal_week f,
         eisdw01@dss_prd_tcp:line l
WHERE    s.store_nbr = l.store_nbr
AND      s.sales_date >= f.start_dt
AND      s.sales_date <= f.end_dt
AND      f.fiscal_week_id = 202001
AND      l.sales_chain_id in (210, 110, 250, 270, 280)
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
         left outer join datawhse02@dss_prd_tcp:customer c on l.store_nbr = c.customer_nbr
WHERE    l.sales_chain_id in (210, 110, 250, 270, 280)
AND      l.sls_line_close_dt > '06-01-2019'
;

--ARSP
SELECT   Distinct STORE_ID,
--         STORE_NAME,
         UPC_CD,
         AD_EFF_DATE,
         AD_EXPIRE_DATE,
--         EVENT_ID,
         EVENT_DESC
FROM     REG_AD_RTL_RPT A
WHERE    AD_EXPIRE_DATE >= '2019-10-06'
AND      STORE_ID in (108 ,114 ,115 ,116 ,119 ,122 ,123 ,129 ,137 ,158 ,239 ,254 ,265 ,339 ,408 ,543 ,635 ,636 ,641 ,642 ,643 ,645 ,647 ,648 ,655 ,711 ,712 ,713 ,718 ,760 ,764 ,766 ,767 ,768 ,771 ,772 ,774 ,777 ,832 ,834 ,835 ,836 ,837 ,838 ,849 ,852 ,854 ,855 ,856 ,857 ,858 ,861 ,862 ,863 ,877 ,878 ,886 ,1400 ,1401 ,1501 ,1502 ,1504 ,1505 ,1506 ,1507 ,1508 ,1509 ,1510 ,1511 ,1513 ,1514 ,1515 ,1516 ,1517 ,1519 ,1522 ,1523 ,1524 ,1525 ,1527 ,1529 ,1530 ,1532 ,1570 ,1571 ,1572 ,1573 ,1574 ,1575 ,1576 ,1577 ,1579 ,1580 ,1586 ,1587 ,1589 ,1591 ,1593 ,1903 ,1904 ,1914 ,1920 ,1921 ,1922 ,1925 ,1927 ,1929 ,1930 ,1932 ,1934 ,1955 ,1962 ,1966 ,1967 ,1968 ,1972 ,1973 ,1975 ,1979 ,1980 ,1986 ,1990 ,1992 ,1994 ,1995 ,1998 ,1999)
AND      ZONE_ID IS NOT NULL
;


