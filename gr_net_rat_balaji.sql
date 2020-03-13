SELECT   fw.FISCAL_WEEK_ID,
         dsh.TRANSACTION_DATE,
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
         inner join WH_OWNER.fiscal_day fd on dsh.TRANSACTION_DATE = fd.SALES_DT 
         inner join WH_OWNER.fiscal_week fw on fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID
WHERE    dsh.TRANSACTION_DATE between '03-13-2020' and '03-13-2020'
AND      dsh.FACILITY_ID = 1
GROUP BY fw.FISCAL_WEEK_ID, dsh.TRANSACTION_DATE, dsh.FACILITY_ID, 
         dsh.CUSTOMER_NBR, cust.CUSTOMER_NAME, cust.CUST_ST1_ADDR, 
         cust.CUST_ST2_ADDR, cust.CUST_CITY_NAME, cust.CUST_STATE_CD, 
         cust.CUST_ZIP_CD, cust.CORPORATION_ID, corp.CORPORATION_NAME, 
         dsh.COMMODITY_CODE, c.COMMODITY_DESC
;


;
SELECT   fw.FISCAL_WEEK_ID,
         bed.TRANSACTION_DATE,
         bed.FACILITY_ID,
         bed.CUSTOMER_NBR,
         cust.CUSTOMER_NAME,
         cust.CUST_ST1_ADDR,
         cust.CUST_ST2_ADDR,
         cust.CUST_CITY_NAME,
         cust.CUST_STATE_CD,
         cust.CUST_ZIP_CD,
         cust.CORPORATION_ID,
         corp.CORPORATION_NAME,
         bed.COMMODITY_CODE,
         c.COMMODITY_DESC,
--         bed.INVOICE_NBR,
--         bed.SEQ_NBR,
         bed.COMMODITY_CODE,
--         bed.ITEM_NBR,
         bed.SHIP_ERROR_CD, se.SHIP_ERROR_DESC, seg.SHIP_ERROR_GRP_DESC, 
         sum(bed.NOT_SHIP_CASE_QTY) out_qty
FROM     WH_OWNER.dc_bill_error_dtl bed
         inner join WH_OWNER.DC_ITEM i on bed.FACILITY_ID = i.FACILITY_ID and bed.ITEM_NBR = i.ITEM_NBR 
         inner join WH_OWNER.COMMODITY c on bed.COMMODITY_CODE = c.COMMODITY_CODE 
         inner join WH_OWNER.DC_CUSTOMER cust on cust.FACILITY_ID = bed.FACILITY_ID and cust.CUSTOMER_NBR = bed.CUSTOMER_NBR 
         inner join wh_owner.DC_CORPORATION corp on corp.CORPORATION_ID = cust.CORPORATION_ID 
         inner join WH_OWNER.fiscal_day fd on bed.TRANSACTION_DATE = fd.SALES_DT 
         inner join WH_OWNER.fiscal_week fw on fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID
         inner join WH_OWNER.SHIP_ERROR se on bed.SHIP_ERROR_CD = se.SHIP_ERROR_CD
         inner join WH_OWNER.SHIP_ERROR_GRP seg on se.SHIP_ERROR_GRP_CD = seg.SHIP_ERROR_GRP_CD
WHERE    bed.FACILITY_ID = 1
AND      bed.TRANSACTION_DATE = '03-12-2020'
group by fw.FISCAL_WEEK_ID,
         bed.TRANSACTION_DATE,
         bed.FACILITY_ID,
         bed.CUSTOMER_NBR,
         cust.CUSTOMER_NAME,
         cust.CUST_ST1_ADDR,
         cust.CUST_ST2_ADDR,
         cust.CUST_CITY_NAME,
         cust.CUST_STATE_CD,
         cust.CUST_ZIP_CD,
         cust.CORPORATION_ID,
         corp.CORPORATION_NAME,
         bed.COMMODITY_CODE,
         c.COMMODITY_DESC,
--         bed.INVOICE_NBR,
--         bed.SEQ_NBR,
         bed.COMMODITY_CODE,
--         bed.ITEM_NBR,
         bed.SHIP_ERROR_CD,  se.SHIP_ERROR_DESC, seg.SHIP_ERROR_GRP_DESC