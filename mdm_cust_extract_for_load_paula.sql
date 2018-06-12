SELECT   Distinct CUSTOMER_NBR_STND CUSTOMER_CODE,
         '' URL_DESC,
         0 WEB_LOCATOR_IND,
         cust.CREATE_DATE STORE_OPEN_DATE,
         '' ACQUISITION_DATE,
         '' STORE_CLOSE_DATE,
         '' LATITUDE_NBR,
         '' LONGITUDE_NBR,
         '' SQFT_MSR,
         0 PI_IND,
         '' PI_EFF_DATE,
         '' PI_EXP_DATE,
         '' SCHOOL_DIST_NAME,
         cust.COUNTY_DESCRIPTION COUNTY_NAME,
         '' TOWNSHIP_NAME,
         cust.PRIVATE_RTL_DEPT_FLAG DEPT_STRUCTURE_IND,
         cust.TERRITORY_NO CUST_CLASS_DESC,
         2 COMP_STATUS_CD,
         '' COMP_STATUS_DATE,
         '' RELATED_CUST_NBR,
         '' RTL_SERV_CUST_CD,
         '' AGGREGATE_CUST_CD,
         '' EXT_SYSTEM_CUST_CD,
         2 DC_COMP_STAT_CD,
         '' DC_COMP_STAT_DATE,
         '' DC_COMP_LINK_NBR,
         '' FIRST_PURCHASE_IND,
         '' COMPARE_SAVE_IND,
         0 FREQ_SHOPPER_IND,
         0 CUST_PCON_IND,
         '' PRESELL_PART_IND,
         substr(cust.ZIP_CD,1,5), cust.ADDRESS1, cust.ADDRESS3 city, cust.STATE_CD, cust.ADDRESS1 || ' ' || cust.ADDRESS3 || ' ' || cust.STATE_CD FULL_ADDRESS
FROM     CRMADMIN.T_WHSE_CUST cust 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on cust.FACILITYID = d.SWAT_ID
WHERE    d.ACTIVE_FLAG = 'Y'
AND      cust.STATUS_CD not in ('Z')
AND      cust.FACILITYID = cust.HOME_BRANCH
and cust.CUST_CORPORATION not in (102)
--and cust.FACILITYID not in ('001')
;


WHERE    (d.SWAT_ID <> '001'
     AND current date between cust.CONTRACT_START_DATE and cust.CONTRACT_END_DATE
     AND d.ACTIVE_FLAG = 'Y'
--     AND corp.ACTIVE = 'Y'
     AND cust.FACILITYID = cust.HOME_BRANCH
--     AND cust.MDM_CUST_STATUS_CD not in (3, 9)
--     AND cust.TERRITORY_NO not in (29, 39, 59)
--     AND cust.CUSTOMER_NBR_STND > 9
     AND not(cust.STATUS_CD = 'Z')
--     AND not(cust.STATUS_CD = 'D'
--        AND cust.INACTIVE_DATE < current date - 30 days))
OR       (d.SWAT_ID = '001'
     AND current date between cust.CONTRACT_START_DATE and cust.CONTRACT_END_DATE
     AND d.ACTIVE_FLAG = 'Y'
--     AND corp.ACTIVE = 'Y'
     AND cust.MDM_CUST_STATUS_CD not in (3, 4, 9)
     AND cust.CUSTOMER_NBR_STND > 9)
;


--geocode list
SELECT   Distinct CUSTOMER_NBR_STND CUSTOMER_CODE,
         cust.ADDRESS1,
         cust.ADDRESS3 city,
         cust.STATE_CD,
         substr(cust.ZIP_CD,1,5) zip
FROM     CRMADMIN.T_WHSE_CUST cust 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on cust.FACILITYID = d.SWAT_ID
WHERE    d.ACTIVE_FLAG = 'Y'
AND      cust.STATUS_CD not in ('Z')
AND      cust.FACILITYID = cust.HOME_BRANCH
--AND      cust.CUST_CORPORATION not in (102)
;