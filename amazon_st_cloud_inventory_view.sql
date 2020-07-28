
create or replace view CRMADMIN.V_AMZ_ITEM_NFD
as
SELECT   i.FACILITYID,
         dx.SWAT_ID FACILITYID_HOME,
         i.ITEM_NBR_HS ITEM_NBR_HS_HOME,
         i.FACILITYID FACILITYID_STOCK,
         i.ITEM_NBR_HS ITEM_NBR_HS_STOCK,
         tu.LU_CODE ASIN,
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
         integer(value(poq.POQ_QTY, 0)) as POQ_QTY,
         i.ITEM_DEPT,
         i.CODE_DATE_FLAG,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS,
         i.ON_ORDER_TOTAL
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on dx.FACILITYID_UPSTREAM = '002' and dx.PROCESS_ACTIVE_FLAG = 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE between current date and current date + 28 days group by FACILITYID, ITEM_NBR) poq on i.BICEPS_DC = poq.FACILITYID and i.ITEM_NBR = poq.ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      i.FACILITYID = '054'
;

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_INVENTORY_FEED
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED to user CRMEXPLN;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB162511;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB172084;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB172087;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB177494;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB178908;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED_DS
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_INVENTORY_FEED_DS;
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED_DS as       
SELECT   case i.FACILITYID 
--     when '054' then 'F3SPB' 
     when '040' then 'F3SPB' 
     when '058' then 'F3SPA' 
     when '015' then 'F3SPC' 
     when '008' then 'SPD2Z' 
     when '085' then 'SPD30' 
     else i.FACILITYID 
end facilityid,
         current timestamp INVENTORY_EFFECTIVE_DATETIME,
         tu.LU_CODE ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,
         case i.ITEM_RES28 
              when 'A' then (eid.PROD_QTY / i.PACK_CASE) 
              else case i.INVENTORY_TOTAL 
                        when 0 then 0 
                        else (integer(round(((i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case 
                                                                                                                                                                                                                                                                                                                   when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 
                                                                                                                                                                                                                                                                                                                   else 2 end)))) / i.INVENTORY_TOTAL * eid.PROD_QTY))) / i.PACK_CASE) 
                                                                                                                                                                                                                                                                                                              end 
                   end * i.PACK_CASE Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case i.ITEM_RES28 
              when 'A' then (eid.PROD_QTY / i.PACK_CASE) 
              else case i.INVENTORY_TOTAL 
                        when 0 then 0 
                        else (integer(round(((i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case 
                                                                                                                                                                                                                                                                                                                   when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 
                                                                                                                                                                                                                                                                                                                   else 2 end)))) / i.INVENTORY_TOTAL * eid.PROD_QTY))) / i.PACK_CASE) 
                                                                                                                                                                                                                                                                                                              end 
                   end AVAILABLE_ORDERABLE_QTY,
         case i.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         eid.RECEIPT_DT,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - i.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else (eid.RECEIPT_DT + i.SHELF_LIFE days) end) expiration_date_time,
         (i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) * i.PACK_CASE as INVENTORY_UNITS_AVAILABLE,
         (i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) as INVENTORY_AVAILABLE,
         case i.INVENTORY_TOTAL 
              when 0 then 0 
              else (i.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case 
                                                                                                                                                                                                                                                                                         when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 
                                                                                                                                                                                                                                                                                         else 2 end)))) / i.INVENTORY_TOTAL 
                                                                                                                                                                                                                                                                                    end as INVENTORY_PERCENT,
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
         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = i.FACILITYID and eid.ITEM_NBR_HS = i.ITEM_NBR_HS 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE between current date and current date + 28 days group by FACILITYID, ITEM_NBR) poq on i.BICEPS_DC = poq.FACILITYID and i.ITEM_NBR = poq.ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      right(i.FACILITYID,2) = i.STOCK_FAC
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75'
     AND current date > START_DATE
     AND (current date < END_DATE
        OR  END_DATE is null)
     AND i.FACILITYID <> '054');

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_INVENTORY_FEED_DS
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user CRMEXPLN;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB162511;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB172084;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB172087;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB177494;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB178908;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_DS to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED_US
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_INVENTORY_FEED_US;
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED_US as      
SELECT   case i.FACILITYID 
     when '040' then 'F3SPB' 
     when '058' then 'F3SPA' 
     when '015' then 'F3SPC' 
     when '008' then 'SPD2Z' 
     when '085' then 'SPD30' 
     else i.FACILITYID 
