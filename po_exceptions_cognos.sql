SELECT   pe.FACILITYID,
         pe.ITEM_DEPT,
         pe.PO_NBR,
         pe.DATE_ORDERED,
         pe.ITEM_NBR_HS,
         pe.BUYER_NBR,
         wb.LAST_NAME,
         wb.FIRST_NAME,
         pe.LIST_COST,
         pe.LV_DESC,
         pe.I_O_FLAG,
         pe.SAFETY_STOCK,
         pe.CYCLE_STOCK,
         pe.ORDER_INTERVAL_WEEKS,
         pe.CASES_PER_WEEK,
         pe.WHSE_TIE,
         pe.WHSE_TIER,
         pe.VENDOR_TIE,
         pe.VENDOR_TIER,
         pe.INVENTORY_TOTAL,
         pe.IN_PROCESS_REGULAR,
         pe.IN_PROCESS_PROMO,
         pe.RESERVE_COMMITTED,
         pe.RESERVE_UNCOMMITTED,
         pe.STORAGE_COMMITTED,
         pe.STORAGE_UNCOMMITTED,
         pe.POQ_30,
         pe.POQ_CURR,
         pe.ORDER_POINT,
         pe.INVENTORY_TURN,
         pe.INVENTORY_PROMOTION,
         pe.INVENTORY_FWD_BUY,
         pe.ON_ORDER_TOTAL,
         pe.MFG_MIN_ORDER_QTY,
         pe.PRODUCT_DATING,
         pe.MAX_INVENTORY_CASES,
         pe.MAX_INVENTORY,
         pe.SHELF_LIFE,
         pe.DISTRESS_DAYS,
         pe.PO_TURN,
         pe.PO_PROMO,
         pe.PO_FWD_BUY,
         pe.EXCESS_INVENTORY_CASES_CHK,
         pe.EXCESS_INVENTORY_CHK,
         pe.EXCESS_CHECK,
         pe.CODE_DATE_CHECK,
         pe.I_O_CHECK
FROM     KPIADMIN.V_KPI_PO_EXCEPTIONS pe 
         inner join CRMADMIN.V_WEB_BUYER wb on pe.BUYER_NBR = wb.BUYER_NBR
WHERE    DATE_ORDERED = current date - 1 days