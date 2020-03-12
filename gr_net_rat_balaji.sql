SELECT   dsh.TRANSACTION_DATE,
         dsh.FACILITY_ID,
         dsh.CUSTOMER_NBR,
         cust.CUSTOMER_NAME,
         cust.CUST_ST1_ADDR,
         cust.CUST_ST2_ADDR,
         cust.CUST_CITY_NAME,
         cust.CUST_STATE_CD,
         cust.CUST_ZIP_CD,
         cust.CORPORATION_ID,
         corp.CORPORATION_NAME,
         dsh.COMMODITY_CODE,
         c.COMMODITY_DESC,
         sum(dsh.ORDERED_QTY) ordered,
         sum(dsh.ORDERED_QTY * i.SHIP_CASE_CUBE_MSR) ordered_cube,
         sum(dsh.SHIPPED_QTY) shipped,
         sum(dsh.SHIPPED_QTY * i.SHIP_CASE_CUBE_MSR) shipped_cube,
         sum(dsh.EXT_LOST_SALES_AMT) lost_sales,
         sum(dsh.TOTAL_SALES_AMT) tot_sales
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR 
         inner join WH_OWNER.COMMODITY c on dsh.COMMODITY_CODE = c.COMMODITY_CODE 
         inner join WH_OWNER.DC_CUSTOMER cust on cust.FACILITY_ID = dsh.FACILITY_ID and cust.CUSTOMER_NBR = dsh.CUSTOMER_NBR 
         inner join wh_owner.DC_CORPORATION corp on corp.CORPORATION_ID = cust.CORPORATION_ID
WHERE    dsh.TRANSACTION_DATE between '03-01-2020' and '03-07-2020'
AND      dsh.FACILITY_ID = 1
GROUP BY dsh.TRANSACTION_DATE, dsh.FACILITY_ID, dsh.CUSTOMER_NBR, 
         cust.CUSTOMER_NAME, cust.CUST_ST1_ADDR, cust.CUST_ST2_ADDR, 
         cust.CUST_CITY_NAME, cust.CUST_STATE_CD, cust.CUST_ZIP_CD, 
         cust.CORPORATION_ID, corp.CORPORATION_NAME, dsh.COMMODITY_CODE, 
         c.COMMODITY_DESC