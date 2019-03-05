--special costing
Select * from CRMADMIN.T_WHSE_BILLANDHOLD where TYPE_CODE not in ('D', 'E', 'F', 'G');

--reserves
SELECT   FACILITYID, ORDER_TYPE, year(ORDER_RECVD_DTE) order_year,
         count(*)
FROM     CRMADMIN.T_WHSE_ORDER_DTL
WHERE    ORDER_TYPE in ('AD', 'BK', 'FS')
AND      ORDER_RECVD_DTE > '2015-01-01'
GROUP BY FACILITYID, ORDER_TYPE, year(ORDER_RECVD_DTE)
;

--company calendar
SELECT   COMPANY_YEAR_ID || lpad(COMPANY_WEEK_ID, 2, '0'),
         min(DATE_KEY) week_start,
         max(DATE_KEY) week_end
FROM     CRMADMIN.T_DATE
WHERE    COMPANY_YEAR_ID in (2015, 2016, 2017, 2018)
GROUP BY COMPANY_YEAR_ID, COMPANY_WEEK_ID
;

--initial categories
SELECT MERCH_DEPT_GRP, MERCH_DEPT_GRP_DESC, MERCH_DEPT, MERCH_DEPT_DESC, MERCH_GRP, MERCH_GRP_DESC, MERCH_CAT, MERCH_CAT_DESC, MERCH_CLASS , MERCH_CLASS_DESC, FACILITYID, count(*) item_count

--FACILITYID,
--         count(*)
FROM     CRMADMIN.V_WEB_ITEM_CORE
WHERE    (MERCH_CAT in ('1848', '1849', '1850', '1847') or  MERCH_CAT in ('1843', '1844', '1845', '1846'))
and FACILITYID in ('001', '040')
GROUP BY MERCH_DEPT_GRP, MERCH_DEPT_GRP_DESC, MERCH_DEPT, MERCH_DEPT_DESC, MERCH_GRP, MERCH_GRP_DESC, MERCH_CAT, MERCH_CAT_DESC, MERCH_CLASS , MERCH_CLASS_DESC, FACILITYID
;


--shipments daily
--transfers - send for now?
--book n hold / buy n hold - continue to send shipments.
;
SELECT   di.root_item_nbr,
         di.log_var_item_nbr,
         dsh.facility_id,
--         case 
--              when (dsh.presell_nbr > 0) then 2 
--              when (dsh.order_type_cd = 'AD') then 2 
--              when (dsh.order_type_cd = 'BK') then 2 
--              when ((dsh.ext_reflect_amt + dsh.ext_promo_allw_amt) <> 0) then 2 
--              else 0 
--         end as position_type,  -- hard-code to 0
         0 as position_type,  -- hard-code to 0
         0 as line_number,
         dsh.transaction_date,
         sum(dsh.shipped_qty * di.case_pack_qty) unit_qty_shipped,
         0 as processing_indicator,
         date(sysdate) as processing_date,  --mandatory
         date(sysdate) as creation_date,   --exclude
         date(sysdate) as modification_date,  --exclude
         'DATASTAGE' as last_user,
         0 as unique_line_number,
         'DSTAGE ' || to_char(date(sysdate), '%C%y%m%d') as loaded_file_name,  --load bactch id logic
         0 as error_message_no,  --exclude
         '' error_message,  --exclude
         dsh.customer_nbr,
         2 as site_mode,
--         case 
--              when (dsh.presell_nbr > 0) then 2 
--              when (dsh.order_type_cd = 'AD') then 2 
--              when (dsh.order_type_cd = 'BK') then 2 
--              when ((dsh.ext_reflect_amt + dsh.ext_promo_allw_amt) <> 0) then 2 
--              else 0 
--         end as vte_type
         0 as vte_type
--         dsh.item_nbr
--         sum(dsh.ordered_qty) qty_ordered,
--         sum(dsh.adjusted_qty) qty_adjusted,
--         sum(dsh.subbed_qty) qty_subbed
FROM     whmgr.dc_sales_hst dsh 
         inner join whmgr.dc_item di on dsh.facility_id = di.facility_id and dsh.item_nbr = di.item_nbr 
         inner join whmgr.mdse_class mclass on di.mdse_class_key = mclass.mdse_class_key 
         inner join whmgr.mdse_catgy mcat on mclass.mdse_catgy_key = mcat.mdse_catgy_key 
         inner join whmgr.mdse_group mgrp on mcat.mdse_grp_key = mgrp.mdse_grp_key
WHERE    dsh.sales_type_cd = 1
--AND      dsh.transaction_date between '12-31-2017' and '01-13-2018'
AND      dsh.transaction_date = '11-14-2017'
AND      dsh.facility_id in (1, 40)
AND      mgrp.mdse_grp_key in (635, 636)
AND      dsh.shipped_qty <> 0
AND      not(di.root_item_nbr is null OR  di.root_item_nbr = -999999999)
--AND      (di.root_item_nbr is null OR  di.root_item_nbr = -999999999)
GROUP BY 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
;
SELECT   dsh.ship_facility_id facility,
         dsh.invoice_nbr invoice,
         di.item_nbr,
         di.root_item_nbr root,
         di.log_var_item_nbr lv,
         di.root_item_desc,
         dsh.transaction_date trans_date,
         dsh.customer_nbr cust,
         sum(dsh.shipped_qty * di.case_pack_qty) as qty
