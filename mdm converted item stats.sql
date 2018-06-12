SELECT   v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         case ic.READY_FOR_CONVERT_FLAG 
              when 'Y' then '2 Recent' 
              when 'N' then '3 Converted' 
              when 'M' then '4 Manual' 
              else '1 Not Converted' 
         end CONVERT_FLAG,
         i.FACILITYID,
         d.DEPT_CODE,
         d.DEPT_DESCRIPTION,
         sum(case i.FACILITYID when '001' then case when trim(i.ROOT_ITEM_NBR) is null then 0 else 1 end else 0 end) gr_converted,
         sum(case i.FACILITYID when '001' then case when trim(i.ROOT_ITEM_NBR) is null then 1 else 0 end else 0 end) gr_unconverted,
         sum(case i.FACILITYID when '001' then 0 else 1 end) non_gr_items
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF div on i.FACILITYID = div.SWAT_ID
         inner join CRMADMIN.T_WHSE_DEPT d on i.ITEM_DEPT = d.DEPT_CODE 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         left outer join ETLADMIN.T_TEMP_MDM_ITEM_CONV_DRIVER ic on v.MASTER_VENDOR = ic.MASTER_VENDOR
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      div.ACTIVE_FLAG = 'Y'
GROUP BY v.MASTER_VENDOR, v.MASTER_VENDOR_DESC, i.FACILITYID, d.DEPT_CODE, 
         d.DEPT_DESCRIPTION, ic.READY_FOR_CONVERT_FLAG
;


select v.master_vendor, count(*) as reccnt
from crmadmin.t_whse_item i
 inner join crmadmin.t_whse_vendor v
  on i.facilityid = v.facilityid
   and i.vendor_nbr = v.vendor_nbr
 inner join etladmin.T_TEMP_MDM_ITEM_CONV_DRIVER drv
  on v.master_vendor = drv.master_vendor
   and drv.READY_FOR_CONVERT_FLAG = 'Y'
where i.PURCH_STATUS not in ('D','Z')
 and (i.facilityid, i.item_nbr) not in (
                                        select facilityid, item_nbr
                                        from crmadmin.t_whse_item
                                        where facilityid = '001'
                                         and PURCH_STATUS not in ('D','Z')
                                         and (XML_DATE_ADDED is not null or XML_DATE_CHANGED is not null))
group by v.master_vendor
;