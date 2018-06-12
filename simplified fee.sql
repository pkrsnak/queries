-- sales SWAT
SELECT   d.COMPANY_YEAR_ID cyear,
		 d.COMPANY_PERIOD_ID period,
--		 shd.RECORD_ID record_type,
		 shd.FACILITYID facility,
		 shd.CUSTOMER_NO_FULL,
		 shd.billing_date bill_date,
		 shd.ORDER_TYPE order_type, 
--		 shd.SPECIAL_COST_CDE_TYPE,
--		 shd.ORDER_SOURCE order_source,
         shd.ITEM_DEPT dept,
--         shd.WHOL_SALES_CD,
		 shd.PRVT_LBL_FLG PL_FLAG,
--         case when shd.PRVT_LBL_FLG = ' ' then case when substr(shd.UPC_UNIT,8,5) = '70253' then 'Y' else 'N' end else shd.PRVT_LBL_FLG end PL_FLAG,
--         shd.WHOL_SALES_CD wsc,
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
and 	 d.COMPANY_PERIOD_ID in (7, 8, 9, 10)
AND      shd.FACILITYID in ('058')
--AND      shd.ITEM_DEPT in ('020', '025', '030', '031', '035')
--AND      shd.ITEM_DEPT in ('010', '040', '060', '050', '075', '077', '078')
--AND      shd.ITEM_DEPT not in ('098')
   and shd.ITEM_DEPT in ('000', '010', '012', '016', '017', '018', '019', '040', '045', '048', '050', '055', '060', '066', '067', '077', '084', '086', '097', '098')  -- grocery
AND      shd.ORDER_SOURCE not in ('I')
AND      shd.NO_CHRGE_ITM_CDE not in ('*')                          -------  handle no charge items
GROUP BY d.COMPANY_YEAR_ID,
		 d.COMPANY_PERIOD_ID,
--		 shd.RECORD_ID,
		 shd.FACILITYID, 
		 shd.CUSTOMER_NO_FULL,
		 shd.billing_date,
		 shd.ORDER_TYPE, 
--		 shd.ORDER_SOURCE,
--		 shd.SPECIAL_COST_CDE_TYPE,
		 shd.ITEM_DEPT,
--		 shd.WHOL_SALES_CD,
		 shd.PRVT_LBL_FLG,
		 case when shd.net_itm_flg = ' ' then 'N' else shd.net_itm_flg end
--		 shd.WHOL_SALES_CD
;



-------------------------------------------------------------------------------------------------
SELECT   CSCST customer,
         CSFYR cyear,
--         CSYRWK week,
--         CSDEPT dept,
         sum(CSWCOR) cases_adj,
         sum(CSWCAD) cases_ord,
         sum(CSWCWO) cases_out,
         sum(CSWCSH) cases_shipped,
         sum(case when CSDEPT in ('10','40','60', '050', '075', '077', '078') then CSWCSH else 0 end) cases_ship_groc,
         sum(CSWLBS) pounds_shipped,
         sum(CSWECS) ext_cost,
         sum(CSWESL) ext_sell,
         sum(case when CSDEPT in ('10','40','60', '050', '075', '077', '078') then CSWESL else 0 end) ext_sell_groc,
         sum(CSWERT) ext_retail,
         sum(CSWEAL) ext_allow_refl,
         sum(CSWECR) ext_credits_sell,
         sum(CSBYRO) buyer_outs,
         sum(CSVNDO) vendor_outs,
         sum(CSXFEE) ext_fee_purch,
         sum(CSXMUP) ext_markup,
         sum(CSXFRT) ext_freght
FROM     LODATA01.SH0PCSHS
where    CSFYR in 2007
  and    CSYRWK between 25 and 40 
--  and    CSDEPT in ('10','40','60')
group by  CSCST,
         CSFYR
--         CSYRWK
--         CSDEPT;
;


