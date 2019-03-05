--specific to datawhse02
update sb_dc_sales_hst_pdx
--update dc_sales_hst
set origin_id = 'CRM-NSI-M', shipped_qty = 0, 
 case_cost_amt = 0, 
 ext_admin_fee_amt = 0,
ext_arda_amt = 0,
ext_cig_tax_amt = 0,
ext_cust_fee_amt = ext_whse_sales_amt,  --total sales amount
ext_excise_tax_amt = 0,
ext_freight_amt = 0,
ext_fuel_chrge_amt = 0,
ext_leakage_amt = 0,
ext_net_price_amt = 0,
ext_price_adj_amt = 0,
ext_profit_amt = 0,
ext_promo_allw_amt = 0,
ext_reflect_amt = 0,
ext_retail_amt = 0,
ext_rsu_cnt = 0, 
 net_cost_amt = 0,
units_lbs_whse_qty = 0
--where transaction_date between '11-26-2017' and '09-22-2018'
where transaction_date between '12-31-2017' and '01-27-2018'  --per 1
--run for 008, 040, 058, 3, 5
-- and facility_id = '040'
and facility_id in ('003','005','008','040','058')
and item_wholesale_cd in ('002', '009', '011', '013', '016', '017', '030', '052', '060', '095', '111', '114', '155', '156', '157', '163', '164')
;

--specific to crm
update crmadmin.T_WHSE_SALES_HST_DC
set ORIGIN_ID = 'CRM-NSI-M', SHIPPED_QTY = 0, QTY_FOR_EXTENSION = 0, 
 UNITS_LBS_WHSE_QTY = 0, 
 EXT_RSU_CNT = 0, 
 CASE_COST_AMT = 0, 
 NET_COST_AMT = 0,
EXT_NET_PRICE_AMT = 0,
EXT_CUST_FEE_AMT = EXT_WHSE_SALES_AMT,
EXT_FINAL_SELL_AMT = 0,
EXT_RETAIL_AMT = 0,
EXT_FREIGHT_AMT = 0,
EXT_REFLECT_AMT = 0,
EXT_PROMO_ALLW_AMT = 0,
EXT_FUEL_CHRGE_AMT = 0,
EXT_LEAKAGE_AMT = 0,
EXT_PROFIT_AMT = 0,
EXT_LBL_CASE_CHRGE = 0,
EXT_PRICE_ADJUSTMENT = 0,
EXT_EXCISE_TAX = 0,
EXT_ITEM_LVL_MRKUP_AMT_02 = 0,
EXT_PURE_SELL = 0,
EXT_CIG_TAX = 0
--where transaction_date between '2017-11-26' and '2018-09-22'
where transaction_date between '2017-12-31' and '2018-01-27'  --per 1
--where transaction_date between '07-15-2018' and '08-11-2018'  --per 8
--run for 008, 040, 058, 3, 5
-- and FACILITYID = '058'
and facilityid in ('003','005','008','040','058')
and WHOL_SALES_CD in ('002', '009', '011', '013', '016', '017', '030', '052', '060', '095', '111', '114', '155', '156', '157', '163', '164')
;

select ORIGIN_ID, WHOL_SALES_CD, TERRITORY_NO, LAWSON_DEPT, INVOICE_NBR,
sum(EXT_CUST_FEE_AMT) markup, sum(EXT_WHSE_SALES_AMT) sales
from crmadmin.T_WHSE_SALES_HST_DC
--where transaction_date between '2018-12-02' and '2018-12-29'  --per 13
where transaction_date = '2019-01-31'
--where transaction_date between '07-15-2018' and '08-11-2018'  --per 8
--run for 008, 040, 058, 3, 5
-- and FACILITYID = '058'
and facilityid in ('040')
and WHOL_SALES_CD in ('002', '009', '011', '013', '016', '017', '030', '052', '060', '095', '111', '114', '155', '156', '157', '163', '164')
group by ORIGIN_ID, WHOL_SALES_CD, TERRITORY_NO, LAWSON_DEPT, INVOICE_NBR
;

select *
from crmadmin.T_WHSE_SALES_HST_DC
--where transaction_date between '2018-12-02' and '2018-12-29'  --per 1
where transaction_date = '2019-01-30'
and ORIGIN_ID = 'CRM-NSI-MG'
--where transaction_date between '07-15-2018' and '08-11-2018'  --per 8
--run for 008, 040, 058, 3, 5
-- and FACILITYID = '058'
--and facilityid in ('005')
--and WHOL_SALES_CD in ('002', '009', '011', '013', '016', '017', '030', '052', '060', '095', '111', '114', '155', '156', '157', '163', '164')
--group by ORIGIN_ID, WHOL_SALES_CD
;


Select item_nbr , order_type_cd, special_price_flg, origin_id, invoice_nbr, sales_type_cd, gl_account_nbr, ordered_qty, adjusted_qty, shipped_qty, private_label_flg, ext_case_cost_amt, net_cost_amt, net_price_amt, ext_lost_sales_amt, ext_reflect_amt, ext_cust_fee_amt, ext_profit_amt , total_sales_amt 
from dc_sales_hst
where transaction_date = '2019-01-30'
  and facility_id = 40
  and item_wholesale_cd = '001'
;
