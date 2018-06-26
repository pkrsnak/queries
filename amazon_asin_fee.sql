--.25 credit report
create or replace view CRMADMIN.V_AMZ_ASIN_FEE_PRIOR_WEEK
as
SELECT   '2D-01274170' as po_id,
         '' as invoice_id,
         shd.PURCHASE_ORDER_NUM as shipment_id,
         char(shd.INVOICE_NBR) as original_invoice_id,
         c.CUST_STORE_NO as amazon_destination,
         shd.BILLING_DATE as service_date,
         d.WEEK_ENDING_DATE as billing_period,
         asin.FUTURE_USE as amazon_asin,
         (shd.QTY_SOLD - shd.QTY_SCRATCHED) * shd.STORE_PACK as units_shipped,
         ((shd.QTY_SOLD - shd.QTY_SCRATCHED) * shd.STORE_PACK) *.25 as amazon_fee,
         shd.FACILITYID,
         c.CUSTOMER_NBR_STND,
         shd.ITEM_DEPT,
         shd.ORDER_TYPE,
         shd.ITEM_NBR_HS,
         shd.STORE_PACK,
         shd.QTY_SOLD - shd.QTY_SCRATCHED as qty_shipped
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.V_WED d on shd.BILLING_DATE = d.LOOKUP_DATE 
         inner join CRMADMIN.T_WHSE_CUST c on shd.FACILITYID = c.FACILITYID and shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL 
         inner join CRMADMIN.T_WHSE_CUST_GRP cg on c.FACILITYID = cg.FACILITYID and c.CUSTOMER_NBR_STND = cg.CUSTOMER_NBR_STND and CUSTOMER_GRP_TYPE = '75' AND current date >= cg.START_DATE AND (current date <= cg.END_DATE OR cg.END_DATE is null)
         inner join CRMADMIN.T_WHSE_ITEM i on shd.FACILITYID = i.FACILITYID and shd.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join ETLADMIN.T_TEMP_UPC asin on i.UPC_UNIT_CD = asin.UPC_UNIT
WHERE    d.WEEK_ENDING_DATE between current date - 7 days and current date
AND      shd.QTY_SOLD - shd.QTY_SCRATCHED <> 0
AND      shd.ORDER_TYPE not in ('CR')
;

grant select on CRMADMIN.V_AMZ_ASIN_FEE_PRIOR_WEEK to user CRMEXPLN;
grant control on CRMADMIN.V_AMZ_ASIN_FEE_PRIOR_WEEK to user ETL;
grant select on CRMADMIN.V_AMZ_ASIN_FEE_PRIOR_WEEK to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_AMZ_ASIN_FEE_PRIOR_WEEK to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_ASIN_FEE_PRIOR_WEEK to user WEB;
grant select on CRMADMIN.V_AMZ_ASIN_FEE_PRIOR_WEEK to user SIUSER;

/*
-- missing ASINs
select   facilityid, item_nbr_hs, upc_unit_cd, item_descrip, sum(qty_shipped) from (
--select   upc_unit, max(item_descrip), sum(qty_shipped) from (
SELECT   '654664655' as po_id,
         '' as invoice_id,
         shd.PURCHASE_ORDER_NUM as shipment_id,
         shd.INVOICE_NBR as original_invoice_id,
         c.CUST_STORE_NO as amazon_destination,
         shd.BILLING_DATE as service_date,
         d.WEEK_ENDING_DATE as billing_period,
         asin.FUTURE_USE as amazon_asin,
         (shd.QTY_SOLD - shd.QTY_SCRATCHED) * shd.STORE_PACK as units_shipped,
         ((shd.QTY_SOLD - shd.QTY_SCRATCHED) * shd.STORE_PACK) *.25 as amazon_fee,
         shd.FACILITYID,
         c.CUSTOMER_NBR_STND,
         shd.ITEM_DEPT,
         shd.ORDER_TYPE,
         shd.ITEM_NBR_HS,
         i.UPC_UNIT_CD,
         i.ITEM_DESCRIP,
         shd.STORE_PACK,
         shd.QTY_SOLD - shd.QTY_SCRATCHED as qty_shipped
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.V_WED d on shd.BILLING_DATE = d.LOOKUP_DATE 
         inner join CRMADMIN.T_WHSE_CUST c on shd.FACILITYID = c.FACILITYID and shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL 
         inner join CRMADMIN.T_WHSE_CUST_GRP cg on c.FACILITYID = cg.FACILITYID and c.CUSTOMER_NBR_STND = cg.CUSTOMER_NBR_STND and CUSTOMER_GRP_TYPE = '75' AND current date >= cg.START_DATE AND (current date <= cg.END_DATE OR cg.END_DATE is null)
         inner join CRMADMIN.T_WHSE_ITEM i on shd.FACILITYID = i.FACILITYID and shd.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join ETLADMIN.T_TEMP_UPC asin on i.UPC_UNIT_CD = asin.UPC_UNIT
WHERE    shd.BILLING_DATE between current date - 90 days and current date
AND      shd.QTY_SOLD - shd.QTY_SCRATCHED <> 0
and asin.FUTURE_USE is null
)
group by facilityid, item_nbr_hs, upc_unit_cd, item_descrip
--group by upc_unit
order by sum(qty_shipped) desc
;
;*/

