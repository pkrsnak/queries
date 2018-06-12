----------------------------------------------------------------------------------------------------
-- DDL for CRMADMIN.V_WEB_CUSTOMER_ITEM_COST
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW CRMADMIN.V_WEB_CUSTOMER_ITEM_COST_TEST
as
SELECT   cic.FACILITYID,
         cic.CUSTOMER_NBR_STND,
         cic.UPC_UNIT,
         cic.ITEM_NBR_HS,
         cic.REC_START_DATE START_DATE,
         case cic.REC_END_DATE when '2049-12-31' then null else cic.REC_END_DATE end END_DATE,
         dec(round((case vwcf.ALLOW_B4_AFTER when 'B' then cic.UNBURDENED_UNIT_SELL_NET_AMT else cic.UNBURDENED_UNIT_SELL_NO_ALLOW_AMT end), 2), 31, 2) UNBURDENED_COST_UNIT_AMT,
         dec(round((case vwcf.ALLOW_B4_AFTER when 'B' then cic.UNBURDENED_FINAL_SELL_NET_AMT else cic.UNBURDENED_FINAL_SELL_NO_ALLOW_AMT end), 2), 31, 2) UNBURDENED_COST_CASE_AMT,
         dec(round((case vwcf.ALLOW_B4_AFTER when 'B' then cic.FULLBURDENED_UNIT_SELL_NET_AMT else cic.FULLBURDENED_UNIT_SELL_NO_ALLOW_AMT end), 2), 31, 2) BURDENED_COST_UNIT_AMT,
         dec(round((case vwcf.ALLOW_B4_AFTER when 'B' then cic.FULLBURDENED_FINAL_SELL_NET_AMT else cic.FULLBURDENED_FINAL_SELL_NO_ALLOW_AMT end), 2), 31, 2) BURDENED_COST_CASE_AMT,
         cic.CREATE_TIME CREATE_TIMESTAMP,
         cic.PROCESS_TIMESTAMP,
         case 
              when current date between cic.REC_START_DATE and cic.REC_END_DATE then 'C' 
              when cic.REC_END_DATE < current date then 'P' 
              when cic.REC_START_DATE > current date then 'F' 
              else 'Z' 
         end STATUS_CD,
         vwcf.MEMBERSHIP_KEY,
         vwcf.HANDHELD_STATUS_CD,
         vwcf.INSITE_STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST_ITEM_COST cic 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on cic.CUSTOMER_NO_FULL = vwcf.CUSTOMER_NO_FULL and cic.FACILITYID = vwcf.FACILITYID
WHERE    cic.REC_ACTIVE_FLG = 'Y'
AND      vwcf.UPSTREAM_DC_TYP_CD = 'D'
;


Select BURDENED_COST_FLG, ALLOW_B4_AFTER, count(*)
 from CRMADMIN.V_WEB_CUSTOMER_FAC
where FACILITYID = '058'
group by BURDENED_COST_FLG, ALLOW_B4_AFTER
;


select * from CRMADMIN.V_WEB_CUSTOMER_FAC where ALLOW_B4_AFTER = 'B' and BURDENED_COST_FLG = 'Y'
and FACILITYID = '058'
;

select FACILITYID, CUSTOMER_NBR_STND, BURDENED_COST_FLG, ALLOW_B4_AFTER from CRMADMIN.V_WEB_CUSTOMER_FAC where FACILITYID = '058' and CUSTOMER_NBR_STND in (4030, 1126);

SELECT   FACILITYID,
         CUSTOMER_NBR_STND CUST,
--         UPC_UNIT,
         ITEM_NBR_HS,
--         SPECIAL_COSTING_CD,
         REC_START_DATE,
         REC_END_DATE,
--         SALES_PLAN_SELL_AMT,
--         SALES_PLAN_OVERRIDE_SELL_AMT,
--         SALES_PLAN_COMPARISON_SELL_AMT,
--         SALES_PLAN_ACTUAL_AMT,
--         FREIGHT_INVOICED_AMT,
         MRKUP_PER_SHIP_UNT_AMT MKUP,
--         DEAL_AMT,
         OI_ALLOWANCE_START_DATE OI_START,
         OI_ALLOWANCE_END_DATE OI_END,
         REFLECTED_ALLOWANCE_AMT OI_AMT,
--         PA_ALLOWANCE_START_DATE,
--         PA_ALLOWANCE_END_DATE,
--         AD_ALLOWANCE_AMT,
         UNBURDENED_FINAL_SELL_NET_AMT,
         FULLBURDENED_FINAL_SELL_NET_AMT,
         UNBURDENED_FINAL_SELL_NO_ALLOW_AMT,
         FULLBURDENED_FINAL_SELL_NO_ALLOW_AMT
FROM     CRMADMIN.T_WHSE_CUST_ITEM_COST
WHERE    FACILITYID = '058'
--AND      ITEM_NBR_HS = '0875518'
--AND      CUSTOMER_NBR_STND = 4030
AND      ITEM_NBR_HS = '0342824'
AND      CUSTOMER_NBR_STND = 1126
order by REC_START_DATE
;

SELECT   FACILITYID,
         CUSTOMER_NBR_STND,
         ITEM_NBR_HS,
         START_DATE,
         END_DATE,
         UNBURDENED_COST_CASE_AMT,
         BURDENED_COST_CASE_AMT
FROM     CRMADMIN.V_WEB_CUSTOMER_ITEM_COST
WHERE    FACILITYID = '058'
AND      ITEM_NBR_HS = '0875518'
AND      CUSTOMER_NBR_STND = 4030
--AND      ITEM_NBR_HS = '0342824'
--AND      CUSTOMER_NBR_STND = 1126
order by START_DATE 
;