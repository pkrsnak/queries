--#of items with Purch status ="D" and Billing status <> "D" ( Shows the items with status  out of sync )
--@
SELECT   c.BICEPS_DC,
         i.ITEM_DEPT,
         c.ITEM_NBR_HS,
         c.ISC_SHIPPER_UPC,
         i.MASTER_PACK,
         i.PACK_CASE,
         c.ISC_UPC,
         c.ISC_PACK
FROM     CRMADMIN.T_STAGE_BKSCR_SHIPPER c 
         inner join CRMADMIN.T_WHSE_ITEM i on c.BICEPS_DC = i.BICEPS_DC and c.ITEM_NBR_HS = i.ITEM_NBR_HS
where not(i.FACILITYID = '001' and i.PURCH_STATUS in ('D', 'Z'))
and c.ISC_XML_DATE_DELETED is null
