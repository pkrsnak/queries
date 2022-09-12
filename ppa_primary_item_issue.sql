SELECT   b.FACILITYID,
         b.ITEM_NBR_HS,
         b.UPC_UNIT,
         b.PACK_CASE,
         case 
              when b.PRIMARY_ITEM_FLAG = 'Y' then 'Y'
              else 'N'
         end primary_flag,
         case 
              when b.PRESELL_FLG = 'Y' then 'Y' 
              else 'N'
         end presell_flag,
         wic.PURCH_STATUS,
         wic.BILLING_STATUS_BACKSCREEN
FROM     ETLADMIN.V_WEB_ITEM_RETAIL_ORDERABLE_TEST a 
         inner join ETLADMIN.V_WEB_ITEM_RETAIL_ORDERABLE_TEST b on a.FACILITYID = b.FACILITYID and a.UPC_UNIT = b.UPC_UNIT
         inner join CRMADMIN.V_WEB_ITEM_CORE wic on wic.FACILITYID = b.FACILITYID and wic.ITEM_NBR_HS = b.ITEM_NBR_HS and  wic.PURCH_STATUS not in ('X', 'D', 'Z')

inner join 

(select facilityid, UPC_UNIT, count(*) from (
SELECT   b.FACILITYID,
         b.ITEM_NBR_HS,
         b.UPC_UNIT,
         b.PACK_CASE,
         case 
              when b.PRIMARY_ITEM_FLAG = 'Y' then 'Y'
              else 'N'
         end primary_flag,
         case 
              when b.PRESELL_FLG = 'Y' then 'Y' 
              else 'N'
         end presell_flag,
         wic.PURCH_STATUS,
         wic.BILLING_STATUS_BACKSCREEN
FROM     ETLADMIN.V_WEB_ITEM_RETAIL_ORDERABLE_TEST a 
         inner join ETLADMIN.V_WEB_ITEM_RETAIL_ORDERABLE_TEST b on a.FACILITYID = b.FACILITYID and a.UPC_UNIT = b.UPC_UNIT
         inner join CRMADMIN.V_WEB_ITEM_CORE wic on wic.FACILITYID = b.FACILITYID and wic.ITEM_NBR_HS = b.ITEM_NBR_HS and  wic.PURCH_STATUS not in ('X', 'D', 'Z')
WHERE    (a.PRESELL_FLG = 'Y' and a.PRIMARY_ITEM_FLAG = 'Y') 
  
)
group by facilityid, UPC_UNIT having count(*) > 1) c on b.FACILITYID = c.FACILITYID and b.UPC_UNIT = c.UPC_UNIT

WHERE    (a.PRESELL_FLG = 'Y' and a.PRIMARY_ITEM_FLAG = 'Y')
  
;


--------------------------------------------------
-- Create View CRMADMIN.V_WEB_ITEM_RETAIL_ORDERABLE
--------------------------------------------------
CREATE OR REPLACE VIEW ETLADMIN.V_WEB_ITEM_RETAIL_ORDERABLE_TEST    as  




SELECT   
i.FACILITYID,           
i.ITEM_NBR_HS,           
i.UPC_UNIT,           
i.PACK_CASE,           
'Y' MASTER_FLAG,           
i.PRIMARY_ITEM_FLAG,           
case ur.ACTIVE_FLG when 'Y' then 'Y' else 'N' end RECLAIM_FLG,           
case ur.FULL_CASE_FLG when 'Y' then 'Y' else 'N' end RECLAIM_FULL_CASE_FLG,           
i.HANDHELD_STATUS_CD,           
i.INSITE_STATUS_CD, i.PRESELL_FLG  
FROM     CRMADMIN.V_WEB_ITEM_CORE i            
left outer join CRMADMIN.T_WHSE_UPC_RECLAM ur on i.UPC_UNIT = ur.UPC_UNIT and i.FACILITYID = ur.FACILITYID  

union all  

SELECT   
ic.FACILITYID,           
ic.SHIP_ITEM_NBR_HS,           
ic.UPC_UNIT,           
max(ic.RETAIL_PACK) RETAIL_PACK,  --REMOVE------------------------
'N' MASTER_FLAG,           
min(case ic.PRIMARY_ITEM_FLAG when 'Y' then 'Y' else 'N' end) PRIMARY_ITEM_FLAG,  --REMOVE------------------------
case ur.ACTIVE_FLG when 'Y' then 'Y' else 'N' end RECLAIM_FLG,           
case ur.FULL_CASE_FLG when 'Y' then 'Y' else 'N' end RECLAIM_FULL_CASE_FLG,           
ic.HANDHELD_STATUS_CD,           
ic.INSITE_STATUS_CD, ic.PRESELL_FLG  
FROM     CRMADMIN.V_WEB_ITEM_COMPONENT ic            
left outer join CRMADMIN.T_WHSE_UPC_RECLAM ur on ic.UPC_UNIT = ur.UPC_UNIT and ic.FACILITYID = ur.FACILITYID  
where (ic.FACILITYID, ic.SHIP_ITEM_NBR_HS, ic.UPC_UNIT) not in (select FACILITYID, ITEM_NBR_HS, UPC_UNIT from CRMADMIN.T_WHSE_ITEM)  
group by ic.FACILITYID,  --REMOVE------------------------
         ic.SHIP_ITEM_NBR_HS,           
ic.UPC_UNIT,           
'N',           
case ur.ACTIVE_FLG when 'Y' then 'Y' else 'N' end,           
case ur.FULL_CASE_FLG when 'Y' then 'Y' else 'N' end,           
ic.HANDHELD_STATUS_CD,           
ic.INSITE_STATUS_CD,
ic.PRESELL_FLG
;