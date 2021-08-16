--Cognos Upstream New:
SELECT
        "T_WHSE_SALES_HISTORY_DTL"."FACILITYID" "FACILITYID" ,
        "T_WHSE_SALES_HISTORY_DTL"."INVOICE_NBR" "INVOICE_NBR" ,
        "T_WHSE_SALES_HISTORY_DTL"."CUSTOMER_NBR_STND" "CUSTOMER_NBR_STND" ,
        "T_WHSE_CUST"."NAME" "NAME" ,
        --"T_WHSE_SALES_HISTORY_DTL"."USDS_FLG",
        "T_WHSE_SALES_HISTORY_DTL"."BILLING_DATE" "BILLING_DATE" ,
        sum(CASE WHEN "T_WHSE_SALES_HISTORY_DTL"."ORDER_TYPE" = 'GB'
                                  OR "T_WHSE_SALES_HISTORY_DTL"."PLATFORM_TYPE" = 'LEGACY'
                                  AND "T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD" = 0
                    THEN "T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD"
                    ELSE "T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD" - "T_WHSE_SALES_HISTORY_DTL"."QTY_SCRATCHED" END ) "QTY_SHIPPED" ,
        sum(CASE WHEN "T_WHSE_SALES_HISTORY_DTL"."PLATFORM_TYPE" = 'SWAT'
                    THEN CASE WHEN ("T_WHSE_SALES_HISTORY_DTL"."ORDER_TYPE" = 'GB'
                                         OR "T_WHSE_SALES_HISTORY_DTL"."PLATFORM_TYPE" = 'LEGACY'
                                         AND "T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD" = 0)
                                  THEN "T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD"
                                  ELSE ("T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD" - "T_WHSE_SALES_HISTORY_DTL"."QTY_SCRATCHED") END * "T_WHSE_SALES_HISTORY_DTL"."CASE_CUBE"
                                  ELSE CASE WHEN ("T_WHSE_SALES_HISTORY_DTL"."ORDER_TYPE" = 'GB'
                                         OR "T_WHSE_SALES_HISTORY_DTL"."PLATFORM_TYPE" = 'LEGACY'
                                         AND "T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD" = 0)
                                  THEN "T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD"
                                  ELSE ("T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD" - "T_WHSE_SALES_HISTORY_DTL"."QTY_SCRATCHED") END * "T_WHSE_ITEM"."SHIPPING_CASE_CUBE" END ) "EXT_PRODUCT_CUBE"
FROM
        ("CRMADMIN"."T_WHSE_CUST" "T_WHSE_CUST"
INNER JOIN "CRMADMIN"."V_WHSE_SALES_HISTORY_DTL" "T_WHSE_SALES_HISTORY_DTL" ON
        "T_WHSE_CUST"."FACILITYID" = "T_WHSE_SALES_HISTORY_DTL"."FACILITYID"
       AND "T_WHSE_CUST"."CUSTOMER_NO" = "T_WHSE_SALES_HISTORY_DTL"."CUSTOMER_NO"
        AND "T_WHSE_CUST"."TERRITORY_NO" = "T_WHSE_SALES_HISTORY_DTL"."TERRITORY_NO")
LEFT OUTER JOIN "CRMADMIN"."T_WHSE_ITEM" "T_WHSE_ITEM" ON
        "T_WHSE_SALES_HISTORY_DTL"."FACILITYID" = "T_WHSE_ITEM"."FACILITYID"
        AND "T_WHSE_SALES_HISTORY_DTL"."ITEM_NBR_CD" = "T_WHSE_ITEM"."ITEM_NBR_CD"
WHERE
        "T_WHSE_SALES_HISTORY_DTL"."BILLING_DATE" BETWEEN '2021-04-26' AND '2021-05-22'
      --  AND "T_WHSE_SALES_HISTORY_DTL"."FACILITYID" = '058'
        --AND "T_WHSE_SALES_HISTORY_DTL"."FACILITYID" IN ('003', '008', '015', '040', '058', '086')
        -- AND "T_WHSE_SALES_HISTORY_DTL"."CUSTOMER_NBR_STND" IN ('003103', '003125', '419182', '003435', '036211', '040350', '143102', '029190', '029260', '734228', '095138', '170006', '580057', '634234', '000612', '000622', '000757', '000831', '634055', '634068', '634188', '634240')
        AND RIGHT("T_WHSE_ITEM"."FACILITYID", 2) <> "T_WHSE_ITEM"."STOCK_FAC"
        --AND "T_WHSE_SALES_HISTORY_DTL"."USDS_FLG" = 'D'
        AND "T_WHSE_SALES_HISTORY_DTL"."QTY_SOLD" - "T_WHSE_SALES_HISTORY_DTL"."QTY_SCRATCHED">0
