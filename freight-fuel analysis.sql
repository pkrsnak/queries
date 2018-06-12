--freight-fuel looksee
SELECT   --ACCOUNT,
         substr(CUSTOMER, 1,3) FACILITYID,
         YEAR_ID,
         PERIOD_ID,
         int(substr(CUSTOMER, 6,6)) CUSTOMER_NBR_STD,
         CUSTOMER_NAME,
         LAWSON_DEPT,
         sum(case when account in ('353260 0000', '903100 0000') then AMOUNT else 0 end) fuel,
         sum(case when account in ('386490 0000', '386500 0000') then AMOUNT else 0 end) freight,
         sum(case when account in ('301000 0000', '331000 0000') then AMOUNT else 0 end) sales
FROM     CRMADMIN.T_WHSE_SALES_BY_ACCT
WHERE    ACCOUNT in ('353260 0000', '903100 0000', '386490 0000', '386500 0000', '301000 0000', '331000 0000')
AND     ((YEAR_ID = 2014 AND PERIOD_ID between 12 and 13) 
 or      (YEAR_ID = 2015 AND PERIOD_ID between 1 and 11)) 
AND      AMOUNT <> 0
GROUP BY 
--ACCOUNT, 
substr(CUSTOMER, 1,3), 
PERIOD_ID, 
YEAR_ID, 
int(substr(CUSTOMER, 6,6)), 
CUSTOMER_NAME,
LAWSON_DEPT;


--353260 = Fuel Surcharge Income, 
--903100 = Intra Co Fuel Surcharge, 

--386490 = Customer Freight Fee, 
--386500 = Intra Co Freight - COS 