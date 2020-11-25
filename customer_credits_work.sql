--fd customer credits per definition
SELECT   dr.DIVISION_ID,
         DATE('07-12-2020') - (WEEKDAY(DATE('07-12-2020')) + 1) UNITS DAY AS KPI_DATE,
         dsh.SHIP_FACILITY_ID KPI_KEY_VALUE,
         sum(abs(dsh.TOTAL_SALES_AMT)) KPI_DATA_VALUE
FROM     whmgr.DC_SALES_HST dsh
         inner join whmgr.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on dsh.SHIP_FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.SALES_DT BETWEEN DATE('07-12-2020') - (WEEKDAY(DATE('07-12-2020')) + 7) UNITS DAY AND DATE('07-12-2020') - (WEEKDAY(DATE('07-12-2020')) + 1) UNITS DAY
AND      ((dsh.FACILITY_ID <> 1
        AND dsh.CREDIT_REASON_CD in ('01', '03', '05', '08', '09', '10', '11', '12', '19', '20', '21', '22', '26', '29', '40''43', '44', '45', '48','AR', 'BE', 'MS', 'RT', 'SH'))
     OR  (dsh.FACILITY_ID = 1
        AND dsh.CREDIT_REASON_CD in ('01', '02', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '23', '24', '25')))
GROUP BY dr.DIVISION_ID, dsh.SHIP_FACILITY_ID, KPI_DATE
 
UNION ALL
 
--mdv VCMs per definition
SELECT   dr.DIVISION_ID,
         DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY AS KPI_DATE,
         vcm.FACILITY_ID KPI_KEY_VALUE,
         sum(abs(case when vcm.FACILITY_ID = 27 then vcm.tot_ord_line_amt * .8 else vcm.tot_ord_line_amt end)) KPI_DATA_VALUE
FROM     mdvods@ods_uat_tcp:vcm_cr_hst vcm
         inner join whmgr.FISCAL_DAY fd on vcm.ship_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on vcm.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.SALES_DT BETWEEN DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 7) UNITS DAY AND DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY
AND      vcm.cr_type_cd IN ('1','2','3','4','6','9','10','11','12','13','14','16','18','19','22','23','24','25','28','29','30','31','32','33','34','35','37','38','39','40','46','47','48','49','50','51','52','53','54','55','56','57','58')
GROUP BY dr.DIVISION_ID, vcm.FACILITY_ID, KPI_DATE

UNION ALL

--mdv VCMs per definition
SELECT   dr.DIVISION_ID,
         DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY AS KPI_DATE,
         33 KPI_KEY_VALUE,
         sum(abs(vcm.tot_ord_line_amt * (1 - .8))) KPI_DATA_VALUE
FROM     mdvods@ods_uat_tcp:vcm_cr_hst vcm
         inner join whmgr.FISCAL_DAY fd on vcm.ship_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on vcm.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.SALES_DT BETWEEN DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 7) UNITS DAY AND DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY
AND      vcm.FACILITY_ID = 27
AND      vcm.cr_type_cd IN ('1','2','3','4','6','9','10','11','12','13','14','16','18','19','22','23','24','25','28','29','30','31','32','33','34','35','37','38','39','40','46','47','48','49','50','51','52','53','54','55','56','57','58')
GROUP BY dr.DIVISION_ID, vcm.FACILITY_ID, KPI_DATE
;



--mdv customer credits per definition
SELECT   dr.DIVISION_ID,
         DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY AS KPI_DATE,
         vcm.FACILITY_ID KPI_KEY_VALUE,vcm.cr_type_cd,
         sum(abs(vcm.tot_ord_line_amt)) KPI_DATA_VALUE
FROM     mdvods@ods_uat_tcp:vcm_cr_hst vcm
         inner join whmgr.FISCAL_DAY fd on vcm.ship_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on vcm.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.SALES_DT BETWEEN DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 7) UNITS DAY AND DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY
AND      vcm.cr_type_cd IN ('1','2','3','4','6','9','10','11','12','13','14','16','18','19','22','23','24','25','28','29','30','31','32','33','34','35','37','38','39','40','46','47','48','49','50','51','52','53','54','55','56','57','58')
GROUP BY dr.DIVISION_ID, vcm.FACILITY_ID, KPI_DATE, vcm.cr_type_cd
;




--------------------------------------


--total abs value inventory adjustments by facility
--source:  datawhse02 & mdvods
SELECT   'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         'inventory_adjust_total' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY AS KPI_DATE,
         KPI_KEY_VALUE,
         sum(KPI_DATA_VALUE) KPI_DATA_VALUE