GROUP BY
        "T_WHSE_SALES_HISTORY_DTL"."FACILITYID",
        "T_WHSE_SALES_HISTORY_DTL"."INVOICE_NBR",
       -- "T_WHSE_SALES_HISTORY_DTL"."USDS_FLG",
        "T_WHSE_SALES_HISTORY_DTL"."CUSTOMER_NBR_STND",
        "T_WHSE_CUST"."NAME",
        "T_WHSE_SALES_HISTORY_DTL"."BILLING_DATE" FOR FETCH ONLY
;



--Original SQL:
SELECT   shd.FACILITYID,
         dx.DIV_NAME,
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.CUSTOMER_NBR_STND,
         c.NAME,
         sum(shd.QTY_SOLD - shd.QTY_SCRATCHED) qty_shipped,
         sum(case when shd.FACILITYID = shd.FACILITYID_SHIP then shd.QTY_SOLD - shd.QTY_SCRATCHED else 0 end) qty_shipped_ds,
         sum(case when shd.FACILITYID <> shd.FACILITYID_SHIP then shd.QTY_SOLD - shd.QTY_SCRATCHED else 0 end) qty_shipped_us,
         sum(case when shd.FACILITYID = shd.FACILITYID_SHIP then (shd.QTY_SOLD - shd.QTY_SCRATCHED) * shd.CASE_CUBE  else 0 end) cube_shipped_ds,
         sum(case when shd.FACILITYID <> shd.FACILITYID_SHIP then (shd.QTY_SOLD - shd.QTY_SCRATCHED) * shd.CASE_CUBE else 0 end) cube_shipped_us,
         0 qty_shipped_gm,
         0 cube_shipped_gm
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on shd.FACILITYID = dx.SWAT_ID
         inner join CRMADMIN.V_FISCAL_CALENDAR fc on fc.DATE_KEY = shd.BILLING_DATE
         inner join CRMADMIN.T_WHSE_CUST c on shd.FACILITYID = c.FACILITYID and shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL
WHERE    fc.FISCAL_PERIOD = 202105
AND      (shd.QTY_SOLD - shd.QTY_SCRATCHED) > 0
AND      shd.FACILITYID IN ('003', '008', '015', '040', '058', '086')
and shd.NO_CHRGE_ITM_CDE not in '*'
GROUP BY shd.FACILITYID, dx.DIV_NAME, shd.INVOICE_NBR, shd.BILLING_DATE,
         shd.CUSTOMER_NBR_STND, c.NAME
union all
--must do '054'
SELECT   cf.FACILITYID,
         dx.DIV_NAME,
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.CUSTOMER_NBR_STND,
         c.NAME,
         sum(shd.QTY_SOLD - shd.QTY_SCRATCHED) qty_shipped,
         0 qty_shipped_ds,
         0 qty_shipped_us,
         0 cube_shipped_ds,
         0 cube_shipped_us,
         sum(shd.QTY_SOLD - shd.QTY_SCRATCHED) qty_shipped_gm,
         sum((shd.QTY_SOLD - shd.QTY_SCRATCHED) * shd.CASE_CUBE) cube_shipped_gm
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd
         inner join CRMADMIN.V_FISCAL_CALENDAR fc on fc.DATE_KEY = shd.BILLING_DATE
         inner join CRMADMIN.T_WHSE_CUST c on shd.FACILITYID = c.FACILITYID and shd.CUSTOMER_NO_FULL = c.CUSTOMER_NO_FULL
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC cf on cf.CUSTOMER_NBR_STND = shd.CUSTOMER_NBR_STND and cf.FACILITYID_PRIMARY = 'Y'
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cf.FACILITYID = dx.SWAT_ID
WHERE    fc.FISCAL_PERIOD = 202105
AND      (shd.QTY_SOLD - shd.QTY_SCRATCHED) > 0
AND      shd.FACILITYID = ('054')
and shd.NO_CHRGE_ITM_CDE not in '*'
GROUP BY cf.FACILITYID, dx.DIV_NAME, shd.INVOICE_NBR, shd.BILLING_DATE,
         shd.CUSTOMER_NBR_STND, c.NAME;