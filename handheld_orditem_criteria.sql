SELECT facilityid, ELIGIBILITY_RULES_FLG,  count(*)
FROM     (SELECT   FACILITYID,
                   ITEM_NBR_HS,
                   FACILITYID_FULFILL,
                   ITEM_DESC,
                   AVAILABILITY_DATE,
                   MERCH_DEPT,
                   WHOLESALE_DEPT,
                   WHOLESALE_DEPT_OVERRIDE,
                   PRIVATE_LABEL_KEY,
                   UPC_CASE_CD,
                   SHIP_UNIT_CD,
                   SHIP_CASE_CNT,
                   COMMODITY_XREF,
                   BILLING_STATUS_BACKSCREEN,
                   SUPPLY_FLAG,
                   PRESELL_FLG,
                   ITEM_XDOCK_FLG,
                   RAND_WGT_CD,
                   SHIPPING_CASE_CUBE,
                   SHIPPING_CASE_WEIGHT,
                   PRINT_SHELF_LBL_FLAG,
                   RE_AVAILABLE_DATE,
                   DC_AREA_FULFILL,
                   PALLET_QTY,
                   SPECIALTY_ITEM_FLG, ELIGIBILITY_RULES_FLG 
          FROM     CRMADMIN.V_WEB_ITEM_CORE
          WHERE    HANDHELD_STATUS_CD IN ('P')
          AND      ELIGIBILITY_RULES_FLG = 'Y'
          AND      INSITE_DISPLAY_FLG = 'N'

--          AND      BILLING_STATUS_BACKSCREEN In ('A', 'D', 'W', 'P')
--          AND      BILLING_STATUS In ('A', 'D', 'V', 'N', 'I')
--          AND      BILLING_STATUS_FILTER in ('A')
)
group by FACILITYID, ELIGIBILITY_RULES_FLG ;



;


CRMADMIN.V_WEB_ITEM_CORE.BILLING_STATUS_BACKSCREEN In ('A', 'D', 'W', 'P') And
  CRMADMIN.V_WEB_ITEM_CORE.BILLING_STATUS In ('A', 'D', 'V', 'N', 'I') and
  CRMADMIN.V_WEB_ITEM_CORE.BILLING_STATUS_FILTER in ('A')