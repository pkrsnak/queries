--------------------------------------------------------------------------------------------------------------------------------------
-- cal's version
--------------------------------------------------------------------------------------------------------------------------------------
SELECT   d.COMPANY_YEAR_ID cyear,
		 d.COMPANY_PERIOD_ID period,
		 shd.FACILITYID facility,
		 shd.CUSTOMER_NO_FULL,
		 shd.billing_date bill_date,
		 shd.ORDER_TYPE order_type, 
         shd.ITEM_DEPT dept,
		 shd.PRVT_LBL_FLG PL_FLAG,
		 case when shd.net_itm_flg = ' ' then 'N' else shd.net_itm_flg end net_item,
         sum(shd.LAYER_EXT_COST) layer,
         sum(case when shd.OUT_REASON_CODE in ('004', '011') then 0 else (case when shd.ORDER_TYPE = 'GB' then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) end) qty_shipped,
         sum(case when shd.OUT_REASON_CODE in ('004', '011') then 0 else (shd.QTY_ADJUSTED - (case when shd.ORDER_TYPE = 'GB' then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end)) end) outs,
         sum(case when shd.OUT_REASON_CODE in ('004', '011') then 0 else (case when shd.ORDER_TYPE = 'GB' then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) end * shd.MRKUP_DLLRS_PER_SHIP_UNT) fees,
         sum(case when shd.OUT_REASON_CODE in ('004', '011') then 0 else (case when shd.NO_CHRGE_ITM_CDE in ('*') then shd.FINAL_SELL_AMT else (case when shd.ORDER_TYPE = 'GB'  then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) * shd.FINAL_SELL_AMT end) end) dollars_shipped,
         sum(case when shd.OUT_REASON_CODE in ('004', '011') then 0 else (case when shd.NO_CHRGE_ITM_CDE in ('*') then shd.LBL_CASE_CHRGE else (case when shd.ORDER_TYPE = 'GB'  then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) * shd.LBL_CASE_CHRGE end) end) LBL_CASE_CHRGE
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd,
		 CRMADMIN.T_DATE d
WHERE    shd.BILLING_DATE = d.DATE_KEY
and		 d.COMPANY_YEAR_ID = 2007
and 	 d.COMPANY_QUARTER_ID in (4)
AND      shd.FACILITYID in ('058')
AND      shd.ITEM_DEPT in ('045', '060', '077')
--AND      shd.ITEM_DEPT in ('070', '072', '073')
--AND      shd.ITEM_DEPT in ('020', '025', '075', '030', '031', '035', '078', '099')
--AND      shd.ITEM_DEPT in ('020', '025', '030', '031', '035')
--AND      shd.ITEM_DEPT in ('010', '040', '060', '050', '075', '077', '078')
--AND      shd.ITEM_DEPT not in ('098')
--   and shd.ITEM_DEPT in ('000', '010', '012', '016', '017', '018', '019', '040', '045', '048', '050', '055', '060', '066', '067', '077', '084', '086', '097', '098')  -- grocery
AND      shd.ORDER_SOURCE not in ('I')
AND      shd.NO_CHRGE_ITM_CDE not in ('*')
GROUP BY d.COMPANY_YEAR_ID,
		 d.COMPANY_PERIOD_ID,
		 shd.FACILITYID, 
		 shd.CUSTOMER_NO_FULL,
		 shd.billing_date,
		 shd.ORDER_TYPE, 
		 shd.ITEM_DEPT,
		 shd.PRVT_LBL_FLG,
		 case when shd.net_itm_flg = ' ' then 'N' else shd.net_itm_flg end
;