--inventory feed - downstream
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED_DS
as
SELECT   case i.FACILITYID when '054' then 'F3SPB' when '040' then 'F3SPB' when '058' then 'F3SPA' when '015' then 'F3SPC' else i.FACILITYID end facilityid,
         current timestamp INVENTORY_EFFECTIVE_DATETIME,
         tu.FUTURE_USE ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,
         case i.ITEM_RES28 
              when 'A' then (eid.PROD_QTY  / i.PACK_CASE) 
              else (integer(round(((i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / value(i.INVENTORY_TOTAL, 0) * eid.PROD_QTY))) / i.PACK_CASE) 
         end * i.PACK_CASE Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case i.ITEM_RES28 
              when 'A' then (eid.PROD_QTY  / i.PACK_CASE)
              else (integer(round(((i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / value(i.INVENTORY_TOTAL, 0) * eid.PROD_QTY))) / i.PACK_CASE) 
         end AVAILABLE_ORDERABLE_QTY,
         case i.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - i.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else null end) expiration_date_time,
         (i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) * i.PACK_CASE as INVENTORY_UNITS_AVAILABLE,
         (i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) as INVENTORY_AVAILABLE,
         (i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / value(i.INVENTORY_TOTAL, 0) as INVENTORY_PERCENT,
         (i.ON_ORDER_TOTAL * i.PACK_CASE) ON_ORDER_TOTAL_UNITS,
         i.ON_ORDER_TOTAL, i.FACILITYID FACILITYID_HOME, i.FACILITYID FACILITYID_STOCK,
         i.ITEM_DEPT,
         i.ITEM_NBR_HS ITEM_NBR_HS_HOME, i.ITEM_NBR_HS ITEM_NBR_HS_STOCK,
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
         dx.FACILITYID_UPSTREAM
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID
         left outer join ETLADMIN.T_TEMP_UPC tu on i.UPC_UNIT_CD = tu.UPC_UNIT 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = i.FACILITYID and eid.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE between current date and current date + 28 days group by FACILITYID, ITEM_NBR) poq on i.BICEPS_DC = poq.FACILITYID and i.ITEM_NBR = poq.ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      right(i.FACILITYID,2) = i.STOCK_FAC
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75' AND current date > START_DATE AND (current date < END_DATE OR END_DATE is null))
AND      i.INVENTORY_TOTAL <> 0
;

grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user CRMEXPLN;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user WEB;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user SIUSER;

--inventory feed UPSTREAM
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED_US
as
SELECT   case i.FACILITYID when '054' then 'F3SPB' when '040' then 'F3SPB' when '058' then 'F3SPA' when '015' then 'F3SPC' else i.FACILITYID end facilityid,
         current timestamp INVENTORY_EFFECTIVE_DATETIME,
         tu.FUTURE_USE ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,
         integer(round((case vi.ITEM_RES28 
              when 'A' then (eid.PROD_QTY / vi.PACK_CASE) 
              else (integer(round((decimal(((vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / value(vi.INVENTORY_TOTAL, 0)), 11, 3) * decimal(eid.PROD_QTY, 11, 3)) / vi.PACK_CASE))) 
         end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) * vi.PACK_CASE Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         integer(round((case vi.ITEM_RES28 
              when 'A' then (eid.PROD_QTY / vi.PACK_CASE)
              else (integer(round((decimal(((vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / value(vi.INVENTORY_TOTAL, 0)), 11, 3) * decimal(eid.PROD_QTY, 11, 3)) / vi.PACK_CASE))) 
         end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) AVAILABLE_ORDERABLE_QTY,
         case vi.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end  AMZ_SPECIFIC_UPC,
         (case vi.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - vi.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case vi.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else null end) expiration_date_time,
         (vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) * vi.PACK_CASE as INVENTORY_UNITS_AVAILABLE,
         (vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) as INVENTORY_AVAILABLE,
         decimal(((vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / value(vi.INVENTORY_TOTAL, 0)), 11, 3) as INVENTORY_PERCENT,
         (vi.ON_ORDER_TOTAL * vi.PACK_CASE) ON_ORDER_TOTAL_UNITS,
         vi.ON_ORDER_TOTAL, i.FACILITYID FACILITYID_HOME, vi.FACILITYID FACILITYID_STOCK,
         vi.ITEM_DEPT,
         i.ITEM_NBR_HS ITEM_NBR_HS_HOME, vi.ITEM_NBR_HS ITEM_NBR_HS_STOCK,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         vi.INVENTORY_TOTAL,
         eid.PROD_QTY SN_UNITS_AVAIL,
         eid.PROD_QTY / vi.PACK_CASE SN_CASES_AVAIL,
         vi.RESERVE_COMMITTED,
         vi.RESERVE_UNCOMMITTED,
         vi.STORAGE_COMMITTED,
         vi.STORAGE_UNCOMMITTED, 
         integer(value(vi.CASES_PER_WEEK,0)) forecast,
         vi.IN_PROCESS_REGULAR,
         integer(value(poq.POQ_QTY, 0)) as poq_quantity,
         vi.SHELF_LIFE,
         vi.DISTRESS_DAYS,
         vi.CODE_DATE_FLAG, dx.FACILITYID_UPSTREAM, ts.TOTAL_STORES, ds.DC_STORES, (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) US_DS_ALLOC_PERCENT, ir.num_relationships
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
         inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID
         inner join (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.FACILITYID_UPSTREAM) ts on dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM
         inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID
         inner join (SELECT vi.FACILITYID, vi.ITEM_NBR_HS, count(*) num_relationships FROM CRMADMIN.T_WHSE_ITEM i inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID WHERE i.ITEM_RES28 in ('A', 'C') GROUP BY vi.FACILITYID, vi.ITEM_NBR_HS) ir on dx.FACILITYID_UPSTREAM = ir.FACILITYID and vi.ITEM_NBR_HS = ir.ITEM_NBR_HS
         left outer join ETLADMIN.T_TEMP_UPC tu on i.UPC_UNIT_CD = tu.UPC_UNIT 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = vi.FACILITYID and eid.ITEM_NBR_HS = vi.ITEM_NBR_HS 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE between current date and current date + 28 days group by FACILITYID, ITEM_NBR) poq on vi.BICEPS_DC = poq.FACILITYID and vi.ITEM_NBR = poq.ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      right(i.FACILITYID,2) <> i.STOCK_FAC
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75' AND current date > START_DATE AND (current date < END_DATE OR END_DATE is null))
AND      vi.INVENTORY_TOTAL <> 0
;

grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user CRMEXPLN;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user WEB;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user SIUSER;

--consolidated 
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED
as
SELECT   FACILITYID,
         INVENTORY_EFFECTIVE_DATETIME,
         ASIN,
         UPC_UNIT_CD,
         AVAILABLE_QTY_UOM,
         AVAILABLE_QTY_TO_AMZ,
         AVAILABLE_ORDERABLE_QTY_UOM,
         AVAILABLE_ORDERABLE_QTY,
         AMZ_SPECIFIC_UPC,
         SHRINK_DATE_TIME,
         EXPIRATION_DATE_TIME, FACILITYID_HOME, FACILITYID_STOCK, ITEM_DEPT, ITEM_NBR_HS_HOME, ITEM_NBR_HS_STOCK, ITEM_DESCRIP, PACK_CASE, INVENTORY_TOTAL, SN_UNITS_AVAIL, SN_CASES_AVAIL, RESERVE_COMMITTED, RESERVE_UNCOMMITTED, STORAGE_COMMITTED, STORAGE_UNCOMMITTED, FORECAST, IN_PROCESS_REGULAR, POQ_QUANTITY, SHELF_LIFE, DISTRESS_DAYS, CODE_DATE_FLAG
FROM     CRMADMIN.V_AMZ_INVENTORY_FEED_DS
union all 
SELECT   FACILITYID,
         INVENTORY_EFFECTIVE_DATETIME,
         ASIN,
         UPC_UNIT_CD,
         AVAILABLE_QTY_UOM,
         AVAILABLE_QTY_TO_AMZ,
         AVAILABLE_ORDERABLE_QTY_UOM,
         AVAILABLE_ORDERABLE_QTY,
         AMZ_SPECIFIC_UPC,
         SHRINK_DATE_TIME,
         EXPIRATION_DATE_TIME, FACILITYID_HOME, FACILITYID_STOCK, ITEM_DEPT, ITEM_NBR_HS_HOME, ITEM_NBR_HS_STOCK, ITEM_DESCRIP, PACK_CASE, INVENTORY_TOTAL, SN_UNITS_AVAIL, SN_CASES_AVAIL, RESERVE_COMMITTED, RESERVE_UNCOMMITTED, STORAGE_COMMITTED, STORAGE_UNCOMMITTED, FORECAST, IN_PROCESS_REGULAR, POQ_QUANTITY, SHELF_LIFE, DISTRESS_DAYS, CODE_DATE_FLAG
FROM     CRMADMIN.V_AMZ_INVENTORY_FEED_US
;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user CRMEXPLN;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user WEB;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user SIUSER;

/*
--select for SI

SELECT   FACILITYID,
         INVENTORY_EFFECTIVE_DATETIME,
         ASIN,
         UPC_UNIT_CD,
         AVAILABLE_QTY_UOM,
         case when AVAILABLE_QTY_TO_AMZ < 0 then 0 else AVAILABLE_QTY_TO_AMZ end AVAILABLE_QTY_TO_AMZ,
         AVAILABLE_ORDERABLE_QTY_UOM,
         case when AVAILABLE_ORDERABLE_QTY < 0 then 0 else AVAILABLE_ORDERABLE_QTY end AVAILABLE_ORDERABLE_QTY,
         AMZ_SPECIFIC_UPC,
         SHRINK_DATE_TIME,
         EXPIRATION_DATE_TIME
FROM     CRMADMIN.V_AMZ_INVENTORY_FEED
;
*/

--inbound po feed - DS
create or replace view CRMADMIN.V_AMZ_OPEN_PO_FEED_DS
as
SELECT   i.FACILITYID,
         case i.FACILITYID 
              when '054' then 'F3SPB' 
              when '040' then 'F3SPB' 
              when '058' then 'F3SPA' 
              when '015' then 'F3SPC' 
              else i.FACILITYID 
         end vendor_code,
         current timestamp open_po_effective_date_time,
         poh.PO_NBR open_PO_Number,
         poh.VENDOR_NAME supplier_Name,
         asin.FUTURE_USE asin,
         i.UPC_UNIT_CD upc,
         i.ITEM_NBR_HS vendor_Sku,
         decimal(round((pod.LIST_COST / pod.PACK), 2),9, 3) item_Cost_Price,
         decimal(round((pod.AMOUNT_OFF_INVOICE / pod.PACK), 3), 9, 3) item_Cost_Allow,
         pod.PACK case_Pack_Quantity,
         pod.LIST_COST case_Pack_Cost_Price,
         pod.AMOUNT_OFF_INVOICE Case_Pack_Cost_Allow,
         'EA' inbound_quantity_uom,
         integer(round((pod.TURN * ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN)))) * pod.PACK inbound_quantity_for_amz,
         integer(round((pod.TURN * ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN))))  inbound_quantity_total,
         case i.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC, 
         poh.DATE_ORDERED po_create_date, 
         poh.PO_ORIGINAL_DLVRY_DATE orig_req_del_date,
         poh.BUYER_ARRIVAL_DATE required_delivery_date_time,
         poh.DATE_APPOINTMENT item_delivery_date_time,
         poh.DATE_APPOINTMENT + (case dayofweek(poh.DATE_APPOINTMENT) when 6 then 3 when 7 then 2 else 1 end) days item_available_date_time,
         dayofweek(poh.DATE_APPOINTMENT) weekday,
         i.ITEM_DEPT,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.ON_ORDER_TURN,
         i.IN_PROCESS_REGULAR,
         i.CASES_PER_WEEK,
         (i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) on_order_available,
         ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN) on_order_avail_percent
FROM     CRMADMIN.T_WHSE_PO_HDR poh 
         inner join CRMADMIN.T_WHSE_PO_DTL pod on poh.VENDOR_FAC = pod.ITEM_FAC and poh.PO_NBR = pod.PO_NBR and poh.DATE_ORDERED = pod.DATE_ORDERED 
         inner join CRMADMIN.T_WHSE_ITEM i on pod.ITEM_FAC = i.BICEPS_DC and pod.ITEM_NBR = i.ITEM_NBR 
         left outer join ETLADMIN.T_TEMP_UPC asin on i.UPC_UNIT_CD = asin.UPC_UNIT
WHERE    poh.STATUS in ('A', 'P')
AND      i.ITEM_RES28 in ('A', 'C')
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75')
AND      i.ON_ORDER_TURN <> 0
AND      pod.LINE_STATUS not in ('D')
and 	 poh.TYPE not in ('DV')
;

grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user CRMEXPLN;
grant control on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user ETL;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user WEB;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user SIUSER;

--inbound po feed - US
create or replace view CRMADMIN.V_AMZ_OPEN_PO_FEED_US
as
SELECT   i.FACILITYID,
         case i.FACILITYID 
              when '054' then 'F3SPB' 
              when '040' then 'F3SPB' 
              when '058' then 'F3SPA' 
              when '015' then 'F3SPC' 
              else i.FACILITYID 
         end vendor_code,
         current timestamp open_po_effective_date_time,
         poh.PO_NBR open_PO_Number,
         poh.VENDOR_NAME supplier_Name,
         asin.FUTURE_USE asin,
         i.UPC_UNIT_CD upc,
         i.ITEM_NBR_HS vendor_Sku,
         decimal(round((pod.LIST_COST / pod.PACK), 2),9, 3) item_Cost_Price,
         decimal(round((pod.AMOUNT_OFF_INVOICE / pod.PACK), 3), 9, 3) item_Cost_Allow,
         pod.PACK case_Pack_Quantity,
         pod.LIST_COST case_Pack_Cost_Price,
         pod.AMOUNT_OFF_INVOICE Case_Pack_Cost_Allow,
         'EA' inbound_quantity_uom,
         integer(round((case vi.ITEM_RES28 
              when 'A' then pod.TURN 
              else (integer(round((pod.TURN * ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN))))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) * pod.PACK inbound_quantity_for_amz,
         integer(round((case vi.ITEM_RES28 
              when 'A' then pod.TURN 
              else (integer(round((pod.TURN * ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN))))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) inbound_quantity_total,
         case i.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC, 
         poh.DATE_ORDERED po_create_date, 
         poh.PO_ORIGINAL_DLVRY_DATE orig_req_del_date,
         poh.BUYER_ARRIVAL_DATE required_delivery_date_time,
         poh.DATE_APPOINTMENT item_delivery_date_time,
         poh.DATE_APPOINTMENT + (case dayofweek(poh.DATE_APPOINTMENT) when 6 then 3 when 7 then 2 else 1 end) days item_available_date_time,
         dayofweek(poh.DATE_APPOINTMENT) weekday,
         vi.ITEM_DEPT,
         vi.ITEM_NBR_HS,
         vi.ITEM_DESCRIP,
         pod.TURN,
         vi.ON_ORDER_TURN,
         vi.IN_PROCESS_REGULAR,
         vi.CASES_PER_WEEK,
         (vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) on_order_available,
         ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN) on_order_avail_percent,
         dx.FACILITYID_UPSTREAM, ts.TOTAL_STORES, ds.DC_STORES, (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) US_DS_ALLOC_PERCENT, ir.num_relationships
FROM     CRMADMIN.T_WHSE_ITEM i
         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
         inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_PO_DTL pod on pod.ITEM_FAC = vi.BICEPS_DC and pod.ITEM_NBR = vi.ITEM_NBR
         inner join CRMADMIN.T_WHSE_PO_HDR poh on poh.VENDOR_FAC = pod.ITEM_FAC and poh.PO_NBR = pod.PO_NBR and poh.DATE_ORDERED = pod.DATE_ORDERED 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID
         inner join (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.FACILITYID_UPSTREAM) ts on dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM
         inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID
         inner join (SELECT vi.FACILITYID, vi.ITEM_NBR_HS, count(*) num_relationships FROM CRMADMIN.T_WHSE_ITEM i inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID WHERE i.ITEM_RES28 in ('A', 'C') GROUP BY vi.FACILITYID, vi.ITEM_NBR_HS) ir on dx.FACILITYID_UPSTREAM = ir.FACILITYID and vi.ITEM_NBR_HS = ir.ITEM_NBR_HS
         left outer join ETLADMIN.T_TEMP_UPC asin on i.UPC_UNIT_CD = asin.UPC_UNIT
WHERE    poh.STATUS in ('A', 'P')
AND      i.ITEM_RES28 in ('A', 'C')
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75')
AND      vi.ON_ORDER_TURN <> 0
AND      pod.LINE_STATUS not in ('D')
and 	 poh.TYPE not in ('DV')
;

grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user CRMEXPLN;
grant control on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user ETL;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user WEB;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user SIUSER;

--inbound po feed - CONSOLIDATED
create or replace view CRMADMIN.V_AMZ_OPEN_PO_FEED
as
SELECT   VENDOR_CODE,
         OPEN_PO_EFFECTIVE_DATE_TIME,
         OPEN_PO_NUMBER,
         SUPPLIER_NAME,
         ASIN,
         UPC,
         VENDOR_SKU,
         ITEM_COST_PRICE,
         ITEM_COST_ALLOW,
         CASE_PACK_QUANTITY,
         CASE_PACK_COST_PRICE,
         CASE_PACK_COST_ALLOW,
         INBOUND_QUANTITY_UOM,
         INBOUND_QUANTITY_FOR_AMZ,
         INBOUND_QUANTITY_TOTAL,
         AMZ_SPECIFIC_UPC,
         PO_CREATE_DATE,
         ORIG_REQ_DEL_DATE,
         REQUIRED_DELIVERY_DATE_TIME,
         ITEM_DELIVERY_DATE_TIME,
         ITEM_AVAILABLE_DATE_TIME
FROM     CRMADMIN.V_AMZ_OPEN_PO_FEED_DS
union all
SELECT   VENDOR_CODE,
         OPEN_PO_EFFECTIVE_DATE_TIME,
         OPEN_PO_NUMBER,
         SUPPLIER_NAME,
         ASIN,
         UPC,
         VENDOR_SKU,
         ITEM_COST_PRICE,
         ITEM_COST_ALLOW,
         CASE_PACK_QUANTITY,
         CASE_PACK_COST_PRICE,
         CASE_PACK_COST_ALLOW,
         INBOUND_QUANTITY_UOM,
         INBOUND_QUANTITY_FOR_AMZ,
         INBOUND_QUANTITY_TOTAL,
         AMZ_SPECIFIC_UPC,
         PO_CREATE_DATE,
         ORIG_REQ_DEL_DATE,
         REQUIRED_DELIVERY_DATE_TIME,
         ITEM_DELIVERY_DATE_TIME,
         ITEM_AVAILABLE_DATE_TIME
FROM     CRMADMIN.V_AMZ_OPEN_PO_FEED_US
;

grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user CRMEXPLN;
grant control on CRMADMIN.V_AMZ_OPEN_PO_FEED to user ETL;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_AMZ_OPEN_PO_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user WEB;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user SIUSER;

/*
--select for SI

SELECT   VENDOR_CODE,
         OPEN_PO_EFFECTIVE_DATE_TIME,
         OPEN_PO_NUMBER,
         SUPPLIER_NAME,
         ASIN,
         UPC,
         VENDOR_SKU,
         ITEM_COST_PRICE,
         ITEM_COST_ALLOW,
         CASE_PACK_QUANTITY,
         CASE_PACK_COST_PRICE,
         CASE_PACK_COST_ALLOW,
         INBOUND_QUANTITY_UOM,
         INBOUND_QUANTITY_FOR_AMZ,
         INBOUND_QUANTITY_TOTAL,
         AMZ_SPECIFIC_UPC,
         PO_CREATE_DATE,
         ORIG_REQ_DEL_DATE,
         REQUIRED_DELIVERY_DATE_TIME,
         ITEM_DELIVERY_DATE_TIME,
         ITEM_AVAILABLE_DATE_TIME
FROM     CRMADMIN.V_AMZ_OPEN_PO_FEED
where    INBOUND_QUANTITY_FOR_AMZ > 0
;
*/

--catalog feed
create or replace view CRMADMIN.V_AMZ_CATALOG_FEED
as
SELECT   case cic.FACILITYID 
              when '054' then '040' 
              else cic.FACILITYID 
         end FACILITYID,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '054' then 'F3SPB' 
              when '040' then 'F3SPB' 
              when '058' then 'F3SPA' 
              when '015' then 'F3SPC' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.FUTURE_USE asin,
         i.UPC_UNIT_CD unit_upc,
         i.UPC_CASE_CD case_upc,
         i.GTIN,
         i.ITEM_NBR_HS vendor_sku,
         trim(i.BRAND) || ' ' || trim(i.RETAIL_ITEM_DESC) || ' ' || trim(i.ITEM_SIZE) || ' ' || trim(i.ITEM_SIZE_UOM) item_name,
         i.BRAND brand,
         v.MASTER_VENDOR_DESC manufacturer,
         v.VENDOR_NAME supplier_Name,
         case 
              when i.BILLING_STATUS_BACKSCREEN in ('A', 'W') then case 
                                                                       when i.AVAILABILITY_DATE > current date then 'TEMP_OUT_OF_STOCK' 
                                                                       when i.RE_AVAILABLE_DATE > current date then 'TEMP_OUT_OF_STOCK' 
                                                                       else 'AVAILABLE' 
                                                                  end 
              else 'PERM_OUT_OF_STOCK' 
         end availability_status,
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.UNBURDENED_COST_CASE_AMT case_Pack_Cost_Price,
         case i.WAREHOUSE_CODE 
              when '01' then 'Chilled' 
              when '02' then 'Chilled' 
              when '08' then 'Chilled' 
              when '07' then 'Frozen' 
              else 'Ambient' 
         end temp_type,
         i.RET_UNIT_SIZE,
         i.RET_UNIT_DESC,
         (case i.CODE_DATE_FLAG when 'Y' then 'Shelf Life' else 'Does Not Expire' end) expiration_type,
         (case i.CODE_DATE_FLAG when 'Y' then i.SHELF_LIFE else 365 end) shelf_life,
         i.MERCH_DEPT_DESC,
         i.MERCH_GRP_DESC,
         i.MERCH_CAT_DESC,
         i.MERCH_CLASS_DESC,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_burdened,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case when cid.ITEM_AUTH_CD is null then 'Y' else case when cid.ITEM_AUTH_CD = 'Y' then 'Y' else 'N' end end ITEM_AUTH_FLG,
         case when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' else case when i.PRIVATE_LABEL_KEY is null then 'Y' else 'N' end end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT,
                       BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT,
                       PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT
                  FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A 
                  WHERE      A.MASTER_ITEM_FLG = 'Y' 
                         AND A.CUSTOMER_NBR_STND > 0 
                         AND current date between A.START_DATE and A.END_DATE_REAL
               ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y'
         left outer join ETLADMIN.T_TEMP_UPC asin on i.UPC_UNIT_CD = asin.UPC_UNIT
WHERE    cic.FACILITYID in ('015', '040', '054')
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'   
;

grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user CRMEXPLN;
grant control on CRMADMIN.V_AMZ_CATALOG_FEED to user ETL;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user ETLX;
grant select,update,insert,delete on CRMADMIN.V_AMZ_CATALOG_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user WEB;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user SIUSER;

/*
--select for SI
SELECT   VENDOR_CODE,
         CATALOG_EFFECTIVE_DATE_TIME,
         ASIN,
         UNIT_UPC,
         CASE_UPC,
         GTIN,
         VENDOR_SKU,
         ITEM_NAME,
         BRAND,
         MANUFACTURER,
         SUPPLIER_NAME,
         AVAILABILITY_STATUS,
         ITEM_COST_PRICE,
         CASE_PACK_QUANTITY,
         CASE_PACK_COST_PRICE,
         TEMP_TYPE,
         RET_UNIT_SIZE,
         RET_UNIT_DESC,
         EXPIRATION_TYPE,
         SHELF_LIFE,
         MERCH_DEPT_DESC,
         MERCH_GRP_DESC,
         MERCH_CAT_DESC,
         MERCH_CLASS_DESC
FROM     CRMADMIN.V_AMZ_CATALOG_FEED
WHERE    FACILITYID in ('015')
AND      CUSTOMER_NBR_STND = 634001
--WHERE    FACILITYID in ('040', '054')
--AND      CUSTOMER_NBR_STND = 634001
;
*/


/*
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--ARCHIVE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

--inventory feed upstream
SELECT   i.FACILITYID,
         '0' || i.STOCK_FAC stocking_facility,
         tu.FUTURE_USE ASIN,
         i.UPC_UNIT_CD,
         (vi.INVENTORY_TOTAL - (vi.RESERVE_COMMITTED + integer(value(poq.POQ_QTY, 0)) + vi.RESERVE_UNCOMMITTED + (vi.IN_PROCESS_REGULAR * 2))) * vi.PACK_CASE as INVENTORY_UNITS_AVAILABLE,
         vi.INVENTORY_TOTAL - (vi.RESERVE_COMMITTED + integer(value(poq.POQ_QTY, 0)) + vi.RESERVE_UNCOMMITTED + (vi.IN_PROCESS_REGULAR * 2)) as INVENTORY_AVAILABLE,
         case vi.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         cd.CODE_DATE,
         (vi.ON_ORDER_TOTAL * vi.PACK_CASE) ON_ORDER_TOTAL_UNITS,
         vi.ON_ORDER_TOTAL,
         i.ITEM_NBR_HS,
         vi.ITEM_DESCRIP,
         vi.INVENTORY_TOTAL,
         vi.RESERVE_COMMITTED,
         vi.RESERVE_UNCOMMITTED,
         vi.STORAGE_COMMITTED,
         vi.STORAGE_UNCOMMITTED,
         vi.IN_PROCESS_REGULAR,
         integer(value(poq.POQ_QTY, 0)) POQ_QUANTITY,
         vi.SHELF_LIFE,
         vi.DISTRESS_DAYS,
         'US' tag
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
         inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         left outer join ETLADMIN.T_TEMP_UPC tu on i.UPC_UNIT_CD = tu.UPC_UNIT 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE >= current date group by FACILITYID, ITEM_NBR) poq on vi.BICEPS_DC = poq.FACILITYID and vi.ITEM_NBR = poq.ITEM_NBR 
         left outer join (SELECT eid.FACILITYID, eid.ITEM_NBR_HS, min(eid.CDE_DT) code_date FROM CRMADMIN.T_WHSE_EXE_INV_DTL eid 
         inner join CRMADMIN.T_WHSE_ITEM i on eid.FACILITYID = i.FACILITYID and eid.ITEM_NBR_HS = i.ITEM_NBR_HS and eid.STATUS not in ('D') GROUP BY eid.FACILITYID, eid.ITEM_NBR_HS) cd on vi.FACILITYID = cd.FACILITYID and vi.ITEM_NBR_HS = cd.ITEM_NBR_HS
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      right(i.FACILITYID,2) <> i.STOCK_FAC
AND      vi.INVENTORY_TOTAL <> 0

union all

--inventory feed locally stocked
SELECT   i.FACILITYID,
         '0' || i.STOCK_FAC stocking_facility,
         tu.FUTURE_USE ASIN,
         i.UPC_UNIT_CD,
         (i.INVENTORY_TOTAL - (i.RESERVE_COMMITTED + integer(value(poq.POQ_QTY, 0)) + i.RESERVE_UNCOMMITTED + (i.IN_PROCESS_REGULAR * 2))) * i.PACK_CASE as INVENOTRY_UNITS_AVAILABLE,
         i.INVENTORY_TOTAL - (i.RESERVE_COMMITTED + integer(value(poq.POQ_QTY, 0)) + i.RESERVE_UNCOMMITTED + (i.IN_PROCESS_REGULAR * 2)) as INVENTORY_AVAILABLE,
         case i.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         cd.CODE_DATE,
         (i.ON_ORDER_TOTAL * i.PACK_CASE) ON_ORDER_TOTAL_UNITS,
         i.ON_ORDER_TOTAL,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.INVENTORY_TOTAL,
         i.RESERVE_COMMITTED,
         i.RESERVE_UNCOMMITTED,
         i.STORAGE_COMMITTED,
         i.STORAGE_UNCOMMITTED,
         i.IN_PROCESS_REGULAR,
         integer(value(poq.POQ_QTY, 0)) POQ_QUANTITY,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS,
         'DS' tag
FROM     CRMADMIN.T_WHSE_ITEM i 
         left outer join ETLADMIN.T_TEMP_UPC tu on i.UPC_UNIT_CD = tu.UPC_UNIT 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE >= current date group by FACILITYID, ITEM_NBR) poq on i.BICEPS_DC = poq.FACILITYID and i.ITEM_NBR = poq.ITEM_NBR 
         left outer join (SELECT eid.FACILITYID, eid.ITEM_NBR_HS, min(eid.CDE_DT) code_date FROM CRMADMIN.T_WHSE_EXE_INV_DTL eid 
         inner join CRMADMIN.T_WHSE_ITEM i on eid.FACILITYID = i.FACILITYID and eid.ITEM_NBR_HS = i.ITEM_NBR_HS and eid.STATUS not in ('D') GROUP BY eid.FACILITYID, eid.ITEM_NBR_HS) cd on i.FACILITYID = cd.FACILITYID and i.ITEM_NBR_HS = cd.ITEM_NBR_HS
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      right(i.FACILITYID,2) = i.STOCK_FAC
AND      i.FACILITYID not in ('002', '071')
AND      i.INVENTORY_TOTAL <> 0
;

--poq
select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE >= current date group by FACILITYID, ITEM_NBR;

--pallet file
SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT
;

select * from CRMADMIN.V_WEB_CUSTOMER_FAC where CUSTOMER_NBR_STND = 634001;

select * from CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT where CUSTOMER_NBR_STND = 634001;

select * from CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND where CUSTOMER_NBR_STND = 634001;

select FACILITYID, count(*) from CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH where CUSTOMER_NBR_STND = 634001 group by FACILITYID ;
*/

--select for Amazon catalog
SELECT   VENDOR_CODE,
         CATALOG_EFFECTIVE_DATE_TIME,
         ASIN,
         UNIT_UPC,
         CASE_UPC,
         GTIN,
         VENDOR_SKU,
         ITEM_NAME,
         BRAND,
         MANUFACTURER,
         SUPPLIER_NAME,
         AVAILABILITY_STATUS,
         ITEM_COST_PRICE,
         CASE_PACK_QUANTITY,
         CASE_PACK_COST_PRICE,
         TEMP_TYPE,
         RET_UNIT_SIZE,
         RET_UNIT_DESC,
         EXPIRATION_TYPE,
         SHELF_LIFE,
         MERCH_DEPT_DESC,
         MERCH_GRP_DESC,
         MERCH_CAT_DESC,
         MERCH_CLASS_DESC
FROM     CRMADMIN.V_AMZ_CATALOG_FEED
WHERE    (BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(BILLING_STATUS_BACKSCREEN = 'D'
        AND NATAG_MAINT_DATE < current date - 30 days))
AND      ITEM_TYPE_CD not in ('I')
AND      CORP_AUTH_FLG = 'Y'
AND      ITEM_AUTH_FLG = 'Y'
AND      PRIVATE_BRAND_AUTH_FLG = 'Y'
;

-------------------------------------------
--amazon zero shipped
-------------------------------------------
SELECT   shd.PURCHASE_ORDER_NUM as shipment_id,
         char(shd.INVOICE_NBR) as original_invoice_id,
         c.CUST_STORE_NO as amazon_destination,
         shd.BILLING_DATE,
         d.WEEK_ENDING_DATE,
         asin.FUTURE_USE as amazon_asin,
         shd.FACILITYID,
         c.CUSTOMER_NBR_STND,
         shd.ITEM_DEPT,
         shd.ORDER_TYPE,
         shd.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         shd.STORE_PACK,
         shd.QTY_ORDERED,
         shd.QTY_ADJUSTED,
         shd.QTY_SCRATCHED,
         shd.QTY_SOLD - shd.QTY_SCRATCHED as qty_shipped,
         shd.OUT_REASON_CODE
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.V_WED d on shd.BILLING_DATE = d.LOOKUP_DATE 
         inner join CRMADMIN.T_WHSE_CUST c on shd.FACILITYID = c.FACILITYID and shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL 
         inner join CRMADMIN.T_WHSE_CUST_GRP cg on c.FACILITYID = cg.FACILITYID and c.CUSTOMER_NBR_STND = cg.CUSTOMER_NBR_STND and CUSTOMER_GRP_TYPE = '75' AND current date >= cg.START_DATE AND (current date <= cg.END_DATE OR cg.END_DATE is null) 
         inner join CRMADMIN.T_WHSE_ITEM i on shd.FACILITYID = i.FACILITYID and shd.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join ETLADMIN.T_TEMP_UPC asin on i.UPC_UNIT_CD = asin.UPC_UNIT
WHERE    d.WEEK_ENDING_DATE between current date - 7 days and current date
AND      shd.QTY_SOLD - shd.QTY_SCRATCHED = 0
AND      shd.ORDER_TYPE not in ('CR')
;

--orders dropped in OMS
SELECT   od.FACILITYID,
         od.ORIGIN_CDE,
         od.ITEM_NBR_HS,
         od.CUSTOMER_NBR_STND,
         c.NAME,
         od.ORDER_TYPE,
         od.SHIP_DATE,
         od.QTY,
         od.ORDER_STATUS,
         od.ORDER_STATUS_HS,
         od.INVOICE_NBR,
         od.UPLOAD_TO_BILL,
         od.OMS_SERVER_TYPE,
         od.ORIGIN_APP,
         od.ORIGIN_CODE,
         od.SUPPLIER_PRICE_SOURCE,
         od.ITEM_NBR_REQUESTED,
         od.ITEM_NBR_HS_REQUESTED,
         od.FACILITYID_REQUESTED
FROM     CRMADMIN.T_WHSE_ORDER_DTL od 
         inner join CRMADMIN.T_WHSE_CUST c on od.FACILITYID = c.FACILITYID and od.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL 
         inner join CRMADMIN.T_WHSE_CUST_GRP cg on c.FACILITYID = cg.FACILITYID and c.CUSTOMER_NBR_STND = cg.CUSTOMER_NBR_STND and CUSTOMER_GRP_TYPE = '75' AND current date >= cg.START_DATE AND (current date <= cg.END_DATE OR cg.END_DATE is null)
WHERE    od.ORDER_RECVD_DTE between '2018-06-10' and current date
;

--outs in billing
SELECT   shd.PURCHASE_ORDER_NUM as shipment_id,
         char(shd.INVOICE_NBR) as original_invoice_id,
         c.CUST_STORE_NO as amazon_destination,
         shd.BILLING_DATE,
         d.WEEK_ENDING_DATE,
         asin.FUTURE_USE as amazon_asin,
         shd.FACILITYID,
         c.CUSTOMER_NBR_STND,
         shd.ITEM_DEPT,
         shd.ORDER_TYPE,
         shd.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         shd.STORE_PACK,
         shd.QTY_ORDERED,
         shd.QTY_ADJUSTED,
         shd.QTY_SCRATCHED,
         shd.QTY_SOLD - shd.QTY_SCRATCHED as qty_shipped,
         shd.OUT_REASON_CODE, oc.OUT_CODE_DESCRIPTION
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.V_WED d on shd.BILLING_DATE = d.LOOKUP_DATE 
         inner join CRMADMIN.T_WHSE_CUST c on shd.FACILITYID = c.FACILITYID and shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL 
         inner join CRMADMIN.T_WHSE_CUST_GRP cg on c.FACILITYID = cg.FACILITYID and c.CUSTOMER_NBR_STND = cg.CUSTOMER_NBR_STND and CUSTOMER_GRP_TYPE = '75' AND current date >= cg.START_DATE AND (current date <= cg.END_DATE OR cg.END_DATE is null) 
         left outer join CRMADMIN.T_WHSE_ITEM i on shd.FACILITYID = i.FACILITYID and shd.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join ETLADMIN.T_TEMP_UPC asin on i.UPC_UNIT_CD = asin.UPC_UNIT
         left outer join CRMADMIN.T_WHSE_OUT_CODE oc on oc.OUT_CODE = shd.OUT_REASON_CODE
WHERE    d.WEEK_ENDING_DATE between current date - 7 days and current date
AND      shd.QTY_SOLD - shd.QTY_SCRATCHED = 0
AND      shd.ORDER_TYPE not in ('CR')
and shd.NO_CHRGE_ITM_CDE <> '*'
;


--unmarked items
SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.UPC_UNIT_CD,
         i.ITEM_DESCRIP,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.PACK_CASE,
         i.ITEM_RES28 AMAZON_SHARED,
         i.PURCH_STATUS,
         i.BILLING_STATUS_BACKSCREEN
FROM     ETLADMIN.T_TEMP_UPC tu 
         inner join CRMADMIN.T_WHSE_ITEM i on i.UPC_UNIT_CD = tu.UPC_UNIT
WHERE    i.FACILITYID in ('040', '054', '015')
and i.item_res28 not in ('A', 'C')
;

--forecast extract
SELECT   RUN_DATE,
         FC_ID,
         UPC,
         PARENT_ASIN,
         FORECAST_OVERRIDE_FLG,
         FORECAST_WEEK,
         decrypt_char( FORECAST_AMT, 'Test Phrase') forecast_amt
FROM     ETLE.T_WHSE_AMAZON_FORECAST

--------------------------------------------------------------------------------------------------------------------------------------------
--archive

SELECT   case cic.FACILITYID 
              when '054' then '040' 
              else cic.FACILITYID 
         end FACILITYID,
         c.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '054' then 'F3SPB' 
              when '040' then 'F3SPB' 
              when '058' then 'F3SPA' 
              when '015' then 'F3SPC' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.FUTURE_USE asin,
         i.UPC_UNIT_CD unit_upc,
         i.UPC_CASE_CD case_upc,
         i.GTIN,
         i.ITEM_NBR_HS vendor_sku,
         trim(i.BRAND) || ' ' || trim(i.RETAIL_ITEM_DESC) || ' ' || trim(i.ITEM_SIZE) || ' ' || trim(i.ITEM_SIZE_UOM) item_name,
         i.BRAND brand,
         v.MASTER_VENDOR_DESC manufacturer,
         v.VENDOR_NAME supplier_Name,
         case 
              when i.BILLING_STATUS_BACKSCREEN in ('A', 'W') then case 
                                                                       when i.AVAILABILITY_DATE > current date then 'TEMP_OUT_OF_STOCK' 
                                                                       when i.RE_AVAILABLE_DATE > current date then 'TEMP_OUT_OF_STOCK' 
                                                                       else 'AVAILABLE' 
                                                                  end 
              else 'PERM_OUT_OF_STOCK' 
         end availability_status, ---------------------------------------------------------------------------------------------------validate (status = I)
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.UNBURDENED_COST_CASE_AMT case_Pack_Cost_Price,
         case i.WAREHOUSE_CODE 
              when '01' then 'Chilled' 
              when '02' then 'Chilled' 
              when '08' then 'Chilled' 
              when '07' then 'Frozen' 
              else 'Ambient' 
         end temp_type,
         i.RET_UNIT_SIZE,
         i.RET_UNIT_DESC,
         (case i.CODE_DATE_FLAG when 'Y' then 'Shelf Life' else 'Does Not Expire' end) expiration_type,
         (case i.CODE_DATE_FLAG when 'Y' then i.SHELF_LIFE else 365 end) shelf_life,
         i.MERCH_DEPT_DESC,
         i.MERCH_GRP_DESC,
         i.MERCH_CAT_DESC,
         i.MERCH_CLASS_DESC,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_burdened,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC c on i.FACILITYID = c.FACILITYID 
         inner join CRMADMIN.T_WHSE_CUST_DEPT_MDM cmd on i.FACILITYID = cmd.FACILITYID and i.MERCH_DEPT = cmd.MDSE_DEPT_CD and cmd.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND AND cmd.ACTIVE = 'Y' 
         inner join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST cic on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS and c.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.MASTER_ITEM_FLG = 'Y' and cic.START_DATE <= current date + 7 days and (cic.END_DATE >= current date + 7 days or cic.END_DATE is null) 
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY and vwcpb.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND 
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_DEAUTH cid on i.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and i.ITEM_NBR_HS = cid.ITEM_NBR_HS 
         left outer join ETLADMIN.T_TEMP_UPC asin on i.UPC_UNIT_CD = asin.UPC_UNIT
WHERE    (cid.ITEM_AUTH_CD is null
     OR  cid.ITEM_AUTH_CD = 'Y')
AND      (i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY
     OR  i.PRIVATE_LABEL_KEY is null)
AND      (i.BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
AND      i.FACILITYID in ('015', '054', '040')
AND      c.CUSTOMER_NBR_STND = 634001
----------------------------------------------------------------------------------------------------SUPPLIES?
;

