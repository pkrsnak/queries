SELECT   cic.FACILITYID,
         cic.CUSTOMER_NBR_STND,
         cic.UPC_UNIT,
         cic.ITEM_NBR_HS,
         cic.REC_START_DATE START_DATE,
         cic.RANDOM_WEIGHT_CD,
         cic.SHIPPING_CASE_WEIGHT,
         cic.UNBURDENED_FINAL_SELL_NO_ALLOW_AMT,
         case cic.REC_END_DATE when '2049-12-31' then null else cic.REC_END_DATE end END_DATE,
         dec(round(cic.UNBURDENED_UNIT_SELL_NO_ALLOW_AMT, 2), 31, 2) UNBURDENED_COST_UNIT_AMT,
         dec(round(cic.UNBURDENED_FINAL_SELL_NO_ALLOW_AMT, 2), 31, 2) UNBURDENED_COST_CASE_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.UNBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 2), 31, 2) UNBURDENED_COST_CASE_AMT_NEW,
         dec(round(cic.FULLBURDENED_UNIT_SELL_NO_ALLOW_AMT, 2), 31, 2) BURDENED_COST_UNIT_AMT,
         dec(round(cic.FULLBURDENED_FINAL_SELL_NO_ALLOW_AMT, 2), 31, 2) BURDENED_COST_CASE_AMT,
         dec(round(((case cic.RANDOM_WEIGHT_CD when 'R' then cic.SHIPPING_CASE_WEIGHT else 1 end) * (cic.FULLBURDENED_FINAL_SELL_NO_ALLOW_AMT)), 2), 31, 2) BURDENED_COST_CASE_AMT_NEW,
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
AND      cic.RANDOM_WEIGHT_CD = 'R'
and cic.FACILITYID = '058' and cic.CUSTOMER_NBR_STND = 992743

;