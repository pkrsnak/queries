SELECT   corp.CORP_CODE,
         corp.CORP_NAME,
         cust.FACILITYID,
         cust.CUSTOMER_NBR_STND,
         cust.STATUS_CD,
         cust.NAME,
         cust.ADDRESS1,
         cust.ADDRES2,
         cust.ADDRESS3,
         cust.STATE_CD,
         cust.ZIP_CD,
         shd.INVOICE_NBR,
         shd.PO_NBR,
         shd.BILLING_DATE,
         shd.PALLET_ID,
         shd.PALLET_ID_XTREME,
         trxs.TRACKNUM,
         count(*) num_lines
FROM     CRMADMIN.T_WHSE_CORPORATION_MDM corp 
         inner join CRMADMIN.T_WHSE_CUST cust on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND 
         inner join CRMADMIN.T_WHSE_SALES_HISTORY_DTL_EXT shd on cust.FACILITYID = shd.FACILITYID and cust.CUSTOMER_NO_FULL = shd.CUSTOMER_NO_FULL 
         left outer join (SELECT corp.CORP_CODE, corp.CORP_NAME, cust.FACILITYID, cust.CUSTOMER_NBR_STND, cust.STATUS_CD, cust.NAME, cust.ADDRESS1, cust.ADDRES2, cust.ADDRESS3, cust.STATE_CD, cust.STATE_DESCRIPTION, cust.ZIP_CD, trx.PICKTICKET, trx.SHIPDATE, trx.TRACKNUM FROM CRMADMIN.T_WHSE_CORPORATION_MDM corp 
         inner join CRMADMIN.T_WHSE_CUST cust on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND 
         inner join CRMADMIN.T_WHSE_XTREME_HST_TRX trx on cust.FACILITYID = trx.FACILITYID and cust.CUSTOMER_NBR_STND = trx.CUSTOMERNUMBER WHERE corp.CORP_CODE = 880000 AND trx.FACILITYID = '066') trxs on trxs.FACILITYID = shd.FACILITYID and trxs.CUSTOMER_NBR_STND = shd.CUSTOMER_NBR_STND and int(trxs.PICKTICKET) = shd.PALLET_ID
WHERE    corp.CORP_CODE = 880000
AND      shd.FACILITYID = '066'
AND      shd.BILLING_DATE > '2019-01-01'
AND      shd.NO_CHRGE_ITM_CDE <> '*'
AND      shd.INVOICE_NBR in ('7821176' ,'7821183' ,'7820973' ,'7821123' ,'7820942' ,'7821030' ,'7821005' ,'7821014' ,'7820987' ,'7820911' ,'7821140' ,'7821102' ,'7821010' ,'7820966' ,'7820952' ,'7821088' ,'7821037' ,'7821181')
GROUP BY corp.CORP_CODE, corp.CORP_NAME, cust.FACILITYID, 
         cust.CUSTOMER_NBR_STND, cust.STATUS_CD, cust.NAME, cust.ADDRESS1, 
         cust.ADDRES2, cust.ADDRESS3, cust.STATE_CD, cust.STATE_DESCRIPTION, 
         cust.ZIP_CD, shd.INVOICE_NBR, shd.PO_NBR, shd.BILLING_DATE, 
         shd.PALLET_ID, shd.PALLET_ID_XTREME, trxs.TRACKNUM;

SELECT   sales.FACILITYID,
         sales.BILLING_DATE,
         sales.CUSTOMER_NBR_STND,
         sales.INVOICE_NBR,
         sales.PALLET_ID,
         trx.PICKTICKET,
         date(trx.SHIPDATE) as SHIPDATE,
         trx.TRACKNUM
FROM     CRMADMIN.V_WHSE_XTREME_HST_TRX trx 
         inner join CRMADMIN.T_WHSE_SALES_HISTORY_DTL_EXT sales on (trx.FACILITYID = sales.FACILITYID and trx.CUSTOMER_NBR_STND = sales.CUSTOMER_NBR_STND and cast(trx.PICKTICKET as int) = sales.PALLET_ID) 
         inner join crmadmin.T_WHSE_CUST cust on trx.FACILITYID = cust.FACILITYID and trx.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND
