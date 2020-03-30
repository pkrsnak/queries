---------------------------------
-- final
---------------------------------

SELECT   tce.BILLING_DATE,
         tce.FACILITYID,
         tce.SHIP_FACILITYID,
         tce.CORPORATION_ID,
         tce.CORPORATION_NAME,
         tce.CUSTOMER_ID,
         tce.CUSTOMER_NAME,
         tce.CUSTOMER_CITY_NAME,
         tce.COMMODITY_CODE,
         tce.ITEM_DEPT,
         i.MERCH_DEPT_GRP,
         i.MERCH_DEPT_GRP_DESC,
         i.MERCH_DEPT,
         i.MERCH_DEPT_DESC,
         i.FULFILL_FACILITYID,
         i.FULFILL_DC_AREA_ID,
         tce.ORDER_TYPE_CD,
         sum(tce.EXT_ORDERED_QTY) order_qty,
         sum(tce.EXT_CUBE) cube
FROM     ETLADMIN.T_TEMP_CV_EXTRACT tce 
         inner join CRMADMIN.T_WHSE_ITEM i on tce.FACILITYID = i.FACILITYID and tce.ITEM_NBR_HS = i.ITEM_NBR_HS
group by tce.BILLING_DATE,
         tce.FACILITYID,
         tce.SHIP_FACILITYID,
         tce.CORPORATION_ID,
         tce.CORPORATION_NAME,
         tce.CUSTOMER_ID,
         tce.CUSTOMER_NAME,
         tce.CUSTOMER_CITY_NAME,
         tce.COMMODITY_CODE,
         tce.ITEM_DEPT,
         i.MERCH_DEPT_GRP,
         i.MERCH_DEPT_GRP_DESC,
         i.MERCH_DEPT,
         i.MERCH_DEPT_DESC,
         i.FULFILL_FACILITYID,
         i.FULFILL_DC_AREA_ID,
         tce.ORDER_TYPE_CD
;

-------------------------------------------------------------------------------------

SELECT   dsh.TRANSACTION_DATE,
         lpad(dsh.FACILITY_ID, 3, 0) facility,
         lpad(dsh.SHIP_FACILITY_ID, 3, 0) ship_facility,
         corp.CORPORATION_ID,
         corp.CORPORATION_NAME,
         dsh.CUSTOMER_NBR,
         cust.CUSTOMER_NAME,
         cust.CUST_CITY_NAME,
         dsh.COMMODITY_CODE,
         lpad(dsh.WHOLESALE_DEPT_ID, 3, 0) ITEM_DEPT,
         lpad(dsh.ITEM_NBR, 7, 0) item_nbr_hs,
         dsh.ORDER_TYPE_CD,
         sum(dsh.ORDERED_QTY) ext_ordered_qty,
         sum((dsh.ORDERED_QTY * i.SHIP_CASE_CUBE_MSR)) ext_cube
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join wh_owner.DC_ITEM i on dsh.FACILITY_ID = i.FACILITY_ID and dsh.ITEM_NBR = i.ITEM_NBR 
         inner join WH_OWNER.DC_CUSTOMER cust on cust.FACILITY_ID = dsh.FACILITY_ID and cust.CUSTOMER_NBR = dsh.CUSTOMER_NBR 
         inner join WH_OWNER.DC_CORPORATION corp on corp.CORPORATION_ID = cust.CORPORATION_ID
WHERE    dsh.TRANSACTION_DATE between '01-05-2020' and '02-29-2020'
AND      dsh.ORDERED_QTY > 0
GROUP BY dsh.TRANSACTION_DATE, dsh.FACILITY_ID, dsh.SHIP_FACILITY_ID, 
         corp.CORPORATION_ID, corp.CORPORATION_NAME, dsh.CUSTOMER_NBR, 
         cust.CUSTOMER_NAME, cust.CUST_CITY_NAME, dsh.WHSE_CMDTY_ID, 
         dsh.COMMODITY_CODE, dsh.WHOLESALE_DEPT_ID, dsh.ITEM_NBR, 
         dsh.ORDER_TYPE_CD;




--------------------------------------------------
-- Create Table ETLADMIN.T_TEMP_FAC_ITEM
--------------------------------------------------
--drop table ETLADMIN.T_TEMP_FAC_ITEM;
Create Table ETLADMIN.T_TEMP_CV_EXTRACT (
    BILLING_DATE                   DATE                NOT NULL     ,
    FACILITYID                     CHAR(3)             NOT NULL     ,
    SHIP_FACILITYID                CHAR(3)             NOT NULL     ,
    CORPORATION_ID                 INTEGER         With Default 0   ,
    CORPORATION_NAME               VARCHAR(30)                      ,
    CUSTOMER_ID                    INTEGER         With Default 0   ,
    CUSTOMER_NAME                  VARCHAR(30)                      ,
    CUSTOMER_CITY_NAME             VARCHAR(30)                      ,
    COMMODITY_CODE                 INTEGER         With Default 0   ,
    ITEM_DEPT                      VARCHAR(3)                       ,
    ITEM_NBR_HS                    CHAR(7)             NOT NULL     , 
    ORDER_TYPE_CD                  CHAR(2)                          ,
    ext_ordered_qty                INTEGER         With Default 0   ,
    EXT_CUBE                       DECIMAL(11,4)   With Default 0   )
in USER04K   
Compress Yes
Organize by Row ;

--------------------------------------------------
-- Grant Authorities for ETLADMIN.T_TEMP_FAC_ITEM
--------------------------------------------------
grant select,update,insert,delete on ETLADMIN.T_TEMP_CV_EXTRACT to user CRMEXPLN;
grant control on ETLADMIN.T_TEMP_CV_EXTRACT to user DB2INST1;
grant select,update,insert,delete,alter,references on ETLADMIN.T_TEMP_CV_EXTRACT to user DB2INST1 with grant option;
grant select,update,insert,delete on ETLADMIN.T_TEMP_CV_EXTRACT to user ETL;
grant select on ETLADMIN.T_TEMP_CV_EXTRACT to user ETLX;
grant select,update,insert,delete on ETLADMIN.T_TEMP_CV_EXTRACT to user MDM;
grant select on ETLADMIN.T_TEMP_CV_EXTRACT to user SIUSER;
grant select on ETLADMIN.T_TEMP_CV_EXTRACT to user WEB;


--------------------------------------------------
-- Create Index ETLADMIN.T_TEMP_FAC_ITEM_U0
--------------------------------------------------
--drop index ETLADMIN.T_TEMP_FAC_ITEM_U0;
create Index ETLADMIN.T_TEMP_CV_EXTRACT_X0 
	on ETLADMIN.T_TEMP_CV_EXTRACT 
	(FACILITYID, ITEM_NBR)   
	Allow Reverse Scans;