Select * from CRMADMIN.V_WEB_CUSTOMER_GRP_RTL_PRICE where FACILITYID = '001' and ITEM_NBR_HS = '0438051';

Select * from CRMADMIN.V_WEB_ITEM_CORE where FACILITYID = '001' and ITEM_NBR_HS = '0438051';

Select * from CRMADMIN.V_WEB_ITEM_CORE where UPC_UNIT =  '00000000000004275';

SELECT   Distinct i.UPC_UNIT,
         i.BRAND,
         i.ROOT_DESC,
         i.ROOT_ITEM_NBR,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.MERCH_DEPT
FROM     CRMADMIN.V_WEB_ITEM_CORE i 
;



select facilityid, count(*) from CRMADMIN.V_WEB_ITEM_CORE where PURCH_STATUS = 'D' and BILLING_STATUS = 'D' group by facilityid;




--         inner join CRMADMIN.V_WEB_FACILITY dx on i.FACILITYID = dx.FACILITYID
--WHERE    dx.PROCESS_ACTIVE_FLAG = 'Y'
--AND      i.ROOT_ITEM_NBR is not null
--AND      not(i.MERCH_DEPT = '0000')
--AND      i.purch_status not in ('Z')
--AND      i.BILLING_STATUS not in ('D', 'Z')
--AND      i.PRIMARY_ITEM_FLAG = 'Y'
;

SELECT   Distinct i.UPC_UNIT,
         i.BRAND,
         i.ROOT_DESC,
         i.ROOT_ITEM_NBR,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.MERCH_DEPT
FROM     Table( SELECT b.UPC_UNIT, b.BRAND, max(length(trim(b.ROOT_DESC))) ROOT_LENGTH, b.ROOT_ITEM_NBR, b.ITEM_SIZE, b.ITEM_SIZE_UOM, b.MERCH_DEPT FROM CRMADMIN.V_WEB_ITEM_CORE b where not(b.PURCH_STATUS = 'D' and b.BILLING_STATUS = 'D')  group by b.UPC_UNIT, b.BRAND, b.ROOT_ITEM_NBR, b.ITEM_SIZE, b.ITEM_SIZE_UOM, b.MERCH_DEPT) A 
         join CRMADMIN.V_WEB_ITEM_CORE i on i.UPC_UNIT = A.UPC_UNIT and i.BRAND = a.BRAND and length(trim(i.ROOT_DESC)) = a.ROOT_LENGTH and i.ROOT_ITEM_NBR = a.ROOT_ITEM_NBR and i.ITEM_SIZE = a.ITEM_SIZE and i.ITEM_SIZE_UOM = a.ITEM_SIZE_UOM and i.MERCH_DEPT = a.MERCH_DEPT and not(i.PURCH_STATUS = 'D' and i.BILLING_STATUS = 'D')
--where i.UPC_UNIT = '00000000000004275'
;

Select FACILITYID, ITEM_NBR_HS, ITEM_DESC, UPC_UNIT, BRAND, ROOT_DESC, ROOT_ITEM_NBR, ITEM_SIZE, ITEM_SIZE_UOM, MERCH_DEPT, PURCH_STATUS, BILLING_STATUS
 from CRMADMIN.V_WEB_ITEM_CORE where UPC_UNIT in --  '00000000000004275';
(
select UPC_UNIT from (
SELECT   Distinct i.UPC_UNIT,
         i.BRAND,
         i.ROOT_DESC,
         i.ROOT_ITEM_NBR,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.MERCH_DEPT
FROM     Table( SELECT b.UPC_UNIT, b.BRAND, max(length(trim(b.ROOT_DESC))) long, b.ROOT_ITEM_NBR, b.ITEM_SIZE, b.ITEM_SIZE_UOM, b.MERCH_DEPT FROM CRMADMIN.V_WEB_ITEM_CORE b where not(b.PURCH_STATUS = 'D' and b.BILLING_STATUS = 'D') group by b.UPC_UNIT, b.BRAND, b.ROOT_ITEM_NBR, b.ITEM_SIZE, b.ITEM_SIZE_UOM, b.MERCH_DEPT) A 
         join CRMADMIN.V_WEB_ITEM_CORE i on i.UPC_UNIT = A.UPC_UNIT and i.BRAND = a.BRAND and length(trim(i.ROOT_DESC)) = a.long and i.ROOT_ITEM_NBR = a.ROOT_ITEM_NBR and i.ITEM_SIZE = a.ITEM_SIZE and i.ITEM_SIZE_UOM = a.ITEM_SIZE_UOM and i.MERCH_DEPT = a.MERCH_DEPT and not(i.PURCH_STATUS = 'D' and i.BILLING_STATUS = 'D')
)
group by UPC_UNIT
having count(*) > 1)