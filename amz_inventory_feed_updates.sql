(integer(round(((i.INVENTORY_TOTAL - (value(i.STORAGE_COMMITTED, 0) + value(i.RESERVE_COMMITTED, 0))) / i.INVENTORY_TOTAL * value(eid.PROD_QTY, 0)))) / i.PACK_CASE)
;

create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED_DS as 
;
SELECT   case i.FACILITYID 
     when '040' then 'F3SPB' 
     when '058' then 'F3SPA' 
     when '015' then 'F3SPC' 
     when '008' then 'SPD2Z' 
     when '085' then 'SPD30' 
     when '086' then 'SPDPD' 
     else i.FACILITYID 
end facilityid,
         current timestamp INVENTORY_EFFECTIVE_DATETIME,
         tu.LU_CODE ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,

         case i.ITEM_RES28 when 'A' then (value(eid.PROD_QTY, 0) / i.PACK_CASE) else case i.INVENTORY_TOTAL when 0 then 0 else (integer(round(((i.INVENTORY_TOTAL - (value(i.STORAGE_COMMITTED, 0) + value(i.RESERVE_COMMITTED, 0))) / i.INVENTORY_TOTAL * value(eid.PROD_QTY, 0)))) / i.PACK_CASE) end end * i.PACK_CASE Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case i.ITEM_RES28 when 'A' then (value(eid.PROD_QTY, 0) / i.PACK_CASE) else case i.INVENTORY_TOTAL when 0 then 0 else (integer(round(((i.INVENTORY_TOTAL - (value(i.STORAGE_COMMITTED, 0) + value(i.RESERVE_COMMITTED, 0))) / i.INVENTORY_TOTAL * value(eid.PROD_QTY, 0)))) / i.PACK_CASE) end end AVAILABLE_ORDERABLE_QTY,
         case i.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         eid.RECEIPT_DT,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - i.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else (eid.RECEIPT_DT + i.SHELF_LIFE days) end) expiration_date_time,
--         (i.INVENTORY_TOTAL - (integer(round(((i.INVENTORY_TOTAL - (value(i.STORAGE_COMMITTED, 0) + value(i.RESERVE_COMMITTED, 0))) / i.INVENTORY_TOTAL * value(eid.PROD_QTY, 0)))) / i.PACK_CASE)) * i.PACK_CASE as INVENTORY_UNITS_AVAILABLE,
--         (i.INVENTORY_TOTAL - (integer(round(((i.INVENTORY_TOTAL - (value(i.STORAGE_COMMITTED, 0) + value(i.RESERVE_COMMITTED, 0))) / i.INVENTORY_TOTAL * value(eid.PROD_QTY, 0)))) / i.PACK_CASE)) as INVENTORY_AVAILABLE,
--         case i.INVENTORY_TOTAL 
--              when 0 then 0 
--              else (i.INVENTORY_TOTAL - (integer(round(((i.INVENTORY_TOTAL - (value(i.STORAGE_COMMITTED, 0) + value(i.RESERVE_COMMITTED, 0))) / i.INVENTORY_TOTAL * value(eid.PROD_QTY, 0)))) / i.PACK_CASE)) / i.INVENTORY_TOTAL 
--                                                                                                                                                                                                                                                                                    end as INVENTORY_PERCENT,
         (i.ON_ORDER_TOTAL * i.PACK_CASE) ON_ORDER_TOTAL_UNITS,
         i.ON_ORDER_TOTAL,
         i.FACILITYID FACILITYID_HOME,
         i.FACILITYID FACILITYID_STOCK,
         i.ITEM_DEPT,
         i.ITEM_NBR_HS ITEM_NBR_HS_HOME,
         i.ITEM_NBR_HS ITEM_NBR_HS_STOCK,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.INVENTORY_TOTAL,
         value(eid.PROD_QTY, 0) SN_UNITS_AVAIL,
         value(eid.PROD_QTY, 0) / i.PACK_CASE SN_CASES_AVAIL,
         i.RESERVE_COMMITTED,
         i.RESERVE_UNCOMMITTED,
         i.STORAGE_COMMITTED,
         i.STORAGE_UNCOMMITTED,
         integer(value(i.CASES_PER_WEEK,0)) forecast,
         i.IN_PROCESS_REGULAR,
         integer(value(poq.POQ_QTY, 0)) as poq_quantity,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS,
         i.CODE_DATE_FLAG,
         dx.FACILITYID_UPSTREAM
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID 
         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = i.FACILITYID and eid.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE between current date and current date + 28 days group by FACILITYID, ITEM_NBR) poq on i.BICEPS_DC = poq.FACILITYID and i.ITEM_NBR = poq.ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      right(i.FACILITYID,2) = i.STOCK_FAC
AND      i.BILLING_STATUS_BACKSCREEN not in ('D', 'Z')
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75'
     AND current date > START_DATE
     AND (current date < END_DATE
        OR  END_DATE is null)
     AND FACILITYID <> '054')