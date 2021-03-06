
select * from CRMADMIN.V_WEB_CUSTOMER_TROUBLESHOOT
WHERE    CUSTOMER_NBR_STND = 960068
--WHERE    CUSTOMER_NBR_STND = 649
--AND      FACILITYID = '008'
;
select * from CRMADMIN.V_WEB_CUSTOMER where CUSTOMER_NBR_STND = 3999
;

Select * from CRMADMIN.V_WEB_CUSTOMER where CUSTOMER_NBR_STND = 620143;

Select * from CRMADMIN.V_WEB_CUSTOMER_FAC where CUSTOMER_NBR_STND = 3999;

Select * from CRMADMIN.T_WHSE_CORPORATION_MDM where CUSTOMER_NBR_STND = 3999;

select * from CRMADMIN.V_WEB_CUSTOMER where CUSTOMER_NBR_STND = 3511;
select * from CRMADMIN.V_WEB_CUSTOMER_FAC where CUSTOMER_NBR_STND = 3511;
Select * from CRMADMIN.T_WHSE_CUST where CUSTOMER_NBR_STND = 3511;

SELECT   FACILITYID, CUSTOMER_NBR_STND , ITEM_NBR_HS , count(*)
FROM     CRMADMIN.V_WEB_CUSTOMER_ITEM_ORD_LIMIT
--where CUSTOMER_NBR_STND = 57
group by FACILITYID, CUSTOMER_NBR_STND , ITEM_NBR_HS
having count(*) > 1
;

SELECT  distinct cust.CUSTOMER_NBR_STND,
         cust.TERRITORY_NO,
         case value(cust.STATUS_CD, ' ') when ' ' then 'A' else cust.STATUS_CD end
FROM     CRMADMIN.T_WHSE_CUST cust
WHERE    cust.CUSTOMER_NBR_STND in (10326, 10352 , 10909 , 1100 , 1144 , 1218 , 13312 , 1388 , 152165 , 2107 , 240390 , 248518 , 248521 , 2540 , 2604 , 274456 , 280511 , 3326 , 3511 , 3785 , 3798 , 3800 , 3803 , 3805 , 3930 , 4009 , 4010 , 4048 , 4105 , 4210 , 4215 , 4216 , 4507 , 4562 , 4636 , 50107 , 50123 , 50137 , 5016 , 50265 , 50339 , 564 , 565 , 59251 , 600721 , 607965 , 612 , 615007 , 615437 , 616730 , 620142 , 620143 , 621 , 630 , 634 , 739611 , 739841 , 740050 , 740359 , 740437 , 740646 , 741293 , 741470 , 741535 , 741620 , 741999 , 742035 , 742087 , 742381 , 742631 , 761399 , 8057 , 8354 , 8355 , 8400 , 850625 , 890525 , 891111 , 891112 , 891168 , 891184 , 9227 , 9228 , 960068 , 981 )
--and (cust.STATUS_CD not in ('D', 'Z') or cust.STATUS_CD is null)
;


SELECT   *
FROM     CRMADMIN.V_WEB_CUSTOMER_ITEM_ORD_LIMIT
where ITEM_NBR_HS =  '0029884' and CUSTOMER_NBR_STND = 57
;

-- datawhse02
SELECT   *
FROM     whmgr.dc_customer
WHERE    customer_nbr = 6111
--where origin_id = 'dwhse02'
;

SELECT   *
FROM     CRMADMIN.T_WHSE_CORPORATION_MDM
WHERE    CUSTOMER_NBR_STND in (17819, 17819, 17934, 50408, 50641, 50645, 51501, 51504, 51508, 51509, 51510, 51511, 51513, 51516, 51517, 51519, 51523, 51524, 51525, 51527, 51531, 51532, 51572, 51579, 51920, 51921, 51922, 51925, 51927, 51929, 51930, 51931, 51934, 51936, 51975, 51980, 51990, 51994, 51995, 140125, 140125, 140126, 140126, 140127, 140127, 140128, 140128, 140129, 140129, 140130, 140130, 284856, 300001, 550107, 550108, 550115, 550116, 550118, 550122, 550123, 550137, 550239, 550254, 550265, 550339, 561400, 615031, 615031, 615098, 615098, 615130, 615353, 615353, 615411, 615452, 615452 )

;


select * from CRMADMIN.T_WHSE_CUST where CUSTOMER_NBR_STND = 284856
;


drop index WHSE_CUST_GRP_MDM_U0;


CREATE UNIQUE INDEX NASHNET.WHSE_CUST_GRP_MDM_U0 ON NASHNET.WHSE_CUST_GRP_MDM
(
	FACILITYID,
	CUSTOMER_NBR_STND, GROUP_CD, 
	GROUP_TYPE_CD
);



SELECT   FACILITYID,
	CUSTOMER_NBR_STND, GROUP_CD, 
	GROUP_TYPE_CD,
         count(*)
FROM     NASHNET.WHSE_CUST_GRP_MDM
GROUP BY  FACILITYID,
	CUSTOMER_NBR_STND, GROUP_CD, 
	GROUP_TYPE_CD
having count(*) > 1
;



FACILITYID	CUSTOMER_NBR_STND	GROUP_TYPE_CD
001	31	8

FACILITYID	CUSTOMER_NBR_STND	GROUP_CD	GROUP_TYPE_CD	5
001	79	919	19	2
;

FACILITYID	CUSTOMER_NBR_STND	GROUP_CD	GROUP_TYPE_CD
058	19	3	2
;

SELECT   *
FROM     CRMADMIN.T_WHSE_CUST_GRP
where FACILITYID = '058' and CUSTOMER_NBR_STND = 19 and CUSTOMER_GRP_TYPE = 2 and CUSTOMER_GRP_CLASS = 3
;