select * from (
SELECT   ROW_NUMBER() OVER(partition by promo.FACILITYID, promo.ITEM_NBR_HS, promo.REFLECT_ID) row_num,
         promo.FACILITYID,
         promo.REFLECT_ID,
         promo.ITEM_NBR_HS,
         promo.ITEM_DESCRIP,
         promo.REFLECT_START_DATE,
         promo.REFLECT_END_DATE,
         nextdeal.NEXT_REFLECT_ID,
         nextdeal.NEXT_REFLECT_TYPE_CD,
         nextdeal.NEXT_REFLECT_START_DATE,
         nextdeal.NEXT_REFLECT_END_DATE,
         nextdeal.NEXT_REFLECT_AMT
FROM     crmadmin.T_WHSE_PROMO_OFFER promo 
         inner join crmadmin.T_DATE dte on (promo.EVENT_START_DATE = dte.DATE_KEY) 
         left outer join (Select  x.FACILITYID , x.ITEM_NBR_HS, x.REFLECT_ID as NEXT_REFLECT_ID, x.REFLECT_START_DATE AS NEXT_REFLECT_START_DATE, x.REFLECT_END_DATE AS NEXT_REFLECT_END_DATE, x.REFLECT_AMT AS NEXT_REFLECT_AMT, x.REFLECT_TYPE_CD AS NEXT_REFLECT_TYPE_CD
from (SELECT Distinct FACILITYID, ITEM_NBR_HS, REFLECT_ID, REFLECT_START_DATE, REFLECT_END_DATE, REFLECT_AMT, REFLECT_TYPE_CD, COMPANY_WEEK_ID, ACTIVE_FLG, REFLECT_STATUS_CD FROM crmadmin.T_WHSE_PROMO_OFFER WHERE FACILITYID = '001' AND COMPANY_WEEK_ID > 45 AND ACTIVE_FLG = 'Y' AND REFLECT_TYPE_CD <> 'SCAN') x
where x.COMPANY_WEEK_ID > 45  --this is a parameter and the current week in the 12 week loop process is entered.
and x.ACTIVE_FLG = 'Y'
and x.REFLECT_TYPE_CD <> 'SCAN' and x.REFLECT_STATUS_CD <> 'PBCN'
order by x.FACILITYID , x.ITEM_NBR_HS, x.REFLECT_END_DATE ) nextdeal on (promo.facilityid = nextdeal.facilityid and promo.item_nbr_hs = nextdeal.item_nbr_hs and nextdeal.NEXT_REFLECT_END_DATE > promo.REFLECT_END_DATE) -- and nextdeal.ROW_NUM = 1 )
WHERE promo.FACILITYID = '001'
AND promo.ACTIVE_FLG = 'Y'
AND promo.REFLECT_TYPE_CD <> 'SCAN' and REFLECT_STATUS_CD <> 'PBCN'
AND dte.COMPANY_WEEK_ID = 45  --this is a parameter and the current week in the 12 week loop process is entered.
order by promo.FACILITYID, promo.ITEM_NBR_HS, promo.REFLECT_ID, nextdeal.NEXT_REFLECT_END_DATE)
where row_num = 1
;
GROUP BY promo.FACILITYID,
         promo.REFLECT_ID,
         promo.ITEM_NBR_HS,
         promo.ITEM_DESCRIP,
         promo.REFLECT_START_DATE,
         promo.REFLECT_END_DATE,
         nextdeal.NEXT_REFLECT_ID,
         nextdeal.NEXT_REFLECT_TYPE_CD,
         nextdeal.NEXT_REFLECT_START_DATE,
         nextdeal.NEXT_REFLECT_END_DATE,
         nextdeal.NEXT_REFLECT_AMT, nextdeal.ROW_NUM
;

select * from CRMADMIN.T_WHSE_PROMO_OFFER 
where facilityid = '001' 
and item_nbr_hs = '0007021' 
--and AD_WEEK_ID = 201945 
and REFLECT_STATUS_CD <> 'PBCN' 
;