end facilityid,
         current timestamp INVENTORY_EFFECTIVE_DATETIME,
         tu.LU_CODE ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,
         case vi.INVENTORY_TOTAL 
              when 0 then 0 
              else integer(round((case vi.ITEM_RES28 
                                       when 'A' then (eid.PROD_QTY / vi.PACK_CASE) 
                                       else (integer(round((decimal(((vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case 
                                                                                                                                                                                                                                                                                                                                                  when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 
                                                                                                                                                                                                                                                                                                                                                  else 2 end)))) / value(vi.INVENTORY_TOTAL, 0)), 11, 3) * decimal(eid.PROD_QTY, 11, 3)) / vi.PACK_CASE))) end) * (case ir.num_relationships 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        when 1 then decimal(1.00, 9, 3) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) * vi.PACK_CASE 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             end Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case vi.INVENTORY_TOTAL 
              when 0 then 0 
              else integer(round((case vi.ITEM_RES28 
                                       when 'A' then (eid.PROD_QTY / vi.PACK_CASE) 
                                       else (integer(round((decimal(((vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case 
                                                                                                                                                                                                                                                                                                                                                  when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 
                                                                                                                                                                                                                                                                                                                                                  else 2 end)))) / value(vi.INVENTORY_TOTAL, 0)), 11, 3) * decimal(eid.PROD_QTY, 11, 3)) / vi.PACK_CASE))) end) * (case ir.num_relationships 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        when 1 then decimal(1.00, 9, 3) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                   end AVAILABLE_ORDERABLE_QTY,
         case vi.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         eid.RECEIPT_DT,
         (case vi.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - vi.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case vi.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else (eid.RECEIPT_DT + i.SHELF_LIFE days) end) expiration_date_time,
         (vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) * vi.PACK_CASE as INVENTORY_UNITS_AVAILABLE,
         (vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) as INVENTORY_AVAILABLE,
         case vi.INVENTORY_TOTAL 
              when 0 then 0 
              else decimal(((vi.INVENTORY_TOTAL - (integer(value(poq.POQ_QTY, 0)) + (value(vi.STORAGE_COMMITTED, 0) + value(vi.STORAGE_UNCOMMITTED, 0)) + (value(vi.RESERVE_COMMITTED, 0) + value(vi.RESERVE_UNCOMMITTED, 0)) + ((value(vi.CASES_PER_WEEK, 0) + value(vi.IN_PROCESS_REGULAR, 0)) * (case 
                                                                                                                                                                                                                                                                                                         when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 
                                                                                                                                                                                                                                                                                                         else 2 end)))) / value(vi.INVENTORY_TOTAL, 0)), 11, 3) 
                                                                                                                                                                                                                                                                                                    end INVENTORY_PERCENT,
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
         integer(value(vi.CASES_PER_WEEK,0)) forecast,
         vi.IN_PROCESS_REGULAR,
         integer(value(poq.POQ_QTY, 0)) as poq_quantity,
         vi.SHELF_LIFE,
         vi.DISTRESS_DAYS,
         vi.CODE_DATE_FLAG,
         dx.FACILITYID_UPSTREAM,
         ts.TOTAL_STORES,
         ds.DC_STORES,
         (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) US_DS_ALLOC_PERCENT,
         ir.num_relationships
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
         inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID 
         inner join (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY dx.FACILITYID_UPSTREAM) ts on dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM 
         inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds on i.FACILITYID = ds.FACILITYID 
         inner join (SELECT vi.FACILITYID, vi.ITEM_NBR_HS, count(*) num_relationships FROM CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
         inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds on i.FACILITYID = ds.FACILITYID WHERE i.ITEM_RES28 in ('A', 'C') GROUP BY vi.FACILITYID, vi.ITEM_NBR_HS) ir on dx.FACILITYID_UPSTREAM = ir.FACILITYID and vi.ITEM_NBR_HS = ir.ITEM_NBR_HS 
         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = vi.FACILITYID and eid.ITEM_NBR_HS = vi.ITEM_NBR_HS 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE between current date and current date + 28 days group by FACILITYID, ITEM_NBR) poq on vi.BICEPS_DC = poq.FACILITYID and vi.ITEM_NBR = poq.ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C')
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB162511;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB172084;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB172087;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB175453;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB177494;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB178908;
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
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user WEB;



--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED_NFD
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_INVENTORY_FEED_NFD;
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED_NFD as
SELECT   case i.FACILITYID_HOME 
     when '040' then 'F3SPB' 
     when '008' then 'SPD2Z' 
     else i.FACILITYID_HOME 
