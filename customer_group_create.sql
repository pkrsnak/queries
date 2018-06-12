--------------------------------------------------
-- Create Table ETLADMIN.T_WHSE_KEY_CUSTOMER
--------------------------------------------------
DROP table ETLADMIN.T_WHSE_CUSTOMER_GROUP;

Create table ETLADMIN.T_WHSE_CUSTOMER_GROUP(
    CUSTOMER_GROUP_TYPE            VARCHAR(30)         NOT NULL    , 
    CUSTOMER_GROUP_ID              INTEGER             NOT NULL    ,
    CUSTOMER_GROUP_NAME            VARCHAR(50)         NOT NULL    ,
    ADDRESS1                       VARCHAR(50)                     ,
    ADDRESS2                       VARCHAR(50)                     ,
    CITY                           VARCHAR(50)                     ,
    STATE                          VARCHAR(2)                      ,
    ZIP                            VARCHAR(9)                      ,
    TELEPHONE                      VARCHAR(10)                     ,
    OWNER                          VARCHAR(50)                     ,
    CONTACT                        VARCHAR(50)                     ,
    CONTACT_TELEPHONE              VARCHAR(10)                     ,
    CONTACT_EXTENSION              VARCHAR(4)                      ,
    PROCESS_TIMESTAMP              TIMESTAMP                       )
in USERSPACE1   ;

--------------------------------------------------
-- Grant Authorities for ETLADMIN.T_WHSE_CUST_GRP
--------------------------------------------------
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP to user CISWEB;
grant select,update,insert,delete on ETLADMIN.T_WHSE_CUSTOMER_GROUP to user CRMADS;
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP to user CRMJOB;
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP to user CRMWEB;
grant select,update,insert,delete,alter,references on ETLADMIN.T_WHSE_CUSTOMER_GROUP to user DB2INST1 with grant option;
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP to group DB2USERS;
grant select,update,insert,delete on ETLADMIN.T_WHSE_CUSTOMER_GROUP to user ETL;
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP to user WEB;

--------------------------------------------------
-- Create Index ETLADMIN.T_WHSE_CUST_GRP_U0
--------------------------------------------------
create unique Index ETLADMIN.T_WHSE_CUSTOMER_GROUP_U0 
	on ETLADMIN.T_WHSE_CUSTOMER_GROUP
	(CUSTOMER_GROUP_TYPE, CUSTOMER_GROUP_ID)
	Include (CUSTOMER_GROUP_NAME)    Allow Reverse Scans;

--------------------------------------------------
-- Create Table ETLADMIN.T_WHSE_CUST_GRP_XREF 
--------------------------------------------------
DROP table ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF;

Create table ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF (
    CUSTOMER_GROUP_TYPE            VARCHAR(30)         NOT NULL    , 
    CUSTOMER_GROUP_ID              INTEGER             NOT NULL    ,
    FACILITYID                     CHARACTER(3)        NOT NULL    ,
    CUSTOMER_NBR_STND              INTEGER             NOT NULL    ,
    PROCESS_TIMESTAMP              TIMESTAMP                       )
in USERSPACE1   ;

--------------------------------------------------
-- Grant Authorities for ETLADMIN.T_WHSE_CUST_GRP
--------------------------------------------------
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF to user CISWEB;
grant select,update,insert,delete on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF to user CRMADS;
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF to user CRMJOB;
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF to user CRMWEB;
grant select,update,insert,delete,alter,references on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF to user DB2INST1 with grant option;
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF to group DB2USERS;
grant select,update,insert,delete on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF to user ETL;
grant select on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF to user WEB;

----------------------------------------------------
---- Create Index ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF_U0
----------------------------------------------------
create unique Index ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF_U0 
	on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF 
	(CUSTOMER_GROUP_TYPE, CUSTOMER_GROUP_ID, FACILITYID, CUSTOMER_NBR_STND) 
	Allow Reverse Scans;

--------------------------------------------------
-- Create Index ETLADMIN.T_WHSE_KEY_CUSTOMER_X0
--------------------------------------------------
create  Index ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF_X0
	on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF
	(CUSTOMER_NBR_STND, FACILITYID)    Allow Reverse Scans;

--------------------------------------------------
-- Create Index ETLADMIN.T_WHSE_KEY_CUSTOMER_X1
--------------------------------------------------
create  Index ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF_X1
	on ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF
	(CUSTOMER_GROUP_TYPE, CUSTOMER_GROUP_ID)    Allow Reverse Scans;

