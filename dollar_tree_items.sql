SELECT   asin.ROOT_ITEM_NBR,
         asin.LV_ITEM_NBR,
         asin.LU_CODE dtree_item,
         i.ROOT_DESC,
         i.FACILITYID,
         i.ITEM_NBR_HS,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.PURCH_STATUS,
         i.BILLING_STATUS_BACKSCREEN
FROM     CRMADMIN.T_MDM_ITEM_LU_CODE asin 
         inner join crmadmin.T_WHSE_ITEM i on i.ROOT_ITEM_NBR = asin.ROOT_ITEM_NBR and i.LV_ITEM_NBR = asin.LV_ITEM_NBR
WHERE    asin.LU_CODE_TYPE_ID = 902
AND      asin.STATUS_DWH = 'A'
AND      current date between asin.LU_CODE_STARTDATE and asin.LU_CODE_ENDDATE
AND      asin.LU_CODE_STATUS_ID = 1
--AND      i.FACILITYID = '079'
and i.ITEM_NBR_HS = '0840496'