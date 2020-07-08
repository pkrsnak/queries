--fd customer credits per definition
SELECT   dr.DIVISION_ID,
         fd.FISCAL_WEEK_ID,
         dsh.SHIP_FACILITY_ID, dsh.FACILITY_ID, 
         dsh.CREDIT_REASON_CD,
--         sum(abs(dsh.TOTAL_SALES_AMT)) total_credits
         sum(dsh.TOTAL_SALES_AMT) total_credits
FROM     wh_owner.DC_SALES_HST dsh 
         inner join wh_owner.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT 
         inner join wh_owner.DC_FACILITY df on dsh.SHIP_FACILITY_ID = df.FACILITY_ID 
         inner join wh_owner.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.FISCAL_WEEK_ID between 202021 and 202025
AND      ((dsh.FACILITY_ID <> 1
        AND dsh.CREDIT_REASON_CD in ('01', '03', '05', '08', '09', '10', '11', '12', '19', '20', '21', '22', '26', '29', '40''43', '44', '45', '48'))
     OR  (dsh.FACILITY_ID = 1
        AND dsh.CREDIT_REASON_CD in ('01', '02', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '23', '24', '25')))
GROUP BY dr.DIVISION_ID, dsh.CREDIT_REASON_CD, dsh.SHIP_FACILITY_ID, dsh.FACILITY_ID, fd.FISCAL_WEEK_ID
;


--fd customer credits per definition
SELECT   dr.DIVISION_ID,
         fd.FISCAL_WEEK_ID, dsh.TRANSACTION_DATE, dsh.INVOICE_DATE, dsh.ITEM_NBR,
         dsh.SHIP_FACILITY_ID, dsh.FACILITY_ID, 
         dsh.CREDIT_REASON_CD,
         dsh.EXT_CASE_COST_AMT,
         dsh.TOTAL_SALES_AMT
FROM     wh_owner.DC_SALES_HST dsh 
         inner join wh_owner.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT 
         inner join wh_owner.DC_FACILITY df on dsh.SHIP_FACILITY_ID = df.FACILITY_ID 
         inner join wh_owner.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.FISCAL_WEEK_ID between 202021 and 202024
AND      ((dsh.FACILITY_ID <> 1
        AND dsh.CREDIT_REASON_CD in ('01', '03', '05', '08', '09', '10', '11', '12', '19', '20', '21', '22', '26', '29', '40''43', '44', '45', '48'))
     OR  (dsh.FACILITY_ID = 1
        AND dsh.CREDIT_REASON_CD in ('01', '02', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '23', '24', '25')))
--GROUP BY dr.DIVISION_ID, dsh.CREDIT_REASON_CD, dsh.SHIP_FACILITY_ID, dsh.FACILITY_ID, fd.FISCAL_WEEK_ID
;


--fd customer credits per definition
SELECT   (fd.COMPANY_YEAR_ID * 100) + fd.COMPANY_WEEK_ID FISCAL_WEEK_ID,
         dsh.BILLING_DATE,
         dsh.FACILITYID_SHIP,
         dsh.FACILITYID,
         dsh.INVOICE_NBR,
         dsh.ITEM_NBR_HS,
         dsh.NO_CHRGE_ITM_CDE,
         dsh.CREDIT_REASON_CDE,
         dsh.QTY_SOLD,
         dsh.QTY_SCRATCHED,
         dsh.FINAL_SELL_AMT
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL dsh 
         inner join CRMADMIN.T_DATE fd on dsh.BILLING_DATE = fd.DATE_KEY
WHERE    (fd.COMPANY_YEAR_ID = 2020
     AND fd.COMPANY_WEEK_ID between 21 and 25)
AND      dsh.CREDIT_REASON_CDE in ('01', '03', '05', '08', '09', '10', '11', '12', '19', '20', '21', '22', '26', '29', '40''43', '44', '45', '48') 