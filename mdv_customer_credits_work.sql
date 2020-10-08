--fd customer credits per definition
SELECT   dr.DIVISION_ID,
         DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY AS KPI_DATE,
         dsh.SHIP_FACILITY_ID KPI_KEY_VALUE,
         sum(abs(dsh.TOTAL_SALES_AMT)) KPI_DATA_VALUE
FROM     whmgr.DC_SALES_HST dsh
         inner join whmgr.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on dsh.SHIP_FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.SALES_DT BETWEEN DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 7) UNITS DAY AND DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY
AND      ((dsh.FACILITY_ID <> 1
        AND dsh.CREDIT_REASON_CD in ('01', '03', '05', '08', '09', '10', '11', '12', '19', '20', '21', '22', '26', '29', '40', '43', '44', '45', '48','AR', 'BE', 'MS', 'RT', 'SH'))
     OR  (dsh.FACILITY_ID = 1
        AND dsh.CREDIT_REASON_CD in ('01', '02', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '23', '24', '25')))
GROUP BY dr.DIVISION_ID, dsh.SHIP_FACILITY_ID, KPI_DATE

union all
;
--mdv customer credits per definition
SELECT   dr.DIVISION_ID,
         DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY AS KPI_DATE,
         dsh.SHIP_FACILITY_ID KPI_KEY_VALUE,
         sum(abs(dsh.TOTAL_SALES_AMT)) KPI_DATA_VALUE
FROM     eisdw01@dss_uat_tcp:mdvsls_day_ln_com dsh
         inner join whmgr.FISCAL_DAY fd on dsh.sales_dt = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on dsh.SHIP_FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.SALES_DT BETWEEN DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 7) UNITS DAY AND DATE('#CURRENT_DATE_INFX#') - (WEEKDAY(DATE('#CURRENT_DATE_INFX#')) + 1) UNITS DAY
AND      dsh.CREDIT_REASON_CD in (2, 6, 14, 16, 33, 40)
GROUP BY dr.DIVISION_ID, dsh.SHIP_FACILITY_ID, KPI_DATE