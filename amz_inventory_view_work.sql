create or replace view CRMADMIN.V_AMZ_ITEM_CORE
as
SELECT   i.FACILITYID,
         i.STOCK_FAC,
         i.ITEM_NBR,
         i.ITEM_NBR_HS,
         i.ROOT_ITEM_NBR,
         i.LV_ITEM_NBR,
         value(tu.LU_CODE, '') ASIN,
         i.UPC_UNIT_CD,
         i.UPC_CASE_CD,
         i.ITEM_DESCRIP,
         i.INVENTORY_TOTAL,
         i.ITEM_RES28,
         i.PACK_CASE,
         case i.INVENTORY_TOTAL 
              when 0 then 0 
              else decimal((i.INVENTORY_TOTAL - (value(i.STORAGE_COMMITTED, 0) + value(i.RESERVE_COMMITTED, 0))), 11, 3) / decimal(i.INVENTORY_TOTAL, 11, 3) 
         end as INVENTORY_PERCENT,
         value(i.RESERVE_COMMITTED, 0) RESERVE_COMMITTED,
         value(i.RESERVE_UNCOMMITTED, 0) RESERVE_UNCOMMITTED,
         value(i.STORAGE_COMMITTED, 0) STORAGE_COMMITTED,
         value(i.STORAGE_UNCOMMITTED, 0) STORAGE_UNCOMMITTED,
         integer(value(i.CASES_PER_WEEK,0)) FORECAST,
         value(i.IN_PROCESS_REGULAR, 0) IN_PROCESS_REGULAR,
         i.ITEM_DEPT,
         i.CODE_DATE_FLAG,
         value(i.SHELF_LIFE, 0) SHELF_LIFE,
         value(i.DISTRESS_DAYS, 0) DISTRESS_DAYS,
         value(i.ON_ORDER_TURN, 0) ON_ORDER_TURN,
         value(i.ON_ORDER_TOTAL, 0) ON_ORDER_TOTAL,
         i.BILLING_STATUS_BACKSCREEN,
         dx.FACILITYID_UPSTREAM
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID 
         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C');

grant select,update,insert,delete on CRMADMIN.V_AMZ_ITEM_CORE to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB002687;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB033016;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB038712;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB038866;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB065023;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB075216;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB075781;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB076602;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB077382;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB079572;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB081868;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB082673;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB096486;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB099260;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB100026;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB102019;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB103416;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB103570;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB103712;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB103724;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB105018;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB105281;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB105703;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB106139;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB106453;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB108245;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB126235;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB142672;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB146729;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB148781;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB151483;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB153050;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB154428;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB159999;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB160831;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB161042;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB162511;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB172084;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB172087;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB175453;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB177494;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB178908;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB181352;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB184961;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB186096;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB188771;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB189061;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB189628;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB203809;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB209501;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB210344;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB210958;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB211038;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB212676;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB213711;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB221580;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB222356;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB227847;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB228400;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB228405;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB228662;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB235955;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB237127;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB237310;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB237361;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB237844;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB238600;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB238608;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB238609;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB240787;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB241504;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB241793;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB242206;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB243870;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB2CDC;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DBCDC;
grant control on CRMADMIN.V_AMZ_ITEM_CORE to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_ITEM_CORE to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user ETLX;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user SIUSER;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINKART;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINMANI;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINNITH;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINRAME;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINROAN;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_ITEM_NFD
--------------------------------------------------
create or replace view CRMADMIN.V_AMZ_ITEM_NFD as  
SELECT   i.FACILITYID,
         dx.SWAT_ID FACILITYID_HOME,
         i.ITEM_NBR ITEM_NBR_HOME,
         i.ITEM_NBR_HS ITEM_NBR_HS_HOME,
         i.FACILITYID FACILITYID_STOCK,
         i.ITEM_NBR ITEM_NBR_STOCK,
         i.ITEM_NBR_HS ITEM_NBR_HS_STOCK,
         i.ROOT_ITEM_NBR,
         i.LV_ITEM_NBR,
         value(tu.LU_CODE, '') ASIN,
         i.UPC_UNIT_CD,
         i.UPC_CASE_CD,
         i.ITEM_DESCRIP,
         i.INVENTORY_TOTAL,
         i.ITEM_RES28,
         i.PACK_CASE,
         case i.INVENTORY_TOTAL 
              when 0 then 0 
              else decimal((i.INVENTORY_TOTAL - (value(i.STORAGE_COMMITTED, 0) + value(i.RESERVE_COMMITTED, 0))), 11, 3) / decimal(i.INVENTORY_TOTAL, 11, 3) 
         end as INVENTORY_PERCENT,
         value(i.RESERVE_COMMITTED, 0) RESERVE_COMMITTED,
         value(i.RESERVE_UNCOMMITTED, 0) RESERVE_UNCOMMITTED,
         value(i.STORAGE_COMMITTED, 0) STORAGE_COMMITTED,
         value(i.STORAGE_UNCOMMITTED, 0) STORAGE_UNCOMMITTED,
         integer(value(i.CASES_PER_WEEK,0)) FORECAST,
         value(i.IN_PROCESS_REGULAR, 0) IN_PROCESS_REGULAR,
         0 as POQ_QTY,
         i.ITEM_DEPT,
         i.CODE_DATE_FLAG,
         value(i.SHELF_LIFE, 0) SHELF_LIFE,
         value(i.DISTRESS_DAYS, 0) DISTRESS_DAYS,
         value(i.ON_ORDER_TURN, 0) ON_ORDER_TURN,
         value(i.ON_ORDER_TOTAL, 0) ON_ORDER_TOTAL,
         i.BILLING_STATUS_BACKSCREEN
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on dx.FACILITYID_UPSTREAM = '002' and dx.PROCESS_ACTIVE_FLAG = 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      i.FACILITYID = '054';

