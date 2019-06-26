SELECT   v.FACILITYID,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         pd.PO_NBR,
         i.ITEM_NBR_HS,
         pd.CASE_UPC,
         i.ITEM_DESCRIP,
         pd.PACK,
         pd.DATE_ORDERED, 
         pd.ORIGINAL_QUANTITY,
         pd.RECEIVED,
         pd.CORRECTED_FREE_GOODS,
         pd.CORRECTED_BILLBACK,
         pd.QUANTITY,
         pd.TURN,
         pd.PROMOTION,
         pd.FORWARD_BUY,
         pd.LIST_COST,
         pd.AMOUNT_OFF_INVOICE,
         pd.LINE_STATUS
FROM     CRMADMIN.T_WHSE_VENDOR v 
         inner join CRMADMIN.T_WHSE_ITEM i on v.FACILITYID = i.FACILITYID and v.VENDOR_NBR = i.VENDOR_NBR 
         inner join CRMADMIN.T_WHSE_PO_DTL pd on i.FACILITYID = pd.FACILITYID and i.ITEM_NBR = pd.ITEM_NBR
WHERE    v.MASTER_VENDOR = '021000'
AND      v.FACILITYID = '001'
AND      pd.DATE_ORDERED between '2019-01-01' and current date
;


SELECT   v.VENDOR_NBR,
         v.VENDOR_NAME,
         i.ITEM_NBR,
         i.CASE_UPC_NBR,
         i.ROOT_ITEM_DESC,
         sh.TRANSACTION_DATE,
         sum(sh.ORDERED_QTY) ordered,
         sum(sh.SHIPPED_QTY) shipped,
         sum(sh.EXT_NET_COST_AMT) net_cost,
         sum(sh.EXT_NET_PRICE_AMT) net_price,
         sum(sh.TOTAL_SALES_AMT) total_sales
FROM     WH_OWNER.DC_VENDOR v 
         inner join WH_OWNER.DC_ITEM i on v.FACILITY_ID = i.FACILITY_ID and v.VENDOR_NBR = i.VENDOR_NBR 
         inner join WH_OWNER.DC_SALES_HST sh on i.FACILITY_ID = sh.FACILITY_ID and i.ITEM_NBR = sh.ITEM_NBR
WHERE    v.MSTR_VENDOR_NBR = 21000
AND      sh.TRANSACTION_DATE between '01-01-2019' and '06-14-2019'
and sh.FACILITY_ID = 1
group by v.VENDOR_NBR,
         v.VENDOR_NAME,
         i.ITEM_NBR,
         i.CASE_UPC_NBR,
         i.ROOT_ITEM_DESC,
         sh.TRANSACTION_DATE
;