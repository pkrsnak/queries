SELECT   i.FACILITYID,
         bd.DEAL_NBR,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.ITEM_SIZE_DESCRIP,
         i.UPC_CASE,
         bd.DEAL_NBR,
         bd.DATE_START,
         bd.DATE_END,
         bd.AMT_OI,
         bd.AMT_BBACK,
         bd.DATE_ALLOW_EFF,
         bd.DATE_ALLOW_EXP,
         bd.ALLOW_AMT
FROM     CRMADMIN.T_BICEPS_DEAL bd 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = bd.FACILITYID and i.ITEM_NBR_CD = bd.ITEM_NBR
WHERE    (bd.DATE_START <= '2022-09-10'
     AND  bd.DATE_END >= '2022-08-14')
AND      (bd.AMT_OI > 0
     OR  bd.AMT_BBACK > 0)
ORDER BY i.FACILITYID, i.UPC_CASE
;