end facilityid,
         current timestamp INVENTORY_EFFECTIVE_DATETIME,
         i.ASIN,
         i.UPC_UNIT_CD,
         'EA' available_qty_uom,
         case i.INVENTORY_TOTAL 
              when 0 then 0 
              else integer(round((case i.ITEM_RES28 
                                       when 'A' then (eid.PROD_QTY / i.PACK_CASE) 
                                       else (integer(round((decimal(((i.INVENTORY_TOTAL - (integer(value(i.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case 
                                                                                                                                                                                                                                                                                                                                                  when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 
                                                                                                                                                                                                                                                                                                                                                  else 2 end)))) / value(i.INVENTORY_TOTAL, 0)), 11, 3) * decimal(eid.PROD_QTY, 11, 3)) / i.PACK_CASE))) end) * (case ir.num_relationships 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        when 1 then decimal(1.00, 9, 3) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) * i.PACK_CASE 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             end Available_Qty_To_Amz,
         'CA' AVAILABLE_ORDERABLE_QTY_UOM,
         case i.INVENTORY_TOTAL 
              when 0 then 0 
              else integer(round((case i.ITEM_RES28 
                                       when 'A' then (eid.PROD_QTY / i.PACK_CASE) 
                                       else (integer(round((decimal(((i.INVENTORY_TOTAL - (integer(value(i.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case 
                                                                                                                                                                                                                                                                                                                                                  when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 
                                                                                                                                                                                                                                                                                                                                                  else 2 end)))) / value(i.INVENTORY_TOTAL, 0)), 11, 3) * decimal(eid.PROD_QTY, 11, 3)) / i.PACK_CASE))) end) * (case ir.num_relationships 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        when 1 then decimal(1.00, 9, 3) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                   end AVAILABLE_ORDERABLE_QTY,
         case i.ITEM_RES28 
              when 'A' then 'YES' 
              else 'NO' 
         end AMZ_SPECIFIC_UPC,
         eid.RECEIPT_DT,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT - i.DISTRESS_DAYS days else null end) Shrink_date_time,
         (case i.CODE_DATE_FLAG when 'Y' then eid.CDE_DT else (eid.RECEIPT_DT + i.SHELF_LIFE days) end) expiration_date_time,
         (i.INVENTORY_TOTAL - (integer(value(i.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) * i.PACK_CASE as INVENTORY_UNITS_AVAILABLE,
         (i.INVENTORY_TOTAL - (integer(value(i.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) as INVENTORY_AVAILABLE,
         case i.INVENTORY_TOTAL 
              when 0 then 0 
              else decimal(((i.INVENTORY_TOTAL - (integer(value(i.POQ_QTY, 0)) + (value(i.STORAGE_COMMITTED, 0) + value(i.STORAGE_UNCOMMITTED, 0)) + (value(i.RESERVE_COMMITTED, 0) + value(i.RESERVE_UNCOMMITTED, 0)) + ((value(i.CASES_PER_WEEK, 0) + value(i.IN_PROCESS_REGULAR, 0)) * (case 
                                                                                                                                                                                                                                                                                                         when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 
                                                                                                                                                                                                                                                                                                         else 2 end)))) / value(i.INVENTORY_TOTAL, 0)), 11, 3) 
                                                                                                                                                                                                                                                                                                    end INVENTORY_PERCENT,
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
         integer(value(i.CASES_PER_WEEK,0)) forecast,
         i.IN_PROCESS_REGULAR,
         integer(value(i.POQ_QTY, 0)) as poq_quantity,
         i.SHELF_LIFE,
         i.DISTRESS_DAYS,
         i.CODE_DATE_FLAG,
         dx.FACILITYID_UPSTREAM,
         ts.TOTAL_STORES,
         ds.DC_STORES,
         (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) US_DS_ALLOC_PERCENT,
         ir.num_relationships
FROM     CRMADMIN.V_AMZ_ITEM_NFD i 
--         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
--         inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID_HOME = dx.SWAT_ID 

         inner join (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY dx.FACILITYID_UPSTREAM) ts on dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM 

         inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds on i.FACILITYID_HOME = ds.FACILITYID 

         inner join (SELECT FACILITYID_STOCK, ITEM_NBR_HS_STOCK, count(*) num_relationships FROM CRMADMIN.V_AMZ_ITEM_NFD inner join (SELECT vwcf.FACILITYID, count(*) DC_STORES FROM CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.T_WHSE_DIV_XREF dx on vwcf.FACILITYID = dx.SWAT_ID WHERE vwcf.CORP_CODE = 634001 AND vwcf.FACILITYID_PRIMARY = 'Y' AND dx.FACILITYID_UPSTREAM in ('002', '071') GROUP BY vwcf.FACILITYID) ds on FACILITYID_HOME = ds.FACILITYID GROUP BY FACILITYID_STOCK, ITEM_NBR_HS_STOCK) ir on i.FACILITYID_STOCK = ir.FACILITYID_STOCK and i.ITEM_NBR_HS_STOCK = ir.ITEM_NBR_HS_STOCK 

         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = i.FACILITYID_STOCK and eid.ITEM_NBR_HS = i.ITEM_NBR_HS_STOCK 
WHERE    i.FACILITYID_HOME in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75'
     AND current date > START_DATE
     AND (current date < END_DATE
        OR  END_DATE is null))
;


--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_INVENTORY_FEED_US
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DB2CDC;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user DBCDC;
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_NFD to user WEB;


--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_INVENTORY_FEED
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_INVENTORY_FEED;
create or replace view CRMADMIN.V_AMZ_INVENTORY_FEED as   
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
UNION all 
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
UNION all 
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
FROM     CRMADMIN.V_AMZ_INVENTORY_FEED_NFD
;
