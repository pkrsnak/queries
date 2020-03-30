SELECT   dsh.FACILITY_ID,
         dsh.ITEM_NBR,
         i.SHIP_CASE_WGHT_MSR,
         i.SHIP_CASE_CUBE_MSR,
         sum(dsh.ORDERED_QTY) qty_ordered,
         sum(dsh.SHIPPED_QTY) qty_ship,
         sum(dsh.TOTAL_SALES_AMT) tot_sales
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR 
         inner join wh_owner.MDSE_CLASS mcl on i.MDSE_CLASS_KEY = mcl.MDSE_CLASS_KEY 
         inner join wh_owner.MDSE_CATEGORY mctg on mcl.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY 
         inner join WH_OWNER.MDSE_GROUP mgrp on mctg.MDSE_GRP_KEY = mgrp.MDSE_GRP_KEY 
         inner join wh_owner.DEPARTMENT md on mgrp.DEPT_KEY = md.DEPT_KEY
WHERE    dsh.FACILITY_ID = 1
AND      dsh.TRANSACTION_DATE between '02-02-2020' and '02-29-2020'
AND      md.DEPT_KEY = 10
AND      dsh.CUSTOMER_NBR in (108 ,115 ,119 ,122 ,123 ,137 ,1400 ,1504 ,1506 ,1508 ,1510 ,1511 ,1513 ,1514 ,1517 ,1519 ,1522 ,1523 ,1524 ,1525 ,1527 ,1532 ,1570 ,1571 ,1572 ,1573 ,1574 ,1575 ,1576 ,1577 ,1579 ,1580 ,1586 ,1589 ,1591 ,1903 ,1904 ,1920 ,1921 ,1922 ,1925 ,1927 ,1929 ,1930 ,1932 ,1934 ,1972 ,1975 ,1979 ,1980 ,1990 ,1992 ,1994 ,1995 ,239 ,254 ,265 ,339 ,408 ,636 ,641 ,642 ,645 ,647 ,648 ,810 ,811 ,812 ,813 ,815 ,816 ,817 ,818 ,819 ,820 ,822 ,823 ,826 ,827 ,839 ,842 ,843 ,844 ,846 ,848)
GROUP BY dsh.FACILITY_ID, dsh.ITEM_NBR, i.SHIP_CASE_WGHT_MSR, 
         i.SHIP_CASE_CUBE_MSR