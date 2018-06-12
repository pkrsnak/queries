-- original order query
SELECT   '20' || substr(o.order_id,1,2) || '-' || substr(o.order_id,3,2) || '-' || substr(o.order_id,5,2) order_date,
         '20' || substr(o.order_id,1,2) || '-' || substr(o.order_id,3,2) || '-' || substr(o.order_id,5,2) || ' ' || substr(o.order_id,7,2) || ':' || substr(o.order_id,9,2) order_time,
         char(o.ORDER_ID) as ORDER_ID,
         o.FACILITYID division,
         integer(right(trim(o.CUSTOMER_NO_FULL),6)) STORE_NUMBER,
         case 
              when o.PO_NBR is null then 'N' 
              else 'Y' 
         end as EDI_ORDER,
         sum(oi.QTY) tot_qty
FROM     OMSADMIN.ORDER o 
         inner join OMSADMIN.ORDER_ITEM oi on o.ORDER_ID = oi.ORDER_ID 
         inner join OMSADMIN.CUSTOMER cust on (o.FACILITYID = cust.FACILITYID and o.CUSTOMER_NO_FULL = cust.CUSTOMER_NO_FULL)
WHERE    date(o.SUBMIT_TIME) between (current date - 22 days) and (current date - 1 day)
AND      o.order_type not in ('BK')
AND      o.FACILITYID = '066'
AND      o.STATUS = 'X'
AND      cust.CUST_CORPORATION = 102
GROUP BY o.order_id, o.ORDER_ID, o.FACILITYID, o.CUSTOMER_NO_FULL, 
         o.PO_NBR for read only;

--new order query
SELECT   O.ORDER_RECVD_DTE AS ORDER_DATE,
         O.ORDER_RECVD_DTE || ' ' || SUBSTR(O.ORDER_RECVD_TIME,1,5) AS ORDER_TIME,
         CHAR(O.ORDER_ID) AS ORDER_ID,
         O.FACILITYID AS DIVISION,
         INTEGER(RIGHT(TRIM(O.CUSTOMER_NO_FULL),6)) AS STORE_NUMBER,
         CASE 
              WHEN O.RTL_PO_NUMBER IS NULL THEN 'N' 
              ELSE 'Y' 
         END AS EDI_ORDER,
         SUM(O.QTY) AS TOT_QTY
FROM     CRMADMIN.T_WHSE_ORDER_DTL O 
         INNER JOIN CRMADMIN.T_WHSE_ITEM I ON (O.FACILITYID = I.FACILITYID AND O.ITEM_NBR_HS = I.ITEM_NBR_HS) 
         INNER JOIN CRMADMIN.T_WHSE_CUST CUST ON (O.FACILITYID = CUST.FACILITYID AND O.CUSTOMER_NO_FULL = CUST.CUSTOMER_NO_FULL)
WHERE    O.ORDER_RECVD_DTE BETWEEN (CURRENT DATE - 2 DAYS) AND (CURRENT DATE - 1 DAY)
AND      O.ORDER_TYPE NOT IN ('BK')
AND      O.FACILITYID = '066'
AND      O.ORDER_STATUS = 'A'
AND      CUST.CUST_CORPORATION = 102
AND      o.RTL_ORDER_ID IS NOT NULL
GROUP BY O.ORDER_RECVD_DTE, O.ORDER_RECVD_TIME, O.ORDER_ID, O.FACILITYID, 
         O.CUSTOMER_NO_FULL, O.RTL_PO_NUMBER
ORDER BY o.CUSTOMER_NO_FULL asc FOR READ ONLY;

