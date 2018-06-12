SELECT   dtl.FACILITYID,
         dtl.INVOICE_NBR,
         dtl.ITEM_NBR_HS,
         dtl.BILLING_DATE,
         dtl.AD_ALLOW_AMT SALES_RPA_AMT,
         DEAL.RPA_AMT DEAL_RPA_AMT,
         sum(dtl.QTY_SOLD) QTY_SOLD
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL dtl inner join 
         (select FACILITYID, ITEM_NBR, sum(ALLOW_AMT) RPA_AMT from crmadmin.t_whse_deal 
          where AMT_BBACK = 0.0001 
          and DATE_ALLOW_EFF >= BILLING_DATE
          and DATE_ALLOW_EXP <= BILLING_DATE
          group by FACILITYID, ITEM_NBR) DEAL
         on dtl.facilityid = deal.facilityid and dtl.item_nbr_cd = deal.item_nbr
--WHERE    T_WHSE_SALES_HISTORY_DTL.FACILITYID in ('008', '001')
WHERE    dtl.FACILITYID in ('008')
AND      dtl.BILLING_DATE between date('2009-03-01') and date('2009-03-28')
GROUP BY dtl.FACILITYID, 
         dtl.INVOICE_NBR,
         dtl.ITEM_NBR_HS, 
         dtl.BILLING_DATE, 
         dtl.AD_ALLOW_AMT,
         DEAL.RPA_AMT
         FOR FETCH ONLY;
         


SELECT   dtl.FACILITYID,
         dtl.INVOICE_NBR,
         dtl.ITEM_NBR_HS,
         dtl.BILLING_DATE,
         dtl.AD_ALLOW_AMT SALES_RPA_AMT,
         DEAL.RPA_AMT DEAL_RPA_AMT,
         sum(dtl.QTY_SOLD) QTY_SOLD
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL dtl,  table
         (select FACILITYID, ITEM_NBR, sum(ALLOW_AMT) RPA_AMT from crmadmin.t_whse_deal 
          where AMT_BBACK = 0.0001 
          and dtl.BILLING_DATE between DATE_ALLOW_EFF  and DATE_ALLOW_EXP
          group by FACILITYID, ITEM_NBR) as deal
         
--WHERE    T_WHSE_SALES_HISTORY_DTL.FACILITYID in ('008', '001')
WHERE    dtl.FACILITYID in ('008')
AND      dtl.BILLING_DATE between date('2009-03-01') and date('2009-03-28')
AND      dtl.facilityid = deal.facilityid 
and      dtl.item_nbr_cd = deal.item_nbr
GROUP BY dtl.FACILITYID, 
         dtl.INVOICE_NBR,
         dtl.ITEM_NBR_HS, 
         dtl.BILLING_DATE, 
         dtl.AD_ALLOW_AMT,
         DEAL.RPA_AMT
         FOR FETCH ONLY;



select FACILITYID, ITEM_NBR,STATUS, sum(ALLOW_AMT) rpa_amt
  from crmadmin.t_whse_deal 
 where AMT_BBACK = 0.0001 
   and '2009-03-02' between DATE_ALLOW_EFF and DATE_ALLOW_EXP
--   and DATE_ALLOW_EFF <= '2008-03-02' 
--   AND ITEM_NBR='0100446'
   and FACILITYID in ('001')
   group by FACILITYID, ITEM_NBR,STATUS;


select FACILITYID , BILLING_DATE , ITEM_NBR_HS , QTY_SOLD, AD_ALLOW_AMT
  from CRMADMIN.T_WHSE_SALES_HISTORY_DTL
 where FACILITYID = '001'
   and billing_date between '2009-03-01' and '2009-03-02'
   and TERRITORY_NO <> 14
   and ITEM_NBR_HS not in ('0000000');
   
   
SELECT FACILITYID, ITEM_NBR, min(DATE_ALLOW_EFF), SUM(ALLOW_AMT) AS ALLOW_AMT
   FROM CRMADMIN.T_WHSE_DEAL 
WHERE AMT_BBACK = 0.0001 
      AND STATUS = 'A' 
      AND FACILITYID='001'
      AND ITEM_NBR='0100446'
      AND '2009-03-02'  between DATE_ALLOW_EFF and DATE_ALLOW_EXP
GROUP BY FACILITYID, ITEM_NBR;   