WHERE    trx.FACILITYID in ('066', '067')
AND      trx.SHIPDATE >= current date - 365 day
AND      sales.BILLING_DATE >= current date - 365 day
GROUP BY sales.FACILITYID, sales.BILLING_DATE, sales.CUSTOMER_NBR_STND, 
         sales.INVOICE_NBR, sales.PALLET_ID, trx.PICKTICKET, 
         date(trx.SHIPDATE), trx.TRACKNUM
;


SELECT   corp.CORP_CODE,
         corp.CORP_NAME,
         cust.FACILITYID,
         cust.CUSTOMER_NBR_STND,
         cust.STATUS_CD,
         cust.NAME,
         cust.ADDRESS1,
         cust.ADDRES2,
         cust.ADDRESS3,
         cust.STATE_CD,
         cust.STATE_DESCRIPTION,
         cust.ZIP_CD,
         trx.PICKTICKET,
         trx.SHIPDATE,
         trx.TRACKNUM
FROM     CRMADMIN.T_WHSE_CORPORATION_MDM corp 
         inner join CRMADMIN.T_WHSE_CUST cust on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND 
         inner join CRMADMIN.T_WHSE_XTREME_HST_TRX trx on cust.FACILITYID = trx.FACILITYID and cust.CUSTOMER_NBR_STND = trx.CUSTOMERNUMBER
WHERE    corp.CORP_CODE = 880000
AND      trx.FACILITYID = '066'
;


SELECT   *
FROM     crmadmin.V_WHSE_FEDEX_CURRENT
WHERE    FACILITYID = '066';

SELECT   *
FROM     CRMADMIN.T_WHSE_FEDEX
WHERE    TRACK_NBR in ('1ZE1625V4211407296', '1ZE1625V4211406555', '1ZE1625V4211406037', '1ZE1625V4211406822', '1ZE1625V4211407474', '1ZE1625V4211406635', '1ZE1625V4211406939', '1ZE1625V4211406975', '1ZE1625V4211406831', '1ZE1625V4211405949', '1ZE1625V4211405823', '1ZE1625V4211405814', '1ZE1625V4211407116', '1ZE1625V4211406484', '1ZE1625V4211405985', '1ZE1625V4211407134')
AND      CREATE_TIMESTAMP > '2018-09-01'
AND      DLVRY_DATE is not null;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT   corp.CORP_CODE,
         corp.CORP_NAME,
         cust.FACILITYID,
         cust.CUSTOMER_NBR_STND,
         cust.STATUS_CD,
         cust.NAME,
         cust.ADDRESS1,
         cust.ADDRES2,
         cust.ADDRESS3,
         cust.STATE_CD,
         cust.STATE_DESCRIPTION,
         cust.ZIP_CD,
         shd.INVOICE_NBR,
         shd.BILLING_DATE,
         shd.PALLET_ID,
         shd.PALLET_ID_XTREME,
         count(*) num_lines
FROM     CRMADMIN.T_WHSE_CORPORATION_MDM corp 
         inner join CRMADMIN.T_WHSE_CUST cust on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND 
         inner join CRMADMIN.T_WHSE_SALES_HISTORY_DTL_EXT shd on cust.FACILITYID = shd.FACILITYID and cust.CUSTOMER_NO_FULL = shd.CUSTOMER_NO_FULL 
         inner join CRMADMIN.T_WHSE_XTREME_HST_TRX trx on trx.FACILITYID = shd.FACILITYID and trx.CUSTOMERNUMBER = shd.CUSTOMER_NBR_STND and int(trx.PICKTICKET) = shd.PALLET_ID and trx.INVOICENO = shd.INVOICE_NBR