Select ROW_NUMBER() OVER(partition by FACILITYID , ITEM_NBR_HS) row_num , FACILITYID , ITEM_NBR_HS, REFLECT_ID as NEXT_REFLECT_ID, REFLECT_START_DATE AS NEXT_REFLECT_START_DATE, REFLECT_END_DATE AS NEXT_REFLECT_END_DATE, REFLECT_AMT AS NEXT_REFLECT_AMT, REFLECT_TYPE_CD AS NEXT_REFLECT_TYPE_CD
from  (Select distinct FACILITYID , ITEM_NBR_HS, REFLECT_ID, REFLECT_START_DATE, REFLECT_END_DATE, REFLECT_AMT, REFLECT_TYPE_CD from crmadmin.T_WHSE_PROMO_OFFER where FACILITYID = '001' and COMPANY_WEEK_ID > 45 and ACTIVE_FLG = 'Y' and REFLECT_TYPE_CD <> 'SCAN')
where FACILITYID = '001' 
and COMPANY_WEEK_ID > 45  --this is a parameter and the current week in the 12 week loop process is entered.
--and REFLECT_END_DATE > '2019-11-09'   --this is a parameter and the Event End Date is being passed here ***somehow getting the actual reflect date here is needed.
and ACTIVE_FLG = 'Y'
and REFLECT_TYPE_CD <> 'SCAN' 
order by FACILITYID , ITEM_NBR_HS, REFLECT_END_DATE
--Group by FACILITYID , ITEM_NBR_HS 
;

 select offer.FACILITYID, offer.ITEM_NBR_HS, offer.REFLECT_ID as NEXT_REFLECT_ID, offer.REFLECT_START_DATE AS NEXT_REFLECT_START_DATE, offer.REFLECT_END_DATE AS NEXT_REFLECT_END_DATE, offer.REFLECT_AMT AS NEXT_REFLECT_AMT, OFFER.REFLECT_TYPE_CD AS NEXT_REFLECT_TYPE_CD
from crmadmin.T_WHSE_PROMO_OFFER offer
inner join (
Select FACILITYID , ITEM_NBR_HS , min(REFLECT_START_DATE) as NEXT_REFLECT_START_DATE
from crmadmin.T_WHSE_PROMO_OFFER 
where FACILITYID = '001' 
and COMPANY_WEEK_ID > 45  --this is a parameter and the current week in the 12 week loop process is entered.
and REFLECT_END_DATE > '2019-11-09'   --this is a parameter and the Event End Date is being passed here ***somehow getting the actual reflect date here is needed.
and ACTIVE_FLG = 'Y'
and REFLECT_TYPE_CD <> 'SCAN' 
Group by FACILITYID , ITEM_NBR_HS 
) mindate on (offer.FACILITYID = mindate.FACILITYID and offer.ITEM_NBR_HS = mindate.ITEM_NBR_HS and offer.REFLECT_START_DATE = mindate.NEXT_REFLECT_START_DATE) WHERE OFFER.REFLECT_TYPE_CD <>'SCAN' and OFFER.ACTIVE_FLG = 'Y'
;


SELECT ROW_NUMBER() OVER(partition by LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS) row_num, LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_NBR, PO_RECEIPT_DTE, RAND_WGT_CD, lh.SHIPPING_CASE_WEIGHT, fc.FISCAL_WEEK, (case when CORRECT_NET_COST <> 0 then CORRECT_NET_COST else NET_COST_PER_CASE end) layer_cost FROM CRMADMIN.T_WHSE_LAYER_HISTORY lh inner join CRMADMIN.V_FISCAL_CALENDAR fc on lh.LAYER_FILE_DTE = fc.DATE_KEY and lh.LAYER_FILE_DTE between current date - 1  days and current date - 1  days ORDER BY LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_RECEIPT_DTE, PO_NBR


SELECT   ROW_NUMBER() OVER(partition by x.FACILITYID , x.ITEM_NBR_HS) row_num,
         x.FACILITYID,
         x.ITEM_NBR_HS,
         x.REFLECT_ID as NEXT_REFLECT_ID,
         x.REFLECT_START_DATE AS NEXT_REFLECT_START_DATE,
         x.REFLECT_END_DATE AS NEXT_REFLECT_END_DATE,
         x.REFLECT_AMT AS NEXT_REFLECT_AMT,
         x.REFLECT_TYPE_CD AS NEXT_REFLECT_TYPE_CD