from
(
 
SELECT   dr.division_id,
         DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY AS KPI_DATE, --need week end date for prior week
         fia.facility_id KPI_KEY_VALUE,
         sum(abs(fia.ext_layer_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.dc_d_fac_invctrl_adj fia
         inner join whmgr.FISCAL_DAY fd on fia.billing_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on fia.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fia.ext_layer_cost_amt <> 0
AND      fd.SALES_DT BETWEEN DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 7) UNITS DAY AND DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY --need to determine prior week start - end
AND      fia.invtry_adjust_cd in ('CC', 'FL', 'CL', 'CG', 'DS', 'MA', 'AM', 'PC', 'PI', 'RC')
GROUP BY dr.division_id, fia.facility_id, KPI_DATE
 
UNION ALL
 
--fd inventory adjustments for SAT / COL
SELECT   dr.division_id,
         DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY AS KPI_DATE, --need week end date for prior week
         mia.facility_id KPI_KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.mdv_d_fac_invctrl_adj mia
         inner join whmgr.FISCAL_DAY fd on mia.invtry_adj_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on mia.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    mia.ext_layer_cost_amt <> 0
AND      fd.SALES_DT BETWEEN DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 7) UNITS DAY AND DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY  --need to determine prior week start - end
AND      mia.facility_id in (80, 90)
AND      mia.invtry_adjust_cd in ('CC', 'FL', 'CL', 'CG', 'DS', 'MA', 'AM', 'PC', 'PI', 'RC')
GROUP BY dr.division_id, mia.facility_id, KPI_DATE
 
UNION ALL
 
--mdv inventory adjustments928424
SELECT   dr.division_id,
         DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY AS KPI_DATE, --need week end date for prior week
         mia.facility_id KPI_KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.mdv_d_fac_invctrl_adj mia
         inner join whmgr.FISCAL_DAY fd on mia.invtry_adj_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on mia.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    mia.ext_layer_cost_amt <> 0
AND      fd.SALES_DT BETWEEN DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 7) UNITS DAY AND DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY  --need to determine prior week start - end
and      mia.facility_id not in (80, 90)
AND      mia.invtry_adjust_cd in ('CC', 'FL', 'CL', 'CG', 'DS', 'MA', 'AM', 'PC', 'PI', 'RC')
GROUP BY dr.division_id, mia.facility_id, KPI_DATE
 
UNION ALL
 
--fd customer credits per definition
SELECT   dr.DIVISION_ID,
         DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY AS KPI_DATE,
         dsh.SHIP_FACILITY_ID KPI_KEY_VALUE,
         sum(abs(dsh.TOTAL_SALES_AMT)) KPI_DATA_VALUE
FROM     whmgr.DC_SALES_HST dsh
         inner join whmgr.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on dsh.SHIP_FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.SALES_DT BETWEEN DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 7) UNITS DAY AND DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY
AND      ((dsh.FACILITY_ID <> 1
        AND dsh.CREDIT_REASON_CD in ('01', '03', '05', '08', '09', '10', '11', '12', '19', '20', '21', '22', '26', '29', '40''43', '44', '45', '48','AR', 'BE', 'MS', 'RT', 'SH'))
     OR  (dsh.FACILITY_ID = 1
        AND dsh.CREDIT_REASON_CD in ('01', '02', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '23', '24', '25')))
GROUP BY dr.DIVISION_ID, dsh.SHIP_FACILITY_ID, KPI_DATE
 
UNION ALL
 
--mdv customer credits per definition
SELECT   dr.DIVISION_ID,
         DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY AS KPI_DATE,
         vcm.FACILITY_ID KPI_KEY_VALUE,
         sum(abs(vcm.tot_ord_line_amt)) KPI_DATA_VALUE
FROM     mdvods@ods_uat_tcp:vcm_cr_hst vcm
         inner join whmgr.FISCAL_DAY fd on vcm.ship_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on vcm.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.SALES_DT BETWEEN DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 7) UNITS DAY AND DATE('07-05-2020') - (WEEKDAY(DATE('07-05-2020')) + 1) UNITS DAY
AND      vcm.cr_type_cd IN ('1','2','3','4','6','9','10','11','12','13','14','16','18','19','22','23','24','25','28','29','30','31','32','33','34','35','37','38','39','40','46','47','48','49','50','51','52','53','54','55','56','57','58')
GROUP BY dr.DIVISION_ID, vcm.FACILITY_ID, KPI_DATE
 
) x
group by --'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         --'inventory_adjust_total' KPI_TYPE,
         --'F' DATA_GRANULARITY,
         --'W' TIME_GRANULARITY,
         KPI_DATE,
         KPI_KEY_VALUE
;