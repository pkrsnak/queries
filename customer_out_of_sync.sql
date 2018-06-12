---TRUNC THEN LOAD FROM GOLD PROD to etladmin.T_TEMP_FAC_CUST-------
SELECT lpad(trim(CONTRACT_CODE), 3, '0'), CUSTOMER_NUMBER, CUSTOMER_TERRITORY
FROM     ADG.NF_CUSTOMER
;

--mdm status vs. billing status statistics
SELECT   FACILITYID, MDM_CUST_STATUS_CD,
         MDM_CUST_STATUS_DESC,
         STATUS_CD,
         count(*)
FROM     CRMADMIN.T_WHSE_CUST
--WHERE    FACILITYID = '001'
GROUP BY FACILITYID, MDM_CUST_STATUS_CD, MDM_CUST_STATUS_DESC, STATUS_CD
;


SELECT   FACILITYID , CUSTOMER_NO_FULL , CUSTOMER_NBR_STND , NAME , STATUS_CD , ADDRESS1 , ADDRES2 , STATE_CD , ZIP_CD 
FROM     crmadmin.T_WHSE_CUST
WHERE    MDM_CUST_STATUS_CD = 1
AND      STATUS_CD = 'Z'
AND      FACILITYID = '058'
;

Select * from CRMADMIN.V_WEB_CUSTOMER where CUSTOMER_NBR_STND = 243;
Select * from CRMADMIN.V_WEB_CUSTOMER_FAC where CUSTOMER_NBR_STND = 243;
select * from CRMADMIN.T_WHSE_CUST where CUSTOMER_NBR_STND = 243;
select * from CRMADMIN.T_WHSE_CORPORATION_MDM where CUSTOMER_NBR_STND = 57;

--purged in CRM, non-existant in GOLD
SELECT   c.FACILITYID,
         c.CUSTOMER_NO_FULL,
         c.CUSTOMER_NBR_STND,
         c.NAME,
         c.STATUS_CD,
         c.MDM_CUST_STATUS_CD,
         c.MDM_CUST_STATUS_DESC,
         c.ADDRESS1,
         c.ADDRESS3,
         c.STATE_CD,
         c.ZIP_CD,
         tfc.FACILITYID,
         tfc.CUSTOMER_NBR_STND,
         c.process_timestamp
FROM     crmadmin.T_WHSE_CUST c 
         left outer join etladmin.T_TEMP_FAC_CUST tfc on c.FACILITYID = tfc.FACILITYID and c.CUSTOMER_NBR_STND = tfc.CUSTOMER_NBR_STND and c.TERRITORY_NO = tfc.TERRITORY
WHERE    c.MDM_CUST_STATUS_CD is null
AND      c.STATUS_CD = 'Z'
AND      tfc.FACILITYID is null
order by c.FACILITYID, c.CUSTOMER_NBR_STND
;

update   crmadmin.T_WHSE_CUST set mdm_cust_status_cd = 9, MDM_CUST_STATUS_DESC = 'Purged'
--SELECT   count(*)
--FROM     crmadmin.T_WHSE_CUST
WHERE    (FACILITYID, CUSTOMER_NO_FULL) in (SELECT   c.FACILITYID,
         c.CUSTOMER_NO_FULL
FROM     crmadmin.T_WHSE_CUST c 
         left outer join etladmin.T_TEMP_FAC_CUST tfc on c.FACILITYID = tfc.FACILITYID and c.CUSTOMER_NBR_STND = tfc.CUSTOMER_NBR_STND and c.TERRITORY_NO = tfc.TERRITORY
WHERE    c.MDM_CUST_STATUS_CD is null
AND      c.STATUS_CD = 'Z')
;




