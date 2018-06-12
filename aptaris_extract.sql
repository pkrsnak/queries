--Aptaris PRODUCT
SELECT   vwic.FACILITYID || ITEM_NBR_HS ITEM_NUMBER_SKU,
         vwic.ROOT_DESC ITEM_DESCRIPTION,
         '' ITEM_TYPE,
         '' PROMO_DESCRIPTION,
         vwic.MERCH_CLASS HIERARCHY_1_NBR,
         vwic.MERCH_CLASS_DESC HIERARCHY_1_NAME,
         vwic.MERCH_CAT HIERARCHY_2_NBR,
         vwic.MERCH_CAT_DESC HIERARCHY_2_NAME,
         vwic.MERCH_GRP HIERARCHY_3_NBR,
         vwic.MERCH_GRP_DESC HIERARCHY_3_NAME,
         vwic.MERCH_DEPT HIERARCHY_4_NBR,
         vwic.MERCH_DEPT_DESC HIERARCHY_4_NAME,
         vwic.MERCH_DEPT_GRP HIERARCHY_5_NBR,
         vwic.MERCH_DEPT_GRP_DESC HIERARCHY_5_NAME,
         '' HIERARCHY_6_NBR,
         '' HIERARCHY_6_NAME,
         '' HIERARCHY_7_NBR,
         '' HIERARCHY_7_NAME,
         '' PRODUCT_AGG_MASTER_ITEM,
         vwv.MASTER_VENDOR MANUFACTURER_NBR,
         vwv.MASTER_VENDOR_DESC MANUFACTURER_NAME,
         case trim(vwic.RAND_WGT_CD) 
              when 'R' then 1 
              else 0
         end RANDOM_WEIGHT_FLG,
         vwic.ITEM_DESC SHORT_DESCRIPTION,
         vwic.BRAND,
         trim(vwb.LAST_NAME) || ', ' || trim(vwb.FIRST_NAME) BUYER_NAME,
         vwv.AP_VENDOR_NBR,
         vwv.AP_VENDOR_NAME,
         case vwic.SEASONAL_ITEM_CD
              when 'I' then 1
              else 0
         end SHIPPER_FLG
FROM     CRMADMIN.V_WEB_ITEM_CORE vwic 
         inner join CRMADMIN.V_WEB_VENDOR vwv on vwic.FACILITYID = vwv.FACILITY and vwic.VENDOR_NBR = vwv.VENDOR_NBR 
         left outer join CRMADMIN.V_WEB_BUYER vwb on vwic.BUYER_NBR = vwb.BUYER_NBR
WHERE    vwic.FACILITYID in ('001', '058') --, '040', '054')
--exclude dept 13
 AND      vwic.MERCH_DEPT_GRP in ('0010', '0020', '0030', '0040', '0041', '0060', '0070', '0080', '0090')
ORDER BY vwic.FACILITYID, vwic.ITEM_NBR_HS
;

--Aptaris ITEM CORPORATE INFO
SELECT   vwic.FACILITYID || ITEM_NBR_HS ITEM_NUMBER_SKU,
         decimal(round((value(vwic.SSRP_AMNT, 0) / value(vwic.SSRP_UNIT,1)), 2), 9, 2) CURRENT_ITEM_RETAIL,
         decimal(round(((value(vwic.SSRP_AMNT, 0) / value(vwic.SSRP_UNIT,1)) * vwic.PACK_CASE), 2), 17, 4) CURRENT_CASE_RETAIL,
         case vwic.BILLING_STATUS_BACKSCREEN 
              when 'D' then 'D' 
              else 'A' 
         end ITEM_STATUS,
         '' BASE_UNITS,
         '' BASE_CASES
FROM     CRMADMIN.V_WEB_ITEM_CORE vwic 
         inner join CRMADMIN.V_WEB_VENDOR vwv on vwic.FACILITYID = vwv.FACILITY and vwic.VENDOR_NBR = vwv.VENDOR_NBR
WHERE    vwic.FACILITYID in ('001', '058') --, '040', '054')
AND      vwic.MERCH_DEPT_GRP in ('0010', '0020', '0030', '0040', '0041', '0060', '0070', '0080', '0090')
ORDER BY vwic.FACILITYID, vwic.ITEM_NBR_HS
;

