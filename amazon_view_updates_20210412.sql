/*
--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_ITEM_XF
--------------------------------------------------
--drop index CRMADMIN.T_WHSE_ITEM_XF;
create  Index CRMADMIN.T_WHSE_ITEM_XF 
	on CRMADMIN.T_WHSE_ITEM 
	(ROOT_ITEM_NBR, LV_ITEM_NBR)   
	Allow Reverse Scans;

runstats on table CRMADMIN.T_WHSE_ITEM with distribution and detailed indexes all shrlevel change;
*/
--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_ITEM_CORE
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_ITEM_CORE;
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
         inner join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR
WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
;

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_ITEM_CORE
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_ITEM_CORE to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB002687;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB033016;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB038712;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB038866;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB065023;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB075216;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB075781;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB076602;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB076812;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB077382;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB079572;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB081868;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB082194;
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
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB172146;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB172605;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB175453;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB177494;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB178908;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB181352;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB184961;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB186096;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB188771;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB189061;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB189628;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB190428;
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
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB248343;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB248345;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DB2CDC;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user DBCDC;
grant control on CRMADMIN.V_AMZ_ITEM_CORE to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_ITEM_CORE to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user ETLX;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user SIUSER;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINJAME;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINKART;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINMANI;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINNITH;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINRAME;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINROAN;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_ITEM_CORE to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_ITEM_NFD
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_ITEM_NFD;
create or replace view CRMADMIN.V_AMZ_ITEM_NFD 
as    
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
         inner join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR
WHERE    i.FACILITYID = '054';

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_ITEM_NFD
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_ITEM_NFD to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB002687;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB033016;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB038712;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB038866;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB065023;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB075216;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB075781;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB076602;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB076812;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB077382;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB079572;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB081868;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB082194;
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
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB172146;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB172605;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB175453;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB177494;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB178908;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB181352;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB184961;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB186096;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB188771;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB189061;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB189628;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB190428;
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
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB248343;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB248345;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DB2CDC;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user DBCDC;
grant control on CRMADMIN.V_AMZ_ITEM_NFD to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_ITEM_NFD to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user ETLX;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user SIUSER;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINJAME;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINKART;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINMANI;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINNITH;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINRAME;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINROAN;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_ITEM_NFD to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_CATALOG_FEED
--------------------------------------------------
drop view CRMADMIN.V_AMZ_CATALOG_FEED;
CREATE  view CRMADMIN.V_AMZ_CATALOG_FEED 
as 
SELECT   case cic.FACILITYID 
     when '054' then '040' 
     else cic.FACILITYID 
end FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '058' then 'F3SPA' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.LU_CODE asin,
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
         round((cic.BURDENED_COST_CASE_AMT / i.PACK_CASE) + .01, 2) item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_Price,
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
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.CORP_RES 
              when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' 
              when '000' then 'Y' 
              else 'N' 
         end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case 
              when cid.ITEM_AUTH_CD is null then 'Y' 
              else case 
                        when cid.ITEM_AUTH_CD = 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ITEM_AUTH_FLG,
         case 
              when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' 
              else case 
                        when i.PRIVATE_LABEL_KEY is null then 'Y' 
                        else 'N' 
                   end 
         end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date between A.START_DATE and A.END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
WHERE    cic.FACILITYID = '058'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
UNION all 
SELECT   case cic.FACILITYID 
     when '054' then '040' 
     else cic.FACILITYID 
end FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '054' then 'F3SPB' 
              when '040' then 'F3SPB' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.LU_CODE asin,
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
         round((cic.BURDENED_COST_CASE_AMT / i.PACK_CASE) + .01, 2) item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_Price,
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
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.CORP_RES 
              when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' 
              when '000' then 'Y' 
              else 'N' 
         end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case 
              when cid.ITEM_AUTH_CD is null then 'Y' 
              else case 
                        when cid.ITEM_AUTH_CD = 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ITEM_AUTH_FLG,
         case 
              when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' 
              else case 
                        when i.PRIVATE_LABEL_KEY is null then 'Y' 
                        else 'N' 
                   end 
         end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date between A.START_DATE and A.END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
WHERE    cic.FACILITYID = '054'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
UNION all 
SELECT   case cic.FACILITYID 
     when '054' then '040' 
     else cic.FACILITYID 
end FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '054' then 'F3SPB' 
              when '040' then 'F3SPB' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.LU_CODE asin,
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
         round((cic.BURDENED_COST_CASE_AMT / i.PACK_CASE) + .01, 2) item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_Price,
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
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.CORP_RES 
              when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' 
              when '000' then 'Y' 
              else 'N' 
         end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case 
              when cid.ITEM_AUTH_CD is null then 'Y' 
              else case 
                        when cid.ITEM_AUTH_CD = 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ITEM_AUTH_FLG,
         case 
              when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' 
              else case 
                        when i.PRIVATE_LABEL_KEY is null then 'Y' 
                        else 'N' 
                   end 
         end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date between A.START_DATE and A.END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
WHERE    cic.FACILITYID = '040'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
UNION all 
SELECT   case cic.FACILITYID 
     when '054' then '008' 
     else cic.FACILITYID 
end FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '054' then 'SPD2Z' 
              when '008' then 'SPD2Z' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.LU_CODE asin,
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
         round((cic.BURDENED_COST_CASE_AMT / i.PACK_CASE) + .01, 2) item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_Price,
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
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.CORP_RES 
              when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' 
              when '000' then 'Y' 
              else 'N' 
         end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case 
              when cid.ITEM_AUTH_CD is null then 'Y' 
              else case 
                        when cid.ITEM_AUTH_CD = 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ITEM_AUTH_FLG,
         case 
              when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' 
              else case 
                        when i.PRIVATE_LABEL_KEY is null then 'Y' 
                        else 'N' 
                   end 
         end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date between A.START_DATE and A.END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
WHERE    cic.FACILITYID in '054'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
UNION all 
SELECT   case cic.FACILITYID 
     when '054' then '008' 
     else cic.FACILITYID 
end FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '054' then 'SPD2Z' 
              when '008' then 'SPD2Z' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.LU_CODE asin,
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
         round((cic.BURDENED_COST_CASE_AMT / i.PACK_CASE) + .01, 2) item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_Price,
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
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.CORP_RES 
              when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' 
              when '000' then 'Y' 
              else 'N' 
         end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case 
              when cid.ITEM_AUTH_CD is null then 'Y' 
              else case 
                        when cid.ITEM_AUTH_CD = 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ITEM_AUTH_FLG,
         case 
              when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' 
              else case 
                        when i.PRIVATE_LABEL_KEY is null then 'Y' 
                        else 'N' 
                   end 
         end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date between A.START_DATE and A.END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
WHERE    cic.FACILITYID = '008'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
UNION all 
SELECT   case cic.FACILITYID 
     when '054' then '040' 
     else cic.FACILITYID 
end FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '015' then 'F3SPC' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.LU_CODE asin,
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
         round((cic.BURDENED_COST_CASE_AMT / i.PACK_CASE) + .01, 2) item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_Price,
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
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.CORP_RES 
              when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' 
              when '000' then 'Y' 
              else 'N' 
         end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case 
              when cid.ITEM_AUTH_CD is null then 'Y' 
              else case 
                        when cid.ITEM_AUTH_CD = 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ITEM_AUTH_FLG,
         case 
              when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' 
              else case 
                        when i.PRIVATE_LABEL_KEY is null then 'Y' 
                        else 'N' 
                   end 
         end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date between A.START_DATE and A.END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
WHERE    cic.FACILITYID = '015'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
UNION ALL 
SELECT   cic.FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '085' then 'SPD30' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.LU_CODE asin,
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
         round((cic.BURDENED_COST_CASE_AMT / i.PACK_CASE) + .01, 2) item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_Price,
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
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.CORP_RES 
              when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' 
              when '000' then 'Y' 
              else 'N' 
         end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case 
              when cid.ITEM_AUTH_CD is null then 'Y' 
              else case 
                        when cid.ITEM_AUTH_CD = 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ITEM_AUTH_FLG,
         case 
              when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' 
              else case 
                        when i.PRIVATE_LABEL_KEY is null then 'Y' 
                        else 'N' 
                   end 
         end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date between A.START_DATE and A.END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
WHERE    cic.FACILITYID = '085'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'
UNION ALL 
SELECT   cic.FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '086' then 'SPDPD' 
              else cic.FACILITYID 
         end vendor_code,
         current timestamp catalog_effective_date_time,
         asin.LU_CODE asin,
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
         round((cic.BURDENED_COST_CASE_AMT / i.PACK_CASE) + .01, 2) item_cost_price,
         i.PACK_CASE case_Pack_Quantity,
         cic.BURDENED_COST_CASE_AMT case_Pack_Cost_Price,
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
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.BILLING_STATUS_BACKSCREEN,
         i.NATAG_MAINT_DATE,
         i.AVAILABILITY_DATE,
         i.RE_AVAILABLE_DATE,
         case i.CORP_RES 
              when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' 
              when '000' then 'Y' 
              else 'N' 
         end CORP_AUTH_FLG,
         i.INSITE_FLG,
         i.ITEM_TYPE_CD,
         case 
              when cid.ITEM_AUTH_CD is null then 'Y' 
              else case 
                        when cid.ITEM_AUTH_CD = 'Y' then 'Y' 
                        else 'N' 
                   end 
         end ITEM_AUTH_FLG,
         case 
              when i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY then 'Y' 
              else case 
                        when i.PRIVATE_LABEL_KEY is null then 'Y' 
                        else 'N' 
                   end 
         end PRIVATE_BRAND_AUTH_FLG
FROM     TABLE( SELECT A.FACILITYID, A.CUSTOMER_NBR_STND, A.BURDENED_COST_FLG, A.CORP_SWAT, A.ITEM_NBR_HS, START_DATE, END_DATE_REAL, BURDENED_COST_CASE_AMT, UNBURDENED_COST_CASE_AMT, BURDENED_COST_CASE_NET_AMT, UNBURDENED_COST_CASE_NET_AMT, OI_ALLOWANCE_START_DATE, OI_ALLOWANCE_END_DATE, OI_ALLOWANCE_AMT, PA_ALLOWANCE_START_DATE, PA_ALLOWANCE_END_DATE, PA_ALLOWANCE_AMT FROM CRMADMIN.V_WEB_CUSTOMER_ITEM_COST A WHERE A.MASTER_ITEM_FLG = 'Y' AND A.CUSTOMER_NBR_STND > 0 AND current date between A.START_DATE and A.END_DATE_REAL ) CIC 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = cic.FACILITYID and i.ITEM_NBR_HS = cic.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_MDSE_DEPT cmd on i.FACILITYID = cmd.FACILITYID and cmd.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.MERCH_DEPT = cmd.MDSE_DEPT_CD 
         inner join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