--crm purged, not in billing, not in nf_customer
SELECT   c.FACILITYID,
         c.CUSTOMER_NO_FULL,
         c.CUSTOMER_NBR_STND,
         c.NAME,
         c.STATUS_CD,
         c.MDM_CUST_STATUS_CD,
         c.MDM_CUST_STATUS_DESC,
         c.ADDRESS1,
         c.ADDRESS3,
         c.STATE_CD,
         c.ZIP_CD,
         tfc.FACILITYID,
         tfc.CUSTOMER_NBR_STND, c.process_timestamp
FROM     crmadmin.T_WHSE_CUST c 
         left outer join etladmin.T_TEMP_FAC_CUST tfc on c.FACILITYID = tfc.FACILITYID and c.CUSTOMER_NBR_STND = tfc.CUSTOMER_NBR_STND and c.TERRITORY_NO = tfc.TERRITORY
WHERE    tfc.FACILITYID is null
AND      c.STATUS_CD = 'Z' and c.mdm_cust_status_cd <> 9
order by c.FACILITYID, c.CUSTOMER_NBR_STND
;

update   crmadmin.T_WHSE_CUST set mdm_cust_status_cd = 9, MDM_CUST_STATUS_DESC = 'Purged'
--SELECT   count(*)
--FROM     crmadmin.T_WHSE_CUST
WHERE    (FACILITYID, CUSTOMER_NO_FULL) in (SELECT   c.FACILITYID,
         c.CUSTOMER_NO_FULL
FROM     crmadmin.T_WHSE_CUST c 
         left outer join etladmin.T_TEMP_FAC_CUST tfc on c.FACILITYID = tfc.FACILITYID and c.CUSTOMER_NBR_STND = tfc.CUSTOMER_NBR_STND and c.TERRITORY_NO = tfc.TERRITORY
WHERE    tfc.FACILITYID is null
AND      c.STATUS_CD = 'Z' and c.mdm_cust_status_cd <> 9
order by c.FACILITYID, c.CUSTOMER_NBR_STND)
;

commit;

--crm purged, not in billing, in nf_customer
SELECT   c.FACILITYID,
         c.CUSTOMER_NO_FULL,
         c.CUSTOMER_NBR_STND,
         c.NAME,
         c.STATUS_CD,
         c.MDM_CUST_STATUS_CD,
         c.MDM_CUST_STATUS_DESC,
         c.ADDRESS1,
         c.ADDRESS3,
         c.STATE_CD,
         c.ZIP_CD,
         tfc.FACILITYID,
         tfc.CUSTOMER_NBR_STND, c.process_timestamp
FROM     crmadmin.T_WHSE_CUST c 
         left outer join etladmin.T_TEMP_FAC_CUST tfc on c.FACILITYID = tfc.FACILITYID and c.CUSTOMER_NBR_STND = tfc.CUSTOMER_NBR_STND and c.TERRITORY_NO = tfc.TERRITORY
WHERE    tfc.FACILITYID is not null
AND      c.STATUS_CD = 'Z' and c.mdm_cust_status_cd <> 9
order by c.FACILITYID, c.CUSTOMER_NBR_STND
;

update   crmadmin.T_WHSE_CUST set mdm_cust_status_cd = 9, MDM_CUST_STATUS_DESC = 'Purged'
--SELECT   count(*)
--FROM     crmadmin.T_WHSE_CUST
WHERE    (FACILITYID, CUSTOMER_NO_FULL) in (SELECT   c.FACILITYID,
         c.CUSTOMER_NO_FULL
FROM     crmadmin.T_WHSE_CUST c 
         left outer join etladmin.T_TEMP_FAC_CUST tfc on c.FACILITYID = tfc.FACILITYID and c.CUSTOMER_NBR_STND = tfc.CUSTOMER_NBR_STND and c.TERRITORY_NO = tfc.TERRITORY
WHERE    tfc.FACILITYID is not null
AND      c.STATUS_CD = 'Z')
;

commit;

