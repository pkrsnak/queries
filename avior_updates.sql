--AVIOR

--ETL_Inventory_beg
SELECT   FACILITYID,
         ITEM_NBR_HS,VENDOR_LIST_PRICE,
         LAYER_FILE_DTE,
         sum(INVENTORY_TURN + INVENTORY_PROMOTION + INVENTORY_FWD_BUY) as TOTAL
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY
--WHERE    LAYER_FILE_DTE = (date('0001-01-01') + year(#CurrentDate#) years - 1 year + month(#CurrentDate#) months - 2 months )
WHERE    LAYER_FILE_DTE = (date('0001-01-01') + year(Current Date) years - 1 year + month(Current Date) months - 2 months )
--AND      FACILITYID = '066'
AND      FACILITYID = '058'
GROUP BY FACILITYID, ITEM_NBR_HS, VENDOR_LIST_PRICE,LAYER_FILE_DTE;


--ETL_Purchases
SELECT  b.FACILITYID,
         trim(e.DIV_NAME) DIV_NAME,
         a.EXTR_PUR_VENDOR_NUMBER,
         b.ITEM_NBR,
         b.ADJ_ITEM_QUANTITY,
         a.EXTR_VENDOR_INV_NUMBER,
         b.EXTR_ITEM_RECEIPT_DATE DATE_RECEIVED,
         b.ADJ_ITEM_LIST_COST * b.ADJ_ITEM_QUANTITY Total_Amount,
         c.ITEM_SIZE,
         c.MSA_STICK_COUNT,
         b.ADJ_ITEM_LIST_COST, c.Item_dept
FROM     CRMADMIN.T_WHSE_PROMPT_HDR a,
         CRMADMIN.T_WHSE_PROMPT_dtl b,
         CRMADMIN.T_WHSE_ITEM c,
         CRMADMIN.T_WHSE_DIV_XREF e
WHERE    a.FACILITYID = b.FACILITYID
AND      a.PO_NBR = b.EXTR_ITEM_PO_NUMBER
AND      a.EXTR_RECEIPT_NUMBER = b.EXTR_ITEM_RECEIPT_NUMBER
AND      a.EXTR_RECEIPT_SUFFIX = b.EXTR_ITEM_RECEIPT_SUFFIX
AND      a.EXTR_PO_DATE = b.EXTR_ITEM_PO_DATE
AND      b.EXTR_ITEM_RECEIPT_DATE between (date('0001-01-01') + year(current date) years - 1 year + month(Current Date) months - 2 months ) and ( date('0001-01-01') + year(Current Date) years - 1 year + month(Current Date) months - 1 months - 1 days )
--AND      b.EXTR_ITEM_RECEIPT_DATE between (date('0001-01-01') + year(#CurrentDate#) years - 1 year + month(#CurrentDate#) months - 2 months ) and ( date('0001-01-01') + year(#CurrentDate#) years - 1 year + month(#CurrentDate#) months - 1 months - 1 days )
AND      b.FACILITYID = (c.FACILITYID)
AND      b.item_nbr = c.ITEM_NBR
and   b.ADJ_ITEM_QUANTITY > 0
AND      c.BILLING_STATUS not in ('D', 'Z')
AND      ( c.Item_dept in ('050','055')
     OR  (c.Item_dept = '060'
        AND (c.famgrp_code is not null
            AND not ltrim(c.famgrp_code) = ''
            AND (( to_number(trim(c.famgrp_code)) between 696 and 712 )
                OR  c.FAMGRP_CODE = '510' ) ) ) )
AND      b.FACILITYID = e.SWAT_ID
--AND      b.FACILITYID in ('066')
AND      b.FACILITYID in ('054')
AND      e.ACTIVE_FLAG = 'Y';


--ETL_Vendors  (what the heck is this?)
SELECT    f.MASTER_VENDOR ,  f.fein
FROM       CRMADMIN.t_whse_avior_fein f
--WHERE f.MASTER_VENDOR =?
--and f.active='Y'
;


--ETL_Sales
SELECT   shd.FACILITYID,
         dc.DIV_NAME,
         shd.CUSTOMER_NO_FULL,
         shd.ITEM_NBR_HS,
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         itm.MSA_STICK_COUNT,
         itm.ITEM_SIZE,
         ( shd.BASE_SELL_AMT * SUM((case when (SHD.out_reason_code in ('004', '011') Or (SHD.whol_sales_CD='013' or SHD.whol_sales_CD='016'or SHD.whol_sales_CD='017' ) ) then 0 else (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) end) ) ) as taxable,
         shd.CUSTOMER_NBR_CORP,
         SUM((case when DC.REGION = 'MIDWEST' then (case when (SHD.out_reason_code in ('004', '011') Or (SHD.whol_sales_cd='017')) then 0 else (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE (CASE WHEN (SHD.RECORD_ID='6' or SHD.no_chrge_itm_cde='*') THEN 1 ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END) * (SHD.FINAL_SELL_AMT - SHD.LBL_CASE_CHRGE - SHD.FREIGHT_AMT - SHD.MRKUP_DLLRS_PER_SHIP_UNT - SHD.FUEL_CHRGE_AMT - SHD.PRICE_ADJUSTMENT - SHD.CITY_EXCISE_TAX - SHD.OTHER_EXCISE_TAX_01 - SHD.OTHER_EXCISE_TAX_02 - SHD.OTHER_EXCISE_TAX_03 - SHD.COUNTY_EXCISE_TAX - SHD.STATE_EXCISE_TAX + SHD.LEAKAGE_AMT + SHD.ITEM_LVL_MRKUP_AMT_02 ) end) else (case when (SHD.out_reason_code in ('004', '011') Or (SHD.whol_saleS_CD='013' or SHD.whol_saleS_CD='016'or SHD.whol_saleS_CD='017' ) ) then 0 else (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE (CASE WHEN (SHD.RECORD_ID='6' or SHD.no_chrge_itm_cde='*') THEN 1 ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END) * (SHD.FINAL_SELL_AMT - SHD.LBL_CASE_CHRGE - SHD.PRICE_ADJUSTMENT - SHD.CITY_EXCISE_TAX - SHD.OTHER_EXCISE_TAX_01 - SHD.OTHER_EXCISE_TAX_02 - SHD.OTHER_EXCISE_TAX_03 - SHD.COUNTY_EXCISE_TAX - SHD.STATE_EXCISE_TAX + SHD.LEAKAGE_AMT - (CASE WHEN SHD.MRKUP_SPREAD_FLG IN ('1', '2') THEN SHD.MRKUP_DLLRS_PER_SHIP_UNT ELSE 0 END) - (CASE WHEN SHD.MRKUP_SPREAD_FLG IN ('2') THEN SHD.FREIGHT_AMT ELSE 0 END)) end) end) ) as PURE_SALES_AMOUNT,
         SUM((case when (SHD.out_reason_code in ('004', '011') Or (SHD.whol_sales_CD='013' or SHD.whol_sales_CD='016'or SHD.whol_sales_CD='017' ) ) then 0 else (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) end) ) as QTY_SHIPPED,
         shd.Item_dept,
         sum (shd.AD_ALLOW_AMT) as discount,
         '0' carrier_nbr,
         shd.TAX_CLASS,
         shd.STORE_STATE
FROM     CRMADMIN.V_WHSE_SALES_HISTORY_DTL shd,
         CRMADMIN.T_WHSE_DIV_XREF dc,
         CRMADMIN.T_WHSE_ITEM itm
WHERE    DC.swat_id=SHD.facilityid
AND      dc.ACTIVE_FLAG = 'Y'
AND      shd.FACILITYID = itm.FACILITYID
AND      shd.FACILITYID in ('066')
--AND      shd.FACILITYID in ('054')
AND      shd.ITEM_NBR_HS = itm.ITEM_NBR_HS
AND      ( shd.Item_dept in ('050','055')
     OR  (shd.Item_dept = '060'
        AND (shd.famgrp_code is not null
            AND not ltrim(shd.famgrp_code) = ''
            AND (( to_number(trim(shd.famgrp_code)) between 696 and 712 )
                OR  shd.FAMGRP_CODE = '510' ) ) ) )
AND      shd.RECORD_ID not IN ('1')
AND      shd.USDS_FLG = 'D'
--AND      trunc( shd.billing_date) between (date('0001-01-01') + year(#CurrentDate#) years - 1 year + month(#CurrentDate#) months - 2 months ) and ( date('0001-01-01') + year(#CurrentDate#) years - 1 year + month(#CurrentDate#) months - 1 months - 1 days )
AND      trunc( shd.billing_date) between (date('0001-01-01') + year(Current Date) years - 1 year + month(Current Date) months - 2 months ) and ( date('0001-01-01') + year(Current Date) years - 1 year + month(Current Date) months - 1 months - 1 days )
GROUP BY shd.FACILITYID, dc.DIV_NAME, shd.CUSTOMER_NO_FULL, shd.ITEM_NBR_HS, 
         shd.INVOICE_NBR, shd.BILLING_DATE, itm.MSA_STICK_COUNT, itm.ITEM_SIZE, 
         shd.BASE_SELL_AMT, shd.Item_dept, shd.CUSTOMER_NBR_CORP, 
         shd.TAX_CLASS, shd.STORE_STATE
HAVING   SUM((case when (SHD.out_reason_code in ('004', '011')
OR       (SHD.whol_sales_CD='013'
OR       SHD.whol_sales_CD='016'or SHD.whol_sales_CD='017' ) ) then 0 else (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) end) ) <> 0;