--billing query
SELECT   sls.FACILITYID FACILITYID,
         sls.ORDER_RECVE_DTE,
         sls.BILLING_DATE BILLING_DATE,
         sls.INVOICE_NBR INVOICE_NBR,
         char(REFERENCE_NBR) REFERENCE_NBR,
         char(sls.PALLET_ID) PALLET_ID,
         sls.CUSTOMER_NO_FULL CUSTOMER_NO_FULL,
         cust.CUST_STORE_NO CUST_STORE_NO,
         cust.NAME NAME,
         cust.ADDRESS3 CITY,
         cust.STATE_CD STATE,
         sls.DELIVERY_DATE DELIVERY_DATE,
         sls.SYS_ASSIGNED_ORD_NBR SYS_ASSIGNED_ORD_NBR,
         case 
              when sls.ORDER_ID = 0 then sls.SYS_ASSIGNED_ORD_NBR 
              Else sls.ORDER_ID 
         end as ORDER_ID,
         sls.ORDER_TYPE ORDER_TYPE,
         case 
              when sls.SUB_ITEM_NBR <> '0000000' and sls.QTY_ORDERED = 0 then sls.SUB_ITEM_NBR 
              else sls.ITEM_NBR_HS 
         end ITEM_NBR_HS,
         fed.TRACK_NBR,
         fed.SHIP_DATE,
         fed.DLVRY_DATE,
         fed.DLVRY_TIME,
         fed.POD_NAME,
         fed.LAST_STATUS_DATE,
         fed.LAST_STATUS_CD || ' - ' || fedc.LAST_STATUS_CODE_DESC as LAST_STATUS_CD,
         fed.LB_PKG_WT,
         sum(case when twi.ISI_INNERPACK_COEF is null then sls.QTY_ORDERED * twi.PACK_CASE else sls.QTY_ORDERED * twi.ISI_INNERPACK_COEF end ) QTY_ORDERED,
         sum(case when twi.ISI_INNERPACK_COEF is null then sls.QTY_SOLD * twi.PACK_CASE else sls.QTY_SOLD * twi.ISI_INNERPACK_COEF end ) QTY_SOLD,
         sum(case when twi.ISI_INNERPACK_COEF is null then sls.QTY_ADJUSTED * twi.PACK_CASE else sls.QTY_ADJUSTED * twi.ISI_INNERPACK_COEF end ) QTY_ADJUSTED,
         sum(case when twi.ISI_INNERPACK_COEF is null then case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.PACK_CASE else case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.ISI_INNERPACK_COEF end ) QTY_SHIPPED,
         sum( case when sls.ORDER_TYPE <> 'BK' Then ( case when twi.ISI_INNERPACK_COEF is null then case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.PACK_CASE else case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.ISI_INNERPACK_COEF end )Else 0 End ) QTY_SHIPPED_REG,
         sum( case when sls.ORDER_TYPE = 'BK' Then ( case when twi.ISI_INNERPACK_COEF is null then case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.PACK_CASE else case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.ISI_INNERPACK_COEF end )Else 0 End ) QTY_SHIPPED_PROMO
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL_EXT sls 
         inner join CRMADMIN.T_WHSE_CUST cust on cust.FACILITYID = sls.FACILITYID and cust.CUSTOMER_NO = sls.CUSTOMER_NO and cust.TERRITORY_NO = sls.TERRITORY_NO 
         inner join CRMADMIN.T_WHSE_CUST_SCHED cshed on cust.FACILITYID = cshed.FACILITYID and cust.CUSTOMER_NBR_STND = cshed.CUSTOMER_NBR_STND 
         inner JOIN CRMADMIN.T_WHSE_DIV_XREF dix on dix.SWAT_ID = sls.FACILITYID and dix.ENTERPRISE_KEY = 1 
         inner join CRMADMIN.T_WHSE_ITEM twi on sls.FACILITYID = twi.FACILITYID and sls.ITEM_NBR_CD = twi.ITEM_NBR_CD 
         left outer join CRMADMIN.V_WHSE_FEDEX_CURRENT fed on sls.TRACK_NBR = fed.TRACK_NBR 
         left outer join CRMADMIN.T_WHSE_FEDEX_STATUS_CODE fedc on fed.FEDEX_CO_CD = fedc.COMPANY_CODE and fed.LAST_STATUS_CD = fedc.LAST_STATUS_CODE
