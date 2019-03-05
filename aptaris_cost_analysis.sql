SELECT   mstr.FACILITYID as Facility_Code,
         div.DIV_NAME Facility_Desc,
         '' as Orderable_Item_Key,
         mstr.COMMODITY_XREF as Commodity_Key,
         mstr.ITEM_NBR_HS AS Ord_Item_Code,
         mstr.SHIP_UNIT_CD as Ship_Unit_Cd,
         mstr.ITEM_SIZE_DESCRIP as Size_Msr,
         mstr.ITEM_DESC as Orderable_Item_Dsc,
         mstr.PACK_CASE as Item_Pack_Qty,
         'Y' as Mf_Master_Flg,
         mstr.PSEUDO as Pseudo_Upc_Nbr,
         mstr.UPC_UNIT as Unit_Upc,
         mstr.BRAND as Item_Brand_Desc,
         mstr.RETAIL_ITEM_DESC as Retail_Item_Dsc,
         mstr.ITEM_SIZE as Size_Msr2,
         mstr.ITEM_SIZE_UOM as Size_Uom_Cd,
         mstr.LIST_COST as Cost
FROM     CRMADMIN.V_WEB_ITEM_CORE mstr 
         inner join CRMADMIN.T_WHSE_DIV_XREF div on (mstr.FACILITYID = div.SWAT_ID) 
WHERE    mstr.ROOT_ITEM_NBR in ('000046812', '000061513', '000615436', '000638496', '000646921', '000650385', '000667033', '000674478', '000685911', '000693570', '000697400', '000708705', '000034561', '000039755', '000506774', '000577414', '000632894', '000644915', '000652298' )
union all
SELECT   cmpt.FACILITYID as Facility_Code,
         div.DIV_NAME Facility_Desc,
         '' as Orderable_Item_Key,
         itm.COMMODITY_XREF as Commodity_Key,
         cmpt.SHIP_ITEM_NBR_HS AS Ord_Item_Code,
         itm.ship_unit_cd as Ship_Unit_Cd,
         cmpt.COMP_SIZE || '' || cmpt.COMP_UOM as Size_Msr,
         cmpt.COMP_DESC as Orderable_Item_Dsc,
         cmpt.QTY_IN_SHIPPER as Item_Pack_Qty,
         'N' as Mf_Master_Flg,
         '' as Pseudo_Upc_Nbr,
         cmpt.COMP_UPC_UNIT as Unit_Upc,
         itm.BRAND as Item_Brand_Desc,
         cmpt.COMP_DESC as Retail_Item_Dsc,
         cmpt.COMP_SIZE as Size_Msr2,
         cmpt.COMP_UOM as Size_Uom_Cd,
         cmpt.CUR_UCOST_0 as Cost
FROM     CRMADMIN.T_WHSE_SHIPPER_CMPNTS cmpt 
         inner join CRMADMIN.T_WHSE_DIV_XREF div on (cmpt.FACILITYID = div.SWAT_ID) 
         inner join CRMADMIN.T_WHSE_ITEM itm on (cmpt.FACILITYID = itm.FACILITYID and cmpt.SHIP_ITEM_NBR_HS = itm.ITEM_NBR_HS)
WHERE    itm.ROOT_ITEM_NBR in ('000046812', '000061513', '000615436', '000638496', '000646921', '000650385', '000667033', '000674478', '000685911', '000693570', '000697400', '000708705', '000034561', '000039755', '000506774', '000577414', '000632894', '000644915', '000652298' )
;



WHERE    1=1
AND      ((cmpt.FACILITYID = '001'
     AND cmpt.SHIP_ITEM_NBR_HS in ('0405449' ,'0751347' ,'0282665' ,'0160556' ,'0102939' ,'0849570' ,'0612606' ,'0610725' ,'0418152' ,'0418954' ,'0419697' ,'0109769' ,'0492751' ,'0701680' ,'0343673' ,'0339564' ,'0369306' ,'0389130' ,'0347310' ,'0418160' ,'0524371' ))
OR       (cmpt.FACILITYID = '003'
     AND cmpt.SHIP_ITEM_NBR_HS in ('0058495', '0000877', '0165555', '0423541', '0000893'))
OR       (cmpt.FACILITYID = '005'
     AND cmpt.SHIP_ITEM_NBR_HS in ('0165555', '0000893', '0423541', '0000877'))
OR       (cmpt.FACILITYID = '008'
     AND cmpt.SHIP_ITEM_NBR_HS in ('0000893', '0058495', '0165555', '0423541', '0000877'))
OR       (cmpt.FACILITYID = '015'
     AND cmpt.SHIP_ITEM_NBR_HS in ('0222760', '0114967', '0011817', '0011825', '0011833'))
OR       (cmpt.FACILITYID = '040'
     AND cmpt.SHIP_ITEM_NBR_HS in ('0000893', '0165555', '0423541', '0058495', '0000877'))
OR       (cmpt.FACILITYID = '058'
     AND cmpt.SHIP_ITEM_NBR_HS in ('0910364', '0123182'))
OR       (cmpt.FACILITYID = '061'
     AND cmpt.SHIP_ITEM_NBR_HS in ('0036668')))
;


MINOT


ST CLOUD


LUMBERTON


OMAHA


LIMA


BLUEFIELD