-- fuel surcharge
SELECT   d.COMPANY_YEAR_ID cyear,
		 d.COMPANY_PERIOD_ID period,
		 shd.FACILITYID facility,
		 shd.CUSTOMER_NO_FULL,
		 shd.billing_date bill_date,
--		 shd.ORDER_TYPE order_type, 
--		 shd.ORDER_SOURCE order_source,
         shd.ITEM_DEPT dept,
         sum(shd.FINAL_SELL_AMT) fuel_surcharge
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd,
		 CRMADMIN.T_DATE d
WHERE    shd.BILLING_DATE = d.DATE_KEY
and		 d.COMPANY_YEAR_ID = 2007
and 	 d.COMPANY_PERIOD_ID in (7,8,9,10)
AND      shd.FACILITYID in ('058')
--AND      shd.ITEM_DEPT in ('010', '040', '060')
AND      shd.ORDER_SOURCE in ('I')
AND      shd.ITEM_NBR_HS in ('0099903')
and      shd.FINAL_SELL_AMT > 0 
--AND      shd.RECORD_ID in ('1')
--AND      shd.NO_CHRGE_ITM_CDE not in ('*')                          -------  handle no charge items
GROUP BY d.COMPANY_YEAR_ID,
		 d.COMPANY_PERIOD_ID,
		 shd.FACILITYID, 
		 shd.CUSTOMER_NO_FULL,
		 shd.billing_date,
--		 shd.ORDER_TYPE, 
--		 shd.ORDER_SOURCE,
		 shd.ITEM_DEPT
--		 shd.PRVT_LBL_FLG
--		 shd.WHOL_SALES_CD
;


-----------------------------------------------------------------------------------------------------------
-- sales MIDWEST
SELECT   d.COMPANY_YEAR_ID cyear,
		 d.COMPANY_PERIOD_ID period,
		 shd.FACILITYID facility,
		 shd.CUSTOMER_NO_FULL,
		 shd.billing_date bill_date,
		 shd.ORDER_TYPE, 
         shd.ITEM_DEPT dept,
         shd.PRVT_LBL_FLG,
         sum(shd.LAYER_EXT_COST) layer,
         sum(case when shd.OUT_REASON_CODE in ('004', '011') then 0 else (case when shd.ORDER_TYPE = 'GB' then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) end) qty_shipped,
         sum(case when shd.OUT_REASON_CODE in ('004', '011') then 0 else (shd.QTY_ADJUSTED - (case when shd.ORDER_TYPE = 'GB' then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end)) end) outs,
		 sum(case when shd.RECORD_ID in ('2','3') then (shd.LEAKAGE_AMT + shd.MRKUP_DLLRS_PER_SHIP_UNT + shd.LBL_CASE_CHRGE + shd.FUEL_CHRGE_AMT + shd.FREIGHT_AMT) else 0 end) total_fees,
         sum(case when shd.OUT_REASON_CODE in ('004', '011') then 0 else (case when shd.NO_CHRGE_ITM_CDE in ('*') then shd.FINAL_SELL_AMT else (case when shd.ORDER_TYPE = 'GB'  then shd.QTY_SOLD else shd.QTY_SOLD - shd.QTY_SCRATCHED end) * shd.FINAL_SELL_AMT end) end) dollars_shipped,
		 sum(case when shd.RECORD_ID in ('2','3') then (shd.LEAKAGE_AMT) else 0 end) leakage_fee,
		 sum(case when shd.RECORD_ID in ('2','3') then (shd.MRKUP_DLLRS_PER_SHIP_UNT) else 0 end) markup_fee,
		 sum(case when shd.RECORD_ID in ('2','3') then (shd.LBL_CASE_CHRGE) else 0 end) case_label_fee,
		 sum(case when shd.RECORD_ID in ('2','3') then (shd.FUEL_CHRGE_AMT) else 0 end) fuel_surcharge_fee,
		 sum(case when shd.RECORD_ID in ('2','3') then (shd.FREIGHT_AMT) else 0 end) freight_fee
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd,
		 CRMADMIN.T_DATE d
