--------------------------------------------------------------------------------------------------------------------------------------
-- eric's version
--------------------------------------------------------------------------------------------------------------------------------------
Select b.FACILITYID dc
     , b.CUSTOMER_NO_FULL customer
     , c.NAME name
     , d.COMPANY_YEAR_ID 
     , sum(case when b.OUT_REASON_CODE in ('004', '011') then 0 else b.QTY_ADJUSTED end) TOT_QTY_ADJUSTED
     , sum(case when b.OUT_REASON_CODE in ('004', '011') then 0 else (case when b.ORDER_TYPE = 'GB' then b.QTY_SOLD else b.QTY_SOLD - b.QTY_SCRATCHED end) end) TOT_QTY_SHIPPED
     , sum(case when b.OUT_REASON_CODE in ('004', '011') then 0 else (b.QTY_ADJUSTED - (case when b.ORDER_TYPE = 'GB' then b.QTY_SOLD else b.QTY_SOLD - b.QTY_SCRATCHED end)) end) TOT_OUTS
     , sum(case when b.OUT_REASON_CODE in ('004', '011') then 0 else ((case when b.ORDER_TYPE = 'GB' then b.QTY_SOLD else b.QTY_SOLD - b.QTY_SCRATCHED end) * b.FINAL_SELL_AMT) end) EXT_DOLLARS_SHIPPED
     , count(distinct case when b.FACILITYID_SHIP not in ('SF', 'GM') then case when b.ORDER_TYPE not in ('GB') then b.BILLING_DATE else null end else null end) num_orders
     , count(distinct (char(b.BILLING_DATE) || char(b.TRIP_NBR1))) num_trips  -- fix for gm, sf
     , count(distinct b.ITEM_NBR_HS) num_unique_skus
     , count(distinct (char(b.BILLING_DATE) || char(b.TRIP_NBR1) || b.ITEM_NBR_HS)) num_unique_skus_over_time
  from CRMADMIN.T_WHSE_SALES_HISTORY_DTL b,
  	   CRMADMIN.T_WHSE_CUST c,
  	   CRMADMIN.T_DATE d,
  	   CRMADMIN.T_WHSE_DEPT e
 where b.facilityid = c.facilityid
   and b.CUSTOMER_NO_FULL  = c.CUSTOMER_NO_FULL
--   and b.TERRITORY_NO = c.TERRITORY_NO
   and b.billing_date = d.DATE_KEY
   and b.ITEM_DEPT = e.DEPT_CODE
   and c.facilityid in ('058')
   and d.COMPANY_YEAR_ID = 2007
--   and d.COMPANY_PERIOD_ID in (11,12,13)
--   and b.ITEM_DEPT in ('030', '031', '035', '072', '078', '099')  -- frozen
--   and b.ITEM_DEPT in ('020', '025', '080', '090', '094')  -- dairy
--   and b.ITEM_DEPT in ('070', '073', '074', '075')  -- meat
   and b.ITEM_DEPT in ('010', '012', '016', '017', '018', '019', '040', '045', '048', '050', '055', '060', '066', '067', '077', '084', '086', '097', '098')  -- groc
   AND b.ORDER_SOURCE not in ('I')
   and b.NO_CHRGE_ITM_CDE not in ('*')
   AND b.ORDER_TYPE not in ('CR', '  ', 'CX')
group by  b.FACILITYID
		, b.CUSTOMER_NO_FULL
		, c.NAME
        , d.COMPANY_YEAR_ID 
order by  b.CUSTOMER_NO_FULL
        , d.COMPANY_YEAR_ID ;