WHERE    
sls.FACILITYID = '066' and 
sls.BILLING_DATE > (current_date -8 DAY)
AND      sls.NO_CHRGE_ITM_CDE <> '*'
AND      sls.CUST_CORP_NBR = 102
AND      sls.ORDER_TYPE not in ('CR')
AND      cust.CUSTOMER_NBR_STND between 730000 and 749000
AND      sls.ORDER_RECVE_DTE between (current_date - 8 DAY) and (current_date - 1 DAY)
AND      case when (cshed.BILL_DATE_SUN = 'Y') then 1 when (cshed.BILL_DATE_MON = 'Y') then 2 when (cshed.BILL_DATE_TUE = 'Y') then 3 when (cshed.BILL_DATE_WED = 'Y') then 4 when (cshed.BILL_DATE_THU = 'Y') then 5 when (cshed.BILL_DATE_FRI = 'Y') then 6 else 7 end = dayofweek(current_date)
GROUP BY sls.FACILITYID, sls.ORDER_RECVE_DTE, sls.BILLING_DATE, 
         sls.INVOICE_NBR, char(REFERENCE_NBR), char(sls.PALLET_ID), 
         sls.CUSTOMER_NO_FULL, cust.CUST_STORE_NO, cust.NAME, cust.ADDRESS3, 
         cust.STATE_CD, sls.DELIVERY_DATE, sls.SYS_ASSIGNED_ORD_NBR, 
         case when sls.ORDER_ID = 0 then sls.SYS_ASSIGNED_ORD_NBR Else sls.ORDER_ID end, 
         sls.ORDER_TYPE, 
         case when sls.SUB_ITEM_NBR <> '0000000' and sls.QTY_ORDERED = 0 then sls.SUB_ITEM_NBR else sls.ITEM_NBR_HS end, 
         fed.TRACK_NBR, fed.SHIP_DATE, fed.DLVRY_DATE, fed.DLVRY_TIME, 
         fed.POD_NAME, fed.LAST_STATUS_DATE, 
         fed.LAST_STATUS_CD || ' - ' || fedc.LAST_STATUS_CODE_DESC, 
         fed.LB_PKG_WT
;


SELECT   sls.FACILITYID FACILITYID,
         sls.ORDER_RECVE_DTE,
         sls.BILLING_DATE BILLING_DATE,
         sls.INVOICE_NBR INVOICE_NBR,char(REFERENCE_NBR) REFERENCE_NBR,
         char(sls.PALLET_ID) PALLET_ID,
         sls.CUSTOMER_NO_FULL CUSTOMER_NO_FULL,
         int(cust.CUST_STORE_NO) CUST_STORE_NO,
         cust.NAME NAME,
         cust.ADDRESS3 CITY,
         cust.STATE_CD STATE,
         sls.DELIVERY_DATE DELIVERY_DATE,
         sls.SYS_ASSIGNED_ORD_NBR SYS_ASSIGNED_ORD_NBR,
         char(case when sls.ORDER_ID = 0 then sls.SYS_ASSIGNED_ORD_NBR Else sls.ORDER_ID end)  as ORDER_ID,
         sls.ORDER_TYPE ORDER_TYPE,
         fed.TRACK_NBR,
         fed.SHIP_DATE,
         fed.DLVRY_DATE,
         fed.DLVRY_TIME,
         fed.POD_NAME,
         fed.LAST_STATUS_DATE,
         fed.LAST_STATUS_CD || ' - ' || fedc.LAST_STATUS_CODE_DESC as LAST_STATUS_CD,
         fed.LB_PKG_WT,
         sum(case when twi.ISI_INNERPACK_COEF is null then sls.QTY_ORDERED * twi.PACK_CASE else sls.QTY_ORDERED * twi.ISI_INNERPACK_COEF end ) QTY_ORDERED,
         sum(case when twi.ISI_INNERPACK_COEF is null then sls.QTY_SOLD * twi.PACK_CASE else sls.QTY_SOLD * twi.ISI_INNERPACK_COEF end ) QTY_SOLD,
         sum(case when twi.ISI_INNERPACK_COEF is null then sls.QTY_ADJUSTED * twi.PACK_CASE else sls.QTY_ADJUSTED * twi.ISI_INNERPACK_COEF end ) QTY_ADJUSTED,
         sum(case when twi.ISI_INNERPACK_COEF is null then case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.PACK_CASE else case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.ISI_INNERPACK_COEF end ) QTY_SHIPPED,
         sum( case when sls.ORDER_TYPE <> 'BK' Then ( case when twi.ISI_INNERPACK_COEF is null then case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.PACK_CASE else case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.ISI_INNERPACK_COEF end )Else 0 End ) QTY_SHIPPED_REG,
         sum( case when sls.ORDER_TYPE = 'BK' Then ( case when twi.ISI_INNERPACK_COEF is null then case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.PACK_CASE else case when (sls.ORDER_TYPE = 'GB' or dix.PLATFORM_TYPE = 'LEGACY' and sls.QTY_SOLD = 0) then sls.QTY_SOLD else (sls.QTY_SOLD - sls.QTY_SCRATCHED) end * twi.ISI_INNERPACK_COEF end )Else 0 End ) QTY_SHIPPED_PROMO
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL_EXT sls 
         inner join CRMADMIN.T_DATE dte on dte.DATE_KEY = sls.BILLING_DATE 
         inner join CRMADMIN.T_WHSE_CUST cust on cust.FACILITYID = sls.FACILITYID and cust.CUSTOMER_NO = sls.CUSTOMER_NO and cust.TERRITORY_NO = sls.TERRITORY_NO 
         inner join CRMADMIN.T_WHSE_CUST_SCHED cshed on cust.FACILITYID = cshed.FACILITYID and cust.CUSTOMER_NBR_STND = cshed.CUSTOMER_NBR_STND 
         inner JOIN CRMADMIN.T_WHSE_DIV_XREF dix on dix.SWAT_ID = sls.FACILITYID and dix.ENTERPRISE_KEY = 1 
         inner join CRMADMIN.T_WHSE_ITEM twi on sls.FACILITYID = twi.FACILITYID and sls.ITEM_NBR_CD = twi.ITEM_NBR_CD 
         left outer join CRMADMIN.V_WHSE_FEDEX_CURRENT fed on sls.TRACK_NBR = fed.TRACK_NBR 
         left outer join CRMADMIN.T_WHSE_FEDEX_STATUS_CODE fedc on fed.FEDEX_CO_CD = fedc.COMPANY_CODE and fed.LAST_STATUS_CD = fedc.LAST_STATUS_CODE