grant select,update,insert,delete on CRMADMIN.V_AMZ_ITEM_NFD to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB002687;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB033016;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB038712;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB038866;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB065023;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB075216;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB075781;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB076602;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB077382;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB079572;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB081868;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB082673;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB096486;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB099260;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB100026;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB102019;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB103416;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB103570;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB103712;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB103724;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB105018;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB105281;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB105703;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB106139;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB106453;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB108245;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB126235;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB142672;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB146729;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB148781;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB151483;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB153050;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB154428;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB159999;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB160831;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB161042;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB162511;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB172084;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB172087;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB175453;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB177494;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB178908;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB181352;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB184961;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB186096;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB188771;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB189061;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB189628;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB203809;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB209501;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB210344;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB210958;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB211038;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB212676;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB213711;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB221580;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB222356;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB227847;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB228400;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB228405;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB228662;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB235955;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB237127;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB237310;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB237361;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB237844;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB238600;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB238608;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB238609;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB240787;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB241504;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB241793;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB242206;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB243870;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB2CDC;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DBCDC;
grant control on CRMADMIN.V_AMZ_ITEM_NFD to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_ITEM_NFD to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user ETLX;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user SIUSER;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINKART;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINMANI;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINNITH;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINRAME;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINROAN;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED_DS
--------------------------------------------------
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED_DS 
as
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
         i.ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,
         case i.ITEM_RES28 when 'A' then value(eid.PROD_QTY, 0) else int(round((value(eid.PROD_QTY, 0) * i.INVENTORY_PERCENT))) end Available_Qty_To_Amz, 
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case i.ITEM_RES28 when 'A' then (value(eid.PROD_QTY, 0) / i.PACK_CASE) else int(round(((value(eid.PROD_QTY, 0)) / i.PACK_CASE) * i.INVENTORY_PERCENT)) end AVAILABLE_ORDERABLE_QTY,
         case i.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         eid.RECEIPT_DT,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - i.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else (eid.RECEIPT_DT + i.SHELF_LIFE days) end) expiration_date_time,
         0 INVENTORY_UNITS_AVAILABLE,
         0 INVENTORY_AVAILABLE,
         i.INVENTORY_PERCENT,
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
         i.FORECAST,
         i.IN_PROCESS_REGULAR,
         0 POQ_QUANTITY,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS,
         i.CODE_DATE_FLAG,
         i.FACILITYID_UPSTREAM