FROM     whmgr.dc_sales_hst dsh 
         inner join whmgr.dc_item di on dsh.facility_id = di.facility_id and dsh.item_nbr = di.item_nbr 
         inner join whmgr.mdse_class mclass on di.mdse_class_key = mclass.mdse_class_key 
         inner join whmgr.mdse_catgy mcat on mclass.mdse_catgy_key = mcat.mdse_catgy_key 
         inner join whmgr.mdse_group mgrp on mcat.mdse_grp_key = mgrp.mdse_grp_key
WHERE    dsh.sales_type_cd = 1
AND      dsh.transaction_date between date('01-14-2018') and date('01-20-2018')
AND      dsh.ship_facility_id in (40)
AND      mgrp.mdse_grp_key in (635,636)
AND      dsh.shipped_qty <> 0
AND      not(di.root_item_nbr is null
     OR  di.root_item_nbr = -999999999)
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8
;



--daily shipments for DS job
SELECT   di.root_item_nbr as HJFCEXR,
         di.log_var_item_nbr as HJFCEXVL,
         dsh.facility_id as HJFSITE,
         0 as HJFTPOS,
         0 as HJFNPOS,
         dsh.transaction_date as HJFDMVT, --format for Oracle
         sum(dsh.shipped_qty * di.case_pack_qty) as HJFQTV,
         0 as HJFTRT,
         date(sysdate) as HJFDTRT,
         'DATASTAGE' as HJFUTIL,
         0 as HJFNLIG,  --sequential counter for row number within the load batch
         'DSTAGE ' || to_char(date(sysdate), '%C%y%m%d') as HJFFICH,  --load bactch id logic?
         dsh.customer_nbr as HJFCLIDEST,
         2 as HJFFLAG,
         0 as HJFVTEX
FROM     whmgr.dc_sales_hst dsh 
         inner join whmgr.dc_item di on dsh.facility_id = di.facility_id and dsh.item_nbr = di.item_nbr 
         inner join whmgr.mdse_class mclass on di.mdse_class_key = mclass.mdse_class_key 
         inner join whmgr.mdse_catgy mcat on mclass.mdse_catgy_key = mcat.mdse_catgy_key 
         inner join whmgr.mdse_group mgrp on mcat.mdse_grp_key = mgrp.mdse_grp_key
WHERE    dsh.sales_type_cd = 1
AND      dsh.transaction_date between '12-31-2017' and '01-13-2018'  --parameterize for start and end date, default to current date for automation
AND      dsh.facility_id in (1, 40) --parameterize in statement
AND      mgrp.mdse_grp_key in (635, 636)  --parameterize in statement
AND      dsh.shipped_qty <> 0
AND      not(di.root_item_nbr is null OR  di.root_item_nbr = -999999999)
GROUP BY 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15
;

--weekly shipments for DS job
SELECT   di.root_item_nbr as HJFCEXR,
         di.log_var_item_nbr as HJFCEXVL,
         dsh.facility_id as HJFSITE,
         0 as HJFTPOS,
         0 as HJFNPOS,
         dsh.transaction_date as HJFDMVT, --replace with YYYYWW (year / week number) in job then aggregate
         sum(dsh.shipped_qty * di.case_pack_qty) as HJFQTV,
         0 as HJFTRT,
         date(sysdate) as HJFDTRT,
         'DATASTAGE' as HJFUTIL,
         0 as HJFNLIG,  --sequential counter for row number within the load batch
         'DSTAGE ' || to_char(date(sysdate), '%C%y%m%d') as HJFFICH,  --load bactch id logic?
         dsh.customer_nbr as HJFCLIDEST,
         sum((case when dsh.facility_id = 1 then dsh.ordered_qty else dsh.adjusted_qty end) * di.case_pack_qty) as HHFQTVCORR,
         2 as HJFFLAG,
         0 as HJFVTEX
FROM     whmgr.dc_sales_hst dsh 
         inner join whmgr.dc_item di on dsh.facility_id = di.facility_id and dsh.item_nbr = di.item_nbr 
         inner join whmgr.mdse_class mclass on di.mdse_class_key = mclass.mdse_class_key 
         inner join whmgr.mdse_catgy mcat on mclass.mdse_catgy_key = mcat.mdse_catgy_key 
         inner join whmgr.mdse_group mgrp on mcat.mdse_grp_key = mgrp.mdse_grp_key
WHERE    dsh.sales_type_cd = 1
AND      dsh.transaction_date between '12-31-2017' and '01-13-2018'  --parameterize for start and end date, default to current date for automation
AND      dsh.facility_id in (1, 40) --parameterize in statement
AND      mgrp.mdse_grp_key in (635, 636)  --parameterize in statement
AND      dsh.shipped_qty <> 0
AND      not(di.root_item_nbr is null OR  di.root_item_nbr = -999999999)
GROUP BY 1, 2, 3, 4, 5 --, 6
, 8, 9, 10, 11, 12
, 15
, 16 --, 16
;


