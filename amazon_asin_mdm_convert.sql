SELECT   ROOT_ITEM_NBR,
         LV_ITEM_NBR,
         UPC_UNIT_CD
FROM     CRMADMIN.T_WHSE_ITEM
WHERE    FACILITYID = '015'
AND      ITEM_NBR_HS = '0289512'
;

select * from CRMADMIN.V_AMZ_ASIN where ROOT_ITEM_NBR like '000001086' and LV_ITEM_NBR = 3;

select * from ETLADMIN.T_TEMP_UPC where UPC_UNIT = '00000024000167297';


SELECT   tu.UPC_UNIT,
         tu.FUTURE_USE,
         asin.ROOT_ITEM_NBR,
         asin.LV_ITEM_NBR,
         asin.LU_CODE
FROM     ETLADMIN.T_TEMP_UPC tu 
         left outer join CRMADMIN.V_AMZ_ASIN asin on tu.FUTURE_USE = asin.LU_CODE
where asin.ROOT_ITEM_NBR is null
;


SELECT   i.ROOT_ITEM_NBR,
         i.LV_ITEM_NBR,
         i.UPC_UNIT_CD,
         i.FACILITYID,
         i.ITEM_NBR_HS, tu.FUTURE_USE asin
FROM     CRMADMIN.T_WHSE_ITEM i inner join ETLADMIN.T_TEMP_UPC tu on i.UPC_UNIT_CD = tu.UPC_UNIT
WHERE    ((i.FACILITYID = '015'
        AND i.ITEM_NBR_HS in ('0289512', '0300145', '0416891'))
     OR  (i.FACILITYID = '040'
        AND i.ITEM_NBR_HS in ('0324350', '1607506', '2613875', '2969129'))
     OR  (i.FACILITYID = '054'
        AND i.ITEM_NBR_HS in ('7404007', '7366727', '7366727', '7404007')))
;


SELECT   tu.UPC_UNIT,
         tu.FUTURE_USE,
         asin.ROOT_ITEM_NBR,
         asin.LV_ITEM_NBR,
         asin.LU_CODE
FROM     ETLADMIN.T_TEMP_UPC tu 
         left outer join CRMADMIN.V_AMZ_ASIN asin on tu.FUTURE_USE = asin.LU_CODE
where asin.ROOT_ITEM_NBR is null
and tu.FUTURE_USE in 
(select asin.future_use from ETLADMIN.T_TEMP_UPC asin where asin.FUTURE_USE in (
select tu.FUTURE_USE--, count(*)
from ETLADMIN.T_TEMP_UPC tu
group by tu.FUTURE_USE 
having count(*) > 1))
;


SELECT   asin.FUTURE_USE asin,
         i.FACILITYID,
         i.ITEM_NBR_HS,
         i.ITEM_DESC,
         i.PACK_CASE,
         i.ITEM_SIZE_DESCRIP,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.UPC_UNIT_CD,
         i.ROOT_ITEM_NBR,
         i.ROOT_DESC,
         i.LV_ITEM_NBR,
         i.LV_DESC
FROM     CRMADMIN.V_WEB_ITEM_CORE i 
         inner join ETLADMIN.T_TEMP_UPC asin on i.UPC_UNIT_CD = asin.UPC_UNIT
WHERE    asin.FUTURE_USE in ( select tu.FUTURE_USE from ETLADMIN.T_TEMP_UPC tu group by tu.FUTURE_USE having count(*) > 1)
;

select * from ETLADMIN.T_TEMP_UPC where FUTURE_USE in (
select tu.FUTURE_USE from ETLADMIN.T_TEMP_UPC tu group by tu.FUTURE_USE having count(*) > 1)
;

