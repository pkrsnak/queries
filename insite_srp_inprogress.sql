
SELECT   cd.FACILITYID,
         cd.CUSTOMER_NBR_STND,
         cd.STATUS, cd.HOME_SRP_ZONE_HS
FROM     CRMADMIN.T_WHSE_CUST_DEPT cd
where cd.HOME_SRP_ZONE_HS <> '0'
;


SELECT   custdpt.FACILITYID,
         custdpt.DEPT_CODE,
         custdpt.CUSTOMER_NO_FULL,
         custdpt.STATUS,
         custdpt.SALES_PLAN,
         custdpt.HOME_SRP_ZONE_HS,
         itm.ITEM_NBR_HS,
         itm.ITEM_DESCRIP,
         itm.PURCH_STATUS,
         itm.BILLING_STATUS,
         itm.ITEM_DEPT,
         itm.MERCH_DEPT,
         upc.ITEM_NBR_HS,
         upc.UPC_UNIT,
         upc.SRP_START_DATE,
         upc.SRP,
         upc.CUST_GROUP_NBR
FROM     CRMADMIN.T_WHSE_CUST_DEPT custdpt 
         inner join CRMADMIN.T_WHSE_ITEM itm on (custdpt.FACILITYID = itm.FACILITYID and custdpt.DEPT_CODE = right(itm.MERCH_DEPT,3)) 
         inner join CRMADMIN.T_WHSE_SRP_UPC upc on (itm.FACILITYID = upc.FACILITYID and itm.ITEM_NBR_HS = upc.ITEM_NBR_HS and custdpt.HOME_SRP_ZONE_HS = upc.CUST_GROUP_NBR)
WHERE    custdpt.FACILITYID = '001'
AND      custdpt.CUSTOMER_NO_FULL = '13001021'
AND      itm.PURCH_STATUS <> 'Z'
AND      itm.ITEM_DEPT = '020';
;



SELECT   cd.FACILITYID,
         cd.CUSTOMER_NO,
         cd.DEPT_CODE,
         cd.CUSTOMER_NO_FULL,
--         cd.STATUS,
--         cd.PRIVATE_SRP_ZONE,
--         cd.HOME_SRP_ZONE_HS,
         case 
              when cd.PRIVATE_SRP_ZONE = 0 then cd.HOME_SRP_ZONE_HS 
              else char(cd.PRIVATE_SRP_ZONE) 
         end as ZONE_HS
FROM     CRMADMIN.T_WHSE_CUST_DEPT cd 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on cd.FACILITYID = dx.SWAT_ID
WHERE    cd.FACILITYID = '001'
AND      dx.ACTIVE_FLAG = 'Y'; 