--Aptaris ITEMS BY VENDOR
SELECT   vwic.FACILITYID || ITEM_NBR_HS ITEM_NUMBER_SKU,
         vwic.UPC_UNIT_CD,
         '' VENDOR_REFERENCE_NBR,
         vwic.FACILITYID || vwic.VENDOR_NBR VENDOR_NUMBER,
         case vwic.PRIMARY_ITEM_FLAG 
              when 'Y' then 'Y' 
              else 'N' 
         end PRIMARY_VENDOR_FLG,
         case vwic.PRIMARY_ITEM_FLAG 
              when 'Y' then 'Y' 
              else 'N' 
         end PRIMARY_ITEM_FLAG,
         vwv.BROKER_NBR,
         vwv.BROKER_NAME,
         vwv.AP_VENDOR_NBR,
         vwv.AP_VENDOR_NAME,
         vwic.ITEM_SIZE,
         vwic.ITEM_SIZE_UOM,
         vwic.PACK_CASE,
         decimal(round((vwic.LIST_COST / vwic.PACK_CASE), 4),12,4) CURRENT_COST,
         vwic.LIST_COST CURRENT_CASE_COST
FROM     CRMADMIN.V_WEB_ITEM_CORE vwic 
         inner join CRMADMIN.V_WEB_VENDOR vwv on vwic.FACILITYID = vwv.FACILITY and vwic.VENDOR_NBR = vwv.VENDOR_NBR
WHERE    vwic.FACILITYID in ('001', '058') --, '040', '054')
AND      vwic.MERCH_DEPT_GRP in ('0010', '0020', '0030', '0040', '0041', '0060', '0070', '0080', '0090')
and vwic.FACILITYID = '001' and vwic.ITEM_NBR_HS like '021344%'
ORDER BY vwic.FACILITYID, vwic.ITEM_NBR_HS
;
--potential for primary vendor lookup
select FACILITYID, STOCKING_FACILITY, ITEM_NBR_HS, UPC_UNIT, BRAND, ITEM_DESC, ITEM_SIZE, ITEM_SIZE_UOM, PACK_CASE, VENDOR_NBR, PRIMARY_ITEM_FLAG, PURCH_STATUS, BILLING_STATUS, BILLING_STATUS_BACKSCREEN, AVAILABILITY_CODE, NATAG_MAINT_DATE, AVAILABILITY_DATE
 from CRMADMIN.V_WEB_ITEM_CORE where (facilityid, UPC_UNIT_CD) in (
select facilityid, UPC_UNIT_CD from (
SELECT  distinct vwic.FACILITYID,
         vwic.UPC_UNIT_CD,
         vwic.VENDOR_NBR
FROM     CRMADMIN.V_WEB_ITEM_CORE vwic
WHERE    vwic.FACILITYID in ('001', '058') --, '040', '054')
AND      vwic.MERCH_DEPT_GRP in ('0010', '0020', '0030', '0040', '0041', '0060', '0070', '0080', '0090')
AND      vwic.PRIMARY_ITEM_FLAG = 'Y'
AND vwic.PURCH_STATUS not in ('X')
--ORDER BY vwic.FACILITYID, vwic.ITEM_NBR_HS
)
--where primary_item_flag 
group by facilityid, UPC_UNIT_CD
having count(*) > 1
)
and primary_item_flag = 'Y'
;


--Aptaris VENDOR MASTER

SELECT   vwv.FACILITY || vwv.VENDOR_NBR VENDOR_NUMBER,
         vwv.VENDOR_NAME,
         vwv.VENDOR_ADDRESS_1,
         vwv.VENDOR_ADDRESS_2,
         vwv.VENDOR_CITY,
         vwv.VENDOR_STATE,
         vwv.VENDOR_ZIP,
         vwv.VENDOR_PHONE
FROM     CRMADMIN.V_WEB_VENDOR vwv
WHERE    vwv.FACILITY in ('001', '058') --, '040', '054')
order by vwv.FACILITY, vwv.VENDOR_NBR
;


--Aptaris STORE MASTER

SELECT   vwc.CUSTOMER_NBR_STND,
         vwc.NAME,
         vwc.ADDRESS1,
         vwc.CITY,
         vwc.STATE_CD,
         vwc.ZIP_CD,
         '' DISTRICT,
         vwc.BANNER_DESC