WHERE    corp.CORP_CODE = 880000
AND      shd.BILLING_DATE > '2018-07-01'
AND      shd.NO_CHRGE_ITM_CDE <> '*'
AND      shd.INVOICE_NBR in (5049328, 5179413, 5510280, 5575992, 5643084, 5772398, 5772408, 5772416, 5772426, 5772439, 5772456, 5772490, 5772493, 5772504, 5772510, 5772515, 5772517, 5772518, 5772521, 5840690, 5840709, 5840724, 5840732, 5840803, 5840883, 5840912, 5840919, 5906932, 5906959, 5906962, 5906966, 5907010, 5907033, 5907080, 5907086, 5970460, 5970465, 5970517, 5970527, 5970549, 5970556, 5970564, 5970582, 5970587, 5970589, 5970593, 5970594, 5970665, 6032379, 6035069, 6035082, 6035212, 6035226, 6035236, 6035264, 6035283, 6035303, 6100317, 6100319, 6100332, 6100454, 6100498, 6100502, 6100505, 6168243, 6233276, 6233310, 6233311, 6233329, 6233395, 6233397, 6298689, 6298690, 6298691, 6298692, 6298693, 6298694, 6298695, 6298696, 6298740, 6298741, 6298746, 6298752, 6298806, 6298816, 6298839, 6313111, 6356184, 6356185, 6356190, 6356195, 6356222, 6356249, 6356309, 6356313, 6356342, 6356368, 6356369, 6356388, 6356398, 6356407, 6356430, 6356456, 6431350, 6431408, 6431434, 6431435, 6431445, 6431458, 6431467, 6431468, 6431469, 6431472, 6489083, 6489084, 6489086, 6489093, 6489104, 6489108, 6489118, 6489122, 6489128, 6489129, 6489164, 6489191, 6489234, 6489245, 6553254, 6553255, 6553267, 6553273, 6553276, 6553279, 6553286, 6553304, 6553311, 6553335, 6553342, 6553343, 6553348, 6553350, 6553368, 6553380, 6553385, 6553408, 6553413, 6553420, 6553435, 6553437, 6553440, 6553441, 6553443, 6553449, 6553453, 6553454, 6553455, 6553459, 6583578)
GROUP BY corp.CORP_CODE, corp.CORP_NAME, cust.FACILITYID, 
         cust.CUSTOMER_NBR_STND, cust.STATUS_CD, cust.NAME, cust.ADDRESS1, 
         cust.ADDRES2, cust.ADDRESS3, cust.STATE_CD, cust.STATE_DESCRIPTION, 
         cust.ZIP_CD, shd.INVOICE_NBR, shd.BILLING_DATE, shd.PALLET_ID, 
         shd.PALLET_ID_XTREME
;


SELECT   sales.FACILITYID,
         sales.BILLING_DATE,
         sales.CUSTOMER_NBR_STND,
         sales.INVOICE_NBR,
         sales.PALLET_ID,
         trx.PICKTICKET,
         date(trx.SHIPDATE) as SHIPDATE,
         trx.TRACKNUM
FROM     CRMADMIN.V_WHSE_XTREME_HST_TRX trx 
         inner join CRMADMIN.T_WHSE_SALES_HISTORY_DTL_EXT sales on (trx.FACILITYID = sales.FACILITYID and trx.CUSTOMER_NBR_STND = sales.CUSTOMER_NBR_STND and cast(trx.PICKTICKET as int) = sales.PALLET_ID) 
         inner join crmadmin.T_WHSE_CUST cust on trx.FACILITYID = cust.FACILITYID and trx.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND
WHERE    trx.FACILITYID in ('066', '067')
AND      trx.SHIPDATE >= current date - 365 day
AND      sales.BILLING_DATE >= current date - 365 day
GROUP BY sales.FACILITYID, sales.BILLING_DATE, sales.CUSTOMER_NBR_STND, 
         sales.INVOICE_NBR, sales.PALLET_ID, trx.PICKTICKET, 
         date(trx.SHIPDATE), trx.TRACKNUM;