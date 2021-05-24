SELECT   facilityid,
         year(DATE_ORDERED),
         count(*)
FROM     CRMADMIN.T_WHSE_PO_DTL
GROUP BY FACILITYID, year(date_ordered)
;

SELECT --MASTER_VENDOR, MASTER_VENDOR_DESC, FACILITYID, VENDOR_NBR, VENDOR_NAME, STATUS , PAYABLE_VENDOR_NBR 
       distinct(MASTER_VENDOR) master_vendor
FROM     CRMADMIN.T_WHSE_VENDOR
WHERE    (MASTER_VENDOR_DESC like '%CLEMENS%'
     OR  MASTER_VENDOR_DESC like '%HORMEL%'
     OR  MASTER_VENDOR_DESC like '%JBS%'
     OR  MASTER_VENDOR_DESC like '%SEABOARD%'
     OR  MASTER_VENDOR_DESC like '%SMITHFIELD%'
     OR  MASTER_VENDOR_DESC like '%TRIUMPH%'
     OR  MASTER_VENDOR_DESC like '%TYSON%'
     OR  MASTER_VENDOR_DESC like '%MORRELL%'
     OR  MASTER_VENDOR_DESC like '%FARMLAND%'
);


/*
Clemens Food Group
Hormel
JBS USA, Inc.
Seaboard Foods
Smithfield Foods
Triumph Foods
Tyson
John Morrell
Farmland

MASTER_VENDOR
004669
023430
023431
023700
037600
053700
070800
099311
310956
716303
716432
770777
*/
;


SELECT   *
FROM     CRMADMIN.T_WHSE_PROD_SUBGROUP
WHERE    (PROD_SUBGROUP_DESC like '%PORK%'
     OR  PROD_SUBGROUP_DESC like '%HAM%'
     OR  PROD_SUBGROUP_DESC like '%BACON%')
;

--pilgrim
--2006 - 2017


SELECT   facilityid,
         year(DATE_ORDERED),
         count(*)
FROM     CRMADMIN.T_WHSE_PO_DTL
GROUP BY FACILITYID, year(date_ordered)
;

SELECT MASTER_VENDOR, MASTER_VENDOR_DESC, FACILITYID, VENDOR_NBR, VENDOR_NAME, STATUS , PAYABLE_VENDOR_NBR 
FROM     CRMADMIN.T_WHSE_VENDOR
WHERE    (MASTER_VENDOR_DESC like '%PILGRIM%'
    
);

--chicken
SELECT   d.COMPANY_YEAR_ID,
         d.COMPANY_PERIOD_ID,
         pod.FACILITYID, dx.DIV_NAME, poh.VENDOR_NBR, poh.VENDOR_NAME,
         pod.ITEM_NBR,
         pod.DESCRIPTION, pod.VARIABLE_WEIGHT_INDICATOR, sum(pod.WEIGHT) weight, sum(pod.WEIGHT_RECEIVED) weight_received,
         sum(pod.RECEIVED) received_qty,
--         sum(pod.RECEIVED * (pod.LAST_COST - pod.AMOUNT_OFF_INVOICE - pod.AMOUNT_BILLBACK)) ext_last_cost,
--         sum(pod.RECEIVED * (pod.LIST_COST - pod.AMOUNT_OFF_INVOICE - pod.AMOUNT_BILLBACK)) ext_cost,
         sum(pod.RECEIVED * (pod.LIST_COST - pod.AMOUNT_OFF_INVOICE - pod.AMOUNT_BILLBACK) * (case when pod.VARIABLE_WEIGHT_INDICATOR = 'Y' then pod.WEIGHT else 1 end) ) ext_cost
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join CRMADMIN.T_WHSE_PO_HDR poh on pod.FACILITYID = poh.FACILITYID and pod.PO_NBR = poh.PO_NBR and pod.DATE_ORDERED = poh.DATE_ORDERED 
         inner join CRMADMIN.T_WHSE_VENDOR v on poh.FACILITYID = v.FACILITYID and poh.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.T_DATE d on pod.DATE_ORDERED = d.DATE_KEY
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on pod.FACILITYID = dx.SWAT_ID
WHERE    d.COMPANY_YEAR_ID between 2006 and 2017
AND      v.MASTER_VENDOR in ('074960', '024105')
AND      pod.RECEIVED > 0
GROUP BY d.COMPANY_YEAR_ID, d.COMPANY_PERIOD_ID, pod.FACILITYID, dx.DIV_NAME,poh.VENDOR_NBR, poh.VENDOR_NAME, pod.ITEM_NBR, 
         pod.DESCRIPTION, pod.VARIABLE_WEIGHT_INDICATOR
