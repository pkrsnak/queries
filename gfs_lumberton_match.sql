SELECT   tmpitm.FACILITYID,
         tmpitm.ITEM_NBR,
         itmgr.ITEM_DESCRIP,
         itmgr.PURCH_STATUS,
         itmgr.UPC_CASE,
         itmgr.UPC_UNIT,
         itmgr.MASTER_PACK,
         itmlm.FACILITYID,
         itmlm.ITEM_NBR,
         itmlm.ITEM_DESCRIP,
         itmlm.PURCH_STATUS,
         itmlm.UPC_CASE,
         itmlm.UPC_UNIT,
         itmlm.MASTER_PACK,
         itmlm.INVENTORY_TOTAL
FROM     ETLADMIN.T_TEMP_FAC_ITEM tmpitm 
         inner join crmadmin.T_WHSE_ITEM itmgr on tmpitm.facilityid = itmgr.facilityid and tmpitm.item_nbr = itmgr.item_nbr_hs 
         left join crmadmin.T_WHSE_ITEM itmlm on itmgr.UPC_UNIT = itmlm.UPC_UNIT and itmlm.facilityid = '015' and itmlm.PURCH_STATUS not in ('D','Z')
ORDER BY itmgr.UPC_CASE, itmgr.UPC_UNIT, itmgr.MASTER_PACK
;



--   and itmgr.UPC_CASE = itmlm.UPC_CASE
--   and itmgr.MASTER_PACK = itmlm.MASTER_PACK


--Select tmpitm.FACILITYID, tmpitm.ITEM_NBR, itmgr.ITEM_DESCRIP, itmgr.PURCH_STATUS, itmgr.UPC_CASE, itmgr.UPC_UNIT, itmgr.MASTER_PACK, itmgr.IN_OUT_FLAG,
-- itmlm.FACILITYID, itmlm.ITEM_NBR_HS, itmlm.ITEM_DESCRIP, itmlm.PURCH_STATUS, itmlm.UPC_CASE, itmlm.UPC_UNIT, itmlm.MASTER_PACK, itmlm.IN_OUT_FLAG,
-- itmbe.FACILITYID, itmbe.ITEM_NBR_HS, itmbe.ITEM_DESCRIP, itmbe.PURCH_STATUS, itmbe.UPC_CASE, itmbe.UPC_UNIT, itmbe.MASTER_PACK, itmbe.IN_OUT_FLAG
Select tmpitm.FACILITYID as FACILITYID_GR, tmpitm.ITEM_NBR as ITEM_NBR_HS_GR, itmgr.ITEM_DESCRIP as ITEM_DESCRIP_GR, itmgr.PURCH_STATUS as PURCH_STATUS_GR, itmgr.UPC_CASE as UPC_CASE_GR, itmgr.UPC_UNIT as UPC_UNIT_GR, itmgr.MASTER_PACK as MASTER_PACK_GR, itmgr.IN_OUT_FLAG as IN_OUT_FLAG_GR,
 itmlm.FACILITYID as FACILITYID_LM, itmlm.ITEM_NBR_HS as ITEM_NBR_HS_LM, itmlm.ITEM_DESCRIP as ITEM_DESCRIP_LM, itmlm.PURCH_STATUS as PURCH_STATUS_LM, itmlm.UPC_CASE as UPC_CASE_LM, itmlm.UPC_UNIT as UPC_UNIT_LM, itmlm.MASTER_PACK as MASTER_PACK_LM, itmlm.IN_OUT_FLAG as IN_OUT_FLAG_LM,
 itmbe.FACILITYID as FACILITYID_BE, itmbe.ITEM_NBR_HS as ITEM_NBR_HS_BE, itmbe.ITEM_DESCRIP as ITEM_DESCRIP_BE, itmbe.PURCH_STATUS as PURCH_STATUS_BE, itmbe.UPC_CASE as UPC_CASE_BE, itmbe.UPC_UNIT as UPC_UNIT_BE, itmbe.MASTER_PACK as MASTER_PACK_BE, itmbe.IN_OUT_FLAG as IN_OUT_FLAG_BE
from ETLADMIN.T_TEMP_FAC_ITEM tmpitm
 inner join crmadmin.T_WHSE_ITEM itmgr
  on tmpitm.facilityid = itmgr.facilityid
   and tmpitm.item_nbr = itmgr.item_nbr_hs
 left join crmadmin.T_WHSE_ITEM itmlm
  on itmgr.UPC_UNIT = itmlm.UPC_UNIT
--   and itmgr.UPC_CASE = itmlm.UPC_CASE
--   and itmgr.MASTER_PACK = itmlm.MASTER_PACK
   and itmlm.facilityid = '015'
    and itmlm.PURCH_STATUS not in ('D','Z')
 left join crmadmin.T_WHSE_ITEM itmbe
  on itmgr.UPC_UNIT = itmbe.UPC_UNIT
--   and itmgr.UPC_CASE = itmbe.UPC_CASE
--   and itmgr.MASTER_PACK = itmbe.MASTER_PACK
   and itmbe.facilityid = '071'
    and itmbe.PURCH_STATUS not in ('D','Z')
order by itmgr.UPC_CASE, itmgr.UPC_UNIT, itmgr.MASTER_PACK
;