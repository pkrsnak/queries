
with
reg as 
(SELECT  c.FACILITYID,
         c.CUST_CORPORATION,
         c.CUST_STORE_NO,
         c.CUSTOMER_NBR_CORP,
         c.CUSTOMER_NBR_STND,
         c.NAME,
         c.ADDRESS1,
         c.ADDRES2,
	     c.ADDRESS3,
         c.STATE_CD,
         cc.STATE_DESC,
         cc.STATE_SALES_TAX_FLAG,
         cc.STATE_EXCISE_TAX_FLAG,
         cc.STATE_STAMP_TAX_FLAG,
         c.COUNTY_CD,
         cc.COUNTY_DESC,
         cc.COUNTY_SALES_TAX_FLAG,
         cc.COUNTY_EXCISE_TAX_FLAG,
         cc.COUNTY_STAMP_TAX_FLAG,
         c.CITY_CD,
         cc.CITY_DESC,
         cc.CITY_SALES_TAX_FLAG,
         cc.CITY_EXCISE_TAX_FLAG,
         cc.CITY_STAMP_TAX_FLAG,
         cc.TAXING_ENTITY1,
         cc.TAXENT1_STAMP_TAX_FLAG,
         cc.TAXENT1_EXCISE_TAX_FLAG,
         cc.TAXENT1_USE_TAX_FLAG,
         cc.TAXING_ENTITY2,
         cc.TAXENT2_STAMP_TAX_FLAG,
         cc.TAXENT2_EXCISE_TAX_FLAG,
         cc.TAXENT2_USE_TAX_FLAG,
         cc.TAXING_ENTITY3,
         cc.TAXENT3_STAMP_TAX_FLAG,
         cc.TAXENT3_EXCISE_TAX_FLAG,
         cc.TAXENT3_USE_TAX_FLAG
FROM     CRMADMIN.T_WHSE_CUST c 
         inner join CRMADMIN.V_WHSE_CUST_TAX_CLASS cc on c.FACILITYID = cc.FACILITYID and c.CUSTOMER_NBR_CORP = cc.CUSTOMER_NBR_CORP
WHERE    c.CUST_CORPORATION = '102' and c.STATUS_CD not in ('D', 'Z') and c.CUST_STORE_NO is not null
AND      (cc.COUNTY_DESC <> '' or cc.COUNTY_DESC is null)
GROUP BY c.FACILITYID, c.CUST_CORPORATION, c.CUST_STORE_NO, c.CUSTOMER_NBR_CORP,c.CUSTOMER_NBR_STND, c.NAME,c.ADDRESS1,
         c.ADDRES2, c.ADDRESS3, 
         c.STATE_CD, cc.STATE_DESC, cc.STATE_SALES_TAX_FLAG, 
         cc.STATE_EXCISE_TAX_FLAG, cc.STATE_STAMP_TAX_FLAG, c.COUNTY_CD, 
         cc.COUNTY_DESC, cc.COUNTY_SALES_TAX_FLAG, cc.COUNTY_EXCISE_TAX_FLAG, 
         cc.COUNTY_STAMP_TAX_FLAG, c.CITY_CD, cc.CITY_DESC, 
         cc.CITY_SALES_TAX_FLAG, cc.CITY_EXCISE_TAX_FLAG, 
         cc.CITY_STAMP_TAX_FLAG, cc.TAXING_ENTITY1, cc.TAXENT1_STAMP_TAX_FLAG, 
         cc.TAXENT1_EXCISE_TAX_FLAG, cc.TAXENT1_USE_TAX_FLAG, 
         cc.TAXING_ENTITY2, cc.TAXENT2_STAMP_TAX_FLAG, 
         cc.TAXENT2_EXCISE_TAX_FLAG, cc.TAXENT2_USE_TAX_FLAG, 
         cc.TAXING_ENTITY3, cc.TAXENT3_STAMP_TAX_FLAG, 
         cc.TAXENT3_EXCISE_TAX_FLAG, cc.TAXENT3_USE_TAX_FLAG
ORDER BY c.FACILITYID, c.CUST_CORPORATION, c.CUSTOMER_NBR_CORP, c.NAME, 
         c.STATE_CD, cc.STATE_DESC, cc.COUNTY_DESC asc, cc.CITY_DESC asc
),
 spl as (
SELECT   c.FACILITYID,
         c.CUST_CORPORATION,
         c.CUSTOMER_NBR_CORP,
         c.NAME,
         c.STATE_CD,
         cc.STATE_DESC,
         cc.STATE_SALES_TAX_FLAG,
         cc.STATE_EXCISE_TAX_FLAG,
         cc.STATE_STAMP_TAX_FLAG,
         c.COUNTY_CD,
         cc.COUNTY_DESC,
         cc.COUNTY_SALES_TAX_FLAG,
         cc.COUNTY_EXCISE_TAX_FLAG,
         cc.COUNTY_STAMP_TAX_FLAG,
         c.CITY_CD,
         cc.CITY_DESC,
         cc.CITY_SALES_TAX_FLAG,
         cc.CITY_EXCISE_TAX_FLAG,
         cc.CITY_STAMP_TAX_FLAG,
         cc.TAXING_ENTITY1,
         cc.TAXENT1_STAMP_TAX_FLAG,
         cc.TAXENT1_EXCISE_TAX_FLAG,
         cc.TAXENT1_USE_TAX_FLAG,
         cc.TAXING_ENTITY2,
         cc.TAXENT2_STAMP_TAX_FLAG,
         cc.TAXENT2_EXCISE_TAX_FLAG,
         cc.TAXENT2_USE_TAX_FLAG,
         cc.TAXING_ENTITY3,
         cc.TAXENT3_STAMP_TAX_FLAG,
         cc.TAXENT3_EXCISE_TAX_FLAG,
         cc.TAXENT3_USE_TAX_FLAG
FROM     CRMADMIN.T_WHSE_CUST c 
         inner join CRMADMIN.V_WHSE_CUST_TAX_CLASS cc on c.FACILITYID = cc.FACILITYID and c.CUSTOMER_NBR_CORP = cc.CUSTOMER_NBR_CORP
WHERE    c.CUST_CORPORATION = '102'
AND      cc.COUNTY_DESC = ''
GROUP BY c.FACILITYID, c.CUST_CORPORATION, c.CUSTOMER_NBR_CORP, c.NAME, 
         c.STATE_CD, cc.STATE_DESC, cc.STATE_SALES_TAX_FLAG, 
         cc.STATE_EXCISE_TAX_FLAG, cc.STATE_STAMP_TAX_FLAG, c.COUNTY_CD, 
         cc.COUNTY_DESC, cc.COUNTY_SALES_TAX_FLAG, cc.COUNTY_EXCISE_TAX_FLAG, 
         cc.COUNTY_STAMP_TAX_FLAG, c.CITY_CD, cc.CITY_DESC, 
         cc.CITY_SALES_TAX_FLAG, cc.CITY_EXCISE_TAX_FLAG, 
         cc.CITY_STAMP_TAX_FLAG, cc.TAXING_ENTITY1, cc.TAXENT1_STAMP_TAX_FLAG, 
         cc.TAXENT1_EXCISE_TAX_FLAG, cc.TAXENT1_USE_TAX_FLAG, 
         cc.TAXING_ENTITY2, cc.TAXENT2_STAMP_TAX_FLAG, 
         cc.TAXENT2_EXCISE_TAX_FLAG, cc.TAXENT2_USE_TAX_FLAG, 
         cc.TAXING_ENTITY3, cc.TAXENT3_STAMP_TAX_FLAG, 
         cc.TAXENT3_EXCISE_TAX_FLAG, cc.TAXENT3_USE_TAX_FLAG
ORDER BY c.FACILITYID, c.CUST_CORPORATION, c.CUSTOMER_NBR_CORP, c.NAME, 
         c.STATE_CD, cc.STATE_DESC, cc.COUNTY_DESC asc, cc.CITY_DESC asc
)