FROM     CRMADMIN.V_WEB_CUSTOMER vwc
WHERE    vwc.MEMBERSHIP_KEY in ('O', 'W')
order by vwc.CUSTOMER_NBR_STND
;

--Aptaris vendor-upc-store
SELECT  distinct vwic.UPC_UNIT_CD,
         vwic.FACILITYID || vwic.VENDOR_NBR VENDOR_NUMBER,
         vwcic.CUSTOMER_NBR_STND,
         1 as VENDOR_AVAILABILITY,
         '' as VENDOR_STATUS,
         vwcic.BURDENED_COST_UNIT_AMT,
         vwcic.BURDENED_COST_CASE_AMT
FROM     CRMADMIN.V_WEB_ITEM_CORE vwic 
         inner join CRMADMIN.V_WEB_VENDOR vwv on vwic.FACILITYID = vwv.FACILITY and vwic.VENDOR_NBR = vwv.VENDOR_NBR 
         left outer join CRMADMIN.V_WEB_CUSTOMER_ITEM_COST vwcic on vwic.FACILITYID = vwcic.FACILITYID and vwic.ITEM_NBR_HS = vwcic.ITEM_NBR_HS
WHERE    vwic.FACILITYID in ('001', '058')  --, '040', '054'
AND      vwic.MERCH_DEPT_GRP in ('0010', '0020', '0030', '0040', '0041', '0060', '0070', '0080', '0090')
and current date between vwcic.START_DATE and vwcic.END_DATE
and vwcic.CUSTOMER_NBR_STND = 1423
ORDER BY vwic.FACILITYID, vwic.ITEM_NBR_HS;

--vendor broker extract
SELECT   FACILITY || VENDOR_NBR VENDOR_NUMBER,
         VENDOR_NAME,
         FACILITY || BROKER_NBR BROKER_NUMBER,
         BROKER_NAME,
         BROKER_ADDRESS_1,
         BROKER_CITY,
         BROKER_STATE,
         BROKER_ZIP,
         BROKER_CONTACT,
         BROKER_PHONE,
         MASTER_BROKER,
         MSTRBKR_NAME,
         MASTER_VENDOR,
         MASTER_VENDOR_DESC
FROM     CRMADMIN.V_WEB_VENDOR
;


--data volume estimates:
SELECT   f.FACILITYID, f.DIV_NAME,
         count(*) num_active_items
FROM     CRMADMIN.V_WEB_ITEM_CORE ic inner join CRMADMIN.V_WEB_FACILITY f on ic.FACILITYID = f.FACILITYID
WHERE    ic.PURCH_STATUS not in ('D', 'Z')
AND      f.FACILITYID not in ('002', '071')
GROUP BY f.FACILITYID, f.DIV_NAME
;

SELECT   f.FACILITYID,f.DIV_NAME, count(*) num_active_customers
FROM     CRMADMIN.V_WEB_CUSTOMER_FAC vwcf inner join CRMADMIN.V_WEB_FACILITY f on vwcf.FACILITYID = f.FACILITYID
WHERE    vwcf.MEMBERSHIP_KEY in ('O', 'W')
AND      f.FACILITYID not in ('002', '071')
GROUP BY f.FACILITYID, f.DIV_NAME
;


SELECT   vwv.FACILITY, count(*) num_active_vendors
FROM     CRMADMIN.V_WEB_VENDOR vwv
WHERE    vwv.FACILITY not in ('002', '071', '009', '065', '059', '062', '064')
group by vwv.FACILITY
;


-----------------
-- item counts
SELECT UPC_UNIT, VENDOR_NBR, FACILITYID, count(*)
FROM     CRMADMIN.V_WEB_ITEM_CORE
--where ELIGIBILITY_RULES_FLG = 'Y'
group by UPC_UNIT, VENDOR_NBR, FACILITYID
having count(*) > 1;


SELECT count(*)
FROM     CRMADMIN.V_WEB_ITEM_CORE
where ELIGIBILITY_RULES_FLG = 'Y'
--group by UPC_UNIT, VENDOR_NBR, FACILITYID
having count(*) > 1

