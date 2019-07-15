SELECT   i.ROOT_ITEM_NBR,
         i.ROOT_DESC,
         LV_ITEM_NBR,
--         LV_DESC,
         i.FACILITYID,
         i.ITEM_NBR_HS,
--         i.ITEM_DESCRIP,
         i.INVENTORY_TOTAL,
         i.CASES_PER_WEEK,
         i.VENDOR_TIE,
         i.VENDOR_TIER,
         i.WHSE_TIE,
         i.WHSE_TIER,
         i.ORDER_RESTRICT_QTY,  --multiple of 
         i.VENDOR_PALLET_FACTOR,
         i.CYCLE_STOCK,
         case i.VENDOR_PALLET_FACTOR 
              when 'C' then i.CYCLE_STOCK 
              when 'L' then i.WHSE_TIE 
              when 'P' then i.VENDOR_TIE * VENDOR_TIER 
              when 'T' then i.VENDOR_TIE 
              when 'W' then i.WHSE_TIE * WHSE_TIER 
              else 0 
         end MOQ,
         case 
              when i.CASES_PER_WEEK = 0 then 9999999 
              else (i.INVENTORY_TOTAL / i.CASES_PER_WEEK * 7) 
         end days_supply,
         i.SERVICE_LEVEL_CODE
FROM     CRMADMIN.T_WHSE_ITEM i
WHERE    i.PURCH_STATUS in ('A')
--AND      i.FACILITYID = '001'
;

/*
C	Cycle stock
L	whs tie
N	None
P	vendor pallet
T	Vendor tie
U	unit
W	Whs pallet
*/