;

--pork
SELECT   d.COMPANY_YEAR_ID,
         d.COMPANY_PERIOD_ID,
         pod.FACILITYID,
         dx.DIV_NAME,
         poh.VENDOR_NBR,
         poh.VENDOR_NAME,
         i.ITEM_DEPT,
         i.PRODUCT_GROUP,
--         pg.PROD_GROUP_DESC,
         i.PRODUCT_SUB_GROUP,
--         psg.PROD_SUBGROUP_DESC,
         i.MERCH_DEPT_GRP,
         i.MERCH_DEPT_GRP_DESC,
         i.MERCH_DEPT,
         i.MERCH_DEPT_DESC,
         i.MERCH_GRP,
         i.MERCH_GRP_DESC,
         i.MERCH_CAT,
         i.MERCH_CAT_DESC,
         i.MERCH_CLASS,
         i.MERCH_CLASS_DESC,
         pod.ITEM_NBR,
         pod.DESCRIPTION,
         pod.VARIABLE_WEIGHT_INDICATOR,
         sum(pod.WEIGHT) weight,
         sum(pod.WEIGHT_RECEIVED) weight_received,
         sum(pod.RECEIVED) received_qty,
         sum(pod.RECEIVED * (pod.LIST_COST - pod.AMOUNT_OFF_INVOICE - pod.AMOUNT_BILLBACK) * (case when pod.VARIABLE_WEIGHT_INDICATOR = 'Y' then pod.WEIGHT else 1 end) ) ext_cost
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join CRMADMIN.T_WHSE_PO_HDR poh on pod.FACILITYID = poh.FACILITYID and pod.PO_NBR = poh.PO_NBR and pod.DATE_ORDERED = poh.DATE_ORDERED 
         inner join CRMADMIN.T_WHSE_ITEM i on pod.FACILITYID = i.FACILITYID and pod.ITEM_NBR = i.ITEM_NBR 
--         inner join CRMADMIN.T_WHSE_PROD_GROUP pg on i.FACILITYID = pg.FACILITY and i.PRODUCT_GROUP = pg.PROD_GROUP 
--         inner join CRMADMIN.T_WHSE_PROD_SUBGROUP psg on i.FACILITYID = psg.FACILITY and i.PRODUCT_SUB_GROUP = psg.PROD_SUBGROUP 
         inner join CRMADMIN.T_WHSE_VENDOR v on poh.FACILITYID = v.FACILITYID and poh.VENDOR_NBR = v.VENDOR_NBR 
         inner join CRMADMIN.T_DATE d on pod.DATE_ORDERED = d.DATE_KEY 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on pod.FACILITYID = dx.SWAT_ID
WHERE    d.COMPANY_YEAR_ID between 2006 and 2021
AND      v.MASTER_VENDOR in ('004669', '023430', '023431', '023700', '037600', '053700', '070800', '099311', '310956', '716303', '716432', '770777')
AND      pod.RECEIVED > 0
GROUP BY d.COMPANY_YEAR_ID, d.COMPANY_PERIOD_ID, pod.FACILITYID, dx.DIV_NAME, 
         poh.VENDOR_NBR, poh.VENDOR_NAME, i.ITEM_DEPT, i.PRODUCT_GROUP, 
--         pg.PROD_GROUP_DESC, 
i.PRODUCT_SUB_GROUP, 
--psg.PROD_SUBGROUP_DESC, 
         i.MERCH_DEPT_GRP, i.MERCH_DEPT_GRP_DESC, i.MERCH_DEPT, 
         i.MERCH_DEPT_DESC, i.MERCH_GRP, i.MERCH_GRP_DESC, i.MERCH_CAT, 
         i.MERCH_CAT_DESC, i.MERCH_CLASS, i.MERCH_CLASS_DESC, pod.ITEM_NBR, 
         pod.DESCRIPTION, pod.VARIABLE_WEIGHT_INDICATOR;

