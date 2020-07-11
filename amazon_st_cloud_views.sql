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
FROM     CRMADMIN.V_AMZ_INVENTORY_FEED_US;

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
;   
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
AND      (right(i.FACILITYID,2) = i.STOCK_FAC and i.FACILITYID <> '054')
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75'
     AND current date > START_DATE
     AND (current date < END_DATE
        OR  END_DATE is null));

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
;
SELECT   case i.FACILITYID 
     when '054' then 'F3SPB' 
     when '040' then 'F3SPB' 
     when '058' then 'F3SPA' 
     when '015' then 'F3SPC' 
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
         inner join (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID 
         inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.FACILITYID_UPSTREAM) ts on dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM 
         inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID 
         inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID 
         inner join (SELECT vi.FACILITYID, vi.ITEM_NBR_HS, count(*) num_relationships FROM CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD 
         inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS 
         inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID 
         inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID WHERE i.ITEM_RES28 in ('A', 'C') GROUP BY vi.FACILITYID, vi.ITEM_NBR_HS) ir on dx.FACILITYID_UPSTREAM = ir.FACILITYID and vi.ITEM_NBR_HS = ir.ITEM_NBR_HS 
         left outer join CRMADMIN.V_AMZ_ASIN tu on i.ROOT_ITEM_NBR = tu.ROOT_ITEM_NBR and i.LV_ITEM_NBR = tu.LV_ITEM_NBR 
         left outer join (SELECT FACILITYID, ITEM_NBR_HS, CDE_DT, max(date(RECEIPT_DTIM)) receipt_dt, sum(PROD_QTY) PROD_QTY FROM CRMADMIN.T_WHSE_EXE_INV_DTL where STATUS not in ('D') GROUP BY FACILITYID, ITEM_NBR_HS, CDE_DT) eid on eid.FACILITYID = vi.FACILITYID and eid.ITEM_NBR_HS = vi.ITEM_NBR_HS 
         left outer join (select FACILITYID, ITEM_NBR, sum(PROMO_QTY) POQ_QTY from CRMADMIN.V_WHSE_DEAL where PROMO_QTY > 0 and DATE_DEAL_ARRIVE between current date and current date + 28 days group by FACILITYID, ITEM_NBR) poq on vi.BICEPS_DC = poq.FACILITYID and vi.ITEM_NBR = poq.ITEM_NBR