FROM     CRMADMIN.V_AMZ_ITEM_CORE i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID and dx.PROCESS_ACTIVE_FLAG = 'Y' AND i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75' AND current date > START_DATE AND (current date < END_DATE OR END_DATE is null) AND FACILITYID <> '054')
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS = 'A' AND FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75' AND current date > START_DATE AND (current date < END_DATE OR END_DATE is null) AND FACILITYID <> '054') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = i.FACILITYID and eid.ITEM_NBR_HS = i.ITEM_NBR_HS
AND      right(i.FACILITYID,2) = i.STOCK_FAC
AND      i.BILLING_STATUS_BACKSCREEN not in ('D', 'Z')
;

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_INVENTORY_FEED_DS
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB002687;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB033016;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB038712;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB038866;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB065023;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB075216;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB075781;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB076602;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB077382;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB079572;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB081868;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB082673;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB096486;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB099260;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB100026;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB102019;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB103416;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB103570;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB103712;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB103724;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB105018;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB105281;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB105703;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB106139;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB106453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB108245;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB126235;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB142672;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB146729;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB148781;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB151483;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB153050;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB154428;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB159999;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB160831;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB161042;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB162511;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB172084;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB172087;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB177494;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB178908;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB181352;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB184961;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB186096;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB188771;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB189061;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB189628;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB203809;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB209501;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB210344;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB210958;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB211038;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB212676;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB213711;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB221580;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB222356;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB227847;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB228400;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB228405;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB228662;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB235955;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB237127;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB237310;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB237361;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB237844;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB238600;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB238608;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB238609;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB240787;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB241504;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB241793;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB242206;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB243870;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINKART;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINMANI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINNITH;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINRAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINROAN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED_NFD
--------------------------------------------------
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED_NFD 
as
SELECT   case i.FACILITYID_HOME 
     when '040' then 'F3SPB' 
     when '008' then 'SPD2Z' 
     else i.FACILITYID_HOME 
