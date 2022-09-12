SELECT   dsh.TRANSACTION_DATE,
         dsh.FACILITY_ID,
         dsh.CUSTOMER_NBR,
         dsh.ITEM_NBR,
         i.ROOT_ITEM_DESC,
         dsh.INVOICE_NBR,
         dsh.ORDER_TYPE_CD,
         dsh.WHOLESALE_DEPT_ID,
         dsh.ORDERED_QTY,
         dsh.ADJUSTED_QTY,
         dsh.SUBBED_QTY,
         dsh.SHIPPED_QTY,
         dsh.EXT_WHSE_SALES_AMT,
         dsh.TOTAL_SALES_AMT,
         dsh.CREDIT_REASON_CD,
         cc.CREDIT_REASON_DESC
FROM     WH_OWNER.DC_SALES_HST dsh 
         left join WH_OWNER.DC_CREDIT_CODE cc on cc.FACILITY_ID = dsh.FACILITY_ID and cc.CREDIT_REASON_CD = dsh.CREDIT_REASON_CD 
         left join WH_OWNER.DC_ITEM i on i.FACILITY_ID = dsh.FACILITY_ID and i.ITEM_NBR = dsh.ITEM_NBR
WHERE    order_type_cd = 'CR'
AND      TRANSACTION_DATE >= '2022-04-27'
AND      dsh.CREDIT_REASON_CD not in ('AR')