SELECT   fd.FISCAL_WEEK_ID,
         dsh.TRANSACTION_DATE,
         dsh.FACILITY_ID,
         c.CORPORATION_ID,
         dsh.CUSTOMER_NBR,
         c.CUSTOMER_NAME,
         d.DEPT_KEY,
         d.DEPT_NAME,
         sum(dsh.SHIPPED_QTY) qty_shipped,
         sum(dsh.TOTAL_SALES_AMT) sales_amt
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.DC_CUSTOMER c on c.FACILITY_ID = dsh.FACILITY_ID and c.CUSTOMER_NBR = dsh.CUSTOMER_NBR 
         inner join WH_OWNER.DC_CORPORATION corp on corp.CORPORATION_ID = c.CORPORATION_ID 
         inner join WH_OWNER.DC_ITEM i on i.FACILITY_ID = dsh.FACILITY_ID and i.ITEM_NBR = dsh.ITEM_NBR 
         inner join WH_OWNER.MDSE_CLASS cl ON i.MDSE_CLASS_KEY = cl.MDSE_CLASS_KEY 
         inner join WH_OWNER.MDSE_CATEGORY cat ON cl.MDSE_CATGY_KEY = cat.MDSE_CATGY_KEY 
         inner join WH_OWNER.MDSE_GROUP mgrp ON cat.MDSE_GRP_KEY = mgrp.MDSE_GRP_KEY 
         inner join WH_OWNER.DEPARTMENT d ON mgrp.DEPT_KEY = d.DEPT_KEY 
         inner join WH_OWNER.FISCAL_DAY fd on fd.SALES_DT = dsh.TRANSACTION_DATE
WHERE    c.CORPORATION_ID in (118, 542, 3999, 2302)
AND      fd.FISCAL_WEEK_ID between 202131 and 202230
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8
HAVING   sum(dsh.SHIPPED_QTY) > 0;