FROM     (SELECT Distinct FACILITYID, ITEM_NBR_HS, REFLECT_ID, REFLECT_START_DATE, REFLECT_END_DATE, REFLECT_AMT, REFLECT_TYPE_CD, COMPANY_WEEK_ID, ACTIVE_FLG, REFLECT_STATUS_CD FROM crmadmin.T_WHSE_PROMO_OFFER WHERE FACILITYID = '001' AND COMPANY_WEEK_ID > 45 AND ACTIVE_FLG = 'Y' AND REFLECT_TYPE_CD <> 'SCAN') x
WHERE    x.COMPANY_WEEK_ID > 45
AND      x.ACTIVE_FLG = 'Y'
AND      x.REFLECT_TYPE_CD <> 'SCAN'
AND      x.REFLECT_STATUS_CD <> 'PBCN'
and x.iTEM_NBR_HS = '0017079'
ORDER BY x.FACILITYID, x.ITEM_NBR_HS, x.REFLECT_END_DATE


SELECT   promo.FACILITYID,
         promo.REFLECT_ID,
         promo.ITEM_NBR_HS,
         promo.ITEM_DESCRIP,
         promo.REFLECT_START_DATE,
         promo.REFLECT_END_DATE,
         minbuydate.NEXT_REFLECT_ID,
         minbuydate.NEXT_REFLECT_TYPE_CD,
         minbuydate.NEXT_REFLECT_START_DATE,
         minbuydate.NEXT_REFLECT_END_DATE,
         minbuydate.NEXT_REFLECT_AMT
FROM     crmadmin.T_WHSE_PROMO_OFFER promo 
         inner join crmadmin.T_DATE dte on (promo.EVENT_START_DATE = dte.DATE_KEY) 
         left outer join ( select offer.FACILITYID, offer.ITEM_NBR_HS, offer.REFLECT_ID as NEXT_REFLECT_ID, offer.REFLECT_START_DATE AS NEXT_REFLECT_START_DATE, offer.REFLECT_END_DATE AS NEXT_REFLECT_END_DATE, offer.REFLECT_AMT AS NEXT_REFLECT_AMT, OFFER.REFLECT_TYPE_CD AS NEXT_REFLECT_TYPE_CD
from crmadmin.T_WHSE_PROMO_OFFER offer
inner join (
Select FACILITYID , ITEM_NBR_HS , min(REFLECT_START_DATE) as NEXT_REFLECT_START_DATE
from crmadmin.T_WHSE_PROMO_OFFER 
where FACILITYID = '001' 
and COMPANY_WEEK_ID > 45  --this is a parameter and the current week in the 12 week loop process is entered.
and REFLECT_END_DATE > '2019-11-09'   --this is a parameter and the Event End Date is being passed here ***somehow getting the actual reflect date here is needed.
and ACTIVE_FLG = 'Y'
and REFLECT_TYPE_CD <> 'SCAN' 
Group by FACILITYID , ITEM_NBR_HS 
) mindate on (offer.FACILITYID = mindate.FACILITYID and offer.ITEM_NBR_HS = mindate.ITEM_NBR_HS and offer.REFLECT_START_DATE = mindate.NEXT_REFLECT_START_DATE) WHERE OFFER.REFLECT_TYPE_CD <>'SCAN' and OFFER.ACTIVE_FLG = 'Y' ) minbuydate on (promo.facilityid = minbuydate.facilityid and promo.item_nbr_hs = minbuydate.item_nbr_hs)
WHERE promo.FACILITYID = '001'
AND promo.ACTIVE_FLG = 'Y'
AND promo.REFLECT_TYPE_CD <> 'SCAN'
AND dte.COMPANY_WEEK_ID = 45  --this is a parameter and the current week in the 12 week loop process is entered.
GROUP BY promo.FACILITYID,
         promo.REFLECT_ID,
         promo.ITEM_NBR_HS,
         promo.ITEM_DESCRIP,
         promo.REFLECT_START_DATE,
         promo.REFLECT_END_DATE,
         minbuydate.NEXT_REFLECT_ID,
         minbuydate.NEXT_REFLECT_TYPE_CD,
         minbuydate.NEXT_REFLECT_START_DATE,
         minbuydate.NEXT_REFLECT_END_DATE,
         minbuydate.NEXT_REFLECT_AMT
;