--look up to  whmgr.fiscal_day fd on dsh.transaction_date = fd.sales_dt -- need fiscal_week_id

----------------------------------------------------------------------------------------------------------------------------------------------------
--historical deal extract
----------------------------------------------------------------------------------------------------------------------------------------------------

--from crmtest1
SELECT   bd.FACILITYID,
         i.STOCK_FAC,
         bd.ITEM_NBR,
         bd.DEAL_NBR,
         bd.SEQ_NBR,
         bd.STATUS,
         bd.DATE_START,
         bd.DATE_END,
         bd.FORWARD_BUY_IND,
         bd.MAX_NBR_CASES,
         bd.DATE_SETLMT_BB,
         bd.DATE_SETLMT_AD,
         bd.AMT_OI,
         bd.AMT_ADV,
         bd.AMT_BBACK,
         bd.ITEM_LST_FUTR,
         bd.FORWARD_BUY_QTY,
         bd.FREE_CASES,
         bd.QUALIFY_AMT,
         bd.SPREAD_DAYS,
         bd.PROMO_QTY,
         bd.DATE_DEAL_ARRIVE,
         bd.CATALOG_CTL,
         bd.REMRK,
         bd.REMRK_2,
         bd.REMRK_3,
         bd.PRICE_INC_FLAG,
         bd.PROMO_QTY_ORDR,
         bd.FWD_BUY_QTY_ORDR,
         bd.PROMO_MVMT_TYP,
         bd.PROMO_LEAD_TIME,
         bd.PROMO_MVMT_IND,
         bd.RECOUNT,
         bd.DATE_ALLOW_EFF,
         bd.DATE_ALLOW_EXP,
         bd.ALLOW_AMT,
         bd.REVIEWED,
         bd.NBR_OF_BUYS,
         bd.MERCHZR_NBR,
         bd.ADD_DATE,
         bd.CHANGE_DATE,
         bd.CHANGE_USR_ID,
         bd.BUYS_TAKEN,
         bd.BUYS_TAKEN_OVRD_DATE,
         bd.SATISFY_FR_EXCESS,
         bd.PROMO_QTY_TRANS,
         bd.PROMO_TRANS_ASOF_DATE,
         bd.PROMO_ORDR_ASOF_DATE,
         bd.CURR_BRCKT,
         bd.BRCKT_LST_FUTR,
         bd.BRCKT_LST_FUTR_2,
         bd.BRCKT_LST_FUTR_3,
         bd.BRCKT_LST_FUTR_4,
         bd.BRCKT_LST_FUTR_5,
         bd.BRCKT_LST_FUTR_6,
         bd.BRCKT_LST_FUTR_7,
         bd.SHIP_START,
         bd.SHIP_END,
         bd.AMT_OI_TYP,
         bd.AMT_BBACK_TYP,
         bd.AMT_OI_FLAT,
         bd.AMT_BBACK_FLAT,
         bd.INCTV_OI,
         bd.INCTV_BBACK,
         bd.INCTV_OI_TYP,
         bd.INCTV_BBACK_TYP,
         bd.INCTV_ACCT_NBR,
         bd.SHUTOFF_COST_LNK,
         bd.ALL_VNDR_ITEMS,
         bd.ADD_USR_ID,
         bd.VNDR_NBR,
         bd.AMT_OI_PCT,
         bd.AMT_BBACK_PCT,
         bd.INCTV_OI_PCT,
         bd.INCTV_BBACK_PCT,
         bd.VNDR_LEVEL_DEAL,
         bd.FLAT_AMTS_TAKEN,
         bd.FLAT_AMT_ORDR,
         bd.TURN_QTY_ORDR,
         bd.DEAL_NBR_MFG,
         bd.TODAY_BUYS_TAKEN,
         bd.ACCOUNT_CD,
         bd.DATE_SELL_EFF,
         bd.PERFORMANCE,
         bd.DATE_LAST_STORE_ORDR,
         bd.FLR_STOCK_PROMO_FLAG,
         bd.FLR_STOCK_DECLN_FLAG,
         bd.DEAL_WAS_UPDTD,
         bd.BROKER_NBR,
         bd.PRT_DEAL_CONF_FLAG,
         bd.NBR_DEAL_CONF_BILL,
         bd.PRICE_PROTECT_ELIG,
         bd.LST_COST_AT_START,
         bd.PROMO_TYP,
         bd.PROMO_PCT,
         bd.HIST_ENTERED,
         bd.BACK_DATED_DEAL,
         bd.DATE_ST_ACTL_PROMO,
         bd.DATE_END_ACTL_PROMO,
         bd.DATE_START_ARRIVE,
         bd.DATE_END_ARRIVE,
         bd.PROCESS_TIMESTAMP,
         bd.RPA_DESC1,
         bd.RPA_DESC2,
         bd.RPA_FLG, i.MERCH_CLASS, i.MERCH_GRP
