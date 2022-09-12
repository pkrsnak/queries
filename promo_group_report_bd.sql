SELECT   grp.GROUP_CD,
         grp.GROUP_DESC,
         grp.GROUP_TYPE_DESC,
--         ban.BANNER_DESC,
--         grp.CUSTOMER_NBR_STND,
--         cust.NAME,
         max(grp.CREATE_TMSP) max_create_tmsp, 
         max(a.max_end_date) max_end_date
FROM     CRMADMIN.V_WEB_CUSTOMER_GRP grp 
 --        inner join CRMADMIN.V_WEB_CUSTOMER cust on (grp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND) 
 --        left outer join CRMADMIN.T_WHSE_CUST_BANNER ban on (cust.BANNER_ID = ban.BANNER_ID)
         left outer join (SELECT a.ALLOW_CUST_GRP, max(a.ALLOW_DATE_EFF) max_end_date FROM CRMADMIN.T_WHSE_ALLOWANCES a WHERE a.allow_type in ('PA', 'RPA') GROUP BY a.ALLOW_CUST_GRP) a on a.ALLOW_CUST_GRP = grp.GROUP_CD
WHERE    grp.AUDIT_SOURCE_ID = 'MDM'
AND      grp.GROUP_TYPE_CD = 8
AND      grp.ACTIVE = 'Y'
AND      grp.FACILITYID not in ('002', '071')
group by grp.GROUP_CD,
         grp.GROUP_DESC,
         grp.GROUP_TYPE_DESC
--order by 1, 2

union all

SELECT   grp.GROUP_CD,
         grp.GROUP_DESC,
         grp.GROUP_TYPE_DESC,
--         ban.BANNER_DESC,
--         grp.CUSTOMER_NBR_STND,
--         cust.NAME,
         max(grp.CREATE_TMSP) max_create_tmsp, 
         max(a.max_end_date) max_end_date
FROM     CRMADMIN.V_WEB_CUSTOMER_GRP grp 
 --        inner join CRMADMIN.V_WEB_CUSTOMER cust on (grp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND) 
 --        left outer join CRMADMIN.T_WHSE_CUST_BANNER ban on (cust.BANNER_ID = ban.BANNER_ID)
         left outer join (SELECT a.ALLOW_CUST_GRP, max(a.ALLOW_DATE_EFF) max_end_date FROM CRMADMIN.T_WHSE_ALLOWANCES a WHERE a.allow_type in ('PA', 'RPA') GROUP BY a.ALLOW_CUST_GRP) a on a.ALLOW_CUST_GRP = grp.GROUP_CD
WHERE    grp.AUDIT_SOURCE_ID = 'MDM'
AND      grp.GROUP_TYPE_CD = 9
AND      grp.ACTIVE = 'Y'
AND      grp.FACILITYID not in ('002', '071')
group by grp.GROUP_CD,
         grp.GROUP_DESC,
         grp.GROUP_TYPE_DESC
--order by 1, 2
;

SELECT   grp.GROUP_CD,
         grp.GROUP_DESC,
         grp.GROUP_TYPE_DESC,
--         ban.BANNER_DESC,
--         grp.CUSTOMER_NBR_STND,
--         cust.NAME,
         max(grp.CREATE_TMSP) max_create_tmsp
FROM     CRMADMIN.V_WEB_CUSTOMER_GRP grp 
         inner join CRMADMIN.V_WEB_CUSTOMER cust on (grp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND) 
         left outer join CRMADMIN.T_WHSE_CUST_BANNER ban on (cust.BANNER_ID = ban.BANNER_ID)
WHERE    grp.AUDIT_SOURCE_ID = 'MDM'
AND      grp.GROUP_TYPE_CD in (8,9)
AND      grp.ACTIVE = 'Y'
AND      grp.FACILITYID not in ('002', '071')
group by grp.GROUP_CD,
         grp.GROUP_DESC,
         grp.GROUP_TYPE_DESC 
--         ban.BANNER_DESC
;