WHERE    
dte.DATE_KEY between (current_date + -(MOD( DAYOFWEEK( current_date ) - 1 + 7 - 7, 7 ) + 1 - 1) DAY) and current_date
AND      sls.NO_CHRGE_ITM_CDE <> '*'
AND      sls.CUST_CORP_NBR = 102
AND      sls.ORDER_TYPE <> 'CR'
AND      cust.CUSTOMER_NBR_STND between 730000 and 749000
GROUP BY sls.FACILITYID, sls.ORDER_RECVE_DTE, sls.BILLING_DATE, 
         sls.INVOICE_NBR,char(REFERENCE_NBR), char(sls.PALLET_ID), sls.CUSTOMER_NO_FULL, 
         cust.CUST_STORE_NO, cust.NAME, cust.ADDRESS3, cust.STATE_CD, 
         sls.DELIVERY_DATE, sls.SYS_ASSIGNED_ORD_NBR, case when sls.ORDER_ID = 0 then sls.SYS_ASSIGNED_ORD_NBR Else sls.ORDER_ID end , 
         sls.ORDER_TYPE, 
         fed.TRACK_NBR, fed.SHIP_DATE, fed.DLVRY_DATE, fed.DLVRY_TIME, 
         fed.POD_NAME, fed.LAST_STATUS_DATE, 
         fed.LAST_STATUS_CD || ' - ' || fedc.LAST_STATUS_CODE_DESC, 
         fed.LB_PKG_WT
;

--published order query
SELECT   O.ORDER_RECVD_DTE AS ORDER_DATE,
         O.ORDER_RECVD_DTE || ' ' || SUBSTR(O.ORDER_RECVD_TIME,1,5) AS ORDER_TIME,
         CHAR(O.ORDER_ID) AS ORDER_ID,
         O.FACILITYID AS DIVISION,
         INTEGER(RIGHT(TRIM(O.CUSTOMER_NO_FULL),6)) AS STORE_NUMBER,
         CASE 
              WHEN O.RTL_PO_NUMBER IS NULL THEN 'N' 
              ELSE 'Y' 
         END AS EDI_ORDER,
         SUM(O.QTY) AS TOT_QTY
FROM     CRMADMIN.T_WHSE_ORDER_DTL O 
         INNER JOIN CRMADMIN.T_WHSE_ITEM I ON (O.FACILITYID = I.FACILITYID AND O.ITEM_NBR_HS = I.ITEM_NBR_HS) 
         INNER JOIN CRMADMIN.T_WHSE_CUST CUST ON (O.FACILITYID = CUST.FACILITYID AND O.CUSTOMER_NO_FULL = CUST.CUSTOMER_NO_FULL)
WHERE    O.ORDER_RECVD_DTE BETWEEN (CURRENT DATE - 2 DAYS) AND (CURRENT DATE - 1 DAY)
AND      O.ORDER_TYPE NOT IN ('BK')
AND      O.FACILITYID = '066'
AND      O.ORDER_STATUS = 'A'
AND      CUST.CUST_CORPORATION = 102
AND      o.RTL_ORDER_ID IS NOT NULL
GROUP BY O.ORDER_RECVD_DTE, O.ORDER_RECVD_TIME, O.ORDER_ID, O.FACILITYID, 
         O.CUSTOMER_NO_FULL, O.RTL_PO_NUMBER
ORDER BY o.CUSTOMER_NO_FULL asc FOR READ ONLY;