FROM     CRMADMIN.T_BICEPS_DEAL_2015 bd 
         inner join CRMADMIN.T_WHSE_ITEM i on bd.FACILITYID = i.FACILITYID and bd.ITEM_NBR = i.ITEM_NBR_HS
WHERE    i.FACILITYID in ('001', '040')
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0635', '0636', '0315', '0545', '0557', '0341')
--     AND FACILITYID in ('001', '040'))
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0315', '0545', '0557', '0341')
--     AND FACILITYID in ('001', '040'))
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0502', '0503', '0668', '0669', '0670', '0671', '0672', '0673', '0693', '0694', '0695', '1414', '1853', '1933', '0060', '0061', '0062', '0191', '0192', '0293', '0294', '0295', '0296', '0297', '0299', '0300', '0301', '0302', '0303', '0304', '0305')
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0638', '0639')
AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('1414','1853','0191','0192','1933','0293','0294','0295','0296','0297','0299','0300','0301','0302','0303','0304','0305','0315','0338','0340','0341','0502','0503','0508','0512','0545','0547','0557','0563','0060','0061','0617','0062','0635','0636','0638','0639','0665','0668','0669','0670','0671','0672','0673','0693','0694','0695') 
     AND FACILITYID in ('001', '040'))
AND      (bd.DATE_START between '2015-01-04' and '2016-01-02'
     OR  bd.DATE_END between '2015-01-04' AND '2016-01-02')

union all

SELECT   bd.FACILITYID,
         i.STOCK_FAC,
         bd.ITEM_NBR,
         bd.DEAL_NBR,
         bd.SEQ_NBR,
         bd.STATUS,
         bd.DATE_START,
         bd.DATE_END,
         bd.FORWARD_BUY_IND,
         bd.MAX_NBR_CASES,
         bd.DATE_SETLMT_BB,
         bd.DATE_SETLMT_AD,
         bd.AMT_OI,
         bd.AMT_ADV,
         bd.AMT_BBACK,
         bd.ITEM_LST_FUTR,
         bd.FORWARD_BUY_QTY,
         bd.FREE_CASES,
         bd.QUALIFY_AMT,
         bd.SPREAD_DAYS,
         bd.PROMO_QTY,
         bd.DATE_DEAL_ARRIVE,
         bd.CATALOG_CTL,
         bd.REMRK,
         bd.REMRK_2,
         bd.REMRK_3,
         bd.PRICE_INC_FLAG,
         bd.PROMO_QTY_ORDR,
         bd.FWD_BUY_QTY_ORDR,
         bd.PROMO_MVMT_TYP,
         bd.PROMO_LEAD_TIME,
         bd.PROMO_MVMT_IND,
         bd.RECOUNT,
         bd.DATE_ALLOW_EFF,
         bd.DATE_ALLOW_EXP,
         bd.ALLOW_AMT,
         bd.REVIEWED,
         bd.NBR_OF_BUYS,
         bd.MERCHZR_NBR,
         bd.ADD_DATE,
         bd.CHANGE_DATE,
         bd.CHANGE_USR_ID,
         bd.BUYS_TAKEN,
         bd.BUYS_TAKEN_OVRD_DATE,
         bd.SATISFY_FR_EXCESS,
         bd.PROMO_QTY_TRANS,
         bd.PROMO_TRANS_ASOF_DATE,
         bd.PROMO_ORDR_ASOF_DATE,
         bd.CURR_BRCKT,
         bd.BRCKT_LST_FUTR,
         bd.BRCKT_LST_FUTR_2,
         bd.BRCKT_LST_FUTR_3,
         bd.BRCKT_LST_FUTR_4,
         bd.BRCKT_LST_FUTR_5,
         bd.BRCKT_LST_FUTR_6,
         bd.BRCKT_LST_FUTR_7,
         bd.SHIP_START,
         bd.SHIP_END,
         bd.AMT_OI_TYP,
         bd.AMT_BBACK_TYP,
         bd.AMT_OI_FLAT,
         bd.AMT_BBACK_FLAT,
         bd.INCTV_OI,
         bd.INCTV_BBACK,
         bd.INCTV_OI_TYP,
         bd.INCTV_BBACK_TYP,
         bd.INCTV_ACCT_NBR,
         bd.SHUTOFF_COST_LNK,
         bd.ALL_VNDR_ITEMS,
         bd.ADD_USR_ID,
         bd.VNDR_NBR,
         bd.AMT_OI_PCT,
         bd.AMT_BBACK_PCT,
         bd.INCTV_OI_PCT,
         bd.INCTV_BBACK_PCT,
         bd.VNDR_LEVEL_DEAL,
         bd.FLAT_AMTS_TAKEN,
         bd.FLAT_AMT_ORDR,
         bd.TURN_QTY_ORDR,
         bd.DEAL_NBR_MFG,
         bd.TODAY_BUYS_TAKEN,
         bd.ACCOUNT_CD,
         bd.DATE_SELL_EFF,
         bd.PERFORMANCE,
         bd.DATE_LAST_STORE_ORDR,
         bd.FLR_STOCK_PROMO_FLAG,
         bd.FLR_STOCK_DECLN_FLAG,
         bd.DEAL_WAS_UPDTD,
         bd.BROKER_NBR,
         bd.PRT_DEAL_CONF_FLAG,
         bd.NBR_DEAL_CONF_BILL,
         bd.PRICE_PROTECT_ELIG,
         bd.LST_COST_AT_START,
         bd.PROMO_TYP,
         bd.PROMO_PCT,
         bd.HIST_ENTERED,
         bd.BACK_DATED_DEAL,
         bd.DATE_ST_ACTL_PROMO,
         bd.DATE_END_ACTL_PROMO,
         bd.DATE_START_ARRIVE,
         bd.DATE_END_ARRIVE,
         bd.PROCESS_TIMESTAMP,
         bd.RPA_DESC1,
         bd.RPA_DESC2,
         bd.RPA_FLG, i.MERCH_CLASS, i.MERCH_GRP