SELECT   case reg.FACILITYID when '015' then 'LUMBERTON - 015' when '040' then 'OMAHA - 040' when '058' then 'BELLEFONTAINE (LIMA) - 058' else 'BELLEFONTAINE - 066' end FAC_SERVICED_BY,
         reg.FACILITYID,
--         reg.CUST_CORPORATION,
         int(reg.CUST_STORE_NO) as dg_store_no,
         reg.CUSTOMER_NBR_STND nf_store_no,
--         reg.CUSTOMER_NBR_CORP,
         reg.NAME,
         reg.ADDRESS1,
--         reg.ADDRES2,
         reg.ADDRESS3,
         reg.STATE_CD,
         reg.STATE_DESC,
         reg.STATE_SALES_TAX_FLAG,
         reg.STATE_EXCISE_TAX_FLAG,
         reg.STATE_STAMP_TAX_FLAG,
         reg.COUNTY_CD,
         reg.COUNTY_DESC,
         reg.COUNTY_SALES_TAX_FLAG,
         reg.COUNTY_EXCISE_TAX_FLAG,
         reg.COUNTY_STAMP_TAX_FLAG,
         reg.CITY_CD,
         reg.CITY_DESC,
         reg.CITY_SALES_TAX_FLAG,
         reg.CITY_EXCISE_TAX_FLAG,
         reg.CITY_STAMP_TAX_FLAG,
         coalesce(spl.TAXING_ENTITY1,'') as TAXING_ENTITY1,
         case when spl.TAXING_ENTITY1 <> '' Then spl.STATE_DESC Else '' end as TAXING_ENTITY1_DESC,
         case when spl.TAXING_ENTITY1 <> '' Then spl.TAXENT1_STAMP_TAX_FLAG Else '' end as TAXENT1_STAMP_TAX_FLAG,
         case when spl.TAXING_ENTITY1 <> '' Then spl.TAXENT1_EXCISE_TAX_FLAG Else '' end as TAXENT1_EXCISE_TAX_FLAG,
         case when spl.TAXING_ENTITY1 <> '' Then spl.TAXENT1_USE_TAX_FLAG Else '' end as TAXENT1_USE_TAX_FLAG,
         coalesce(spl.TAXING_ENTITY2,'') as TAXING_ENTITY2,
         case  when spl.TAXING_ENTITY2 <> '' Then spl.STATE_DESC  Else ''  end as TAXING_ENTITY2_DESC,
         case when spl.TAXING_ENTITY2 <> '' Then spl.TAXENT2_STAMP_TAX_FLAG Else '' end as TAXENT2_STAMP_TAX_FLAG,
         case when spl.TAXING_ENTITY2 <> '' Then spl.TAXENT2_EXCISE_TAX_FLAG Else '' end as TAXENT2_EXCISE_TAX_FLAG,
         case when spl.TAXING_ENTITY2 <> '' Then spl.TAXENT2_USE_TAX_FLAG Else '' end as TAXENT2_USE_TAX_FLAG,
         coalesce(spl.TAXING_ENTITY3,'') as TAXING_ENTITY3,
         case when spl.TAXING_ENTITY3 <> '' Then spl.STATE_DESC Else '' end as TAXING_ENTITY3_DESC,
         case when spl.TAXING_ENTITY3 <> '' Then spl.TAXENT3_STAMP_TAX_FLAG Else '' end as TAXENT3_STAMP_TAX_FLAG,
         case when spl.TAXING_ENTITY3 <> '' Then spl.TAXENT3_EXCISE_TAX_FLAG Else '' end as TAXENT3_EXCISE_TAX_FLAG,
         case when spl.TAXING_ENTITY3 <> '' Then spl.TAXENT3_USE_TAX_FLAG Else '' end as TAXENT3_USE_TAX_FLAG
FROM     reg 
         left outer join spl on reg.FACILITYID = spl.FACILITYID and reg.CUSTOMER_NBR_CORP = spl.CUSTOMER_NBR_CORP
;
