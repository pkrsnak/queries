SELECT   c.CORPORATION_ID,
         c.FACILITY_ID,
         i.SHIP_FACILITY_ID,
         c.CUSTOMER_NBR,
         c.CUSTOMER_NAME,
         dsh.TRANSACTION_DATE,
         dsh.ITEM_NBR,
         i.ROOT_ITEM_DESC,
         i.ITEM_SIZE_DESC,
         dsh.TOTAL_SALES_AMT
FROM     WH_OWNER.DC_CUSTOMER c 
         inner join WH_OWNER.DC_SALES_HST dsh on dsh.FACILITY_ID = c.FACILITY_ID and dsh.CUSTOMER_NBR = c.CUSTOMER_NBR 
         inner join WH_OWNER.DC_ITEM i on i.FACILITY_ID = dsh.FACILITY_ID and i.ITEM_NBR = dsh.ITEM_NBR
WHERE    c.CORPORATION_ID = 368
AND      dsh.TRANSACTION_DATE >= '2021-09-01'
;



SELECT   CORP_CODE,
         CORP_NAME,
         CUSTOMER_NBR_STND,
         NAME,
         ADDRESS1
--         STATUS_CD
FROM     CRMADMIN.V_WEB_CUSTOMER
WHERE   CORP_CODE = 2302
;
 NAME like 'MARTIN%'
--AND      STATUS_CD not in ('Z')
;

SELECT   FACILITYID,
         CUSTOMER_NBR_STND,
         NAME,
         ADDRESS1,
         STATUS_CD,
         LAST_ORDER_DATE LAWSON_LAST_UPDATE,
         MDM_CUSTOMER_LASTUPDATE,
         MDM_UPDATE_DATE, HOME_BRANCH, MDM_CUST_STATUS_CD, TERRITORY_NO, CUST_CLASS_CD, CONTRACT_START_DATE, CONTRACT_END_DATE
FROM     CRMADMIN.T_WHSE_CUST
--WHERE    CUSTOMER_NBR_STND in (2302, 702, 2304, 2306, 2308, 728, 2310, 731, 2311, 2312, 2712, 722, 2314, 2714, 2315, 2316, 2716, 2317, 2717, 717, 2318, 2319, 2320, 730, 2321, 2721, 2389, 2322, 2323, 2324, 724, 2325, 735, 2326, 2327, 2341)
WHERE    CUSTOMER_NBR_STND in (731, 722, 717, 730, 724, 735)
AND      FACILITYID not in ('015', '059', '058')
--NAME like 'MARTIN%'
--AND      STATUS_CD not in ('Z')

;



SELECT   CORP_CODE,
         CORP_NAME,
         CUSTOMER_NBR_STND,
         NAME,
         ADDRESS1,
         ADDRESS2,
         CITY,
         STATE_CD,
         ZIP_CD
FROM     CRMADMIN.V_WEB_CUSTOMER
--WHERE    CUSTOMER_NBR_STND in (2302, 702, 2304, 2306, 2308, 728, 2310, 731, 2311, 2312, 2712, 722, 2314, 2714, 2315, 2316, 2716, 2317, 2717, 717, 2318, 2319, 2320, 730, 2321, 2721, 2389, 2322, 2323, 2324, 724, 2325, 735, 2326, 2327, 2341)
WHERE    CUSTOMER_NBR_STND in (731, 722, 717, 730, 724, 735)
;