FROM     CRMADMIN.T_BICEPS_DEAL_2016 bd 
         inner join CRMADMIN.T_WHSE_ITEM i on bd.FACILITYID = i.FACILITYID and bd.ITEM_NBR = i.ITEM_NBR_HS
WHERE    i.FACILITYID in ('001', '040')
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0635', '0636', '0315', '0545', '0557', '0341')
--     AND FACILITYID in ('001', '040'))
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0315', '0545', '0557', '0341')
--     AND FACILITYID in ('001', '040'))
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0502', '0503', '0668', '0669', '0670', '0671', '0672', '0673', '0693', '0694', '0695', '1414', '1853', '1933', '0060', '0061', '0062', '0191', '0192', '0293', '0294', '0295', '0296', '0297', '0299', '0300', '0301', '0302', '0303', '0304', '0305')
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0638', '0639')
AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('1414','1853','0191','0192','1933','0293','0294','0295','0296','0297','0299','0300','0301','0302','0303','0304','0305','0315','0338','0340','0341','0502','0503','0508','0512','0545','0547','0557','0563','0060','0061','0617','0062','0635','0636','0638','0639','0665','0668','0669','0670','0671','0672','0673','0693','0694','0695') 
     AND FACILITYID in ('001', '040'))
AND      (bd.DATE_START between '2016-01-03' and '2016-12-31'
     OR  bd.DATE_END between '2016-01-03' and '2016-12-31')

union all

SELECT   bd.FACILITYID,
         i.STOCK_FAC,
         bd.ITEM_NBR,
         bd.DEAL_NBR,
         bd.SEQ_NBR,
         bd.STATUS,
         bd.DATE_START,
         bd.DATE_END,
         bd.FORWARD_BUY_IND,
         bd.MAX_NBR_CASES,
         bd.DATE_SETLMT_BB,
         bd.DATE_SETLMT_AD,
         bd.AMT_OI,
         bd.AMT_ADV,
         bd.AMT_BBACK,
         bd.ITEM_LST_FUTR,
         bd.FORWARD_BUY_QTY,
         bd.FREE_CASES,
         bd.QUALIFY_AMT,
         bd.SPREAD_DAYS,
         bd.PROMO_QTY,
         bd.DATE_DEAL_ARRIVE,
         bd.CATALOG_CTL,
         bd.REMRK,
         bd.REMRK_2,
         bd.REMRK_3,
         bd.PRICE_INC_FLAG,
         bd.PROMO_QTY_ORDR,
         bd.FWD_BUY_QTY_ORDR,
         bd.PROMO_MVMT_TYP,
         bd.PROMO_LEAD_TIME,
         bd.PROMO_MVMT_IND,
         bd.RECOUNT,
         bd.DATE_ALLOW_EFF,
         bd.DATE_ALLOW_EXP,
         bd.ALLOW_AMT,
         bd.REVIEWED,
         bd.NBR_OF_BUYS,
         bd.MERCHZR_NBR,
         bd.ADD_DATE,
         bd.CHANGE_DATE,
         bd.CHANGE_USR_ID,
         bd.BUYS_TAKEN,
         bd.BUYS_TAKEN_OVRD_DATE,
         bd.SATISFY_FR_EXCESS,
         bd.PROMO_QTY_TRANS,
         bd.PROMO_TRANS_ASOF_DATE,
         bd.PROMO_ORDR_ASOF_DATE,
         bd.CURR_BRCKT,
         bd.BRCKT_LST_FUTR,
         bd.BRCKT_LST_FUTR_2,
         bd.BRCKT_LST_FUTR_3,
         bd.BRCKT_LST_FUTR_4,
         bd.BRCKT_LST_FUTR_5,
         bd.BRCKT_LST_FUTR_6,
         bd.BRCKT_LST_FUTR_7,
         bd.SHIP_START,
         bd.SHIP_END,
         bd.AMT_OI_TYP,
         bd.AMT_BBACK_TYP,
         bd.AMT_OI_FLAT,
         bd.AMT_BBACK_FLAT,
         bd.INCTV_OI,
         bd.INCTV_BBACK,
         bd.INCTV_OI_TYP,
         bd.INCTV_BBACK_TYP,
         bd.INCTV_ACCT_NBR,
         bd.SHUTOFF_COST_LNK,
         bd.ALL_VNDR_ITEMS,
         bd.ADD_USR_ID,
         bd.VNDR_NBR,
         bd.AMT_OI_PCT,
         bd.AMT_BBACK_PCT,
         bd.INCTV_OI_PCT,
         bd.INCTV_BBACK_PCT,
         bd.VNDR_LEVEL_DEAL,
         bd.FLAT_AMTS_TAKEN,
         bd.FLAT_AMT_ORDR,
         bd.TURN_QTY_ORDR,
         bd.DEAL_NBR_MFG,
         bd.TODAY_BUYS_TAKEN,
         bd.ACCOUNT_CD,
         bd.DATE_SELL_EFF,
         bd.PERFORMANCE,
         bd.DATE_LAST_STORE_ORDR,
         bd.FLR_STOCK_PROMO_FLAG,
         bd.FLR_STOCK_DECLN_FLAG,
         bd.DEAL_WAS_UPDTD,
         bd.BROKER_NBR,
         bd.PRT_DEAL_CONF_FLAG,
         bd.NBR_DEAL_CONF_BILL,
         bd.PRICE_PROTECT_ELIG,
         bd.LST_COST_AT_START,
         bd.PROMO_TYP,
         bd.PROMO_PCT,
         bd.HIST_ENTERED,
         bd.BACK_DATED_DEAL,
         bd.DATE_ST_ACTL_PROMO,
         bd.DATE_END_ACTL_PROMO,
         bd.DATE_START_ARRIVE,
         bd.DATE_END_ARRIVE,
         bd.PROCESS_TIMESTAMP,
         bd.RPA_DESC1,
         bd.RPA_DESC2,
         bd.RPA_FLG, i.MERCH_CLASS, i.MERCH_GRP
