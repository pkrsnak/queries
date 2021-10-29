SELECT   dsh.FACILITY_ID,
         INVOICE_NBR, PRESELL_NBR,
         TRANSACTION_DATE,
         INVOICE_DATE,
         DELIVERY_DATE,
         sum(dsh.SHIPPED_QTY) qty_shipped
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT
WHERE    fd.FISCAL_WEEK_ID = 202143
AND      FACILITY_ID in (1,3,40, 58)
AND      SHIPPED_QTY > 0
and TRANSACTION_DATE <> DELIVERY_DATE
GROUP BY dsh.FACILITY_ID, INVOICE_NBR, PRESELL_NBR, TRANSACTION_DATE, INVOICE_DATE, 
         DELIVERY_DATE
;



SELECT   i.FACILITY_ID,
         DG.DEPT_GRP_KEY,
         DG.DEPT_GRP_NAME,
         D.DEPT_KEY,
         D.DEPT_NAME,
         i.COMMODITY_KEY,
         i.ITEM_NBR,
         i.CASE_PACK_QTY,
         i.MASTER_PACK_QTY,
         i.RETAIL_PACK_QTY,
         case 
              when sales.QTY_SHIPPED is null then 0 
              else sales.QTY_SHIPPED 
         end p10_sales
FROM     WH_OWNER.DC_ITEM i 
         inner join WH_OWNER.MDSE_CLASS MCL on MCL.MDSE_CLASS_KEY = i.MDSE_CLASS_KEY 
         inner join WH_OWNER.MDSE_CATEGORY MC on MC.MDSE_CATGY_KEY = mcl.MDSE_CATGY_KEY 
         inner join WH_OWNER.MDSE_GROUP MG on MG.MDSE_GRP_KEY = mc.MDSE_GRP_KEY 
         inner join WH_OWNER.DEPARTMENT D on d.DEPT_KEY = mg.DEPT_KEY 
         inner join WH_OWNER.DEPARTMENT_GROUP DG on dg.DEPT_GRP_KEY = d.DEPT_GRP_KEY 
         left outer join (SELECT dsh.FACILITY_ID, dsh.ITEM_NBR, sum(dsh.SHIPPED_QTY) qty_shipped FROM WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT WHERE dsh.FACILITY_ID = 1 AND fd.FISCAL_WEEK_ID between 202137 and 202140 GROUP BY dsh.FACILITY_ID, dsh.ITEM_NBR) sales on sales.FACILITY_ID = i.FACILITY_ID and sales.ITEM_NBR = i.ITEM_NBR
WHERE    i.PURCH_STATUS_CD not in ('D', 'Z')
AND      i.FACILITY_ID = 1
AND      i.COMMODITY_KEY is not null
AND      (sales.QTY_SHIPPED > 0
     OR  i.INVTRY_TOTAL_QTY > 0);