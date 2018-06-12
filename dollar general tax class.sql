SELECT   FACILITYID,
         CUSTOMER_NO_FULL,
         CUSTOMER_NBR_STND,
         CUST_CORPORATION,
         STATUS_CD,
         NAME,
         ADDRESS1,
         ADDRES2,
         ADDRESS3,
         STATE_CD,
         STATE_DESCRIPTION,
         ZIP_CD,
         COUNTY_CD,
         COUNTY_DESCRIPTION,
         CITY_CD,
         HOME_BRANCH,
         CUST_CORPORATION,
         TAXING_ENTITY1,
         TAXING_ENTITY2,
         TAXING_ENTITY3,
         TAXABILTY_TYPE
FROM     CRMADMIN.T_WHSE_CUST
WHERE    CUST_CORPORATION = 102
AND      STATUS_CD not in ('D', 'Z');

Select * from CRMADMIN.T_WHSE_CUST where FACILITYID = '061' and STATUS_CD not in ('D', 'Z')
;

SELECT   i.FACILITYID, i.ITEM_NBR_HS, i.ITEM_DESCRIP, i.TAX_CLASS, i.ROOT_ITEM_NBR
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_MDM_ITEM_ATTRIBUTE mia on mia.ROOT_ITEM_NBR = i.ROOT_ITEM_NBR and mia.CLASS_CDE = 'NACC'
where mia.ATTRIB_CDE = 'DG' 
  and i.PURCH_STATUS not in ('D', 'Z')
  and i.TAX_CLASS > 0
;

--WHERE    name like '%DOLLAR GENERAL%'