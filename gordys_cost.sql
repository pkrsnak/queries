SELECT   *
FROM     CRMADMIN.T_WHSE_CUST
WHERE    name like 'GORDY%';


SELECT   c.FACILITYID,
         c.CUSTOMER_NBR_STND,
         c.NAME,
         c.ADDRESS1,
         c.STATE_DESCRIPTION,
         cd.DEPT_CODE,
         d.DEPT_DESCRIPTION,
         cd.SALES_PLAN,
         c.STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST c 
         inner join CRMADMIN.T_WHSE_CUST_DEPT cd on c.FACILITYID = cd.FACILITYID and c.CUSTOMER_NO_FULL = cd.CUSTOMER_NO_FULL 
         inner join CRMADMIN.T_WHSE_DEPT d on cd.DEPT_CODE = d.DEPT_CODE
WHERE    c.CUST_CORPORATION = 30
AND      c.FACILITYID in ('008', '054')
and c.STATUS_CD not in ('D', 'Z')

;