FROM     CRMADMIN.T_BICEPS_DEAL_2017 bd 
         inner join CRMADMIN.T_WHSE_ITEM i on bd.FACILITYID = i.FACILITYID and bd.ITEM_NBR = i.ITEM_NBR_HS
WHERE    i.FACILITYID in ('001', '040')
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0635', '0636', '0315', '0545', '0557', '0341')
--     AND FACILITYID in ('001', '040'))
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0315', '0545', '0557', '0341')
--     AND FACILITYID in ('001', '040'))
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0502', '0503', '0668', '0669', '0670', '0671', '0672', '0673', '0693', '0694', '0695', '1414', '1853', '1933', '0060', '0061', '0062', '0191', '0192', '0293', '0294', '0295', '0296', '0297', '0299', '0300', '0301', '0302', '0303', '0304', '0305')
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0638', '0639')
AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('1414','1853','0191','0192','1933','0293','0294','0295','0296','0297','0299','0300','0301','0302','0303','0304','0305','0315','0338','0340','0341','0502','0503','0508','0512','0545','0547','0557','0563','0060','0061','0617','0062','0635','0636','0638','0639','0665','0668','0669','0670','0671','0672','0673','0693','0694','0695') 
     AND FACILITYID in ('001', '040'))
AND      (bd.DATE_START between '2017-01-01' and '2017-12-30'
     OR  bd.DATE_END between '2017-01-01' and '2017-12-30')
