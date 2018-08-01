SELECT   Distinct WHOL_SALES_CD
FROM     CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN
WHERE    BUSINESS_SEGMENT = '2'
AND      SPLIT_GL_ACCOUNT in ('70230', '70240')
AND      FACILITYID = '058'
;

--dw02 record counts
SELECT   gl_account_nbr,
         item_wholesale_cd,
         count(*) num_records
FROM     whmgr.dc_sales_hst
WHERE    transaction_date > '11-25-2017'
AND      origin_id = 'CRM-NSI'
AND      item_wholesale_cd in (2, 9, 11, 13, 16, 17, 30, 52, 60, 95, 111, 114, 155, 156, 157, 163, 164)
GROUP BY gl_account_nbr, item_wholesale_cd
;

--dw02 origin type comparison
SELECT   *
FROM     whmgr.dc_sales_hst
WHERE    transaction_date = '11-25-2017'
AND      origin_id = 'CRM-NSI-M'
--AND      item_wholesale_cd in (2, 9, 11, 13, 16, 17, 30, 52, 60, 95, 111, 114, 155, 156, 157, 163, 164)
--GROUP BY gl_account_nbr, item_wholesale_cd
;

--crm record counts
SELECT   gl_account_nbr,
         WHOL_SALES_CD,
         count(*) num_records
FROM     CRMADMIN.T_WHSE_SALES_HST_DC
WHERE    transaction_date > '2017-11-25'
AND      origin_id = 'CRM-NSI'
AND      WHOL_SALES_CD in ('002', '009', '011', '013', '016', '017', '030', '052', '060', '095', '111', '114', '155', '156', '157', '163', '164')
GROUP BY gl_account_nbr, WHOL_SALES_CD
;

/*  as of 8/1/18
gl_account_nbr	item_wholesale_cd	num_records
50000	002	2363
50000	009	26
50000	011	18
50000	013	215
50000	016	1119
50000	017	6146
50000	060	18
50000	095	34
50000	114	86
50000	155	957
50000	157	173
50000	163	7
50005	002	655
50005	013	13
50005	016	169
50005	095	1
50005	114	6
50005	155	174
50005	157	52
50005	163	1
*/