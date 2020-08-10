--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED
--------------------------------------------------
create or replace view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED 
as
;
SELECT   STOCK_FAC,
         FACILITYID,
         VENDOR_CODE,
         SNAPSHOT_DATE,
         PO_NUMBER,
         SUPPLIER_NAME,
         ASIN,
         VENDOR_SKU,
         UPC_UNIT_CD,
         UPC_CASE,
         ITEM_DESCRIP,
         CASE_PACK_QTY,
         CASE_QTY_UOM,
         AMZ_SPECIFIC_UPC,
         ITEM_COST_PRICE,
         ITEM_COST_ALLOW,
         CASE_PACK_COST_PRICE,
         CASE_PACK_COST_ALLOW,
         STATUS,
         ORDERED_DATE,
         ORIG_REQ_DEL_DATE,
         ADJ_REQ_DEL_DATE,
         APPOINTMENT_DATE,
         RECEIVED_DTIME,
         TOTAL_UNITS_ORDERED,
         TOTAL_UNITS_RECEIVED,
         TURN_UNITS_ORDERED,
         TURN_UNITS_RECEIVED,
         AMZ_UNITS_ORDERED,
         AMZ_UNITS_RECEIVED
FROM     CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS
WHERE    FACILITYID <> '085'
UNION all 
SELECT   STOCK_FAC,
         FACILITYID,
         VENDOR_CODE,
         SNAPSHOT_DATE,
         PO_NUMBER,
         SUPPLIER_NAME,
         ASIN,
         VENDOR_SKU,
         UPC_UNIT_CD,
         UPC_CASE,
         ITEM_DESCRIP,
         CASE_PACK_QTY,
         CASE_QTY_UOM,
         AMZ_SPECIFIC_UPC,
         ITEM_COST_PRICE,
         ITEM_COST_ALLOW,
         CASE_PACK_COST_PRICE,
         CASE_PACK_COST_ALLOW,
         STATUS,
         ORDERED_DATE,
         ORIG_REQ_DEL_DATE,
         ADJ_REQ_DEL_DATE,
         APPOINTMENT_DATE,
         RECEIVED_DTIME,
         TOTAL_UNITS_ORDERED,
         TOTAL_UNITS_RECEIVED,
         TURN_UNITS_ORDERED,
         TURN_UNITS_RECEIVED,
         AMZ_UNITS_ORDERED,
         AMZ_UNITS_RECEIVED
