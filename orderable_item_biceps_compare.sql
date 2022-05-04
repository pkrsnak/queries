

SELECT   bi.FACILITYID,
         bi.ITEM_NBR,
         bi.ITEM_DESCRIPTION,
         bi.STATUS,
         bi.PURCHASING_STATUS_DATE,
         bi.BILLING_STATUS,
         bi.BILLING_STATUS_DATE,
         sum(dsh.SHIPPED_QTY) cases_shipped
FROM     EDL.BICEPS.ITEM bi 
         left join EDL.GRB.ORDERABLE_ITEM oi on bi.ITEM_NBR::integer = oi.ORD_ITEM_CODE::integer
         left join EDW.FD.DC_SALES_HST_VW dsh on bi.FACILITYID = dsh.FACILITY_ID and bi.ITEM_NBR = dsh.ITEM_NBR and dsh.TRANSACTION_DT between current_date() - 365 and current_date()
WHERE    bi.facilityid = '01'
AND      oi.ORD_ITEM_CODE is null
GROUP BY bi.FACILITYID, bi.ITEM_NBR, bi.ITEM_DESCRIPTION, bi.STATUS, 
         bi.PURCHASING_STATUS_DATE, bi.BILLING_STATUS, bi.BILLING_STATUS_DATE
;



SELECT   FACILITYID,
         ITEM_NBR_HS,
         ITEM_DESCRIP,
         PURCH_STATUS,
         PURCH_STATUS_DATE,
         BILLING_STATUS,
         BILLING_STATUS_DATE,
         BILLING_STATUS_BACKSCREEN
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    FACILITYID = '001'
AND      ITEM_NBR_HS = '0872390'
--AND      ITEM_NBR_HS = '0957548'
;



SELECT    BILLING_STATUS_BACKSCREEN, count(*)
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    FACILITYID = '001'
group by BILLING_STATUS_BACKSCREEN
--AND      ITEM_NBR_HS = '0957548'

;



Select * from EDL.GRB.ORDERABLE_ITEM where ORD_ITEM_CODE = 872390;


Select count(*) from EDL.GRB.ORDERABLE_ITEM --where ORD_ITEM_CODE = 872390
;


SELECT   SPTN_CUSTOMER_NBR,
         CUST_TOT_SQFT_MSR,
         CUST_BLDG_SQFT_MSR
FROM     GRB.CUSTOMER
WHERE    (CUST_TOT_SQFT_MSR > 0
     OR  CUST_BLDG_SQFT_MSR > 0)
;


SELECT   c.CUSTOMER_NBR_STND,
         c.SELL_SQFT MDM_SELL_SQFT,
         grbc.CUST_TOT_SQFT_MSR GRB_TOT_SQFT,
         grbc.CUST_SELL_SQFT_MSR GRB_SELL_SQFT
FROM     EDW.FD.CUSTOMER_DIM c 
         left join (SELECT SPTN_CUSTOMER_NBR, CUST_TOT_SQFT_MSR, CUST_SELL_SQFT_MSR FROM EDL.GRB.CUSTOMER WHERE (CUST_TOT_SQFT_MSR > 0 OR CUST_BLDG_SQFT_MSR > 0)) grbc on c.CUSTOMER_NBR_STND = grbc.SPTN_CUSTOMER_NBR
WHERE    grbc.CUST_TOT_SQFT_MSR > 0