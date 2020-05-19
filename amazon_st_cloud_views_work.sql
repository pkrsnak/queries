create or replace view CRMADMIN.V_AMZ_ITEM_NFD
as
SELECT   dx.SWAT_ID FACILITYID,
         i.FACILITYID FACILITYID_STOCK,
         i.BICEPS_DC,
         i.ROOT_ITEM_NBR,
         i.LV_ITEM_NBR,
         i.ITEM_NBR_HS,
         i.ITEM_NBR,
         i.UPC_UNIT_CD,
         i.ITEM_DESCRIP,
         i.INVENTORY_TOTAL,
         i.ITEM_RES28,
         i.PACK_CASE,
         i.STORAGE_COMMITTED,
         i.STORAGE_UNCOMMITTED,
         i.RESERVE_COMMITTED,
         i.RESERVE_UNCOMMITTED,
         i.CASES_PER_WEEK,
         i.IN_PROCESS_REGULAR,
         i.ITEM_DEPT,
         i.CODE_DATE_FLAG,
         i.DISTRESS_DAYS,
         i.SHELF_LIFE,
         i.ON_ORDER_TOTAL
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on dx.REGION = 'MIDWEST' and dx.SWAT_ID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75' AND FACILITYID <> '054' AND current date > START_DATE AND (current date < END_DATE OR END_DATE is null))
WHERE    FACILITYID = '054'
AND      i.ITEM_RES28 in ('A', 'C')
;


--nfd upstream logic
SELECT   case i.FACILITYID 
              when '008' then 'F3SP?' 
              when '040' then 'F3SPB' 
              when '058' then 'F3SPA' 
              when '015' then 'F3SPC' 
              else i.FACILITYID 
         end facilityid,
         current timestamp INVENTORY_EFFECTIVE_DATETIME,
         tu.LU_CODE ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,
         case i.INVENTORY_TOTAL when 0 then 0 else integer(round((case i.ITEM_RES28 when 'A' then (eid.PROD_QTY / i.PACK_CASE) else (integer(round((decimal(((i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / value(i.INVENTORY_TOTAL, 0)), 11, 3) * decimal(eid.PROD_QTY, 11, 3)) / i.PACK_CASE))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ts.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) * i.PACK_CASE end Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case i.INVENTORY_TOTAL when 0 then 0 else integer(round((case i.ITEM_RES28 when 'A' then (eid.PROD_QTY / i.PACK_CASE) else (integer(round((decimal(((i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / value(i.INVENTORY_TOTAL, 0)), 11, 3) * decimal(eid.PROD_QTY, 11, 3)) / i.PACK_CASE))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ts.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) end AVAILABLE_ORDERABLE_QTY,
         case i.ITEM_RES28 when 'A' then 'YES' else 'NO' end AMZ_SPECIFIC_UPC,
         eid.RECEIPT_DT,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - i.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else (eid.RECEIPT_DT + i.SHELF_LIFE days) end) expiration_date_time,
         (i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) * i.PACK_CASE as INVENTORY_UNITS_AVAILABLE,
         (i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) as INVENTORY_AVAILABLE,
         case i.INVENTORY_TOTAL when 0 then 0 else decimal(((i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / value(i.INVENTORY_TOTAL, 0)), 11, 3) end INVENTORY_PERCENT,
         (i.ON_ORDER_TOTAL * i.PACK_CASE) ON_ORDER_TOTAL_UNITS,
         i.ON_ORDER_TOTAL,
         i.FACILITYID,
--         vi.FACILITYID FACILITYID_STOCK,
         i.ITEM_DEPT,
         i.ITEM_NBR_HS,
--         vi.ITEM_NBR_HS ITEM_NBR_HS_STOCK,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.INVENTORY_TOTAL,
         eid.PROD_QTY SN_UNITS_AVAIL,
         eid.PROD_QTY / i.PACK_CASE SN_CASES_AVAIL,
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
--         dx.FACILITYID_UPSTREAM,
         ts.TOTAL_STORES,
         ts.DC_STORES,
         (decimal(value(ts.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) US_DS_ALLOC_PERCENT,
         ir.num_relationships
FROM     CRMADMIN.V_AMZ_ITEM_NFD i 
--         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
--         inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID 

--upstream store counts
         inner join (SELECT dx.SWAT_ID FACILITYID, '054' FACILITYID_UPSTREAM, us.TOTAL_STORES, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' inner join (SELECT FACILITYID_UPSTREAM, sum(TOTAL_STORES) TOTAL_STORES FROM ( SELECT dx.SWAT_ID FACILITYID, '054' FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND (dx.REGION = 'MIDWEST' AND cg.FACILITYID <> '054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) x GROUP BY FACILITYID_UPSTREAM) us on us.FACILITYID_UPSTREAM = '054' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND (dx.REGION = 'MIDWEST' AND cg.FACILITYID <> '054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID, us.TOTAL_STORES) ts on dx.SWAT_ID = ts.FACILITYID 

--downstream store counts
--         inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg 
--         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID 
--         inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND dx.REGION = 'MIDWEST' AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID 

--item relationship counts
         inner join (

SELECT   vi.FACILITYID_STOCK,
         vi.ITEM_NBR_HS,
         count(*) num_relationships
FROM     CRMADMIN.V_AMZ_ITEM_NFD vi 
         inner join (

SELECT   dx.SWAT_ID FACILITYID,
         count(*) DC_STORES
FROM     CRMADMIN.T_WHSE_CUST_GRP cg 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID 
         inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y'
WHERE    cg.CUSTOMER_GRP_TYPE = '75'
AND      (cg.FACILITYID <> '054' and dx.REGION = 'MIDWEST')
AND      current date > cg.START_DATE
AND      (current date < cg.END_DATE
     OR  cg.END_DATE is null)
GROUP BY dx.SWAT_ID

) ds on vi.FACILITYID = ds.FACILITYID
GROUP BY vi.FACILITYID_STOCK, vi.ITEM_NBR_HS

) ir on i.FACILITYID_STOCK = ir.FACILITYID_STOCK and i.ITEM_NBR_HS = ir.ITEM_NBR_HS 

         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = i.FACILITYID and eid.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE between current date and current date + 28 days group by FACILITYID, ITEM_NBR) poq on i.BICEPS_DC = poq.FACILITYID and i.ITEM_NBR = poq.ITEM_NBR

WHERE    i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75'
     AND current date > START_DATE
     AND (current date < END_DATE
        OR  END_DATE is null))