;
--from crm
SELECT   bd.FACILITYID,
         i.STOCK_FAC,
         bd.ITEM_NBR,
         bd.DEAL_NBR,
         bd.SEQ_NBR,
         bd.STATUS,
         bd.DATE_START,
         bd.DATE_END,
         bd.FORWARD_BUY_IND,
         bd.MAX_NBR_CASES,
         bd.DATE_SETLMT_BB,
         bd.DATE_SETLMT_AD,
         bd.AMT_OI,
         bd.AMT_ADV,
         bd.AMT_BBACK,
         bd.ITEM_LST_FUTR,
         bd.FORWARD_BUY_QTY,
         bd.FREE_CASES,
         bd.QUALIFY_AMT,
         bd.SPREAD_DAYS,
         bd.PROMO_QTY,
         bd.DATE_DEAL_ARRIVE,
         bd.CATALOG_CTL,
         bd.REMRK,
         bd.REMRK_2,
         bd.REMRK_3,
         bd.PRICE_INC_FLAG,
         bd.PROMO_QTY_ORDR,
         bd.FWD_BUY_QTY_ORDR,
         bd.PROMO_MVMT_TYP,
         bd.PROMO_LEAD_TIME,
         bd.PROMO_MVMT_IND,
         bd.RECOUNT,
         bd.DATE_ALLOW_EFF,
         bd.DATE_ALLOW_EXP,
         bd.ALLOW_AMT,
         bd.REVIEWED,
         bd.NBR_OF_BUYS,
         bd.MERCHZR_NBR,
         bd.ADD_DATE,
         bd.CHANGE_DATE,
         bd.CHANGE_USR_ID,
         bd.BUYS_TAKEN,
         bd.BUYS_TAKEN_OVRD_DATE,
         bd.SATISFY_FR_EXCESS,
         bd.PROMO_QTY_TRANS,
         bd.PROMO_TRANS_ASOF_DATE,
         bd.PROMO_ORDR_ASOF_DATE,
         bd.CURR_BRCKT,
         bd.BRCKT_LST_FUTR,
         bd.BRCKT_LST_FUTR_2,
         bd.BRCKT_LST_FUTR_3,
         bd.BRCKT_LST_FUTR_4,
         bd.BRCKT_LST_FUTR_5,
         bd.BRCKT_LST_FUTR_6,
         bd.BRCKT_LST_FUTR_7,
         bd.SHIP_START,
         bd.SHIP_END,
         bd.AMT_OI_TYP,
         bd.AMT_BBACK_TYP,
         bd.AMT_OI_FLAT,
         bd.AMT_BBACK_FLAT,
         bd.INCTV_OI,
         bd.INCTV_BBACK,
         bd.INCTV_OI_TYP,
         bd.INCTV_BBACK_TYP,
         bd.INCTV_ACCT_NBR,
         bd.SHUTOFF_COST_LNK,
         bd.ALL_VNDR_ITEMS,
         bd.ADD_USR_ID,
         bd.VNDR_NBR,
         bd.AMT_OI_PCT,
         bd.AMT_BBACK_PCT,
         bd.INCTV_OI_PCT,
         bd.INCTV_BBACK_PCT,
         bd.VNDR_LEVEL_DEAL,
         bd.FLAT_AMTS_TAKEN,
         bd.FLAT_AMT_ORDR,
         bd.TURN_QTY_ORDR,
         bd.DEAL_NBR_MFG,
         bd.TODAY_BUYS_TAKEN,
         bd.ACCOUNT_CD,
         bd.DATE_SELL_EFF,
         bd.PERFORMANCE,
         bd.DATE_LAST_STORE_ORDR,
         bd.FLR_STOCK_PROMO_FLAG,
         bd.FLR_STOCK_DECLN_FLAG,
         bd.DEAL_WAS_UPDTD,
         bd.BROKER_NBR,
         bd.PRT_DEAL_CONF_FLAG,
         bd.NBR_DEAL_CONF_BILL,
         bd.PRICE_PROTECT_ELIG,
         bd.LST_COST_AT_START,
         bd.PROMO_TYP,
         bd.PROMO_PCT,
         bd.HIST_ENTERED,
         bd.BACK_DATED_DEAL,
         bd.DATE_ST_ACTL_PROMO,
         bd.DATE_END_ACTL_PROMO,
         bd.DATE_START_ARRIVE,
         bd.DATE_END_ARRIVE,
         bd.PROCESS_TIMESTAMP,
         bd.RPA_DESC1,
         bd.RPA_DESC2,
         bd.RPA_FLG
FROM     CRMADMIN.T_BICEPS_DEAL bd 
         inner join CRMADMIN.T_WHSE_ITEM i on bd.FACILITYID = i.FACILITYID and bd.ITEM_NBR = i.ITEM_NBR_HS
WHERE    i.FACILITYID in ('001', '040')
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0635', '0636', '0315', '0545', '0557', '0341')
--     AND FACILITYID in ('001', '040'))
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0315', '0545', '0557', '0341')
--     AND FACILITYID in ('001', '040'))
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0502', '0503', '0668', '0669', '0670', '0671', '0672', '0673', '0693', '0694', '0695', '1414', '1853', '1933', '0060', '0061', '0062', '0191', '0192', '0293', '0294', '0295', '0296', '0297', '0299', '0300', '0301', '0302', '0303', '0304', '0305')
--AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('0638', '0639')
AND      i.MERCH_CLASS in (select distinct MERCH_CLASS from CRMADMIN.V_WEB_ITEM_CORE where MERCH_GRP in ('1414','1853','0191','0192','1933','0293','0294','0295','0296','0297','0299','0300','0301','0302','0303','0304','0305','0315','0338','0340','0341','0502','0503','0508','0512','0545','0547','0557','0563','0060','0061','0617','0062','0635','0636','0638','0639','0665','0668','0669','0670','0671','0672','0673','0693','0694','0695') 
     AND FACILITYID in ('001')) --, '040'))
AND      (bd.DATE_START between '2017-12-31' and current date
     OR  bd.DATE_END between '2017-12-31' and current date)
;
--gr promos
SELECT   '001' FACILITY_ID,
         oi.ORD_ITEM_CODE,
         PE.PROMO_EVENT_KEY,
         PE.PRMO_EVNT_TYPE_CD,
         PE.EVNT_ST_CD,
         PPO.STATUS_CD,
         PE.EFFECTIVE_DATE,
         PE.EFFECTIVE_TIME,
         sua.UNIT_ALLOWANCE_AMT,
         (sua.UNIT_ALLOWANCE_AMT * VALUE (ORI.ITEM_PACK_QTY,1)) ALLOWANCE_AMT,
         VALUE (PPO.MINIMUM_QTY,0) min_qty,
         ORI.ORD_RTL_ITEM_KEY,
         ORI.RETAIL_ITEM_KEY,
         VALUE (ORI.ITEM_PACK_QTY,1) pack,
         VALUE (OI.SHIP_UNIT_CD,'CS') ship_unit,
         VALUE (OI.PRICE_WEIGHT_MSR,1) weight,
         VALUE (RI.SHELF_LBL_UPM_CD,'  ') shelf_label_upm,
         RI.SIZE_MSR
