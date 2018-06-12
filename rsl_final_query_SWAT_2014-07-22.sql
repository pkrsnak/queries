SELECT   'RDET' As RECORD_SOURCE,
         sls.FACILITYID FACILITYID,
         sls.BILLING_DATE BILLING_DATE,
         sxref.STORE_ID STORE_ID,
         sls.INVOICE_NBR INVOICE_NBR,
         rlxref.LAWDEPT FINANCIAL_DEPT,
         sum(case when sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0 then sls.QTY_SOLD else sls.QTY_SOLD - sls.QTY_SCRATCHED end ) QTY_SHIPPED,
         sum(case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * sls.STORE_PACK) UNITS_SHIPPED,
         sum(case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * (sls.REFLECT_ALLOW_AMT - sls.AD_ALLOW_AMT)) REFLECT_OI_AMT_EXT,
         sum(case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * sls.AD_ALLOW_AMT) REFLECT_RPA_AMT_EXT,
         sum(case when dxref.PLATFORM_TYPE = 'SWAT' then case when (sls.NO_CHRGE_ITM_CDE = '*') then 1 when (sls.ORDER_SOURCE = 'I') then 1 when (dxref.PLATFORM_TYPE = 'SWAT' and sls.QTY_SOLD = 0 and sls.OUT_REASON_CODE = '000') then 0 when (dxref.PLATFORM_TYPE = 'LEGACY' and sls.RECORD_ID = '6') then 1 when (dxref.PLATFORM_TYPE = 'LEGACY' and case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else sls.QTY_SOLD - sls.QTY_SCRATCHED end = 0) then 1 else case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end end * sls.FREIGHT_AMT else case when (sls.NO_CHRGE_ITM_CDE = '*') then 1 when (sls.ORDER_SOURCE = 'I') then 1 when (dxref.PLATFORM_TYPE = 'SWAT' and sls.QTY_SOLD = 0 and sls.OUT_REASON_CODE = '000') then 0 when (dxref.PLATFORM_TYPE = 'LEGACY' and sls.RECORD_ID = '6') then 1 when (dxref.PLATFORM_TYPE = 'LEGACY' and case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else sls.QTY_SOLD - sls.QTY_SCRATCHED end = 0) then 1 else case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end end * sls.FREIGHT_AMT end ) EXT_FREIGHT,
         sum(case when (sls.NO_CHRGE_ITM_CDE = '*') then 1 when (sls.ORDER_SOURCE = 'I') then 1 when (dxref.PLATFORM_TYPE = 'SWAT' and sls.QTY_SOLD = 0 and sls.OUT_REASON_CODE = '000') then 0 when (dxref.PLATFORM_TYPE = 'LEGACY' and sls.RECORD_ID = '6') then 1 when (dxref.PLATFORM_TYPE = 'LEGACY' and case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else sls.QTY_SOLD - sls.QTY_SCRATCHED end = 0) then 1 else case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end end * round(case sls.RANDOM_WGT_FLG when 'R' then (round(((sls.UNIT_SALES_PRICE * sls.RANDOM_WGT) +   sls.LEAKAGE_AMT),2)) else (((sls.FINAL_SELL_AMT - ((sls.LBL_CASE_CHRGE + sls.PRICE_ADJUSTMENT) + sls.LEAKAGE_AMT * -1)) - case when (sls.ITEM_DEPT = '050') then 0 else (((sls.CITY_EXCISE_TAX + sls.COUNTY_EXCISE_TAX) + (sls.STATE_EXCISE_TAX + sls.OTHER_EXCISE_TAX_01)) + (sls.OTHER_EXCISE_TAX_02 + sls.OTHER_EXCISE_TAX_03)) end ) - case dxref.PLATFORM_TYPE when 'LEGACY' then ((sls.FUEL_CHRGE_AMT + sls.FREIGHT_AMT) + (sls.MRKUP_DLLRS_PER_SHIP_UNT + sls.ITEM_LVL_MRKUP_AMT_02)) when 'SWAT' then (case when (sls.MRKUP_SPREAD_FLG in ('2')) then sls.FREIGHT_AMT else 0 end + case when (sls.MRKUP_SPREAD_FLG in ('1', '2')) then sls.MRKUP_DLLRS_PER_SHIP_UNT else 0 end ) else 0 end )
end ,2 )) EXTENDED_PURE_SELL,
        sum(case record_id when '6' then sls.RETAIL_PRICE else (case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * case when (sls.RANDOM_WGT_FLG = 'R') then (sls.RETAIL_PRICE * case when (sls.RANDOM_WGT_FLG = 'R') then sls.RANDOM_WGT else (case when (sls.ORDER_TYPE = 'GB' or dxref.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * itm.SHIPPING_CASE_WEIGHT) end ) else (sls.RETAIL_PRICE * ((sls.STORE_PACK * 1.0e0) / nullif(case when (sls.SRP_UNITS = 0) then 1 when sls.SRP_UNITS is null then 1 else sls.SRP_UNITS end , 0))) end) end ) EXT_RETAIL 
FROM     (( select dxref.SWAT_ID SWAT_ID , dxref.PLATFORM_TYPE PLATFORM_TYPE from CRMADMIN.T_WHSE_DIV_XREF dxref where dxref.ENTERPRISE_KEY = 1) dxref 
         inner join CRMADMIN.T_WHSE_CUST cust on dxref.SWAT_ID = cust.FACILITYID) 
         inner join CRMADMIN.V_WHSE_SALES_HISTORY_DTL sls on cust.FACILITYID = sls.FACILITYID and cust.CUSTOMER_NO = sls.CUSTOMER_NO and cust.TERRITORY_NO = sls.TERRITORY_NO 
         LEFT OUTER JOIN CRMADMIN.T_WHSE_ITEM itm on sls.FACILITYID = itm.FACILITYID and sls.ITEM_NBR_CD = itm.ITEM_NBR_CD 
         inner join ETLADMIN.T_WHSE_RTL_STORE_XREF sxref on sxref.FACILITYID = sls.FACILITYID and sls.CUSTOMER_NO_FULL = sxref.CUSTOMER_NO_FULL
         LEFT OUTER JOIN ETLADMIN.T_RTL_LAW_DEPT_XREF rlxref on dxref.PLATFORM_TYPE = rlxref.PLATFORM_TYPE and rlxref.RTL_DEPT =  trim(sls.CUST_OVRRDE_RTL_DEPT)
         inner join ( select lxref.FACILITYID FACILITYID , lxref.LAWSON_DEPT LAWSON_DEPT , lxref.LAWSON_ACCOUNT, lxref.WHOL_SALES_CD WHOL_SALES_CD , lxref.TERRITORY_NO TERRITORY_NO from CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN lxref where lxref.BUSINESS_SEGMENT = '2') lxref on sls.FACILITYID = lxref.FACILITYID and sls.WHOL_SALES_CD = lxref.WHOL_SALES_CD and sls.TERRITORY_NO = lxref.TERRITORY_NO 
WHERE    ((dxref.platform_type = 'LEGACY' and sls.NO_CHRGE_ITM_CDE NOT in ('*')) or dxref.platform_type = 'SWAT')
AND      sls.BILLING_DATE = current date - #NOD# days
AND      sls.USDS_FLG = 'D'
and sls.FACILITYID <> '002' 
and lxref.LAWSON_ACCOUNT in (331000, 225010, 225000, 248000)
and sls.item_dept not in ('040')
and not (sls.RECORD_ID = '6' and trim(OVRRDE_RTL_CHRGE_CDE) = 'B')
and rlxref.LAWDEPT is not null
GROUP BY sls.FACILITYID, sls.BILLING_DATE, sxref.STORE_ID, sls.INVOICE_NBR, rlxref.LAWDEPT
Union ALL
SELECT   
         'ARDA' As RECORD_SOURCE,
         sls.FACILITYID FACILITYID,
         sls.BILLING_DATE BILLING_DATE,
         sxref.STORE_ID STORE_ID,
         sls.INVOICE_NBR INVOICE_NBR,
         lxref.LAWSON_DEPT FINANCIAL_DEPT,
         0 as QTY_SHIPPED,
         0 as UNITS_SHIPPED,
         0 as REFLECT_OI_AMT_EXT,
         0 as REFLECT_RPA_AMT_EXT,
         0 as  EXT_FREIGHT,
         sum(case when (sls.NO_CHRGE_ITM_CDE = '*') then 1 when (sls.ORDER_SOURCE = 'I') then 1 when (dxref.PLATFORM_TYPE = 'SWAT' and sls.QTY_SOLD = 0 and sls.OUT_REASON_CODE = '000') then 0 when (dxref.PLATFORM_TYPE = 'LEGACY' and sls.RECORD_ID = '6') then 1 when (dxref.PLATFORM_TYPE = 'LEGACY' and case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else sls.QTY_SOLD - sls.QTY_SCRATCHED end = 0) then 1 else case when (sls.ORDER_TYPE = 'GB') then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end end * (((sls.FINAL_SELL_AMT - ((sls.LBL_CASE_CHRGE + sls.PRICE_ADJUSTMENT) + sls.LEAKAGE_AMT * -1)) - case when (sls.ITEM_DEPT = '050') then 0 else (((sls.CITY_EXCISE_TAX + sls.COUNTY_EXCISE_TAX) + (sls.STATE_EXCISE_TAX + sls.OTHER_EXCISE_TAX_01)) + (sls.OTHER_EXCISE_TAX_02 + sls.OTHER_EXCISE_TAX_03)) end ) - case dxref.PLATFORM_TYPE when 'LEGACY' then ((sls.FUEL_CHRGE_AMT + sls.FREIGHT_AMT) + (sls.MRKUP_DLLRS_PER_SHIP_UNT + sls.ITEM_LVL_MRKUP_AMT_02)) when 'SWAT' then (case when (sls.MRKUP_SPREAD_FLG in ('2')) then sls.FREIGHT_AMT else 0 end + case when (sls.MRKUP_SPREAD_FLG in ('1', '2')) then sls.MRKUP_DLLRS_PER_SHIP_UNT else 0 end ) else 0 end )) EXTENDED_PURE_SELL,
        0 as  EXT_RETAIL
FROM     (((( select dxref.SWAT_ID SWAT_ID , dxref.PLATFORM_TYPE PLATFORM_TYPE from CRMADMIN.T_WHSE_DIV_XREF dxref where dxref.ENTERPRISE_KEY = 1) dxref 
         inner join CRMADMIN.T_WHSE_CUST cust on dxref.SWAT_ID = cust.FACILITYID) 
         inner join CRMADMIN.V_WHSE_SALES_HISTORY_DTL sls on cust.FACILITYID = sls.FACILITYID and cust.CUSTOMER_NO = sls.CUSTOMER_NO and cust.TERRITORY_NO = sls.TERRITORY_NO) 
         inner join ( select lxref.FACILITYID FACILITYID , lxref.LAWSON_DEPT LAWSON_DEPT , lxref.WHOL_SALES_CD WHOL_SALES_CD , lxref.TERRITORY_NO TERRITORY_NO from CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN lxref where lxref.BUSINESS_SEGMENT = '2') lxref on sls.FACILITYID = lxref.FACILITYID and sls.WHOL_SALES_CD = lxref.WHOL_SALES_CD and sls.TERRITORY_NO = lxref.TERRITORY_NO) 
         LEFT OUTER JOIN CRMADMIN.T_WHSE_ITEM itm on sls.FACILITYID = itm.FACILITYID and sls.ITEM_NBR_CD = itm.ITEM_NBR_CD 
         inner join ETLADMIN.T_WHSE_RTL_STORE_XREF sxref on sxref.FACILITYID = sls.FACILITYID and sls.CUSTOMER_NO_FULL = sxref.CUSTOMER_NO_FULL
WHERE    ((dxref.platform_type = 'LEGACY' and sls.NO_CHRGE_ITM_CDE in ('*') and sls.WHOL_SALES_CD in ('094', '015', '012', '150') and  sls.RECORD_ID = '2') or (dxref.platform_type = 'SWAT' and sls.CREDIT_REASON_CDE = '19'))
AND      sls.BILLING_DATE = current date - #NOD# days
and 	 sls.FACILITYID <> '002' 
AND      sls.USDS_FLG = 'D'
GROUP BY sls.FACILITYID, sls.BILLING_DATE,
         sxref.STORE_ID, sls.INVOICE_NBR, lxref.LAWSON_DEPT
Union All
SELECT   
         'TAX' As RECORD_SOURCE,
         sls.FACILITYID FACILITYID,
         sls.BILLING_DATE BILLING_DATE,
         sxref.STORE_ID STORE_ID,
         sls.INVOICE_NBR INVOICE_NBR,
         rlxref.LAWDEPT FINANCIAL_DEPT,
         0 as QTY_SHIPPED,
         0 as UNITS_SHIPPED,
         0 as REFLECT_OI_AMT_EXT,
         0 as REFLECT_RPA_AMT_EXT,
         0 as  EXT_FREIGHT,
         sum((sls.CITY_EXCISE_TAX + sls.COUNTY_EXCISE_TAX + sls.STATE_EXCISE_TAX + 
 sls.OTHER_EXCISE_TAX_01 + sls.OTHER_EXCISE_TAX_02 + sls.OTHER_EXCISE_TAX_03 + 
 sls.CITY_SALES_TAX + sls.STATE_SALES_TAX + sls.COUNTY_SALES_TAX)) EXTENDED_PURE_SELL,
        0 as  EXT_RETAIL
FROM     (((( select dxref.SWAT_ID SWAT_ID , dxref.PLATFORM_TYPE PLATFORM_TYPE from CRMADMIN.T_WHSE_DIV_XREF dxref where dxref.ENTERPRISE_KEY = 1) dxref 
         inner join CRMADMIN.T_WHSE_CUST cust on dxref.SWAT_ID = cust.FACILITYID) 
         inner join CRMADMIN.V_WHSE_SALES_HISTORY_DTL sls on cust.FACILITYID = sls.FACILITYID and cust.CUSTOMER_NO = sls.CUSTOMER_NO and cust.TERRITORY_NO = sls.TERRITORY_NO) )
         LEFT OUTER JOIN CRMADMIN.T_WHSE_ITEM itm on sls.FACILITYID = itm.FACILITYID and sls.ITEM_NBR_CD = itm.ITEM_NBR_CD 
         inner join ETLADMIN.T_WHSE_RTL_STORE_XREF sxref on sxref.FACILITYID = sls.FACILITYID and sls.CUSTOMER_NO_FULL = sxref.CUSTOMER_NO_FULL
         LEFT OUTER JOIN ETLADMIN.T_RTL_LAW_DEPT_XREF rlxref on dxref.PLATFORM_TYPE = rlxref.PLATFORM_TYPE and rlxref.RTL_DEPT =  trim(sls.CUST_OVRRDE_RTL_DEPT)
WHERE    sls.NO_CHRGE_ITM_CDE in ('*')
--AND     ((dxref.platform_type = 'LEGACY' and sls.RECORD_ID = '4') or dxref.platform_type = 'SWAT')
AND     ((dxref.platform_type = 'LEGACY' and sls.RECORD_ID = '4'))
AND      sls.BILLING_DATE = current date - #NOD# days
AND      sls.USDS_FLG = 'D'
AND      sls.ITEM_DEPT not in ('040')
GROUP BY sls.FACILITYID, sls.BILLING_DATE,
         sxref.STORE_ID, sls.INVOICE_NBR, rlxref.LAWDEPT
having sum(sls.CITY_EXCISE_TAX + sls.COUNTY_EXCISE_TAX + sls.STATE_EXCISE_TAX + 
 sls.OTHER_EXCISE_TAX_01 + sls.OTHER_EXCISE_TAX_02 + sls.OTHER_EXCISE_TAX_03 + 
 sls.CITY_SALES_TAX + sls.STATE_SALES_TAX + sls.COUNTY_SALES_TAX) <> 0
Union All
SELECT   
         'LEAK' As RECORD_SOURCE,
         sls.FACILITYID FACILITYID,
         sls.BILLING_DATE BILLING_DATE,
         sxref.STORE_ID STORE_ID,
         sls.INVOICE_NBR INVOICE_NBR,
         rlxref.LAWDEPT FINANCIAL_DEPT,
         0 as QTY_SHIPPED,
         0 as UNITS_SHIPPED,
         0 as REFLECT_OI_AMT_EXT,
         0 as REFLECT_RPA_AMT_EXT,
         0 as  EXT_FREIGHT,
         sum(sls.LEAKAGE_AMT * -1) EXTENDED_PURE_SELL,
        0 as  EXT_RETAIL
FROM     (((( select dxref.SWAT_ID SWAT_ID , dxref.PLATFORM_TYPE PLATFORM_TYPE from CRMADMIN.T_WHSE_DIV_XREF dxref where dxref.ENTERPRISE_KEY = 1) dxref 
         inner join CRMADMIN.T_WHSE_CUST cust on dxref.SWAT_ID = cust.FACILITYID) 
         inner join CRMADMIN.V_WHSE_SALES_HISTORY_DTL sls on cust.FACILITYID = sls.FACILITYID and cust.CUSTOMER_NO = sls.CUSTOMER_NO and cust.TERRITORY_NO = sls.TERRITORY_NO) 
         inner join ( select lxref.FACILITYID FACILITYID , lxref.LAWSON_DEPT LAWSON_DEPT , lxref.WHOL_SALES_CD WHOL_SALES_CD , lxref.TERRITORY_NO TERRITORY_NO from CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN lxref where lxref.BUSINESS_SEGMENT = '2') lxref on sls.FACILITYID = lxref.FACILITYID and sls.WHOL_SALES_CD = lxref.WHOL_SALES_CD and sls.TERRITORY_NO = lxref.TERRITORY_NO) 
         LEFT OUTER JOIN CRMADMIN.T_WHSE_ITEM itm on sls.FACILITYID = itm.FACILITYID and sls.ITEM_NBR_CD = itm.ITEM_NBR_CD 
         inner join ETLADMIN.T_WHSE_RTL_STORE_XREF sxref on sxref.FACILITYID = sls.FACILITYID and sls.CUSTOMER_NO_FULL = sxref.CUSTOMER_NO_FULL
         LEFT OUTER JOIN ETLADMIN.T_RTL_LAW_DEPT_XREF rlxref on dxref.PLATFORM_TYPE = rlxref.PLATFORM_TYPE and rlxref.RTL_DEPT =  trim(sls.CUST_OVRRDE_RTL_DEPT)
WHERE    ((dxref.platform_type = 'LEGACY' and sls.NO_CHRGE_ITM_CDE in ('*') AND sls.RECORD_ID = '2') or dxref.platform_type = 'SWAT')
AND      sls.BILLING_DATE = current date - #NOD# days
and sls.FACILITYID <> '002' 
AND      sls.USDS_FLG = 'D'
and sls.LEAKAGE_AMT <> 0 
GROUP BY sls.FACILITYID, sls.BILLING_DATE,
         sxref.STORE_ID, sls.INVOICE_NBR, rlxref.LAWDEPT