SELECT   Distinct corp.CORP_CODE,
         corp.CORP_NAME,
         cust.TERRITORY_NO,
         cust.CUSTOMER_NO_FULL,
         cust.CUSTOMER_NBR_STND,
         cust.RTL_SERV_CUST_CD,
         cust.NAME,
         cust.LEGAL_CUSTOMER_NAME,
         cust.ADDRESS1,
         trim(cust.ADDRES2) as ADDRESS2,
         cust.ADDRESS3 as CITY,
         cust.STATE_CD,
         cust.ZIP_CD,
         cust.BILL_TO_NAME,
         cust.BILL_TO_ADDRESS1,
         cust.BILL_TO_ADDRESS2,
         cust.BILL_TO_CITY,
         cust.BILL_TO_STATE,
         cust.BILL_TO_ZIP_CDE,
         cust.BILL_TO_COUNTRY,
         cust.TELEPHONE,
         trim(cust.BILL_TO_PHONE_NBR) as BILL_TO_PHONE_NBR,
         cust.BILL_TO_FAX_NBR,
         cust.BILL_TO_EMAIL,
         cust.COUNTY_CD_MDM,
         cust.COUNTY_KEY_MDM,
         cust.COUNTY_DESCRIPTION_MDM,
         cust.LONGITUDE_NBR,
         cust.LATITUDE_NBR,
         cust.ACQUISITION_DATE,
         cust.STORE_OPEN_DATE,
         cust.STORE_CLOSE_DATE,
         cust.BILLABLE_FLAG,
         cust.PI_IND,
         cust.PI_EFF_DATE,
         cust.PI_EXP_DATE,
         cust.COMP_STAT_KEY,
         cust.COMP_STAT_DESC,
         cust.COMP_STAT_DATE,
         cust.DC_COMP_STAT_KEY,
         cust.DC_COMP_STAT_DESC,
         cust.DC_COMP_STAT_DATE,
         cust.DC_COMP_LINK_NBR,
         cust.DEPT_STRUCT_KEY,
         cust.DEPT_STRUCT_DESC,
         cust.PRESELL_PART_IND,
         cust.RELATED_CUST_CD,
         cust.CUST_PCON_IND,
         cust.COMPARE_SAVE_IND,
         cust.FREQ_SHOPPER_IND,
         cust.FIRST_PURCHASE_IND,
         cust.WEB_LOCATOR_IND,
         cust.CUST_CLASS_KEY,
         cust.CUST_CLASS_CD,
         cust.CUST_CLASS_DESC,
         cust.FEDERAL_ID_NO,
         cust.STORE_LICENSE_ID,
         cust.STORE_CIGARETTE_TAX_ID,
         cust.STORE_TOBACCO_TAX_ID,
         cust.PRIM_STORE_NO,
         cust.SELL_SQFT,
         cust.TOWNSHIP_KEY,
         cust.TOWNSHIP_NAME,
         cust.SCHOOL_DIST_KEY,
         cust.SCHOOL_DIST_NAME,
         cust.BANNER_ID,
         banner.BANNER_DESC,
         cust.MEMBERSHIP_CODE,
         cust.MEMBERSHIP_KEY,
         cust.MEMBERSHIP_DESC,
         cust.MDM_CUST_STATUS_CD,
         cust.MDM_CUST_STATUS_DESC,
         cust.MDM_UPDATE_DATE,
         cust.CONTRACT_START_DATE,
         cust.CONTRACT_END_DATE,
         case 
              when current date between cust.CONTRACT_START_DATE and cust.CONTRACT_END_DATE then 'A' 
              else 'D' 
         end CONTRACT_STATUS,
         cust.MANAGER,
         cust.OWNER,
         upper(cust.TIME_ZONE_CUST) TIME_ZONE_CUST,
         corp.CORP_BURDEN_COST_IND,
         cust.STORE_FAX_NBR,
         cust.STORE_EMAIL,
         cust.STATEMENT_CYCLE_SUNDAY,
         cust.STATEMENT_CYCLE_MONDAY,
         cust.STATEMENT_CYCLE_TUESDAY,
         cust.STATEMENT_CYCLE_WEDNESDAY,
         cust.STATEMENT_CYCLE_THURSDAY,
         cust.STATEMENT_CYCLE_FRIDAY,
         cust.STATEMENT_CYCLE_SATURDAY,
         cust.STATEMENT_FREQ,
         cust.STATEMENT_FREQ_DESC
FROM     CRMADMIN.T_WHSE_CUST cust 
         inner join CRMADMIN.T_WHSE_CORPORATION_MDM corp on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND 
         inner join CRMADMIN.V_WEB_FACILITY dx on cust.FACILITYID = dx.FACILITYID 
         left outer join CRMADMIN.T_WHSE_CUST_BANNER banner on cust.BANNER_ID = banner.BANNER_ID
WHERE    --dx.UPSTREAM_DC_TYP_CD = 'D'
--AND      cust.CONTRACT_END_DATE > current date - 30 days
--AND      corp.ACTIVE = 'Y'
--AND      cust.FACILITYID = cust.HOME_BRANCH
--AND      cust.MDM_CUST_STATUS_CD not in (3, 9)
--AND      cust.TERRITORY_NO not in (29, 39, 59)
--AND      cust.CUST_CLASS_CD not in (14)
--AND      (cust.STATUS_CD not in ('P', 'Z')
--     OR  cust.STATUS_CD is null)
--AND      
cust.CUSTOMER_NBR_STND in (731, 722, 717, 730, 724, 735)
;


;
SELECT   dsh.TRANSACTION_DATE as dte,
         dsh.FACILITY_ID as fac,
         dsh.CUSTOMER_NBR as cust,
         dsh.INVOICE_NBR as invc,
         sum(dsh.SHIPPED_QTY) as qty,
         sum(dsh.EXT_RSU_CNT) as rsu,
         sum(dsh.TOTAL_SALES_AMT) as cust,
         sum(dsh.EXT_RETAIL_AMT) as retail
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR 
         inner join WH_OWNER.MDSE_CLASS MCL on MCL.MDSE_CLASS_KEY = i.MDSE_CLASS_KEY 
         inner join WH_OWNER.MDSE_CATEGORY MC on MC.MDSE_CATGY_KEY = mcl.MDSE_CATGY_KEY 
         inner join WH_OWNER.MDSE_GROUP MG on MG.MDSE_GRP_KEY = mc.MDSE_GRP_KEY 
         inner join WH_OWNER.DEPARTMENT D on d.DEPT_KEY = mg.DEPT_KEY 
         inner join WH_OWNER.DEPARTMENT_GROUP DG on dg.DEPT_GRP_KEY = d.DEPT_GRP_KEY
WHERE    CUSTOMER_NBR in (810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 822, 823, 826, 827, 839, 843, 844, 846, 848)
AND      TRANSACTION_DATE >= '11-28-2021'
GROUP BY 1,2,3,4;

