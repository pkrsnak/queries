SELECT   dsh.TRANSACTION_DATE,
         dsh.FACILITY_ID,
         dsh.COMMODITY_CODE,
         dsh.CUSTOMER_NBR,
         dsh.INVOICE_NBR,
         case 
              when dsh.PRESELL_NBR <> 0 then 'PRESELL' 
              else 'REGULAR' 
         end order_type,
         dsh.PRESELL_NBR,
         dsh.ITEM_NBR, i.ROOT_ITEM_DESC,
         sum(dsh.ORDERED_QTY) ordered,
         sum(dsh.SHIPPED_QTY) shipped
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.DC_CUSTOMER c on dsh.FACILITY_ID = c.FACILITY_ID and dsh.CUSTOMER_NBR = c.CUSTOMER_NBR 
         inner join WH_OWNER.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR
WHERE    dsh.TRANSACTION_DATE between '10-18-2020' and '10-21-2020'
AND      dsh.FACILITY_ID = 1
AND      c.CORPORATION_ID in (118, 3999)
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9