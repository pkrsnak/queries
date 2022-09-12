Select FACILITYID, count(*) from CRMADMIN.T_WHSE_EXE_SHIPPING_DTL where  CREATE_DTIM >= '2022-08-01' group by FACILITYID 
;


Select * from CRMADMIN.T_WHSE_EXE_SHIPPING_DTL where  CREATE_DTIM >= '2022-08-01' --group by FACILITYID 
;



--all items each / inner  T_WHSE_ITEM
--180 days of inventory  T_WHSE_LAYER_HISTORY

--orders received, waved, pick (timestamps)   aseld / aassg 
--how many totes shipped (count distinct ASELD where jcsf_id = 'PT', count of items in each tote aka lic_plt_id)


SELECT   i.FACILITYID,
         i.ITEM_DEPT,
         i.MERCH_DEPT_GRP,
         i.MERCH_DEPT_GRP_DESC,
         i.MERCH_DEPT,
         i.MERCH_DEPT_DESC,
         i.MERCH_GRP,
         i.MERCH_GRP_DESC,
         i.MERCH_CAT,
         i.MERCH_CAT_DESC,
         i.MERCH_CLASS,
         i.MERCH_CLASS_DESC,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.PACK_CASE,
         i.MASTER_PACK,
         i.PURCH_STATUS,
         i.BILLING_STATUS_BACKSCREEN
FROM     CRMADMIN.T_WHSE_ITEM i
WHERE    i.FACILITYID = '001'
AND      i.PACK_CASE <> i.MASTER_PACK
AND      i.PURCH_STATUS not in ('D', 'Z')