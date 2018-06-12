SELECT   ic.codeScheme,
         ic.itemCode,
         ic.dc,
         dci.dcArea,
         ic.dcItemId,
         dci.itemDescription,
         dci.itemPack,
         dci.innerPack,
         dci.itemSize,
         ic.maintGroup
FROM     itemcode ic 
         inner join dcitem dci on ic.dc = dci.dc and ic.dcItemId = dci.dcItemId
WHERE    ic.codescheme <> 'U'
;

--ic.maintGroup ='Z'
--AND      ic.codescheme='G' AND ic.dc = 'C'
--AND      ic.codescheme='I' AND ic.dc = 'B'
--AND      
 --AND ic.dc = 'I'
;


Select * from itemcode where itemcode = '1479' --cross ref in OMS
;

SELECT   item_xref.FACILITYID_FROM,
         item_xref.ITEM_NBR_HS_FROM,
         item.DC_AREA_ID,
         item.ITEM_DESCRIP,
         item.ITEM_PACK,
         item.ITEM_SIZE,
         item.ITEM_STATUS,
         item_xref.FACILITYID_TO,
         item_xref.ITEM_NBR_HS_TO,
         item_xref.MAINT_GROUP_CD,
         item_xref.PRIORITY_CD,
         item_mast.item_descrip,
         item_mast.purch_status,
         item_mast.PACK_CASE,
         item_mast.ITEM_SIZE
FROM     ETLADMIN.T_STAGE_ITEM_OMS item 
         inner join ETLADMIN.T_STAGE_ITEM_OMS_XREF item_xref on (item.FACILITYID = item_xref.FACILITYID_TO and item.ITEM_NBR_HS = item_xref.ITEM_NBR_HS_TO) 
         inner join CRMADMIN.T_WHSE_ITEM item_mast on (item_xref.FACILITYID_FROM = item_mast.FACILITYID and item_xref.ITEM_NBR_HS_FROM = item_mast.ITEM_NBR_HS)
WHERE    item.ITEM_NBR_HS in ('0000182', '0690354');