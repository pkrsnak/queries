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