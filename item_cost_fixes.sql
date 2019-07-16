SELECT   FACILITYID,
         CUSTOMER_NBR_STND,
         ITEM_NBR_HS,
         count(*)
FROM     ETLADMIN.T_STAGE_CUST_ITEM_COST
WHERE    FACILITYID = '005'
GROUP BY FACILITYID, CUSTOMER_NBR_STND, ITEM_NBR_HS
having count(*) > 1;


SELECT   *
FROM     ETLADMIN.T_STAGE_CUST_ITEM_COST
WHERE    FACILITYID = '005'
;


SELECT   FACILITYID,
         CREATE_TIME,
         REC_TYPE_CD,
         CUSTOMER_NBR_STND,
         ITEM_NBR_HS,
         REC_START_DATE,
         REC_END_DATE,
         CREATE_DATE,
         CASE 
              WHEN REC_TYPE_CD = '001' THEN 1 
              WHEN REC_TYPE_CD = '002' THEN 1 
              WHEN REC_TYPE_CD = '005' THEN 1 
              WHEN REC_TYPE_CD = '004' THEN 1 
              WHEN REC_TYPE_CD = '003' THEN 98 
              WHEN REC_TYPE_CD = '007' THEN 99 
              ELSE 1 
         END REC_TYPE_CD_SORT,
         REC_ACTIVE_FLG
FROM     CRMADMIN.T_WHSE_CUST_ITEM_COST
WHERE    (FACILITYID, CUSTOMER_NBR_STND, ITEM_NBR_HS) IN (SELECT FACILITYID, CUSTOMER_NBR_STND, ITEM_NBR_HS FROM ETLADMIN.T_STAGE_CUST_ITEM_COST WHERE FACILITYID = '058')
;



SELECT   cic.FACILITYID,
         cic.CREATE_TIME,
         cic.REC_TYPE_CD,
         cic.CUSTOMER_NBR_STND,
         cic.ITEM_NBR_HS,
         cic.REC_START_DATE,
         cic.REC_END_DATE,
         cic.CREATE_DATE,
         CASE 
              WHEN cic.REC_TYPE_CD = '001' THEN 1 
              WHEN cic.REC_TYPE_CD = '002' THEN 1 
              WHEN cic.REC_TYPE_CD = '005' THEN 1 
              WHEN cic.REC_TYPE_CD = '004' THEN 1 
              WHEN cic.REC_TYPE_CD = '003' THEN 98 
              WHEN cic.REC_TYPE_CD = '007' THEN 99 
              ELSE 1 
         END REC_TYPE_CD_SORT,
         cic.REC_ACTIVE_FLG
FROM     CRMADMIN.T_WHSE_CUST_ITEM_COST cic inner join ETLADMIN.T_STAGE_CUST_ITEM_COST scic on scic.FACILITYID = cic.FACILITYID and scic.CUSTOMER_NBR_STND = cic.CUSTOMER_NBR_STND and scic.ITEM_NBR_HS = cic.ITEM_NBR_HS
where scic.FACILITYID = '058'
; 