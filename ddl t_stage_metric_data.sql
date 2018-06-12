--------------------------------------------------
-- Create Table KPIADMIN.T_STAGE_METRIC_DATA
--------------------------------------------------
Drop table KPIADMIN.T_STAGE_METRIC_DATA;

Create table KPIADMIN.T_STAGE_METRIC_DATA (
    FACILITYID                     CHARACTER(3)        NOT NULL    ,
    METRIC_DATE                    DATE                NOT NULL    ,
    METRIC_ID                      INTEGER             NOT NULL    ,
    METRIC_NAME                    VARCHAR(50)                     ,
    METRIC_VALUE                   DECIMAL(31,4)                   ,
    PROCESS_TIMESTAMP              TIMESTAMP                       ) 
in USERSPACE1   ;

--------------------------------------------------
-- Grant Authorities for KPIADMIN.T_STAGE_METRIC_DATA
--------------------------------------------------
grant select on KPIADMIN.T_STAGE_METRIC_DATA to user CISWEB;
grant select,update,insert,delete on KPIADMIN.T_STAGE_METRIC_DATA to user CRMADS;
grant select on KPIADMIN.T_STAGE_METRIC_DATA to user CRMJOB;
grant select on KPIADMIN.T_STAGE_METRIC_DATA to user CRMWEB;
grant select,update,insert,delete,alter,references on KPIADMIN.T_STAGE_METRIC_DATA to user DB2INST1 with grant option;
grant select on KPIADMIN.T_STAGE_METRIC_DATA to group DB2USERS;
grant select,update,insert,delete,alter,references on KPIADMIN.T_STAGE_METRIC_DATA to user ETL with grant option;
grant select on KPIADMIN.T_STAGE_METRIC_DATA to user WEB;


--------------------------------------------------
-- Create Index KPIADMIN.T_STAGE_METRIC_DATA_U0
--------------------------------------------------
create unique Index KPIADMIN.T_STAGE_METRIC_DATA_U0 
	on KPIADMIN.T_STAGE_METRIC_DATA 
	(FACILITYID, METRIC_DATE, METRIC_ID)    Allow Reverse Scans;