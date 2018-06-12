SELECT   FACILITYID, CUSTOMER_NO_FULL,
         INVOICE_NBR, BILLING_DATE,
         ITEM_NBR_HS,
         ITEM_DESCRIPTION,
         NO_CHRGE_ITM_CDE, ITEM_DEPT, ITEM_DEPT_HS, CUST_OVRRDE_RTL_DEPT, OVRRDE_RTL_CHRGE_CDE,
         ORDER_SOURCE,
         QTY_SOLD,
         OUT_REASON_CODE,
         RECORD_ID,
         ORDER_TYPE,
         QTY_SCRATCHED,
         FINAL_SELL_AMT,
         LBL_CASE_CHRGE,
         PRICE_ADJUSTMENT,
         LEAKAGE_AMT * -1 leakage,
         ITEM_DEPT,
         CITY_EXCISE_TAX,
         COUNTY_EXCISE_TAX,
         STATE_EXCISE_TAX,
         OTHER_EXCISE_TAX_01,
         OTHER_EXCISE_TAX_02,
         OTHER_EXCISE_TAX_03, CITY_SALES_TAX, STATE_SALES_TAX, COUNTY_SALES_TAX,
         FUEL_CHRGE_AMT,
         FREIGHT_AMT,
         MRKUP_DLLRS_PER_SHIP_UNT,
         ITEM_LVL_MRKUP_AMT_02,
         MRKUP_SPREAD_FLG,
         FREIGHT_AMT, FUEL_CHRGE_AMT
FROM     CRMADMIN.V_WHSE_SALES_HISTORY_DTL
WHERE    FACILITYID in ('059', '071')
--AND      CUSTOMER_NO_FULL in ('31000409') --3073
--AND      CUSTOMER_NO_FULL in ('31003840') --3075
--AND      CUSTOMER_NO_FULL in ('31001098') --3077
AND      CUSTOMER_NO_FULL in ('31001528') --3361
--AND      CUSTOMER_NO_FULL in ('31003366') --3362
--AND      BILLING_DATE between '2014-07-13' and '2014-08-09'
--and RECORD_ID = '6'
--AND      BILLING_DATE = '2014-07-23'
and INVOICE_NBR = 447622

--and ITEM_DEPT not in ('040')
--and (CITY_EXCISE_TAX + COUNTY_EXCISE_TAX + STATE_EXCISE_TAX + OTHER_EXCISE_TAX_01 + OTHER_EXCISE_TAX_02 + OTHER_EXCISE_TAX_03 + 
-- CITY_SALES_TAX + STATE_SALES_TAX + COUNTY_SALES_TAX) <> 0
;


SELECT   'RDET' As RECORD_SOURCE,
         sls.FACILITYID FACILITYID,
         sls.BILLING_DATE BILLING_DATE, --sls.ORDER_SOURCE, sls.ITEM_DEPT,
         sxref.STORE_ID STORE_ID,
         sls.INVOICE_NBR INVOICE_NBR,
         rlxref.LAWDEPT FINANCIAL_DEPT, lxref.LAWSON_ACCOUNT, 
         sum(case when sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0 then sls.QTY_SOLD else sls.QTY_SOLD - sls.QTY_SCRATCHED end ) QTY_SHIPPED,
         sum(case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * sls.STORE_PACK) UNITS_SHIPPED,
         sum(case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * (sls.REFLECT_ALLOW_AMT - sls.AD_ALLOW_AMT)) REFLECT_OI_AMT_EXT,
         sum(case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * sls.AD_ALLOW_AMT) REFLECT_RPA_AMT_EXT,
         sum(case when dxref.PLATFORM_TYPE = 'SWAT' then case when (sls.NO_CHRGE_ITM_CDE = '*') then 1 when (sls.ORDER_SOURCE = 'I') then 1 when (dxref.PLATFORM_TYPE = 'SWAT' and sls.QTY_SOLD = 0 and sls.OUT_REASON_CODE = '000') then 0 when (dxref.PLATFORM_TYPE = 'LEGACY' and sls.RECORD_ID = '6') then 1 when (dxref.PLATFORM_TYPE = 'LEGACY' and case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else sls.QTY_SOLD - sls.QTY_SCRATCHED end = 0) then 1 else case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end end * sls.FREIGHT_AMT else case when (sls.NO_CHRGE_ITM_CDE = '*') then 1 when (sls.ORDER_SOURCE = 'I') then 1 when (dxref.PLATFORM_TYPE = 'SWAT' and sls.QTY_SOLD = 0 and sls.OUT_REASON_CODE = '000') then 0 when (dxref.PLATFORM_TYPE = 'LEGACY' and sls.RECORD_ID = '6') then 1 when (dxref.PLATFORM_TYPE = 'LEGACY' and case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else sls.QTY_SOLD - sls.QTY_SCRATCHED end = 0) then 1 else case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end end * sls.FREIGHT_AMT end ) EXT_FREIGHT,

         sum(case when (sls.NO_CHRGE_ITM_CDE = '*') then 1 when (sls.ORDER_SOURCE = 'I') then 1 when (dxref.PLATFORM_TYPE = 'SWAT' and sls.QTY_SOLD = 0 and sls.OUT_REASON_CODE = '000') then 0 when (dxref.PLATFORM_TYPE = 'LEGACY' and sls.RECORD_ID = '6') then 1 when (dxref.PLATFORM_TYPE = 'LEGACY' and case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else sls.QTY_SOLD - sls.QTY_SCRATCHED end = 0) then 1 else case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end end * round(case sls.RANDOM_WGT_FLG when 'R' then (round(((sls.UNIT_SALES_PRICE * sls.RANDOM_WGT) +   sls.LEAKAGE_AMT),2)) else (((sls.FINAL_SELL_AMT - ((sls.LBL_CASE_CHRGE + sls.PRICE_ADJUSTMENT) + sls.LEAKAGE_AMT * -1)) - case when (sls.ITEM_DEPT = '050') then 0 else (((sls.CITY_EXCISE_TAX + sls.COUNTY_EXCISE_TAX) + (sls.STATE_EXCISE_TAX + sls.OTHER_EXCISE_TAX_01)) + (sls.OTHER_EXCISE_TAX_02 + sls.OTHER_EXCISE_TAX_03)) end ) - case dxref.PLATFORM_TYPE when 'LEGACY' then ((sls.FUEL_CHRGE_AMT + sls.FREIGHT_AMT) + (sls.MRKUP_DLLRS_PER_SHIP_UNT + sls.ITEM_LVL_MRKUP_AMT_02)) when 'SWAT' then (case when (sls.MRKUP_SPREAD_FLG in ('2')) then sls.FREIGHT_AMT else 0 end + case when (sls.MRKUP_SPREAD_FLG in ('1', '2')) then sls.MRKUP_DLLRS_PER_SHIP_UNT else 0 end ) else 0 end )
end ,2 )) EXTENDED_PURE_SELL,

         sum(case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * case when (sls.RANDOM_WGT_FLG = 'R') then (sls.RETAIL_PRICE * case when (sls.RANDOM_WGT_FLG = 'R') then sls.RANDOM_WGT else (case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * itm.SHIPPING_CASE_WEIGHT) end ) else (sls.RETAIL_PRICE * ((sls.STORE_PACK * 1.0e0) / nullif(case when (sls.SRP_UNITS = 0) then 1 when sls.SRP_UNITS is null then 1 else sls.SRP_UNITS end , 0))) end ) EXT_RETAIL