FROM     CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US
WHERE    FACILITYID <> '085';

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB2CDC;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DBCDC;
grant control on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user ETLX;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user SIUSER;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS
--------------------------------------------------
create or replace view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS 
as     
;
SELECT pod.FACILITYID as STOCK_FAC, i.FACILITYID, case i.FACILITYID when '054' then 'F3SPB' when '040' then 'F3SPB' when '058' then 'F3SPA' when '015' then 'F3SPC' else i.FACILITYID end as VENDOR_CODE, current date as SNAPSHOT_DATE, poh.PO_NBR as PO_NUMBER, poh.VENDOR_NAME as SUPPLIER_NAME, az.LU_CODE as ASIN, i.ITEM_NBR_HS as VENDOR_SKU, i.UPC_UNIT_CD, i.UPC_CASE, i.ITEM_DESCRIP, pod.PACK as CASE_PACK_QTY, 'EA' as CASE_QTY_UOM, case i.ITEM_RES28 when 'A' then 'YES' else 'NO' end as AMZ_SPECIFIC_UPC, decimal(round((pod.LIST_COST / pod.PACK), 2),9, 3) as ITEM_COST_PRICE, decimal(round((pod.AMOUNT_OFF_INVOICE / pod.PACK), 3), 9, 3) as ITEM_COST_ALLOW, pod.LIST_COST as CASE_PACK_COST_PRICE, pod.AMOUNT_OFF_INVOICE as CASE_PACK_COST_ALLOW, case pod.LINE_STATUS when 'D' then 'RECEIVED' else 'OPEN' end as STATUS, pod.DATE_ORDERED as ORDERED_DATE, poh.PO_ORIGINAL_DLVRY_DATE as ORIG_REQ_DEL_DATE, poh.BUYER_ARRIVAL_DATE as ADJ_REQ_DEL_DATE, poh.DATE_ARRIVAL as APPOINTMENT_DATE, pod.EXE_FIRST_RECVD_TIMESTAMP as RECEIVED_DTIME, case pod.ORIGINAL_QUANTITY when 0 then pod.QUANTITY * pod.PACK else pod.ORIGINAL_QUANTITY * pod.PACK end as TOTAL_UNITS_ORDERED, pod.RECEIVED * pod.PACK as TOTAL_UNITS_RECEIVED, pod.TURN * pod.PACK as TURN_UNITS_ORDERED, case pod.LINE_STATUS when 'D' then INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)) * pod.PACK else 0 end as TURN_UNITS_RECEIVED, case when (integer(round((case i.ITEM_RES28 when 'A' then pod.QUANTITY else (integer(round((pod.TURN * ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN))))) end))) * pod.PACK) <0 then 0 else (integer(round((case i.ITEM_RES28 when 'A' then pod.QUANTITY else (integer(round((pod.TURN * ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN))))) end))) * pod.PACK) end as AMZ_UNITS_ORDERED, case when (case pod.LINE_STATUS when 'D' then integer(round((case i.ITEM_RES28 when 'A' then pod.RECEIVED else (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN))) end))) * pod.PACK else 0 end)<0 then 0 else case pod.LINE_STATUS when 'D' then integer(round((case i.ITEM_RES28 when 'A' then pod.RECEIVED else (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN))) end))) * pod.PACK else 0 end end as AMZ_UNITS_RECEIVED FROM CRMADMIN.T_WHSE_PO_HDR poh inner join CRMADMIN.T_WHSE_PO_DTL pod on poh.VENDOR_FAC = pod.ITEM_FAC and poh.PO_NBR = pod.PO_NBR and poh.DATE_ORDERED = pod.DATE_ORDERED inner join CRMADMIN.T_WHSE_ITEM i on pod.ITEM_FAC = i.BICEPS_DC and pod.ITEM_NBR = i.ITEM_NBR inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_VENDOR v on poh.FACILITYID = v.FACILITYID and poh.VENDOR_NBR = v.VENDOR_NBR left outer join CRMADMIN.V_AMZ_ASIN az on i.ROOT_ITEM_NBR = az.ROOT_ITEM_NBR and i.LV_ITEM_NBR = az.LV_ITEM_NBR WHERE poh.TYPE not in ('DV') AND ((pod.LINE_STATUS <> 'D' and pod.DATE_ORDERED >= SYSDATE -60 DAY) or(pod.LINE_STATUS = 'D' and pod.DATE_RECEIVED between CURRENT DATE -7 DAY and CURRENT DATE)) AND pod.QUANTITY >0 AND i.ITEM_RES28 in ('A','C') AND i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75') AND i.ON_ORDER_TURN <> 0 AND v.MASTER_VENDOR NOT IN ('757575','767676') AND i.FACILITYID <> '008';

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB2CDC;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DBCDC;
grant control on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user ETLX;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user SIUSER;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US
--------------------------------------------------
create or replace view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US 
as   
;
SELECT pod.FACILITYID as STOCK_FAC, i.FACILITYID, case i.FACILITYID when '054' then 'F3SPB' when '040' then 'F3SPB' when '058' then 'F3SPA' when '015' then 'F3SPC' else i.FACILITYID end as VENDOR_CODE, current date as SNAPSHOT_DATE, poh.PO_NBR as PO_NUMBER, poh.VENDOR_NAME as SUPPLIER_NAME, az.LU_CODE ASIN, vi.ITEM_NBR_HS as VENDOR_SKU, i.UPC_UNIT_CD, vi.UPC_CASE, vi.ITEM_DESCRIP, pod.PACK as CASE_PACK_QTY, 'EA' as CASE_QTY_UOM, case i.ITEM_RES28 when 'A' then 'YES' else 'NO' end as AMZ_SPECIFIC_UPC, decimal(round((pod.LIST_COST / pod.PACK), 2),9, 3) as ITEM_COST_PRICE, decimal(round((pod.AMOUNT_OFF_INVOICE / pod.PACK), 3), 9, 3) as ITEM_COST_ALLOW, pod.LIST_COST as CASE_PACK_COST_PRICE, pod.AMOUNT_OFF_INVOICE as CASE_PACK_COST_ALLOW, case pod.LINE_STATUS when 'D' then 'RECEIVED' else 'OPEN' end as STATUS, pod.DATE_ORDERED as ORDERED_DATE, poh.PO_ORIGINAL_DLVRY_DATE as ORIG_REQ_DEL_DATE, poh.BUYER_ARRIVAL_DATE as ADJ_REQ_DEL_DATE, poh.DATE_ARRIVAL as APPOINTMENT_DATE, pod.EXE_FIRST_RECVD_TIMESTAMP as RECEIVED_DTIME, case pod.ORIGINAL_QUANTITY when 0 then pod.QUANTITY * pod.PACK else pod.ORIGINAL_QUANTITY * pod.PACK end as TOTAL_UNITS_ORDERED, pod.RECEIVED * pod.PACK as TOTAL_UNITS_RECEIVED, pod.TURN * pod.PACK as TURN_UNITS_ORDERED, case pod.LINE_STATUS when 'D' then INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)) * pod.PACK else 0 end as TURN_UNITS_RECEIVED, case when (integer(round((case vi.ITEM_RES28 when 'A' then pod.QUANTITY else (integer(round((pod.TURN * ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN))))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) * pod.PACK) <0 then 0 else (integer(round((case vi.ITEM_RES28 when 'A' then pod.QUANTITY else (integer(round((pod.TURN * ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN))))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) * pod.PACK) end as AMZ_UNITS_ORDERED, case when ( case pod.LINE_STATUS when 'D' then integer(round((case vi.ITEM_RES28 when 'A' then pod.RECEIVED else (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN))) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3))end)end))) * pod.PACK else 0 end) <0 then 0 else case pod.LINE_STATUS when 'D' then integer(round((case vi.ITEM_RES28 when 'A' then pod.RECEIVED else (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN))) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3))end)end))) * pod.PACK else 0 end end as AMZ_UNITS_RECEIVED, ts.TOTAL_STORES, ds.DC_STORES, (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) as US_DS_ALLOC_PERCENT, ir.num_relationships FROM CRMADMIN.T_WHSE_ITEM i inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS inner join CRMADMIN.T_WHSE_PO_DTL pod on pod.ITEM_FAC = vi.BICEPS_DC and pod.ITEM_NBR = vi.ITEM_NBR inner join CRMADMIN.T_WHSE_PO_HDR poh on poh.VENDOR_FAC = pod.ITEM_FAC and poh.PO_NBR = pod.PO_NBR and poh.DATE_ORDERED = pod.DATE_ORDERED inner join CRMADMIN.T_WHSE_VENDOR v on poh.FACILITYID = v.FACILITYID and poh.VENDOR_NBR = v.VENDOR_NBR inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID inner join (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD in ('A', 'I') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('008','054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.FACILITYID_UPSTREAM) ts on dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD in ('A', 'I') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('008','054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID inner join (SELECT vi.FACILITYID, vi.ITEM_NBR_HS, count(*) num_relationships FROM CRMADMIN.T_WHSE_ITEM i inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD in ('A', 'I') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('008','054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID WHERE i.ITEM_RES28 in ('A', 'C') GROUP BY vi.FACILITYID, vi.ITEM_NBR_HS) ir on dx.FACILITYID_UPSTREAM = ir.FACILITYID and vi.ITEM_NBR_HS = ir.ITEM_NBR_HS left outer join CRMADMIN.V_AMZ_ASIN az on az.ROOT_ITEM_NBR = vi.ROOT_ITEM_NBR and az.LV_ITEM_NBR = vi.LV_ITEM_NBR WHERE ((pod.LINE_STATUS <> 'D' and pod.DATE_ORDERED >= SYSDATE -60 DAY) or (pod.LINE_STATUS = 'D' and pod.DATE_RECEIVED between CURRENT DATE - 7 day and CURRENT DATE)) AND i.ITEM_RES28 in ('A', 'C') AND i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75') AND vi.ON_ORDER_TURN <> 0 AND poh.TYPE not in ('DV') AND pod.QUANTITY >0 AND v.MASTER_VENDOR NOT IN ('757575','767676') AND i.FACILITYID <> '008';

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB2CDC;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DBCDC;
grant control on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user ETLX;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user SIUSER;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user WEB;



SELECT   dx.SWAT_ID FACILITYID,
         '054' FACILITYID_UPSTREAM,
         us.TOTAL_STORES,
         count(*) DC_STORES
FROM     CRMADMIN.T_WHSE_CUST_GRP cg 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID 
         inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' 
         inner join (


SELECT   FACILITYID_UPSTREAM,
         sum(TOTAL_STORES) TOTAL_STORES
FROM     ( SELECT dx.SWAT_ID FACILITYID, '054' FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID 
         inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND (dx.REGION = 'MIDWEST' AND cg.FACILITYID <> '054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID
) x
GROUP BY FACILITYID_UPSTREAM



) us on us.FACILITYID_UPSTREAM = '054'
WHERE    cg.CUSTOMER_GRP_TYPE = '75'
AND      (dx.REGION = 'MIDWEST'
     AND cg.FACILITYID <> '054')
AND      current date > cg.START_DATE
AND      (current date < cg.END_DATE
     OR  cg.END_DATE is null)
GROUP BY dx.SWAT_ID, us.TOTAL_STORES
;


SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY dx.FACILITYID_UPSTREAM
;

SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID
;

SELECT vwcf.FACILITYID FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf WHERE vwcf.CORP_CODE = 634001
     AND vwcf.FACILITYID not in ('001', '002', '071') GROUP BY vwcf.FACILITYID
;


SELECT   *
FROM     CRMADMIN.V_AMZ_ITEM_NFD
;



SELECT   dx.SWAT_ID FACILITYID,
         '054' FACILITYID_UPSTREAM,
         us.TOTAL_STORES,
         count(*) DC_STORES
FROM     CRMADMIN.T_WHSE_CUST_GRP cg 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID 
         inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' 
         inner join (

SELECT FACILITYID_UPSTREAM, sum(TOTAL_STORES) TOTAL_STORES FROM ( SELECT dx.SWAT_ID FACILITYID, '054' FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID 
         inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND (dx.REGION = 'MIDWEST' AND cg.FACILITYID <> '054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) x GROUP BY FACILITYID_UPSTREAM

) us on us.FACILITYID_UPSTREAM = '054'
WHERE    cg.CUSTOMER_GRP_TYPE = '75'
AND      (dx.REGION = 'MIDWEST'
     AND cg.FACILITYID <> '054')
AND      current date > cg.START_DATE
AND      (current date < cg.END_DATE
     OR  cg.END_DATE is null)
GROUP BY dx.SWAT_ID, us.TOTAL_STORES
;


SELECT   dx.FACILITYID_UPSTREAM,
         count(*) TOTAL_STORES
FROM     CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID
WHERE    vwcf.CORP_CODE = 634001
AND      vwcf.FACILITYID_PRIMARY = 'Y'
AND      dx.FACILITYID_UPSTREAM in ('002', '071')
GROUP BY dx.FACILITYID_UPSTREAM