WHERE    cic.FACILITYID = '086'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y';

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_CATALOG_FEED
--------------------------------------------------
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB033016;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB038866;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB065023;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB076602;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB076812;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB077382;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB079572;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB081868;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB082194;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB082673;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB096486;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB099260;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB100026;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB103416;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB103570;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB103712;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB105703;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB106453;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB108245;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB126235;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB142672;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB146729;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB148781;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB151483;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB153050;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB154428;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB159999;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB160831;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB161042;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB162511;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB172084;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB172087;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB172146;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB172605;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB181352;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB184961;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB186096;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB189061;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB189628;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB190428;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB210344;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB210958;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB211038;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB212676;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB213711;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB221580;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB222356;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB227847;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB228405;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB235955;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB237127;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB237361;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB237844;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB238600;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB238608;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB240787;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB241793;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB242206;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB243870;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB248343;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB248345;
grant control on CRMADMIN.V_AMZ_CATALOG_FEED to user DB2INST1;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB2INST1 with grant option;
grant select,update,insert,delete on CRMADMIN.V_AMZ_CATALOG_FEED to user ETL;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user SIUSER;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINJAME;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINKART;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINMANI;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINNITH;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINRAME;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED_DS
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_INVENTORY_FEED_DS;
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
         case i.ITEM_RES28 
              when 'A' then value(eid.PROD_QTY, 0) 
              else int(round((value(eid.PROD_QTY, 0) * i.INVENTORY_PERCENT))) 
         end Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case i.ITEM_RES28 
              when 'A' then (value(eid.PROD_QTY, 0) / i.PACK_CASE) 
              else int(round(((value(eid.PROD_QTY, 0)) / i.PACK_CASE) * i.INVENTORY_PERCENT)) 
         end AVAILABLE_ORDERABLE_QTY,
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
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS = 'A' AND FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75' AND current date > START_DATE AND (current date < END_DATE OR END_DATE is null) AND FACILITYID <> '054') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = i.FACILITYID and eid.ITEM_NBR_HS = i.ITEM_NBR_HS AND right(i.FACILITYID,2) = i.STOCK_FAC AND i.BILLING_STATUS_BACKSCREEN not in ('D', 'Z');

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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB076812;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB077382;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB079572;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB081868;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB082194;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB172146;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB172605;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB177494;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB178908;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB181352;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB184961;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB186096;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB188771;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB189061;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB189628;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB190428;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB248343;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB248345;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINJAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINKART;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINMANI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINNITH;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINRAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINROAN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED_NFD
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_INVENTORY_FEED_NFD;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB076812;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB077382;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB079572;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB081868;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB082194;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB172087;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB172146;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB172605;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB181352;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB184961;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB186096;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB189061;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB189628;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB190428;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB248343;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB248345;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINJAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINKART;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINMANI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINNITH;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINRAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINROAN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED_US
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_INVENTORY_FEED_US;
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
         i.ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,
         case vi.INVENTORY_TOTAL 
              when 0 then 0 
              else integer(round((case vi.ITEM_RES28 
                                       when 'A' then (eid.PROD_QTY / vi.PACK_CASE) 
                                       else int(round((eid.PROD_QTY * vi.INVENTORY_PERCENT))) end) * (case ir.num_relationships 
                                                                                                           when 1 then decimal(1.00, 9, 3) 
                                                                                                           else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) 
                                                                                                      end Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case vi.INVENTORY_TOTAL 
              when 0 then 0 
              else integer(round((case vi.ITEM_RES28 
                                       when 'A' then (eid.PROD_QTY / vi.PACK_CASE) 
                                       else int(round(((eid.PROD_QTY / vi.PACK_CASE)* vi.INVENTORY_PERCENT))) end) * (case ir.num_relationships 
                                                                                                                           when 1 then decimal(1.00, 9, 3) 
                                                                                                                           else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) 
                                                                                                                      end AVAILABLE_ORDERABLE_QTY,
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
         inner join (SELECT vi.FACILITYID, vi.ITEM_NBR_HS, count(*) num_relationships FROM CRMADMIN.V_AMZ_ITEM_CORE i 
         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
         inner join CRMADMIN.V_AMZ_ITEM_CORE vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds on i.FACILITYID = ds.FACILITYID GROUP BY vi.FACILITYID, vi.ITEM_NBR_HS) ir on dx.FACILITYID_UPSTREAM = ir.FACILITYID and vi.ITEM_NBR_HS = ir.ITEM_NBR_HS 
--         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') and FACILITYID in ('002', '071') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = vi.FACILITYID and eid.ITEM_NBR_HS = vi.ITEM_NBR_HS
WHERE    i.BILLING_STATUS_BACKSCREEN not in ('D', 'Z')
AND      right(i.FACILITYID,2) <> i.STOCK_FAC
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75'
     AND current date > START_DATE
     AND (current date < END_DATE
        OR  END_DATE is null))
;

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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB076812;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB077382;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB079572;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB081868;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB082194;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB172146;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB172605;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB177494;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB178908;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB181352;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB184961;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB186096;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB188771;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB189061;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB189628;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB190428;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB248343;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB248345;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINJAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINKART;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINMANI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINNITH;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINRAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINROAN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_INVENTORY_FEED;
CREATE OR replace VIEW CRMADMIN.V_AMZ_INVENTORY_FEED 
AS  
SELECT   FACILITYID,
         INVENTORY_EFFECTIVE_DATETIME,
         ASIN,
         UPC_UNIT_CD,
         AVAILABLE_QTY_UOM,
         AVAILABLE_QTY_TO_AMZ,
         AVAILABLE_ORDERABLE_QTY_UOM,
         AVAILABLE_ORDERABLE_QTY,
         AMZ_SPECIFIC_UPC,
         RECEIPT_DT,
         SHRINK_DATE_TIME,
         EXPIRATION_DATE_TIME,
         FACILITYID_HOME,
         FACILITYID_STOCK,
         ITEM_DEPT,
         ITEM_NBR_HS_HOME,
         ITEM_NBR_HS_STOCK,
         ITEM_DESCRIP,
         PACK_CASE,
         INVENTORY_TOTAL,
         SN_UNITS_AVAIL,
         SN_CASES_AVAIL,
         RESERVE_COMMITTED,
         RESERVE_UNCOMMITTED,
         STORAGE_COMMITTED,
         STORAGE_UNCOMMITTED,
         FORECAST,
         IN_PROCESS_REGULAR,
         POQ_QUANTITY,
         SHELF_LIFE,
         DISTRESS_DAYS,
         CODE_DATE_FLAG
FROM     CRMADMIN.V_AMZ_INVENTORY_FEED_DS
UNION ALL 
SELECT   FACILITYID,
         INVENTORY_EFFECTIVE_DATETIME,
         ASIN,
         UPC_UNIT_CD,
         AVAILABLE_QTY_UOM,
         AVAILABLE_QTY_TO_AMZ,
         AVAILABLE_ORDERABLE_QTY_UOM,
         AVAILABLE_ORDERABLE_QTY,
         AMZ_SPECIFIC_UPC,
         RECEIPT_DT,
         SHRINK_DATE_TIME,
         EXPIRATION_DATE_TIME,
         FACILITYID_HOME,
         FACILITYID_STOCK,
         ITEM_DEPT,
         ITEM_NBR_HS_HOME,
         ITEM_NBR_HS_STOCK,
         ITEM_DESCRIP,
         PACK_CASE,
         INVENTORY_TOTAL,
         SN_UNITS_AVAIL,
         SN_CASES_AVAIL,
         RESERVE_COMMITTED,
         RESERVE_UNCOMMITTED,
         STORAGE_COMMITTED,
         STORAGE_UNCOMMITTED,
         FORECAST,
         IN_PROCESS_REGULAR,
         POQ_QUANTITY,
         SHELF_LIFE,
         DISTRESS_DAYS,
         CODE_DATE_FLAG
FROM     CRMADMIN.V_AMZ_INVENTORY_FEED_US
UNION ALL 
SELECT   FACILITYID,
         INVENTORY_EFFECTIVE_DATETIME,
         ASIN,
         UPC_UNIT_CD,
         AVAILABLE_QTY_UOM,
         AVAILABLE_QTY_TO_AMZ,
         AVAILABLE_ORDERABLE_QTY_UOM,
         AVAILABLE_ORDERABLE_QTY,
         AMZ_SPECIFIC_UPC,
         RECEIPT_DT,
         SHRINK_DATE_TIME,
         EXPIRATION_DATE_TIME,
         FACILITYID_HOME,
         FACILITYID_STOCK,
         ITEM_DEPT,
         ITEM_NBR_HS_HOME,
         ITEM_NBR_HS_STOCK,
         ITEM_DESCRIP,
         PACK_CASE,
         INVENTORY_TOTAL,
         SN_UNITS_AVAIL,
         SN_CASES_AVAIL,
         RESERVE_COMMITTED,
         RESERVE_UNCOMMITTED,
         STORAGE_COMMITTED,
         STORAGE_UNCOMMITTED,
         FORECAST,
         IN_PROCESS_REGULAR,
         POQ_QUANTITY,
         SHELF_LIFE,
         DISTRESS_DAYS,
         CODE_DATE_FLAG
FROM     CRMADMIN.V_AMZ_INVENTORY_FEED_NFD;

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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB076812;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB077382;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB079572;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB081868;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB082194;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB172146;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB172605;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB177494;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB178908;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB181352;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB184961;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB186096;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB188771;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB189061;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB189628;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB190428;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB248343;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB248345;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINJAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINKART;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINMANI;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINNITH;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINRAME;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINROAN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user WEB;



--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS;
create or replace view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS 
as   
SELECT pod.FACILITYID AS STOCK_FAC, i.FACILITYID, CASE i.FACILITYID WHEN '054' THEN 'F3SPB' WHEN '040' THEN 'F3SPB' WHEN '058' THEN 'F3SPA' WHEN '015' THEN 'F3SPC' WHEN '008' then 'SPD2Z' WHEN '085' then 'SPD30' WHEN '086' then 'SPDPD' ELSE i.FACILITYID END AS VENDOR_CODE, CURRENT date AS SNAPSHOT_DATE, poh.PO_NBR AS PO_NUMBER, poh.VENDOR_NAME AS SUPPLIER_NAME, az.LU_CODE AS ASIN, i.ITEM_NBR_HS AS VENDOR_SKU, i.UPC_UNIT_CD, i.UPC_CASE_CD, i.ITEM_DESCRIP, pod.PACK AS CASE_PACK_QTY, 'EA' AS CASE_QTY_UOM, CASE i.ITEM_RES28 WHEN 'A' THEN 'YES' ELSE 'NO' END AS AMZ_SPECIFIC_UPC, decimal(round((pod.LIST_COST / pod.PACK), 2), 9, 3) AS ITEM_COST_PRICE, decimal(round((pod.AMOUNT_OFF_INVOICE / pod.PACK), 3), 9, 3) AS ITEM_COST_ALLOW, pod.LIST_COST AS CASE_PACK_COST_PRICE, pod.AMOUNT_OFF_INVOICE AS CASE_PACK_COST_ALLOW, CASE pod.LINE_STATUS WHEN 'D' THEN 'RECEIVED' ELSE 'OPEN' END AS STATUS, pod.DATE_ORDERED AS ORDERED_DATE, poh.PO_ORIGINAL_DLVRY_DATE AS ORIG_REQ_DEL_DATE, poh.BUYER_ARRIVAL_DATE AS ADJ_REQ_DEL_DATE, poh.DATE_ARRIVAL AS APPOINTMENT_DATE, pod.EXE_FIRST_RECVD_TIMESTAMP AS RECEIVED_DTIME, CASE pod.ORIGINAL_QUANTITY WHEN 0 THEN pod.QUANTITY * pod.PACK ELSE pod.ORIGINAL_QUANTITY * pod.PACK END AS TOTAL_UNITS_ORDERED, pod.RECEIVED * pod.PACK AS TOTAL_UNITS_RECEIVED, pod.TURN * pod.PACK AS TURN_UNITS_ORDERED, CASE pod.LINE_STATUS WHEN 'D' THEN INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)) * pod.PACK ELSE 0 END AS TURN_UNITS_RECEIVED, CASE WHEN (integer(round((CASE i.ITEM_RES28 WHEN 'A' THEN pod.QUANTITY ELSE (integer(round((pod.TURN * ((i.ON_ORDER_TURN - ((i.CASES_PER_WEEK * (CASE WHEN i.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / i.ON_ORDER_TURN))))) END))) * pod.PACK) <0 THEN 0 ELSE (integer(round((CASE i.ITEM_RES28 WHEN 'A' THEN pod.QUANTITY ELSE (integer(round((pod.TURN * ((i.ON_ORDER_TURN - ((i.CASES_PER_WEEK * (CASE WHEN i.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / i.ON_ORDER_TURN))))) END))) * pod.PACK) END AS AMZ_UNITS_ORDERED, CASE WHEN (CASE pod.LINE_STATUS WHEN 'D' THEN integer(round((CASE i.ITEM_RES28 WHEN 'A' THEN pod.RECEIVED ELSE (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((i.ON_ORDER_TURN - ((i.CASES_PER_WEEK * (CASE WHEN i.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / i.ON_ORDER_TURN))) END))) * pod.PACK ELSE 0 END)<0 THEN 0 ELSE CASE pod.LINE_STATUS WHEN 'D' THEN integer(round((CASE i.ITEM_RES28 WHEN 'A' THEN pod.RECEIVED ELSE (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((i.ON_ORDER_TURN - ((i.CASES_PER_WEEK * (CASE WHEN i.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / i.ON_ORDER_TURN))) END))) * pod.PACK ELSE 0 END END AS AMZ_UNITS_RECEIVED 

FROM CRMADMIN.T_WHSE_PO_HDR poh 
INNER JOIN CRMADMIN.T_WHSE_PO_DTL pod ON poh.VENDOR_FAC = pod.ITEM_FAC AND poh.PO_NBR = pod.PO_NBR AND poh.DATE_ORDERED = pod.DATE_ORDERED 
INNER JOIN CRMADMIN.T_WHSE_ITEM i ON pod.ITEM_FAC = i.BICEPS_DC AND pod.ITEM_NBR = i.ITEM_NBR INNER JOIN CRMADMIN.T_WHSE_DIV_XREF dx ON i.FACILITYID = dx.SWAT_ID 
INNER JOIN CRMADMIN.T_WHSE_VENDOR v ON poh.FACILITYID = v.FACILITYID AND poh.VENDOR_NBR = v.VENDOR_NBR 
INNER JOIN CRMADMIN.V_AMZ_ASIN az ON i.ROOT_ITEM_NBR = az.ROOT_ITEM_NBR AND i.LV_ITEM_NBR = az.LV_ITEM_NBR 

WHERE poh.TYPE NOT IN ('DV') 
AND ((pod.LINE_STATUS <> 'D' AND pod.DATE_ORDERED >= SYSDATE -60 DAY) 
 OR(pod.LINE_STATUS = 'D' AND pod.DATE_RECEIVED BETWEEN CURRENT DATE -7 DAY AND CURRENT DATE)) 
AND pod.QUANTITY > 0 
--AND i.ITEM_RES28 IN ('A', 'C') 
AND i.FACILITYID IN ( SELECT vwcf.FACILITYID FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID not in ('001', '002', '071') GROUP BY vwcf.FACILITYID) 
AND i.ON_ORDER_TURN <> 0 
AND v.MASTER_VENDOR 
NOT IN ('757575', '767676') 
AND i.FACILITYID <> '054';

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB002687;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB033016;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB038712;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB038866;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB065023;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB075216;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB075781;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB076602;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB076812;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB077382;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB079572;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB081868;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB082194;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB082673;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB096486;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB099260;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB100026;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB102019;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB103416;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB103570;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB103712;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB103724;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB105018;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB105281;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB105703;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB106139;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB106453;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB108245;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB126235;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB142672;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB146729;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB148781;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB151483;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB153050;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB154428;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB159999;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB160831;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB161042;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB162511;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB172084;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB172087;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB172146;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB172605;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB175453;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB177494;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB178908;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB181352;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB184961;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB186096;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB188771;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB189061;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB189628;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB190428;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB203809;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB209501;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB210344;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB210958;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB211038;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB212676;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB213711;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB221580;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB222356;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB227847;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB228400;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB228405;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB228662;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB235955;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB237127;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB237310;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB237361;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB237844;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB238600;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB238608;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB238609;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB240787;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB241504;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB241793;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB242206;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB243870;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB248343;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB248345;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DB2CDC;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user DBCDC;
grant control on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user ETLX;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user SIUSER;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINJAME;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINKART;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINMANI;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINNITH;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINRAME;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINROAN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_DS to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD;
create or replace view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD  as             SELECT pod.FACILITYID AS STOCK_FAC, i.FACILITYID, CASE i.FACILITYID_HOME WHEN '040' THEN 'F3SPB' WHEN '008' then 'SPD2Z' ELSE i.FACILITYID END AS VENDOR_CODE, CURRENT date AS SNAPSHOT_DATE, poh.PO_NBR AS PO_NUMBER, poh.VENDOR_NAME AS SUPPLIER_NAME, az.LU_CODE ASIN, i.ITEM_NBR_HS_HOME AS VENDOR_SKU, i.UPC_UNIT_CD, i.UPC_CASE_CD, i.ITEM_DESCRIP, pod.PACK AS CASE_PACK_QTY, 'EA' AS CASE_QTY_UOM, CASE i.ITEM_RES28 WHEN 'A' THEN 'YES' ELSE 'NO' END AS AMZ_SPECIFIC_UPC, decimal(round((pod.LIST_COST / pod.PACK), 2), 9, 3) AS ITEM_COST_PRICE, decimal(round((pod.AMOUNT_OFF_INVOICE / pod.PACK), 3), 9, 3) AS ITEM_COST_ALLOW, pod.LIST_COST AS CASE_PACK_COST_PRICE, pod.AMOUNT_OFF_INVOICE AS CASE_PACK_COST_ALLOW, CASE pod.LINE_STATUS WHEN 'D' THEN 'RECEIVED' ELSE 'OPEN' END AS STATUS, pod.DATE_ORDERED AS ORDERED_DATE, poh.PO_ORIGINAL_DLVRY_DATE AS ORIG_REQ_DEL_DATE, poh.BUYER_ARRIVAL_DATE AS ADJ_REQ_DEL_DATE, poh.DATE_ARRIVAL AS APPOINTMENT_DATE, pod.EXE_FIRST_RECVD_TIMESTAMP AS RECEIVED_DTIME, CASE pod.ORIGINAL_QUANTITY WHEN 0 THEN pod.QUANTITY * pod.PACK ELSE pod.ORIGINAL_QUANTITY * pod.PACK END AS TOTAL_UNITS_ORDERED, pod.RECEIVED * pod.PACK AS TOTAL_UNITS_RECEIVED, pod.TURN * pod.PACK AS TURN_UNITS_ORDERED, CASE pod.LINE_STATUS WHEN 'D' THEN INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)) * pod.PACK ELSE 0 END AS TURN_UNITS_RECEIVED, CASE WHEN (integer(round((CASE i.ITEM_RES28 WHEN 'A' THEN pod.QUANTITY ELSE (integer(round((pod.TURN * ((i.ON_ORDER_TURN - ((i.FORECAST * (CASE WHEN i.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / i.ON_ORDER_TURN))))) END) * (CASE ir.num_relationships WHEN 1 THEN decimal(1.00, 9, 3) ELSE (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3)) END))) * pod.PACK) < 0 THEN 0 ELSE (integer(round((CASE i.ITEM_RES28 WHEN 'A' THEN pod.QUANTITY ELSE (integer(round((pod.TURN * ((i.ON_ORDER_TURN - ((i.FORECAST * (CASE WHEN i.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / i.ON_ORDER_TURN))))) END) * (CASE ir.num_relationships WHEN 1 THEN decimal(1.00, 9, 3) ELSE (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3)) END))) * pod.PACK) END AS AMZ_UNITS_ORDERED, CASE WHEN ( CASE pod.LINE_STATUS WHEN 'D' THEN integer(round((CASE i.ITEM_RES28 WHEN 'A' THEN pod.RECEIVED ELSE (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((i.ON_ORDER_TURN - ((i.FORECAST * (CASE WHEN i.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / i.ON_ORDER_TURN))) * (CASE ir.num_relationships WHEN 1 THEN decimal(1.00, 9, 3) ELSE (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3))END)END))) * pod.PACK ELSE 0 END) < 0 THEN 0 ELSE CASE pod.LINE_STATUS WHEN 'D' THEN integer(round((CASE i.ITEM_RES28 WHEN 'A' THEN pod.RECEIVED ELSE (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((i.ON_ORDER_TURN - ((i.FORECAST * (CASE WHEN i.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / i.ON_ORDER_TURN))) * (CASE ir.num_relationships WHEN 1 THEN decimal(1.00, 9, 3) ELSE (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3))END)END))) * pod.PACK ELSE 0 END END AS AMZ_UNITS_RECEIVED, ts.TOTAL_STORES, ds.DC_STORES, (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3)) AS US_DS_ALLOC_PERCENT, ir.num_relationships 

FROM CRMADMIN.V_AMZ_ITEM_NFD i 
INNER JOIN CRMADMIN.T_WHSE_PO_DTL pod ON pod.FACILITYID = i.FACILITYID_STOCK AND pod.ITEM_NBR = i.ITEM_NBR_STOCK 
INNER JOIN CRMADMIN.T_WHSE_PO_HDR poh ON poh.VENDOR_FAC = pod.ITEM_FAC AND poh.PO_NBR = pod.PO_NBR AND poh.DATE_ORDERED = pod.DATE_ORDERED 
INNER JOIN CRMADMIN.T_WHSE_VENDOR v ON poh.FACILITYID = v.FACILITYID AND poh.VENDOR_NBR = v.VENDOR_NBR 
INNER JOIN (SELECT '054' FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002') GROUP BY dx.FACILITYID_UPSTREAM) ts ON i.FACILITYID_STOCK = ts.FACILITYID_UPSTREAM 
INNER JOIN (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002') GROUP BY vwcf.FACILITYID) ds ON i.FACILITYID_HOME = ds.FACILITYID 
INNER JOIN (SELECT FACILITYID_STOCK, ITEM_NBR_HS_STOCK, count(*) num_relationships FROM CRMADMIN.V_AMZ_ITEM_NFD inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002') GROUP BY vwcf.FACILITYID) ds on FACILITYID_HOME = ds.FACILITYID GROUP BY FACILITYID_STOCK, ITEM_NBR_HS_STOCK) ir ON i.FACILITYID_STOCK = ir.FACILITYID_STOCK AND i.ITEM_NBR_HS_STOCK = ir.ITEM_NBR_HS_STOCK 
LEFT OUTER JOIN CRMADMIN.V_AMZ_ASIN az ON az.ROOT_ITEM_NBR = i.ROOT_ITEM_NBR AND az.LV_ITEM_NBR = i.LV_ITEM_NBR 

WHERE ((pod.LINE_STATUS <> 'D' AND pod.DATE_ORDERED >= SYSDATE -60 DAY) OR (pod.LINE_STATUS = 'D' AND pod.DATE_RECEIVED BETWEEN CURRENT DATE - 7 DAY AND CURRENT DATE)) 
--AND i.ITEM_RES28 IN ('A', 'C') 
AND i.ON_ORDER_TURN <> 0 
AND poh.TYPE NOT IN ('DV') 
AND pod.QUANTITY > 0 
AND v.MASTER_VENDOR NOT IN ('757575', '767676');

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB002687;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB033016;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB038712;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB038866;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB065023;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB075216;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB075781;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB076602;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB076812;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB077382;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB079572;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB081868;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB082194;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB082673;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB096486;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB099260;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB100026;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB102019;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB103416;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB103570;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB103712;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB103724;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB105018;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB105281;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB105703;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB106139;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB106453;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB108245;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB126235;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB142672;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB146729;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB148781;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB151483;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB153050;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB154428;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB159999;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB160831;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB161042;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB162511;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB172084;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB172087;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB172146;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB172605;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB175453;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB177494;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB178908;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB181352;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB184961;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB186096;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB188771;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB189061;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB189628;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB190428;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB203809;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB209501;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB210344;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB210958;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB211038;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB212676;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB213711;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB221580;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB222356;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB227847;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB228400;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB228405;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB228662;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB235955;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB237127;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB237310;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB237361;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB237844;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB238600;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB238608;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB238609;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB240787;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB241504;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB241793;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB242206;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB243870;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB248343;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB248345;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user DB2CDC;
grant control on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user ETLX;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user SIUSER;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINJAME;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINKART;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINMANI;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINNITH;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINRAME;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINROAN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US;
create or replace view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US as   SELECT pod.FACILITYID AS STOCK_FAC, i.FACILITYID, CASE i.FACILITYID WHEN '054' THEN 'F3SPB' WHEN '040' THEN 'F3SPB' WHEN '058' THEN 'F3SPA' WHEN '015' THEN 'F3SPC' WHEN '008' then 'SPD2Z' WHEN '085' then 'SPD30' WHEN '086' then 'SPDPD' ELSE i.FACILITYID END AS VENDOR_CODE, CURRENT date AS SNAPSHOT_DATE, poh.PO_NBR AS PO_NUMBER, poh.VENDOR_NAME AS SUPPLIER_NAME, az.LU_CODE ASIN, vi.ITEM_NBR_HS AS VENDOR_SKU, i.UPC_UNIT_CD, vi.UPC_CASE_CD, vi.ITEM_DESCRIP, pod.PACK AS CASE_PACK_QTY, 'EA' AS CASE_QTY_UOM, CASE i.ITEM_RES28 WHEN 'A' THEN 'YES' ELSE 'NO' END AS AMZ_SPECIFIC_UPC, decimal(round((pod.LIST_COST / pod.PACK), 2), 9, 3) AS ITEM_COST_PRICE, decimal(round((pod.AMOUNT_OFF_INVOICE / pod.PACK), 3), 9, 3) AS ITEM_COST_ALLOW, pod.LIST_COST AS CASE_PACK_COST_PRICE, pod.AMOUNT_OFF_INVOICE AS CASE_PACK_COST_ALLOW, CASE pod.LINE_STATUS WHEN 'D' THEN 'RECEIVED' ELSE 'OPEN' END AS STATUS, pod.DATE_ORDERED AS ORDERED_DATE, poh.PO_ORIGINAL_DLVRY_DATE AS ORIG_REQ_DEL_DATE, poh.BUYER_ARRIVAL_DATE AS ADJ_REQ_DEL_DATE, poh.DATE_ARRIVAL AS APPOINTMENT_DATE, pod.EXE_FIRST_RECVD_TIMESTAMP AS RECEIVED_DTIME, CASE pod.ORIGINAL_QUANTITY WHEN 0 THEN pod.QUANTITY * pod.PACK ELSE pod.ORIGINAL_QUANTITY * pod.PACK END AS TOTAL_UNITS_ORDERED, pod.RECEIVED * pod.PACK AS TOTAL_UNITS_RECEIVED, pod.TURN * pod.PACK AS TURN_UNITS_ORDERED, CASE pod.LINE_STATUS WHEN 'D' THEN INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)) * pod.PACK ELSE 0 END AS TURN_UNITS_RECEIVED, CASE WHEN (integer(round((CASE vi.ITEM_RES28 WHEN 'A' THEN pod.QUANTITY ELSE (integer(round((pod.TURN * ((vi.ON_ORDER_TURN - ((vi.CASES_PER_WEEK * (CASE WHEN vi.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / vi.ON_ORDER_TURN))))) END) * (CASE ir.num_relationships WHEN 1 THEN decimal(1.00, 9, 3) ELSE (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3)) END))) * pod.PACK) <0 THEN 0 ELSE (integer(round((CASE vi.ITEM_RES28 WHEN 'A' THEN pod.QUANTITY ELSE (integer(round((pod.TURN * ((vi.ON_ORDER_TURN - ((vi.CASES_PER_WEEK * (CASE WHEN vi.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / vi.ON_ORDER_TURN))))) END) * (CASE ir.num_relationships WHEN 1 THEN decimal(1.00, 9, 3) ELSE (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3)) END))) * pod.PACK) END AS AMZ_UNITS_ORDERED, CASE WHEN ( CASE pod.LINE_STATUS WHEN 'D' THEN integer(round((CASE vi.ITEM_RES28 WHEN 'A' THEN pod.RECEIVED ELSE (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((vi.ON_ORDER_TURN - ((vi.CASES_PER_WEEK * (CASE WHEN vi.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / vi.ON_ORDER_TURN))) * (CASE ir.num_relationships WHEN 1 THEN decimal(1.00, 9, 3) ELSE (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3))END)END))) * pod.PACK ELSE 0 END) <0 THEN 0 ELSE CASE pod.LINE_STATUS WHEN 'D' THEN integer(round((CASE vi.ITEM_RES28 WHEN 'A' THEN pod.RECEIVED ELSE (integer(round((INTEGER(pod.RECEIVED * (pod.TURN / pod.QUANTITY)))) * ((vi.ON_ORDER_TURN - ((vi.CASES_PER_WEEK * (CASE WHEN vi.ITEM_DEPT IN ('020', '025', '070', '073', '075', '080', '090') THEN 1 ELSE 2 END)))) / vi.ON_ORDER_TURN))) * (CASE ir.num_relationships WHEN 1 THEN decimal(1.00, 9, 3) ELSE (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3))END)END))) * pod.PACK ELSE 0 END END AS AMZ_UNITS_RECEIVED, ts.TOTAL_STORES, ds.DC_STORES, (decimal(value(ds.DC_STORES, 0), 9, 3) / decimal(value(ts.TOTAL_STORES, 0), 9, 3)) AS US_DS_ALLOC_PERCENT, ir.num_relationships 

FROM CRMADMIN.T_WHSE_ITEM i 
INNER JOIN CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc ON i.FACILITYID = ipc.FACILITYID_CHILD AND i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
INNER JOIN CRMADMIN.T_WHSE_ITEM vi ON ipc.FACILITYID_PARENT = vi.FACILITYID AND ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
INNER JOIN CRMADMIN.T_WHSE_PO_DTL pod ON pod.ITEM_FAC = vi.BICEPS_DC AND pod.ITEM_NBR = vi.ITEM_NBR 
INNER JOIN CRMADMIN.T_WHSE_PO_HDR poh ON poh.VENDOR_FAC = pod.ITEM_FAC AND poh.PO_NBR = pod.PO_NBR AND poh.DATE_ORDERED = pod.DATE_ORDERED 
INNER JOIN CRMADMIN.T_WHSE_VENDOR v ON poh.FACILITYID = v.FACILITYID AND poh.VENDOR_NBR = v.VENDOR_NBR 
INNER JOIN CRMADMIN.T_WHSE_DIV_XREF dx ON i.FACILITYID = dx.SWAT_ID 
INNER JOIN (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY dx.FACILITYID_UPSTREAM) ts ON dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM 
INNER JOIN (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds ON i.FACILITYID = ds.FACILITYID 
INNER JOIN (SELECT vi.FACILITYID, vi.ITEM_NBR_HS, count(*) num_relationships FROM CRMADMIN.T_WHSE_ITEM i INNER JOIN CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc ON i.FACILITYID = ipc.FACILITYID_CHILD AND i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD INNER JOIN CRMADMIN.T_WHSE_ITEM vi ON ipc.FACILITYID_PARENT = vi.FACILITYID AND ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS INNER JOIN (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds ON i.FACILITYID = ds.FACILITYID WHERE i.ITEM_RES28 IN ('A', 'C') GROUP BY vi.FACILITYID, vi.ITEM_NBR_HS) ir ON dx.FACILITYID_UPSTREAM = ir.FACILITYID AND vi.ITEM_NBR_HS = ir.ITEM_NBR_HS 
INNER JOIN CRMADMIN.V_AMZ_ASIN az ON az.ROOT_ITEM_NBR = vi.ROOT_ITEM_NBR AND az.LV_ITEM_NBR = vi.LV_ITEM_NBR 
WHERE ((pod.LINE_STATUS <> 'D' AND pod.DATE_ORDERED >= SYSDATE -60 DAY) OR (pod.LINE_STATUS = 'D' AND pod.DATE_RECEIVED BETWEEN CURRENT DATE - 7 DAY AND CURRENT DATE)) 
--AND i.ITEM_RES28 IN ('A', 'C') 
AND i.FACILITYID IN (SELECT vwcf.FACILITYID FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID not in ('001', '002', '071') GROUP BY vwcf.FACILITYID) 
AND vi.ON_ORDER_TURN <> 0 
AND poh.TYPE NOT IN ('DV') 
AND pod.QUANTITY >0 
AND v.MASTER_VENDOR NOT IN ('757575', '767676') 
AND i.FACILITYID <> '054';

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB002687;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB033016;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB038712;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB038866;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB065023;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB075216;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB075781;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB076602;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB076812;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB077382;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB079572;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB081868;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB082194;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB082673;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB096486;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB099260;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB100026;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB102019;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB103416;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB103570;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB103712;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB103724;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB105018;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB105281;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB105703;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB106139;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB106453;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB108245;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB126235;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB142672;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB146729;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB148781;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB151483;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB153050;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB154428;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB159999;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB160831;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB161042;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB162511;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB172084;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB172087;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB172146;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB172605;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB175453;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB177494;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB178908;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB181352;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB184961;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB186096;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB188771;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB189061;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB189628;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB190428;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB203809;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB209501;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB210344;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB210958;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB211038;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB212676;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB213711;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB221580;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB222356;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB227847;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB228400;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB228405;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB228662;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB235955;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB237127;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB237310;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB237361;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB237844;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB238600;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB238608;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB238609;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB240787;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB241504;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB241793;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB242206;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB243870;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB248343;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB248345;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DB2CDC;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user DBCDC;
grant control on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user ETLX;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user SIUSER;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINJAME;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINKART;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINMANI;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINNITH;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINRAME;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINROAN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_US to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED;
create or replace view CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED 
as   
SELECT   STOCK_FAC,
         FACILITYID,
         VENDOR_CODE,
         SNAPSHOT_DATE,
         PO_NUMBER,
         SUPPLIER_NAME,
         ASIN,
         VENDOR_SKU,
         UPC_UNIT_CD,
         UPC_CASE_CD as UPC_CASE,
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
         UPC_CASE_CD as UPC_CASE,
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
         UPC_CASE_CD as UPC_CASE,
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
FROM     CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED_NFD;

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB002687;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB033016;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB038712;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB038866;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB065023;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB075216;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB075781;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB076602;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB076812;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB077382;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB079572;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB081868;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB082194;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB082673;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB096486;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB099260;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB100026;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB102019;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB103416;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB103570;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB103712;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB103724;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB105018;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB105281;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB105703;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB106139;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB106453;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB108245;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB126235;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB142672;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB146729;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB148781;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB151483;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB153050;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB154428;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB159999;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB160831;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB161042;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB162511;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB172084;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB172087;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB172146;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB172605;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB175453;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB177494;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB178908;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB181352;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB184961;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB186096;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB188771;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB189061;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB189628;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB190428;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB203809;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB209501;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB210344;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB210958;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB211038;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB212676;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB213711;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB221580;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB222356;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB227847;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB228400;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB228405;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB228662;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB235955;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB237127;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB237310;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB237361;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB237844;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB238600;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB238608;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB238609;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB240787;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB241504;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB241793;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB242206;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB243870;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB248343;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB248345;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DB2CDC;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user DBCDC;
grant control on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user ETLX;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user SIUSER;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINDIVY;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINJAME;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINJAUR;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINKART;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINKAVI;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINMANI;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINMRIN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINNAIR;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINNITH;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINPAUL;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINPRAS;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINPRAV;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINRAJ;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINRAME;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINROAN;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINTAYA;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSINTHIY;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user VSSWAPNA;
grant select on CRMADMIN.V_AMZ_MFG_FILL_RATE_FEED to user WEB;