WHERE    shd.BILLING_DATE = d.DATE_KEY
and		 d.COMPANY_YEAR_ID = 2007
--and		 ((d.COMPANY_YEAR_ID = 2007 and d.COMPANY_PERIOD_ID in (5,6,7,8,9,10,11,12,13))
--  or	 (d.COMPANY_YEAR_ID = 2008 and d.COMPANY_PERIOD_ID in (1,2,3,4)))
AND      shd.FACILITYID in ('008')
and		 shd.CUSTOMER_NO_FULL = '21002985'
--AND      shd.ITEM_DEPT in ('020', '025', '030', '031', '035')
--AND      shd.ITEM_DEPT in ('010', '040', '060', '050', '075', '077', '078')
--   and shd.ITEM_DEPT in ('000', '010', '012', '016', '017', '018', '019', '040', '045', '048', '050', '055', '060', '066', '067', '077', '084', '086', '097', '098')  -- grocery
AND      shd.ORDER_SOURCE not in ('I')
AND		 shd.RECORD_ID in ('1', '2', '3', '6')
--AND      shd.NO_CHRGE_ITM_CDE not in ('*')                          -------  handle no charge items
GROUP BY d.COMPANY_YEAR_ID,
		 d.COMPANY_PERIOD_ID,
--		 shd.RECORD_ID,
		 shd.FACILITYID, 
		 shd.CUSTOMER_NO_FULL,
		 shd.billing_date,
		 shd.ORDER_TYPE, 
--		 shd.ORDER_SOURCE,
		 shd.ITEM_DEPT,
		 shd.PRVT_LBL_FLG;
-----------------------------------------------------------------------------------------------------------



CRMADMIN.T_WHSE_WSC wsc;
		 
--customer list
SELECT   FACILITYID,
         substr(char(TERRITORY_NO),1,2) territory,
         char(rtrim(ltrim(CUSTOMER_NO))) cust_no,
         substr(char(TERRITORY_NO),1,2) || REPEAT('0',6-LENGTH(rtrim(ltrim(CUSTOMER_NO)))) || ltrim(rtrim(CUSTOMER_NO)) AS CUSTOMER_NO_FULL, 
--         string(6-length(rtrim(ltrim(char(CUSTOMER_NO)))),'0') leng,
--         full_cust_nbr,
         NAME,
         ADDRESS1,
         ADDRES2 ADDRESS2,
         ADDRESS3,
         STATE_CD,
         STATE_DESCRIPTION,
         ZIP_CD,
         MILES_FRM_WHSE,
         CUST_CORPORATION,
         STORE_CLASS         
FROM     CRMADMIN.T_WHSE_CUST
WHERE    facilityid = '058';



----------------------------------------------------------------------------------------------------------------------
--customer
--customer list
SELECT   FACILITYID,
         substr(char(TERRITORY_NO),1,2) territory,
         char(rtrim(ltrim(CUSTOMER_NO))) cust_no,
         substr(char(TERRITORY_NO),1,2) || REPEAT('0',6-LENGTH(rtrim(ltrim(CUSTOMER_NO)))) || ltrim(rtrim(CUSTOMER_NO)) AS CUSTOMER_NO_FULL, 
--         string(6-length(rtrim(ltrim(char(CUSTOMER_NO)))),'0') leng,
--         full_cust_nbr,
         NAME,
         ADDRESS1,
         ADDRES2 ADDRESS2,
         ADDRESS3,
         STATE_CD,
         STATE_DESCRIPTION,
         ZIP_CD,
         MILES_FRM_WHSE,
         CUST_CORPORATION,
         STORE_CLASS         
FROM     CRMADMIN.T_WHSE_CUST
WHERE    facilityid = '058';