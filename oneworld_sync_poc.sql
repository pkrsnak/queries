SELECT   i.FACILITYID,
         v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         i.ROOT_DESC,
         i.ITEM_NBR_HS,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.GTIN,
         i.ITEM_ADDED_DATE,
         i.PURCH_STATUS,
         i.BILLING_STATUS
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.VENDOR_NBR = v.VENDOR_NBR and i.FACILITYID = v.FACILITYID
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      v.MASTER_VENDOR in ('018000' ,'021000' ,'037000' ,'048001' ,'070800')
order by v.MASTER_VENDOR, i.UPC_CASE