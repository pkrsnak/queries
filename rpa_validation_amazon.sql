--by customer
SELECT   shd.FACILITYID,
         d.COMPANY_YEAR_ID,
         d.COMPANY_WEEK_ID,
         shd.CUSTOMER_NO_FULL,
         case shd.ITEM_DEPT_HS 
              when '016' then 'GMS' 
              when '017' then 'GMS' 
              when '066' then 'GMS' 
              when '067' then 'GMS' 
              else 'NORMAL' 
         end as EXCPTN_ITEMS,
         shd.VEND_RPA,
         count(*) num_records,
         sum(shd.VEND_RPA_AMT_EXT)
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.T_DATE d on shd.BILLING_DATE = d.DATE_KEY
WHERE    shd.BILLING_DATE > '2016-01-01'
AND      shd.CUST_CORP_NBR = '875'
GROUP BY shd.FACILITYID, d.COMPANY_YEAR_ID, d.COMPANY_WEEK_ID, 
         shd.CUSTOMER_NO_FULL, 
         case shd.ITEM_DEPT_HS when '016' then 'GMS' when '017' then 'GMS' when '066' then 'GMS' when '067' then 'GMS' else 'NORMAL' end, 
         shd.VEND_RPA
HAVING   sum(shd.VEND_RPA_AMT_EXT) <> 0
;


--by item
SELECT   shd.FACILITYID, shd.ITEM_NBR_HS, shd.ITEM_DESCRIPTION,
         d.COMPANY_YEAR_ID,
         d.COMPANY_WEEK_ID,
--         shd.CUSTOMER_NO_FULL,
         case shd.ITEM_DEPT_HS 
              when '016' then 'GMS' 
              when '017' then 'GMS' 
              when '066' then 'GMS' 
              when '067' then 'GMS' 
              else 'NORMAL' 
         end as EXCPTN_ITEMS,
         shd.VEND_RPA,
         count(*) num_records,
         sum(shd.VEND_RPA_AMT_EXT)
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join CRMADMIN.T_DATE d on shd.BILLING_DATE = d.DATE_KEY
WHERE    shd.BILLING_DATE > '2016-01-01'
AND      shd.CUST_CORP_NBR = '875'
GROUP BY shd.FACILITYID, shd.ITEM_NBR_HS, shd.ITEM_DESCRIPTION, d.COMPANY_YEAR_ID, d.COMPANY_WEEK_ID, 
--         shd.CUSTOMER_NO_FULL, 
         case shd.ITEM_DEPT_HS when '016' then 'GMS' when '017' then 'GMS' when '066' then 'GMS' when '067' then 'GMS' else 'NORMAL' end, 
         shd.VEND_RPA
HAVING   sum(shd.VEND_RPA_AMT_EXT) <> 0
;



--customer exceptions
SELECT   c.FACILITYID, c.CUSTOMER_NO_FULL , c.CUSTOMER_NBR_STND , c.NAME, e.RPA_TYPE , c.STATUS_CD
FROM     CRMADMIN.T_WHSE_CUST c 
         left outer join ETLADMIN.T_RPA_EXCEPTIONS e on  c.CUSTOMER_NBR_STND = e.CUSTOMER_NO_FULL and e.STATUS = 'A'
where c.CUST_CORPORATION = 875
;

