--midwest
SELECT   wi.BICEPS_DC,
         wi.ITEM_NBR,
         wi.item_dept,
         wi.item_descrip,
         wi.UPC_CASE,
         wi.UPC_UNIT,
         '' as PROMO_ID,
         wi.COMMENT,
         mb1.MSA_CAT_CODE,
         mb1.MSA_STICK_COUNT,
         wi.ON_ORDER_TURN,
         wi.ON_ORDER_PROMOTION,
         wi.ON_ORDER_FWD_BUY,
         wi.INVENTORY_TOTAL,
         wi.PURCH_STATUS,
         wi.BILLING_STATUS,
         wi.LAST_SHIPPED_DATE
FROM     crmadmin.t_whse_item wi 
         join crmadmin.T_STAGE_MW_BKSCR_01 mb1 on wi.ITEM_NBR_CD = mb1.ITEM_NBR_CD and wi.BICEPS_DC = mb1.BICEPS_DC
WHERE    item_dept in ('050', '055', '060')
AND      wi.PURCH_STATUS not in ('D')
--AND      ascii(trim(wi.COMMENT)) > 0
;

--swat
SELECT   sb8.BICEPS_DC,
         sb8.ITEM_NBR,
         wi.item_dept,
         wi.item_descrip,
         wi.UPC_CASE,
         wi.UPC_UNIT,
		 sb8.GMPMID_PROMO_ID,
         sb8.GMPDSC_PROMO_DESC,
         sb8.ISS_08_MSA_CAT_CODE,
         sb8.ISS_08_MSA_STICK_CT,
         wi.ON_ORDER_TURN,
         wi.ON_ORDER_PROMOTION,
         wi.ON_ORDER_FWD_BUY,
         wi.INVENTORY_TOTAL,
         wi.PURCH_STATUS,
         wi.BILLING_STATUS,
         wi.LAST_SHIPPED_DATE
FROM     CRMADMIN.T_STAGE_SWAT_BKSCR_08 sb8 
         join crmadmin.t_whse_item wi on sb8.biceps_dc = wi.biceps_dc and sb8.item_nbr = wi.item_nbr
WHERE    sb8.BICEPS_DC in ('15', '58', '59', '61', '62', '64', '71')
and      item_dept in ('050', '055', '060')
AND      wi.PURCH_STATUS not in ('D')
--AND      (ascii(trim(sb8.GMPMID_PROMO_ID)) > 0
 --OR  ascii(trim(sb8.GMPDSC_PROMO_DESC)) > 0)

