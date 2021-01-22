Hi Pat,
 
Below is the Inventory Adjustments SQL from PROD.
 
--total abs value inventory adjustments by facility
--source:  datawhse02 & mdvods
SELECT type,  'distribution' SCORECARD_TYPE,
         DIVISION_ID,
         'inventory_adjust_total' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         fiscal_week_id KPI_DATE,
         KPI_KEY_VALUE,
         sum(KPI_DATA_VALUE) KPI_DATA_VALUE
from
(

SELECT 'adj' type,  dr.division_id,
         fd.fiscal_week_id KPI_DATE, --need week end date for prior week
         fia.facility_id KPI_KEY_VALUE,
         sum(abs(fia.ext_layer_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.dc_d_fac_invctrl_adj fia
         inner join whmgr.FISCAL_DAY fd on fia.billing_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on fia.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fia.ext_layer_cost_amt <> 0
and     fd.fiscal_week_id = 202102
AND      fia.invtry_adjust_cd in ('CC', 'FL', 'CL', 'CG', 'DS', 'MA', 'AM', 'PC', 'PI', 'RC')
GROUP BY dr.division_id, fia.facility_id, KPI_DATE

UNION ALL

--fd inventory adjustments for SAT / COL
SELECT 'adj' type,  dr.division_id,
         fd.fiscal_week_id KPI_DATE, --need week end date for prior week
         mia.facility_id KPI_KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.mdv_d_fac_invctrl_adj mia
         inner join whmgr.FISCAL_DAY fd on mia.invtry_adj_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on mia.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    mia.ext_layer_cost_amt <> 0
and     fd.fiscal_week_id = 202102
AND      mia.facility_id in (80, 90)
AND      mia.invtry_adjust_cd in ('CC', 'FL', 'CL', 'CG', 'DS', 'MA', 'AM', 'PC', 'PI', 'RC')
GROUP BY dr.division_id, mia.facility_id, KPI_DATE
 
UNION ALL

--mdv inventory adjustments928424
SELECT 'adj' type,  dr.division_id,
         fd.fiscal_week_id KPI_DATE, --need week end date for prior week
         mia.facility_id KPI_KEY_VALUE,
         sum(abs(mia.ext_layer_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.mdv_d_fac_invctrl_adj mia
         inner join whmgr.FISCAL_DAY fd on mia.invtry_adj_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on mia.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    mia.ext_layer_cost_amt <> 0
and     fd.fiscal_week_id = 202102
and      mia.facility_id not in (80, 90)
AND      mia.invtry_adjust_cd in ('CC', 'FL', 'CL', 'CG', 'DS', 'MA', 'AM', 'PC', 'PI', 'RC')
GROUP BY dr.division_id, mia.facility_id, KPI_DATE
 
UNION ALL
 
--fd customer credits per definition
SELECT 'cred' type,  dr.DIVISION_ID,
         fd.fiscal_week_id KPI_DATE,
         dsh.SHIP_FACILITY_ID KPI_KEY_VALUE,
         sum(abs(dsh.TOTAL_SALES_AMT)) KPI_DATA_VALUE
FROM     whmgr.DC_SALES_HST dsh
         inner join whmgr.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on dsh.SHIP_FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.fiscal_week_id = 202102
AND      ((dsh.FACILITY_ID <> 1
      --  AND dsh.CREDIT_REASON_CD in ('01', '03', '05', '08', '09', '10', '11', '12', '19', '20', '21', '22', '26', '29', '40''43', '44', '45', '48','AR', 'BE', 'MS', 'RT', 'SH'))
          AND dsh.CREDIT_REASON_CD in ('01', '03', '05', '08', '09', '10', '11', '12', '19', '20', '21', '22', '26', '29', '40''43', '44', '45', '48'))
     OR  (dsh.FACILITY_ID = 1
        AND dsh.CREDIT_REASON_CD in ('01', '02', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '23', '24', '25')))
GROUP BY dr.DIVISION_ID, dsh.SHIP_FACILITY_ID, KPI_DATE
 
UNION ALL
 
--DG customer credits per definition
SELECT 'cred' type,  dr.DIVISION_ID,
         fd.fiscal_week_id KPI_DATE,
         dsh.FACILITY_ID KPI_KEY_VALUE,
         sum(abs(dsh.ext_cost_amt)) KPI_DATA_VALUE
FROM     whmgr.mdv_fd_cr_hst dsh
         inner join whmgr.FISCAL_DAY fd on dsh.INPUT_DATE = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on dsh.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.fiscal_week_id = 202102
AND      ((dsh.FACILITY_ID <> 1
        AND dsh.CREDIT_REASON_CD in ('AR', 'BE', 'MS', 'RT', 'SH'))
     )
GROUP BY dr.DIVISION_ID, dsh.FACILITY_ID, KPI_DATE
 
UNION ALL
 
--mdv VCMs per definition
SELECT 'cred' type,  dr.DIVISION_ID,
         fd.fiscal_week_id KPI_DATE,
         vcm.FACILITY_ID KPI_KEY_VALUE,
         sum(abs(case when vcm.FACILITY_ID = 27 then vcm.tot_ord_line_amt * .8 else vcm.tot_ord_line_amt end)) KPI_DATA_VALUE
FROM     whmgr.vcm_cr_hst vcm
         inner join whmgr.FISCAL_DAY fd on vcm.ship_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on vcm.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.fiscal_week_id = 202102
AND      vcm.cr_type_cd IN ('1','2','3','4','6','9','10','11','12','13','14','16','18','19','22','23','24','25','28','29','30','31','32','33','34','35','37','38','39','40','46','47','48','49','50','51','52','53','54','55','56','57','58')
GROUP BY dr.DIVISION_ID, vcm.FACILITY_ID, KPI_DATE
 
UNION ALL
 
--mdv VCMs per definition
SELECT 'cred_alloc' type,  dr.DIVISION_ID,
        fd.fiscal_week_id KPI_DATE,
         33 KPI_KEY_VALUE,
         sum(abs(vcm.tot_ord_line_amt * (1 - .8))) KPI_DATA_VALUE
FROM     whmgr.vcm_cr_hst vcm
         inner join whmgr.FISCAL_DAY fd on vcm.ship_date = fd.SALES_DT
         inner join whmgr.DC_FACILITY df on vcm.FACILITY_ID = df.FACILITY_ID
         inner join whmgr.DC_REGION dr on df.REGION_ID = dr.REGION_ID
WHERE    fd.fiscal_week_id = 202102
AND      vcm.FACILITY_ID = 27
AND      vcm.cr_type_cd IN ('1','2','3','4','6','9','10','11','12','13','14','16','18','19','22','23','24','25','28','29','30','31','32','33','34','35','37','38','39','40','46','47','48','49','50','51','52','53','54','55','56','57','58')
GROUP BY dr.DIVISION_ID, vcm.FACILITY_ID, KPI_DATE
 
) x
group by type, division_id, fiscal_week_id, KPI_KEY_VALUE
;



SELECT   *
FROM     whmgr.mdv_fd_cr_hst
WHERE    input_date between '01-10-2021' and '01-16-2021'
AND      CREDIT_REASON_CD in ('AR', 'BE', 'MS', 'RT', 'SH')
;


SELECT *
FROM     whmgr.vcm_cr_hst 
WHERE    ship_date between '01-10-2021' and '01-16-2021'
AND      cr_type_cd IN ('1','2','3','4','6','9','10','11','12','13','14','16','18','19','22','23','24','25','28','29','30','31','32','33','34','35','37','38','39','40','46','47','48','49','50','51','52','53','54','55','56','57','58')
;


SELECT   FISCAL_WEEK_ID, DIVISION_ID , FACILITY_ID , INVADJ_TOT_AMT 
FROM     WH_OWNER.KPI_WK_DIV_DISTRIB
WHERE    FISCAL_WEEK_ID = 202102