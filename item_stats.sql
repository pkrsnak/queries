--ntz
SELECT   istat.FISCAL_YEAR_ID,  
         istat.FISCAL_QUARTER_ID, 
         istat.FISCAL_PERIOD_ID,
         istat.MDSE_CATGY_KEY, 
         istat.MDSE_CATGY_NAME,
         istat.LAST_NM, 
         istat.FIRST_NM, 
         istat.FACILITY_ID,
         istat.FACILITY_NAME,
         istat.SHIP_FACILITY_ID,
         istat.SHIP_FACILITY_NAME,
         istat.WHSE_CMDTY_ID,
         istat.COMMODITY_CODE,
         istat.WHOLESALE_DEPT_ID,
--         istat.ITEM_NBR,
         sum(case when istat.ITEM_ADDED_YEAR = istat.FISCAL_YEAR_ID then 1 else 0 end) item_added,
         sum(istat.SALES) total_sales,
         sum(case when istat.SALES_AMZ > 0 then 1 else 0 end) amazon_count,
         sum(case when istat.SALES_DG > 0 then 1 else 0 end) dg_count,
         sum(case when istat.SALES_CORP > 0 then 1 else 0 end) corp_count,
         sum(case when istat.SALES_OTHER > 0 then 1 else 0 end) ind_count,
         sum(case when istat.SALES > 0 then 1 else 0 end) total_count
FROM     ( SELECT fd.FISCAL_YEAR_ID, fd.FISCAL_QUARTER_ID, fd.FISCAL_PERIOD_ID, mctg.MDSE_CATGY_KEY, mctg.MDSE_CATGY_NAME, cm.LAST_NM, cm.FIRST_NM, dsh.FACILITY_ID, f.FACILITY_NAME, dsh.SHIP_FACILITY_ID, fs.FACILITY_NAME SHIP_FACILITY_NAME, dsh.WHSE_CMDTY_ID, dsh.COMMODITY_CODE, dsh.WHOLESALE_DEPT_ID, dsh.ITEM_NBR, DATE_PART('YEAR', i.ITEM_ADDED_DATE) item_added_year, sum(dsh.TOTAL_SALES_AMT) sales, sum(case when c.CORPORATION_ID = 634001 then dsh.TOTAL_SALES_AMT else 0 end) sales_amz, sum(case when c.CORPORATION_ID = 910022 then dsh.TOTAL_SALES_AMT else 0 end) sales_dg, sum(case when c.CORPORATION_ID in (118, 3999) then dsh.TOTAL_SALES_AMT else 0 end) sales_corp, sum(case when c.CORPORATION_ID not in (634001, 910022, 3999) then dsh.TOTAL_SALES_AMT else 0 end) sales_other FROM WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.DC_FACILITY f on dsh.FACILITY_ID = f.FACILITY_ID 
         inner join WH_OWNER.DC_FACILITY fs on dsh.SHIP_FACILITY_ID = fs.FACILITY_ID 
         inner join WH_OWNER.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR 
         inner join WH_OWNER.DC_CUSTOMER c on dsh.FACILITY_ID = c.FACILITY_ID and dsh.CUSTOMER_NBR = c.CUSTOMER_NBR 
         inner join WH_OWNER.DC_CORPORATION cp on c.CORPORATION_ID = cp.CORPORATION_ID 
         inner join WH_OWNER.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT
         inner join WH_OWNER.MDSE_CLASS mcls on i.MDSE_CLASS_KEY = mcls.MDSE_CLASS_KEY
         inner join WH_OWNER.MDSE_CATEGORY mctg on mcls.MDSE_CATGY_KEY = mctg.MDSE_CATGY_KEY
         inner join WH_OWNER.MDSE_CLASS_MANAGER mcmgr on mcmgr.MDSE_CLASS_KEY = mcls.MDSE_CLASS_KEY
         inner join WH_OWNER.CATEGORY_MANAGER cm on mcmgr.CATGY_MANAGER_KEY = cm.CATGY_MANAGER_KEY
         WHERE dsh.SALES_TYPE_CD = 1 AND fd.FISCAL_YEAR_ID in (2016, 2017, 2018, 2019) AND dsh.ITEM_NBR > 0 
         GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16) istat
group by istat.FISCAL_YEAR_ID, 
         istat.FISCAL_QUARTER_ID, 
         istat.FISCAL_PERIOD_ID,
         istat.MDSE_CATGY_KEY, 
         istat.MDSE_CATGY_NAME,
         istat.LAST_NM, 
         istat.FIRST_NM, 
         istat.FACILITY_ID,
         istat.FACILITY_NAME,
         istat.SHIP_FACILITY_ID,
         istat.SHIP_FACILITY_NAME,
         istat.WHSE_CMDTY_ID,
         istat.COMMODITY_CODE,
         istat.WHOLESALE_DEPT_ID
;

--crm
SELECT   year(lh.LAYER_FILE_DTE) fiscal_year,
         int(lh.FACILITYID) FACILITY_ID,
         int(lh.STOCK_FAC) SHIP_FACILITY_ID,
         int(lh.ITEM_NBR_HS) item_nbr,
         int(lh.ITEM_DEPT) WHOLESALE_DEPT_ID, i.COMMODITY_XREF, i.ITEM_DEPT,
         sum(lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) inventory
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on lh.FACILITYID = dx.SWAT_ID
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = lh.FACILITYID and i.ITEM_NBR_HS = lh.ITEM_NBR_HS
WHERE    lh.LAYER_FILE_DTE in ('2016-12-31', '2017-12-31', '2018-12-31', '2019-12-31')
AND      dx.ENTERPRISE_KEY = 1
GROUP BY year(lh.LAYER_FILE_DTE), lh.FACILITYID, lh.STOCK_FAC, lh.ITEM_NBR_HS, 
         lh.ITEM_DEPT, i.COMMODITY_XREF, i.ITEM_DEPT
HAVING   sum(lh.INVENTORY_TURN + lh.INVENTORY_PROMOTION + lh.INVENTORY_FWD_BUY) > 0
;


SELECT FACILITYID, ITEM_DEPT, COMMODITY_XREF, WAREHOUSE_CODE, ITEM_ADDED_DATE, count(*) num_items
FROM     CRMADMIN.T_WHSE_ITEM
group by FACILITYID, ITEM_DEPT, COMMODITY_XREF, WAREHOUSE_CODE, ITEM_ADDED_DATE
;