FROM     (( select dxref.SWAT_ID SWAT_ID , dxref.PLATFORM_TYPE PLATFORM_TYPE from CRMADMIN.T_WHSE_DIV_XREF dxref where dxref.ENTERPRISE_KEY = 1) dxref 
         inner join CRMADMIN.T_WHSE_CUST cust on dxref.SWAT_ID = cust.FACILITYID) 
         inner join CRMADMIN.V_WHSE_SALES_HISTORY_DTL sls on cust.FACILITYID = sls.FACILITYID and cust.CUSTOMER_NO = sls.CUSTOMER_NO and cust.TERRITORY_NO = sls.TERRITORY_NO 
         LEFT OUTER JOIN CRMADMIN.T_WHSE_ITEM itm on sls.FACILITYID = itm.FACILITYID and sls.ITEM_NBR_CD = itm.ITEM_NBR_CD 
         inner join ETLADMIN.T_WHSE_RTL_STORE_XREF sxref on sxref.FACILITYID = sls.FACILITYID and sls.CUSTOMER_NO_FULL = sxref.CUSTOMER_NO_FULL
         LEFT OUTER JOIN ETLADMIN.T_RTL_LAW_DEPT_XREF rlxref on dxref.PLATFORM_TYPE = rlxref.PLATFORM_TYPE and rlxref.RTL_DEPT =  trim(sls.CUST_OVRRDE_RTL_DEPT)
         inner join ( select lxref.FACILITYID FACILITYID , lxref.LAWSON_DEPT LAWSON_DEPT , lxref.LAWSON_ACCOUNT, lxref.WHOL_SALES_CD WHOL_SALES_CD , lxref.TERRITORY_NO TERRITORY_NO from CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN lxref where lxref.BUSINESS_SEGMENT = '2') lxref on sls.FACILITYID = lxref.FACILITYID and sls.WHOL_SALES_CD = lxref.WHOL_SALES_CD and sls.TERRITORY_NO = lxref.TERRITORY_NO 
WHERE    sls.BILLING_DATE = '2014-07-09'
--AND      sls.NO_CHRGE_ITM_CDE NOT in ('*')
--AND      sls.BILLING_DATE between '2014-05-18' and '2014-06-14'
--AND      sls.USDS_FLG = 'D'
--and sls.FACILITYID <> '002' 
--and sls.FACILITYID = '005' 
and sls.INVOICE_NBR = 7090102
and sxref.STORE_ID = 3121
--and lxref.LAWSON_ACCOUNT in (470000)
--and trim(sls.CUST_OVRRDE_RTL_DEPT) = 'X'
--and lxref.LAWSON_ACCOUNT in (331000, 225010, 248000)
--and sls.item_dept not in ('040')
--and not (sls.RECORD_ID = '6' and trim(OVRRDE_RTL_CHRGE_CDE) = 'B')
--and rlxref.LAWDEPT is not null
GROUP BY sls.FACILITYID, sls.BILLING_DATE, --sls.ORDER_SOURCE, sls.ITEM_DEPT, 
         sxref.STORE_ID, sls.INVOICE_NBR, rlxref.LAWDEPT  ,lxref.LAWSON_ACCOUNT