end facilityid,
         current timestamp INVENTORY_EFFECTIVE_DATETIME,
         i.ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,
         int(round(case i.INVENTORY_TOTAL when 0 then 0 else (case i.ITEM_RES28 when 'A' then (eid.PROD_QTY ) else int(round((eid.PROD_QTY * i.INVENTORY_PERCENT))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end) end)) Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         int(round(case i.INVENTORY_TOTAL when 0 then 0 else integer(round((case i.ITEM_RES28 when 'A' then (eid.PROD_QTY / i.PACK_CASE) else int(round(((eid.PROD_QTY / i.PACK_CASE)* i.INVENTORY_PERCENT))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) end)) AVAILABLE_ORDERABLE_QTY,
         case i.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         eid.RECEIPT_DT,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - i.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else (eid.RECEIPT_DT + i.SHELF_LIFE days) end) expiration_date_time,
         0 INVENTORY_UNITS_AVAILABLE,
         0 INVENTORY_AVAILABLE,
         i.INVENTORY_PERCENT,
         (i.ON_ORDER_TOTAL * i.PACK_CASE) ON_ORDER_TOTAL_UNITS,
         i.ON_ORDER_TOTAL,
         i.FACILITYID FACILITYID_HOME,
         i.FACILITYID_STOCK FACILITYID_STOCK,
         i.ITEM_DEPT,
         i.ITEM_NBR_HS_HOME,
         i.ITEM_NBR_HS_STOCK,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.INVENTORY_TOTAL,
         eid.PROD_QTY SN_UNITS_AVAIL,
         eid.PROD_QTY / i.PACK_CASE SN_CASES_AVAIL,
         i.RESERVE_COMMITTED,
         i.RESERVE_UNCOMMITTED,
         i.STORAGE_COMMITTED,
         i.STORAGE_UNCOMMITTED,
         i.FORECAST,
         i.IN_PROCESS_REGULAR,
         0 poq_quantity,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS,
         i.CODE_DATE_FLAG,
         dx.FACILITYID_UPSTREAM,
         ts.TOTAL_STORES,
         ds.DC_STORES,
         (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) US_DS_ALLOC_PERCENT,
         ir.num_relationships
FROM     CRMADMIN.V_AMZ_ITEM_NFD i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID_HOME = dx.SWAT_ID 
         inner join (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY dx.FACILITYID_UPSTREAM) ts on dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM 
         inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds on i.FACILITYID_HOME = ds.FACILITYID 
         inner join (SELECT FACILITYID_STOCK, ITEM_NBR_HS_STOCK, count(*) num_relationships FROM CRMADMIN.V_AMZ_ITEM_NFD 
         inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds on FACILITYID_HOME = ds.FACILITYID GROUP BY FACILITYID_STOCK, ITEM_NBR_HS_STOCK) ir on i.FACILITYID_STOCK = ir.FACILITYID_STOCK and i.ITEM_NBR_HS_STOCK = ir.ITEM_NBR_HS_STOCK 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = i.FACILITYID_STOCK and eid.ITEM_NBR_HS = i.ITEM_NBR_HS_STOCK
WHERE    i.FACILITYID_HOME in (SELECT vwcf.FACILITYID FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf WHERE vwcf.CORP_CODE = 634001
     AND vwcf.FACILITYID not in ('001', '002', '071') GROUP BY vwcf.FACILITYID)
AND      i.BILLING_STATUS_BACKSCREEN not in ('D', 'Z');

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_INVENTORY_FEED_NFD
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB002687;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB033016;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB038866;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB065023;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB076602;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB077382;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB079572;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB081868;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB082673;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB096486;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB099260;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB100026;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB103416;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB103570;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB103712;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB105703;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB106453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB108245;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB126235;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB142672;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB146729;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB148781;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB151483;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB153050;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB154428;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB159999;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB160831;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB161042;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB162511;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB172084;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB181352;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB184961;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB186096;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB189061;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB189628;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB210344;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB210958;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB211038;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB212676;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB213711;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB221580;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB222356;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB227847;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB228405;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB235955;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB237127;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB237361;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB237844;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB238600;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB238608;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB238609;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB240787;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB241504;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB241793;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB242206;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB243870;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINKART;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINMANI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINNITH;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINRAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINROAN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED_US
--------------------------------------------------
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED_US 
as 
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
         case vi.INVENTORY_TOTAL when 0 then 0 else integer(round((case vi.ITEM_RES28 when 'A' then (eid.PROD_QTY / vi.PACK_CASE) else int(round((eid.PROD_QTY * vi.INVENTORY_PERCENT))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) end Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case vi.INVENTORY_TOTAL when 0 then 0 else integer(round((case vi.ITEM_RES28 when 'A' then (eid.PROD_QTY / vi.PACK_CASE) else int(round(((eid.PROD_QTY / vi.PACK_CASE)* vi.INVENTORY_PERCENT))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) end AVAILABLE_ORDERABLE_QTY,
         case vi.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         eid.RECEIPT_DT,
         (case vi.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - vi.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case vi.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else (eid.RECEIPT_DT + vi.SHELF_LIFE days) end) expiration_date_time,
         0 INVENTORY_UNITS_AVAILABLE,
         0 INVENTORY_AVAILABLE,
         vi.INVENTORY_PERCENT,
         (vi.ON_ORDER_TOTAL * vi.PACK_CASE) ON_ORDER_TOTAL_UNITS,
         vi.ON_ORDER_TOTAL,
         i.FACILITYID FACILITYID_HOME,
         vi.FACILITYID FACILITYID_STOCK,
         vi.ITEM_DEPT,
         i.ITEM_NBR_HS ITEM_NBR_HS_HOME,
         vi.ITEM_NBR_HS ITEM_NBR_HS_STOCK,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         vi.INVENTORY_TOTAL,
         eid.PROD_QTY SN_UNITS_AVAIL,
         eid.PROD_QTY / vi.PACK_CASE SN_CASES_AVAIL,
         vi.RESERVE_COMMITTED,
         vi.RESERVE_UNCOMMITTED,
         vi.STORAGE_COMMITTED,
         vi.STORAGE_UNCOMMITTED,
         vi.forecast,
         vi.IN_PROCESS_REGULAR,
         0 poq_quantity,
         vi.SHELF_LIFE,
         vi.DISTRESS_DAYS,
         vi.CODE_DATE_FLAG,
         dx.FACILITYID_UPSTREAM,
         ts.TOTAL_STORES,
         ds.DC_STORES,
         (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) US_DS_ALLOC_PERCENT,
         ir.num_relationships
FROM     CRMADMIN.V_AMZ_ITEM_CORE i 
         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
         inner join CRMADMIN.V_AMZ_ITEM_CORE vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID AND dx.SWAT_ID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75' AND current date > START_DATE AND (current date < END_DATE OR END_DATE is null))
         inner join (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY dx.FACILITYID_UPSTREAM) ts on dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM 
         inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds on i.FACILITYID = ds.FACILITYID 
         inner join (SELECT vi.FACILITYID, vi.ITEM_NBR_HS, count(*) num_relationships FROM CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
         inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds on i.FACILITYID = ds.FACILITYID WHERE i.ITEM_RES28 in ('A', 'C') GROUP BY vi.FACILITYID, vi.ITEM_NBR_HS) ir on dx.FACILITYID_UPSTREAM = ir.FACILITYID and vi.ITEM_NBR_HS = ir.ITEM_NBR_HS 
         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') and FACILITYID in ('002', '071') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = vi.FACILITYID and eid.ITEM_NBR_HS = vi.ITEM_NBR_HS 
--         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE between current date and current date + 28 days group by FACILITYID, ITEM_NBR) poq on vi.BICEPS_DC = poq.FACILITYID and vi.ITEM_NBR = poq.ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      i.BILLING_STATUS_BACKSCREEN not in ('D', 'Z')
AND      right(i.FACILITYID,2) <> i.STOCK_FAC
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75'
     AND current date > START_DATE
     AND (current date < END_DATE
        OR  END_DATE is null));

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_INVENTORY_FEED_US
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB002687;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB033016;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB038712;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB038866;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB065023;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB075216;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB075781;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB076602;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB077382;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB079572;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB081868;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB082673;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB096486;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB099260;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB100026;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB102019;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB103416;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB103570;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB103712;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB103724;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB105018;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB105281;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB105703;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB106139;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB106453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB108245;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB126235;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB142672;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB146729;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB148781;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB151483;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB153050;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB154428;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB159999;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB160831;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB161042;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB162511;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB172084;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB172087;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB177494;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB178908;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB181352;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB184961;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB186096;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB188771;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB189061;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB189628;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB203809;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB209501;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB210344;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB210958;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB211038;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB212676;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB213711;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB221580;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB222356;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB227847;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB228400;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB228405;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB228662;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB235955;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB237127;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB237310;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB237361;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB237844;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB238600;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB238608;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB238609;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB240787;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB241504;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB241793;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB242206;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB243870;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINKART;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINMANI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINNITH;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINRAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINROAN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user WEB;



--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED
--------------------------------------------------
CREATE OR replace VIEW CRMADMIN.V_AMZ_INVENTORY_FEED AS  SELECT   FACILITYID,   INVENTORY_EFFECTIVE_DATETIME,   ASIN,   UPC_UNIT_CD,   AVAILABLE_QTY_UOM,   AVAILABLE_QTY_TO_AMZ,   AVAILABLE_ORDERABLE_QTY_UOM,   AVAILABLE_ORDERABLE_QTY,   AMZ_SPECIFIC_UPC,   RECEIPT_DT,   SHRINK_DATE_TIME,   EXPIRATION_DATE_TIME,   FACILITYID_HOME,   FACILITYID_STOCK,   ITEM_DEPT,   ITEM_NBR_HS_HOME,   ITEM_NBR_HS_STOCK,   ITEM_DESCRIP,   PACK_CASE,   INVENTORY_TOTAL,   SN_UNITS_AVAIL,   SN_CASES_AVAIL,   RESERVE_COMMITTED,   RESERVE_UNCOMMITTED,   STORAGE_COMMITTED,   STORAGE_UNCOMMITTED,   FORECAST,   IN_PROCESS_REGULAR,   POQ_QUANTITY,   SHELF_LIFE,   DISTRESS_DAYS,   CODE_DATE_FLAG  FROM   CRMADMIN.V_AMZ_INVENTORY_FEED_DS  UNION ALL  SELECT   FACILITYID,   INVENTORY_EFFECTIVE_DATETIME,   ASIN,   UPC_UNIT_CD,   AVAILABLE_QTY_UOM,   AVAILABLE_QTY_TO_AMZ,   AVAILABLE_ORDERABLE_QTY_UOM,   AVAILABLE_ORDERABLE_QTY,   AMZ_SPECIFIC_UPC,   RECEIPT_DT,   SHRINK_DATE_TIME,   EXPIRATION_DATE_TIME,   FACILITYID_HOME,   FACILITYID_STOCK,   ITEM_DEPT,   ITEM_NBR_HS_HOME,   ITEM_NBR_HS_STOCK,   ITEM_DESCRIP,   PACK_CASE,   INVENTORY_TOTAL,   SN_UNITS_AVAIL,   SN_CASES_AVAIL,   RESERVE_COMMITTED,   RESERVE_UNCOMMITTED,   STORAGE_COMMITTED,   STORAGE_UNCOMMITTED,   FORECAST,   IN_PROCESS_REGULAR,   POQ_QUANTITY,   SHELF_LIFE,   DISTRESS_DAYS,   CODE_DATE_FLAG  FROM   CRMADMIN.V_AMZ_INVENTORY_FEED_US  UNION ALL  SELECT   FACILITYID,   INVENTORY_EFFECTIVE_DATETIME,   ASIN,   UPC_UNIT_CD,   AVAILABLE_QTY_UOM,   AVAILABLE_QTY_TO_AMZ,   AVAILABLE_ORDERABLE_QTY_UOM,   AVAILABLE_ORDERABLE_QTY,   AMZ_SPECIFIC_UPC,   RECEIPT_DT,   SHRINK_DATE_TIME,   EXPIRATION_DATE_TIME,   FACILITYID_HOME,   FACILITYID_STOCK,   ITEM_DEPT,   ITEM_NBR_HS_HOME,   ITEM_NBR_HS_STOCK,   ITEM_DESCRIP,   PACK_CASE,   INVENTORY_TOTAL,   SN_UNITS_AVAIL,   SN_CASES_AVAIL,   RESERVE_COMMITTED,   RESERVE_UNCOMMITTED,   STORAGE_COMMITTED,   STORAGE_UNCOMMITTED,   FORECAST,   IN_PROCESS_REGULAR,   POQ_QUANTITY,   SHELF_LIFE,   DISTRESS_DAYS,   CODE_DATE_FLAG  FROM   CRMADMIN.V_AMZ_INVENTORY_FEED_NFD;

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_INVENTORY_FEED
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB002687;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB033016;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB038712;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB038866;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB065023;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB075216;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB075781;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB076602;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB077382;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB079572;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB081868;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB082673;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB096486;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB099260;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB100026;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB102019;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB103416;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB103570;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB103712;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB103724;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB105018;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB105281;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB105703;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB106139;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB106453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB108245;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB126235;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB142672;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB146729;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB148781;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB151483;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB153050;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB154428;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB159999;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB160831;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB161042;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB162511;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB172084;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB172087;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB177494;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB178908;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB181352;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB184961;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB186096;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB188771;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB189061;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB189628;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB203809;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB209501;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB210344;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB210958;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB211038;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB212676;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB213711;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB221580;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB222356;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB227847;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB228400;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB228405;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB228662;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB235955;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB237127;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB237310;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB237361;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB237844;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB238600;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB238608;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB238609;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB240787;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB241504;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB241793;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB242206;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB243870;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINKART;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINMANI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINNITH;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINRAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINROAN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user WEB;