WHERE    i.ITEM_RES28 in ('A', 'C')
AND      (right(i.FACILITYID,2) <> i.STOCK_FAC and i.FACILITYID <> '054')
AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75'
     AND current date > START_DATE
     AND (current date < END_DATE
        OR  END_DATE is null));

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
grant control on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user ETLX;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user SIUSER;
grant select on CRMADMIN.V_AMZ_INVENTORY_FEED_US to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_OPEN_PO_FEED
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_OPEN_PO_FEED;
create or replace view CRMADMIN.V_AMZ_OPEN_PO_FEED  as  SELECT   VENDOR_CODE,           OPEN_PO_EFFECTIVE_DATE_TIME,           OPEN_PO_NUMBER,           SUPPLIER_NAME,           ASIN,           UPC,           VENDOR_SKU,           ITEM_COST_PRICE,           ITEM_COST_ALLOW,           CASE_PACK_QUANTITY,           CASE_PACK_COST_PRICE,           CASE_PACK_COST_ALLOW,           INBOUND_QUANTITY_UOM,           INBOUND_QUANTITY_FOR_AMZ,           INBOUND_QUANTITY_TOTAL,           AMZ_SPECIFIC_UPC,           PO_CREATE_DATE,           ORIG_REQ_DEL_DATE,           REQUIRED_DELIVERY_DATE_TIME,           ITEM_DELIVERY_DATE_TIME,           ITEM_AVAILABLE_DATE_TIME  FROM     CRMADMIN.V_AMZ_OPEN_PO_FEED_DS  union all  SELECT   VENDOR_CODE,           OPEN_PO_EFFECTIVE_DATE_TIME,           OPEN_PO_NUMBER,           SUPPLIER_NAME,           ASIN,           UPC,           VENDOR_SKU,           ITEM_COST_PRICE,           ITEM_COST_ALLOW,           CASE_PACK_QUANTITY,           CASE_PACK_COST_PRICE,           CASE_PACK_COST_ALLOW,           INBOUND_QUANTITY_UOM,           INBOUND_QUANTITY_FOR_AMZ,           INBOUND_QUANTITY_TOTAL,           AMZ_SPECIFIC_UPC,           PO_CREATE_DATE,           ORIG_REQ_DEL_DATE,           REQUIRED_DELIVERY_DATE_TIME,           ITEM_DELIVERY_DATE_TIME,           ITEM_AVAILABLE_DATE_TIME  FROM     CRMADMIN.V_AMZ_OPEN_PO_FEED_US;

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_OPEN_PO_FEED
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_OPEN_PO_FEED to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB033016;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB038712;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB038866;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB065023;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB075216;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB075781;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB076602;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB077382;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB079572;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB081868;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB082673;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB096486;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB099260;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB100026;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB102019;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB103416;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB103570;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB103712;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB103724;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB105018;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB105281;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB105703;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB106139;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB106453;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB108245;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB126235;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB142672;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB146729;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB148781;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB151483;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB153050;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB154428;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB159999;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB160831;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB162511;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB172084;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB172087;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB175453;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB177494;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB178908;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB184961;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB186096;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB188771;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB189061;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB189628;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB203809;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB209501;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB210344;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB210958;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB211038;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB212676;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB213711;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB222356;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB227847;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB228400;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB228405;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB228662;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB235955;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB237127;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB237310;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB237361;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB237844;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB238600;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB238608;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user DB238609;
grant control on CRMADMIN.V_AMZ_OPEN_PO_FEED to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_OPEN_PO_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user ETLX;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user SIUSER;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_OPEN_PO_FEED_DS
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_OPEN_PO_FEED_DS;
create or replace view CRMADMIN.V_AMZ_OPEN_PO_FEED_DS as   SELECT   i.FACILITYID,           case i.FACILITYID                 when '054' then 'F3SPB'                 when '040' then 'F3SPB'                 when '058' then 'F3SPA'                 when '015' then 'F3SPC'                 else i.FACILITYID            end vendor_code,           current timestamp open_po_effective_date_time,           poh.PO_NBR open_PO_Number,           poh.VENDOR_NAME supplier_Name,           asin.LU_CODE asin,           i.UPC_UNIT_CD upc,           i.ITEM_NBR_HS vendor_Sku,           decimal(round((pod.LIST_COST / pod.PACK), 2),9, 3) item_Cost_Price,           decimal(round((pod.AMOUNT_OFF_INVOICE / pod.PACK), 3), 9, 3) item_Cost_Allow,           pod.PACK case_Pack_Quantity,           pod.LIST_COST case_Pack_Cost_Price,           pod.AMOUNT_OFF_INVOICE Case_Pack_Cost_Allow,           'EA' inbound_quantity_uom,           integer(round((pod.TURN * ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN)))) * pod.PACK inbound_quantity_for_amz,           integer(round((pod.TURN * ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN)))) inbound_quantity_total,           case i.ITEM_RES28                 when 'A' then 'YES'                 else 'NO'            end AMZ_SPECIFIC_UPC,           poh.DATE_ORDERED po_create_date,           poh.PO_ORIGINAL_DLVRY_DATE orig_req_del_date,           poh.BUYER_ARRIVAL_DATE required_delivery_date_time,           poh.DATE_APPOINTMENT item_delivery_date_time,           poh.DATE_APPOINTMENT + (case dayofweek(poh.DATE_APPOINTMENT) when 6 then 3 when 7 then 2 else 1 end) days item_available_date_time,           dayofweek(poh.DATE_APPOINTMENT) weekday,           i.ITEM_DEPT,           i.ITEM_NBR_HS,           i.ITEM_DESCRIP,           i.ON_ORDER_TURN,           i.IN_PROCESS_REGULAR,           i.CASES_PER_WEEK,           (i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) on_order_available,           ((i.ON_ORDER_TURN - (i.IN_PROCESS_REGULAR + (i.CASES_PER_WEEK * (case when i.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / i.ON_ORDER_TURN) on_order_avail_percent  FROM     CRMADMIN.T_WHSE_PO_HDR poh            inner join CRMADMIN.T_WHSE_PO_DTL pod on poh.VENDOR_FAC = pod.ITEM_FAC and poh.PO_NBR = pod.PO_NBR and poh.DATE_ORDERED = pod.DATE_ORDERED            inner join CRMADMIN.T_WHSE_ITEM i on pod.ITEM_FAC = i.BICEPS_DC and pod.ITEM_NBR = i.ITEM_NBR            left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR  WHERE    poh.STATUS in ('A', 'P')  AND      i.ITEM_RES28 in ('A', 'C')  AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75')  AND      i.ON_ORDER_TURN <> 0  AND      pod.LINE_STATUS not in ('D')  AND      poh.TYPE not in ('DV');

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_OPEN_PO_FEED_DS
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB033016;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB038712;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB038866;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB065023;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB075216;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB075781;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB076602;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB077382;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB079572;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB081868;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB082673;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB096486;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB099260;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB100026;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB102019;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB103416;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB103570;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB103712;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB103724;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB105018;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB105281;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB105703;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB106139;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB106453;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB108245;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB126235;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB142672;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB146729;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB148781;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB151483;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB153050;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB154428;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB159999;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB160831;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB162511;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB172084;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB172087;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB175453;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB177494;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB178908;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB184961;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB186096;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB188771;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB189061;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB189628;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB203809;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB209501;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB210344;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB210958;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB211038;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB212676;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB213711;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB222356;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB227847;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB228400;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB228405;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB228662;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB235955;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB237127;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB237310;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB237361;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB237844;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB238600;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB238608;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user DB238609;
grant control on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user ETLX;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user SIUSER;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_DS to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_OPEN_PO_FEED_US
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_OPEN_PO_FEED_US;
create or replace view CRMADMIN.V_AMZ_OPEN_PO_FEED_US as   SELECT   i.FACILITYID,           case i.FACILITYID                 when '054' then 'F3SPB'                 when '040' then 'F3SPB'                 when '058' then 'F3SPA'                 when '015' then 'F3SPC'                 else i.FACILITYID            end vendor_code,           current timestamp open_po_effective_date_time,           poh.PO_NBR open_PO_Number,           poh.VENDOR_NAME supplier_Name,           asin.LU_CODE asin,           i.UPC_UNIT_CD upc,           i.ITEM_NBR_HS vendor_Sku,           decimal(round((pod.LIST_COST / pod.PACK), 2),9, 3) item_Cost_Price,           decimal(round((pod.AMOUNT_OFF_INVOICE / pod.PACK), 3), 9, 3) item_Cost_Allow,           pod.PACK case_Pack_Quantity,           pod.LIST_COST case_Pack_Cost_Price,           pod.AMOUNT_OFF_INVOICE Case_Pack_Cost_Allow,           'EA' inbound_quantity_uom,           integer(round((case vi.ITEM_RES28 when 'A' then pod.TURN else (integer(round((pod.TURN * ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN))))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) * pod.PACK inbound_quantity_for_amz,           integer(round((case vi.ITEM_RES28 when 'A' then pod.TURN else (integer(round((pod.TURN * ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN))))) end) * (case ir.num_relationships when 1 then decimal(1.00, 9, 3) else (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) end))) inbound_quantity_total,           case i.ITEM_RES28                 when 'A' then 'YES'                 else 'NO'            end AMZ_SPECIFIC_UPC,           poh.DATE_ORDERED po_create_date,           poh.PO_ORIGINAL_DLVRY_DATE orig_req_del_date,           poh.BUYER_ARRIVAL_DATE required_delivery_date_time,           poh.DATE_APPOINTMENT item_delivery_date_time,           poh.DATE_APPOINTMENT + (case dayofweek(poh.DATE_APPOINTMENT) when 6 then 3 when 7 then 2 else 1 end) days item_available_date_time,           dayofweek(poh.DATE_APPOINTMENT) weekday,           vi.ITEM_DEPT,           vi.ITEM_NBR_HS,           vi.ITEM_DESCRIP,           pod.TURN,           vi.ON_ORDER_TURN,           vi.IN_PROCESS_REGULAR,           vi.CASES_PER_WEEK,           (vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) on_order_available,           ((vi.ON_ORDER_TURN - (vi.IN_PROCESS_REGULAR + (vi.CASES_PER_WEEK * (case when vi.ITEM_DEPT in ('020', '025', '070', '073', '075', '080', '090') then 1 else 2 end)))) / vi.ON_ORDER_TURN) on_order_avail_percent,           dx.FACILITYID_UPSTREAM,           ts.TOTAL_STORES,           ds.DC_STORES,           (decimal(value(ds.DC_STORES, 0),9,3) / decimal(value(ts.TOTAL_STORES, 0),9,3)) US_DS_ALLOC_PERCENT,           ir.num_relationships  FROM     CRMADMIN.T_WHSE_ITEM i            inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD            inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS            inner join CRMADMIN.T_WHSE_PO_DTL pod on pod.ITEM_FAC = vi.BICEPS_DC and pod.ITEM_NBR = vi.ITEM_NBR            inner join CRMADMIN.T_WHSE_PO_HDR poh on poh.VENDOR_FAC = pod.ITEM_FAC and poh.PO_NBR = pod.PO_NBR and poh.DATE_ORDERED = pod.DATE_ORDERED            inner join CRMADMIN.T_WHSE_DIV_XREF dx on i.FACILITYID = dx.SWAT_ID            inner join (SELECT dx.FACILITYID_UPSTREAM, count(*) TOTAL_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg            inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID            inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.FACILITYID_UPSTREAM) ts on dx.FACILITYID_UPSTREAM = ts.FACILITYID_UPSTREAM            inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg            inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID            inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID            inner join (SELECT vi.FACILITYID, vi.ITEM_NBR_HS, count(*) num_relationships FROM CRMADMIN.T_WHSE_ITEM i            inner join CRMADMIN.T_WHSE_ITEM_PARENTCHILD ipc on i.FACILITYID = ipc.FACILITYID_CHILD and i.ITEM_NBR_HS = ipc.ITEM_NBR_HS_CHILD            inner join CRMADMIN.T_WHSE_ITEM vi on ipc.FACILITYID_PARENT = vi.FACILITYID and ipc.ITEM_NBR_HS_PARENT = vi.ITEM_NBR_HS            inner join (SELECT dx.SWAT_ID FACILITYID, count(*) DC_STORES FROM CRMADMIN.T_WHSE_CUST_GRP cg            inner join CRMADMIN.T_WHSE_DIV_XREF dx on cg.FACILITYID = dx.SWAT_ID            inner join CRMADMIN.T_WHSE_CUST c on cg.FACILITYID = c.FACILITYID and cg.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and c.STATUS_CD not in ('P', 'D', 'Z') and c.CUSTOMER_BILLABLE_FLAG = 'Y' WHERE cg.CUSTOMER_GRP_TYPE = '75' AND cg.FACILITYID not in ('054') AND current date > cg.START_DATE AND (current date < cg.END_DATE OR cg.END_DATE is null) GROUP BY dx.SWAT_ID) ds on i.FACILITYID = ds.FACILITYID WHERE i.ITEM_RES28 in ('A', 'C') GROUP BY vi.FACILITYID, vi.ITEM_NBR_HS) ir on dx.FACILITYID_UPSTREAM = ir.FACILITYID and vi.ITEM_NBR_HS = ir.ITEM_NBR_HS            left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR  WHERE    poh.STATUS in ('A', 'P')  AND      i.ITEM_RES28 in ('A', 'C')  AND      i.FACILITYID in (select distinct FACILITYID from CRMADMIN.T_WHSE_CUST_GRP WHERE CUSTOMER_GRP_TYPE = '75')  AND      vi.ON_ORDER_TURN <> 0  AND      pod.LINE_STATUS not in ('D')  AND      poh.TYPE not in ('DV');

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_OPEN_PO_FEED_US
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB033016;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB038712;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB038866;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB065023;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB075216;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB075781;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB076602;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB077382;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB079572;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB081868;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB082673;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB096486;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB099260;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB100026;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB102019;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB103416;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB103570;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB103712;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB103724;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB105018;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB105281;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB105703;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB106139;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB106453;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB108245;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB126235;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB142672;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB146729;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB148781;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB151483;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB153050;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB154428;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB159999;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB160831;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB162511;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB172084;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB172087;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB175453;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB177494;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB178908;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB184961;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB186096;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB188771;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB189061;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB189628;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB203809;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB209501;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB210344;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB210958;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB211038;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB212676;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB213711;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB222356;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB227847;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB228400;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB228405;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB228662;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB235955;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB237127;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB237310;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB237361;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB237844;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB238600;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB238608;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user DB238609;
grant control on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user ETLX;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user SIUSER;
grant select on CRMADMIN.V_AMZ_OPEN_PO_FEED_US to user WEB;

--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_VENDOR_CODE
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_VENDOR_CODE;
create or replace view CRMADMIN.V_AMZ_VENDOR_CODE as   
;
SELECT   FACILITYID,
         SITE_ID,
         SITE_DESC,
         SITE_VALUE
FROM     CRMADMIN.T_MDM_SITE
WHERE    SITE_CLASS = 'AVIN'
AND      STATUS_DWH = 'A'
AND      current date between SITE_STARTDATE and SITE_ENDDATE;

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_VENDOR_CODE
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_VENDOR_CODE to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB033016;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB038866;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB065023;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB076602;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB077382;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB079572;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB081868;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB082673;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB096486;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB099260;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB100026;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB103416;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB103570;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB103712;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB105703;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB106453;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB108245;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB126235;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB142672;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB146729;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB148781;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB151483;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB153050;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB154428;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB159999;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB160831;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB162511;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB172084;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB172087;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB175453;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB184961;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB186096;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB189061;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB189628;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB210344;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB210958;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB211038;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB212676;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB213711;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB222356;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB227847;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB228400;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB228405;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB228662;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB235955;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB237127;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB237310;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB237361;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB237844;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB238600;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB238608;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user DB238609;
grant control on CRMADMIN.V_AMZ_VENDOR_CODE to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_VENDOR_CODE to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user ETLX;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user SIUSER;
grant select on CRMADMIN.V_AMZ_VENDOR_CODE to user WEB;




--------------------------------------------------
-- Create View CRMADMIN.V_AMZ_CATALOG_FEED
--------------------------------------------------
--drop view CRMADMIN.V_AMZ_CATALOG_FEED;
create or replace view CRMADMIN.V_AMZ_CATALOG_FEED as
--lima
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
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
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
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    cic.FACILITYID = '058'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'

UNION all 

--Omaha GM
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
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
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
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    cic.FACILITYID = '054'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'

UNION all 

--Omaha
SELECT   case cic.FACILITYID 
     when '054' then '040' 
     else cic.FACILITYID 
end FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '054' then 'F3SPB' 
              when '040' then 'F3SPB' 
--              when '058' then 'F3SPA' 
--              when '015' then 'F3SPC' 
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
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
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
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    cic.FACILITYID = '040'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'

UNION all 

--St. Cloud GM
SELECT   case cic.FACILITYID 
     when '054' then '008' 
     else cic.FACILITYID 
end FACILITYID,
         i.STOCK_FAC,
         cic.CUSTOMER_NBR_STND,
         case cic.FACILITYID 
              when '054' then 'SPD2Z' 
              when '008' then 'SPD2Z' 
--              when '058' then 'F3SPA' 
--              when '015' then 'F3SPC' 
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
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
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
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    cic.FACILITYID in '054'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'

UNION all 

-- st. cloud
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
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
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
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    cic.FACILITYID = '008'
AND      cic.CUSTOMER_NBR_STND = 634001 --need Michelle C to activate 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'

UNION all 

--Lumberton
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
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
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
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    cic.FACILITYID = '015'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'

UNION ALL

--newcomerstown
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
         cic.BURDENED_COST_CASE_AMT / i.PACK_CASE item_cost_price,
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
         left outer join CRMADMIN.V_WEB_CUSTOMER_PRVT_BRAND vwcpb on i.FACILITYID = vwcpb.FACILITYID and vwcpb.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and i.PRIVATE_LABEL_KEY = vwcpb.PRIV_BRAND_KEY 
         left outer join CRMADMIN.T_WHSE_ITEM_AUTH cid on cic.FACILITYID = cid.FACILITYID and cid.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and cic.ITEM_NBR_HS = cid.ITEM_NBR_HS and (cid.EXP_DATE is null or cid.EXP_DATE >= current date) and cid.ITEM_ACTIVE_FLG = 'Y' and cid.ITEM_AUTH_CD <> 'Y' 
         left outer join CRMADMIN.V_AMZ_ASIN asin on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    cic.FACILITYID = '085'
AND      cic.CUSTOMER_NBR_STND = 634001
AND      (i.BILLING_STATUS_BACKSCREEN not in ('P', 'Z', 'I')
     AND not(i.BILLING_STATUS_BACKSCREEN = 'D'
        AND i.NATAG_MAINT_DATE < current date - 30 days))
AND      i.ITEM_TYPE_CD not in ('I')
AND      case i.CORP_RES when lpad(trim(cic.CORP_SWAT),3,'0') then 'Y' when '000' then 'Y' else 'N' end = 'Y'

;

--------------------------------------------------
-- Grant Authorities for CRMADMIN.V_AMZ_CATALOG_FEED
--------------------------------------------------
grant select,update,insert,delete on CRMADMIN.V_AMZ_CATALOG_FEED to user CRMEXPLN;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB033016;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB038712;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB038866;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB065023;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB075216;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB075781;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB076602;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB077382;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB079572;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB081868;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB082673;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB096486;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB099260;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB100026;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB102019;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB103416;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB103570;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB103712;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB103724;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB105018;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB105281;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB105703;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB106139;
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
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB162511;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB172084;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB172087;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB175453;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB177494;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB178908;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB184961;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB186096;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB188771;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB189061;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB189628;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB203809;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB209501;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB210344;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB210958;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB211038;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB212676;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB213711;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB222356;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB227847;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB228400;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB228405;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB228662;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB235955;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB237127;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB237310;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB237361;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB237844;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB238600;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB238608;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user DB238609;
grant control on CRMADMIN.V_AMZ_CATALOG_FEED to user ETL;
grant select,update,insert,delete on CRMADMIN.V_AMZ_CATALOG_FEED to user ETL with grant option;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user ETLX;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user SIUSER;
grant select on CRMADMIN.V_AMZ_CATALOG_FEED to user WEB;