FROM     proddb2.PROMOTION_EVENT PE,
         proddb2.ORD_RETAIL_ITEM ORI,
         proddb2.PROMO_PRICE_OFFSET PPO,
         proddb2.ORDERABLE_ITEM OI,
         proddb2.RETAIL_ITEM RI,
         proddb2.STORE_UNIT_ALLOW sua,
         PRODDB2.MDSE_CLASS MCl,
         PRODDB2.MDSE_CATEGORY MCa
WHERE    PE.PROMO_EVENT_KEY = PPO.PROMO_EVENT_KEY
AND      PPO.ORDERABLE_ITEM_KEY = ORI.ORDERABLE_ITEM_KEY
AND      ORI.ORDERABLE_ITEM_KEY = OI.ORDERABLE_ITEM_KEY
AND      ORI.RETAIL_ITEM_KEY = RI.RETAIL_ITEM_KEY
AND      ori.ORD_RTL_ITEM_KEY = sua.ORD_RTL_ITEM_KEY
AND      pe.PROMO_EVENT_KEY = sua.PROMO_EVENT_KEY
AND      ri.MDSE_CLASS_KEY = MCl.MDSE_CLASS_KEY
AND      MCl.MDSE_CATGY_KEY = mca.MDSE_CATGY_KEY
AND      ( PE.EFFECTIVE_DATE between '2015-01-04' and '2016-12-31'
     OR  PE.EXPIRATION_DATE between '2015-01-04' and '2016-12-31')
AND      RI.ITEM_COMPLETE_FLG = 'Y'
AND      mca.MDSE_CATGY_KEY in (635, 636, 315, 545, 557, 341, 502, 503, 668, 669, 670, 671, 672, 673, 693, 694, 695, 1414, 1853, 1933, 60, 61, 62, 191, 192, 293, 294, 295, 296, 297, 299, 300, 301, 302, 303, 304, 305)
ORDER BY PE.PROMO_EVENT_KEY, ORI.ORD_RTL_ITEM_KEY;

-----------------------------------------------------------------------------------------------------
--If it's a PA promotion then we check to see what stores can receive the promotion. 
--EXEC SQL                                                
--  DECLARE CUR2 CURSOR WITH HOLD FOR                     
   SELECT CG.CUST_GRP_TYPE_KEY                          
         ,EC.ENT_CUSTOMER_NBR                           
   FROM PROMOTION_EVENT      PE                         
      , PROMO_PARTICIPANT    PP                         
      , CUST_GROUP           CG                         
      , CUST_GROUP_LIST      CGL                        
      , ENTPRISE_CUSTOMER    EC                         
 WHERE PE.PROMO_EVENT_KEY = :WS-PE-PROMO-EVENT-KEY      
   AND PE.PROMO_EVENT_KEY = PP.PROMO_EVENT_KEY          
   AND PP.CUST_GROUP_KEY  = CGL.CUST_GROUP_KEY          
   AND CGL.CUST_GROUP_KEY = CG.CUST_GROUP_KEY           
   AND CGL.CUSTOMER_KEY   = EC.CUSTOMER_KEY             
   AND CGL.EFFECTIVE_DATE   <=                          
                                :WS-PE-EXPIRATION-DATE  
   AND VALUE(CGL.EXPIRATION_DATE, DATE('9999-12-31'))   
                           >=   :WS-PE-EFFECTIVE-DATE   
--   END-EXEC.                                              

Select count(*) from PRODDB2.EVENT
where (AD_EFF_DATE between '2015-01-04' and '2016-01-02'
     OR  AD_EXPIRE_DATE between '2015-01-04' and '2016-01-02')
;

Select count(*) from PRODDB2.PROMOTION_EVENT
where (EFFECTIVE_DATE between '2015-01-04' and '2016-01-02'
     OR  EXPIRATION_DATE between '2015-01-04' and '2016-01-02')
;
PROMOTION_EVENT
PROMO_PRICE

;


SELECT   c.campaignid,
         c.campaignname,
         c.campaignshortdesc,
         c.campaignlongdesc,
         c.campaigndatefrom,
         c.campaigndateto,
         e.eventid,
         e.eventtypeid,
         et.eventtypename,
         et.eventzonelistid,
         et.zonesetid,
         et.vehicleclassid,
         et.eventtag,
         e.noteid,
         e.eventzonelistid,
         e.zoneid,
         e.eventstatusid,
         e.eventname,
         e.createdate,
         e.createdby,
         e.status,
         e.shortdesc,
         e.eventdesc,
         e.startdate,
         e.finishdate,
         e.salestart,
         e.saleend,
         e.zonesetid,
         e.color,
         e.eventcode
FROM     whmgr.events e 
         inner join whmgr.eventtype et on e.eventtypeid = et.eventtypeid 
         inner join whmgr.campaignevents ce on e.eventid = ce.eventid 
         inner join whmgr.campaign c on ce.campaignid = c.campaignid
WHERE    e.eventid = 14879
;