--active in nf_customer, otherwise in CRM / Billing
--more than doubled on 8/24
SELECT   c.FACILITYID,
         c.CUSTOMER_NO_FULL,
         c.CUSTOMER_NBR_STND,
         c.NAME,
         c.STATUS_CD,
         c.MDM_CUST_STATUS_CD,
         c.MDM_CUST_STATUS_DESC,
         c.ADDRESS1,
         c.ADDRESS3,
         c.STATE_CD,
         c.ZIP_CD,
         tfc.FACILITYID,
         tfc.CUSTOMER_NBR_STND, c.process_timestamp
FROM     crmadmin.T_WHSE_CUST c 
         left outer join etladmin.T_TEMP_FAC_CUST tfc on c.FACILITYID = tfc.FACILITYID and c.CUSTOMER_NBR_STND = tfc.CUSTOMER_NBR_STND and c.TERRITORY_NO = tfc.TERRITORY
WHERE    tfc.FACILITYID is not null
AND      c.FACILITYID <> '001'
AND      (not(c.STATUS_CD = 'A') or c.STATUS_CD is null)
AND      c.mdm_cust_status_cd = 1
order by c.FACILITYID, c.CUSTOMER_NBR_STND
;


--frozen in nf_customer, purged in CRM / Billing
SELECT   c.FACILITYID,
         c.CUSTOMER_NO_FULL,
         c.CUSTOMER_NBR_STND,
         c.NAME,
         c.STATUS_CD,
         c.MDM_CUST_STATUS_CD,
         c.MDM_CUST_STATUS_DESC,
         c.ADDRESS1,
         c.ADDRESS3,
         c.STATE_CD,
         c.ZIP_CD,
         c.process_timestamp
FROM     crmadmin.T_WHSE_CUST c 
         left outer join etladmin.T_TEMP_FAC_CUST tfc on c.FACILITYID = tfc.FACILITYID and c.CUSTOMER_NBR_STND = tfc.CUSTOMER_NBR_STND and c.TERRITORY_NO = tfc.TERRITORY
WHERE    tfc.FACILITYID is not null
AND      c.FACILITYID <> '001'
AND      (not(c.STATUS_CD in ('I', 'A')) or c.STATUS_CD is null)
AND      c.mdm_cust_status_cd = 2
order by c.FACILITYID, c.CUSTOMER_NBR_STND
;

--deleted in nf_customer, otherwise in CRM / Billing
--significantly down on 8/24 (halfish)
SELECT   c.FACILITYID,
         c.CUSTOMER_NO_FULL,
         c.CUSTOMER_NBR_STND,
         c.NAME,
         c.STATUS_CD,
         c.MDM_CUST_STATUS_CD,
         c.MDM_CUST_STATUS_DESC,
         c.ADDRESS1,
         c.ADDRESS3,
         c.STATE_CD,
         c.ZIP_CD,
         c.process_timestamp
FROM     crmadmin.T_WHSE_CUST c 
         left outer join etladmin.T_TEMP_FAC_CUST tfc on c.FACILITYID = tfc.FACILITYID and c.CUSTOMER_NBR_STND = tfc.CUSTOMER_NBR_STND and c.TERRITORY_NO = tfc.TERRITORY
WHERE    tfc.FACILITYID is not null
AND      c.FACILITYID <> '001'
AND      (not(c.STATUS_CD = 'D') or c.STATUS_CD is null)
AND      c.mdm_cust_status_cd = 3
;

--maintenance not in sync
select * from CRMADMIN.V_WEB_CUSTOMER where CUSTOMER_NBR_STND in (SELECT   CUSTOMER_NBR_STND
FROM     CRMADMIN.V_WEB_CUSTOMER
group by CUSTOMER_NBR_STND 
having count(CORP_CODE) > 1)
;


select * from CRMADMIN.V_WEB_CUSTOMER_FAC where CUSTOMER_NBR_STND in (SELECT   CUSTOMER_NBR_STND
FROM     CRMADMIN.V_WEB_CUSTOMER
group by CUSTOMER_NBR_STND 
having count(*) > 1)
order by CUSTOMER_NBR_STND
;