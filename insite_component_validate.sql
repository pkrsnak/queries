/*
Steve Schoon Remember that blueberry order cd 0363-234 with a pseudo and a bunch of upc’s attached?

[8:16 AM]  
Similar ordercd 0002-014 that I think should have a bunch of upc’s attached but I can’t find them

[8:23 AM]  
Steve Schoon it’s also a blueberry item

[8:30 AM]  
Patrick Krsnak I have an orderable and retail orderable item for the blueberry itself, but no components...

[8:30 AM]  
Steve Schoon i’m digging out the data on legacy sharp to show you

[8:40 AM]  
Steve Schoon so i if query OrdItem/OrdRetailItem/RetailItem all together, for upc 00003338322228, in legacy sharp it’s orderable on 3 diff order cds: 056119, 002014, 492751, but in new sharp its only orderable on 492751
*/

Select * from CRMADMIN.V_WEB_ITEM_RETAIL where UPC_UNIT = '00000049007462890';

Select * from CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE where UPC_UNIT = '00000049007462890';

Select * from CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE where  ITEM_NBR_HS = '0002014' and  FACILITYID = '001';

Select * from CRMADMIN.T_WHSE_ITEM where UPC_UNIT = '00000004900746289';

Select * from CRMADMIN.T_WHSE_ITEM where ITEM_NBR_HS = '0746289' and  FACILITYID = '001' ;

SELECT   FACILITYID, SOURCE , count(*)
FROM     CRMADMIN.T_WHSE_SHIPPER_CMPNTS
group by FACILITYID, SOURCE
;

SELECT   *
FROM     CRMADMIN.T_WHSE_SHIPPER_CMPNTS
where SHIP_ITEM_NBR_HS = '0002014' and facilityid = '001'
--where SOURCE = 'GRMF'
;


SELECT   *
FROM     CRMADMIN.V_WEB_ITEM_COMPONENT
where SHIP_ITEM_NBR_HS = '0002014' and facilityid = '001'
;

SELECT   *
FROM     CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE
WHERE    ITEM_NBR_HS in ('0949057', '0363234')
AND      FACILITYID = '001'
;