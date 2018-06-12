--------------------------------------------------
-- Create Table DAGADMIN.USER_SYSTEM
--------------------------------------------------
drop table DAGADMIN.USER_SYSTEM;
Create table DAGADMIN.USER_SYSTEM (
    PLATFORM                       VARCHAR(15)         NOT NULL    ,
    SYSTEM                         VARCHAR(15)         NOT NULL    ,
    USERID                         VARCHAR(10)                     ,
    EMPLOYEE_NUMBER                INTEGER                         ,
    USERNAME                       VARCHAR(60)                     ,
    PROFILE                        VARCHAR(10)                     ,
    ACCT_STATUS                    VARCHAR(10)                     ,
    RLOGIN_ALLOWED                 VARCHAR(10)                     ,
    LAST_SIGNON                    DATE                            ,
    MULTIPLE_SIGNON                VARCHAR(1)                      ,
    FTP_ALLOWED                    VARCHAR(1)                      ,
    PGRP                           VARCHAR(128)                    ,
    GROUPS                         VARCHAR(128)                    ,
    SU_GROUPS                      VARCHAR(128)                    ,
    USER_TYPE                      VARCHAR(1)                      ,
    USER_CLASS                     VARCHAR(10)                     ,
    PWD_EXPIRATION                 VARCHAR(10)                     ,
    PWD_LAST_UPDATE                VARCHAR(10)                     ,
    PWD_FLAG                       VARCHAR(50)                     ,
    USER_HOME_DIR                  VARCHAR(128)                    ,
    WMS_FLAG                       VARCHAR(10)                     ,
    REPORT_KEY                     VARCHAR(25)         NOT NULL    ,
    PROCESS_TIMESTAMP              TIMESTAMP                       ,
    PROCESS_TYPE                   VARCHAR(1)                      ) 
in USERSPACE1   ;

--------------------------------------------------
-- Grant Authorities for DAGADMIN.USER_SYSTEM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.USER_SYSTEM to user DAGADMIN;
grant select,update,insert,delete,alter,references on DAGADMIN.USER_SYSTEM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.USER_SYSTEM to user ETL;
grant select,update,insert,delete on DAGADMIN.USER_SYSTEM to user WEB;


--------------------------------------------------
-- Create Index DAGADMIN.IX_USER_SYS_EMPNBR
--------------------------------------------------
--drop index DAGADMIN.IX_USER_SYS_EMPNBR;
create  Index DAGADMIN.IX_USER_SYS_EMPNBR 
	on DAGADMIN.USER_SYSTEM 
	(EMPLOYEE_NUMBER)    Allow Reverse Scans;

--------------------------------------------------
-- Create Index DAGADMIN.IX_USER_SYS_PLATFORM
--------------------------------------------------
--drop index DAGADMIN.IX_USER_SYS_PLATFORM;
create  Index DAGADMIN.IX_USER_SYS_PLATFORM 
	on DAGADMIN.USER_SYSTEM 
	(PLATFORM)    Allow Reverse Scans;

--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_ALL
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_ALL;
create view DAGADMIN.v_user_access_all as   select distinct           sv.super_rpts_to as s2_code,           rtrim(s2.last_name) || ', ' || rtrim(s2.first_name) || ' ' || rtrim(s2.middle_init) as s2_name,           em.supervisor as supervisor_code,           rtrim(sv.last_name) || ', ' || rtrim(sv.first_name) || ' ' || rtrim(sv.middle_init) as super_name,     em.employee, rtrim(em.last_name) || ', ' || rtrim(em.first_name) || ' ' || rtrim(em.middle_init) as employee_name,           us.profile,           us.last_signon, um.name unit_name,           dm.name dept_name,           em.emp_status, us.acct_status,           em.process_level,           em.department, us.system,           us.user_class,           us.userid  from dagadmin.employee_master as em      inner join dagadmin.user_system as us on em.employee = us.employee_number        inner join dagadmin.unit_master as um on em.process_level = um.process_level        inner join dagadmin.dept_master as dm on em.company = dm.company and                     em.process_level = dm.process_level and                   em.department = dm.department left outer join  (select distinct e.company, e.employee, e.last_name, e.first_name, e.middle_init,              s.super_rpts_to, s.code from dagadmin.supervisor as s left outer join dagadmin.employee_master as e on e.company = s.company and e.employee = s.employee) as sv      on  em.company = sv.company and em.supervisor = sv.code           left outer join (select distinct s.super_rpts_to, s2.employee, e.last_name, e.first_name, e.middle_init from dagadmin.supervisor as s inner join dagadmin.supervisor as s2 on s.super_rpts_to = s2.code inner join dagadmin.employee_master as e on s2.employee = e.employee and s2.company = e.company) as s2 on sv.super_rpts_to = s2.super_rpts_to;

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_ALL
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_ALL to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_ALL to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_ALL to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_ALL to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_AS400
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_AS400;
create view DAGADMIN.v_user_access_as400  as  Select em.EMPLOYEE, em.LAST_NAME, em.FIRST_NAME, em.MIDDLE_INIT, us.SYSTEM, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, em.PROCESS_LEVEL, um.NAME UNIT_NAME, em.DEPARTMENT,  dm.NAME DEPT_NAME, em.EMP_STATUS    from DAGADMIN.EMPLOYEE_MASTER em,         DAGADMIN.USER_SYSTEM us,         DAGADMIN.UNIT_MASTER um,         DAGADMIN.DEPT_MASTER dm where em.employee = us.employee_number     and em.process_level = um.process_level and em.company = dm.company     and em.process_level = dm.process_level and em.department = dm.department     and us.platform = 'AS400';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_AS400
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_AS400 to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_AS400 to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_AS400 to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_AS400 to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_BICEPS_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_BICEPS_NM;
Create view DAGADMIN.V_USER_ACCESS_BICEPS_NM    (SYSTEM, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS, CICS_STATUS, CICS_NAME, USERID) as    Select us.SYSTEM, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS, xx.ACCT_STATUS CICS_STATUS, xx.USERNAME CICS_NAME, us.USERID from DAGADMIN.EMPLOYEE_MASTER em         right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number         left outer join (select USERID, ACCT_STATUS, USERNAME from DAGADMIN.USER_SYSTEM where platform = 'MAINFRAME' and SYSTEM = 'NPCICS') xx on us.userid = xx.userid   where em.EMPLOYEE is null     and us.USER_CLASS not in ('MDV')     and us.platform = 'BICEPS';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_BICEPS_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_BICEPS_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_BICEPS_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_BICEPS_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_BICEPS_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_DATAMART_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_DATAMART_NM;
Create view DAGADMIN.V_USER_ACCESS_DATAMART_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.USER_CLASS not in ('MDV')     and us.platform = 'UNIX'     and us.system = 'mpunfcdb';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_DATAMART_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_DATAMART_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_DATAMART_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_DATAMART_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_DATAMART_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_ESSBASE_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_ESSBASE_NM;
Create view DAGADMIN.V_USER_ACCESS_ESSBASE_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and (us.platform = 'MICROSOFT'     and us.system = 'Essbase');

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_ESSBASE_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_ESSBASE_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_ESSBASE_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_ESSBASE_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_ESSBASE_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_EXE_DEV_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_EXE_DEV_NM;
Create view DAGADMIN.V_USER_ACCESS_EXE_DEV_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.USER_CLASS not in ('MDV')     and us.platform = 'UNIX'     and us.system = 'eguwms';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_EXE_DEV_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_EXE_DEV_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_EXE_DEV_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_EXE_DEV_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_EXE_DEV_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_EXE_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_EXE_NM;
Create view DAGADMIN.V_USER_ACCESS_EXE_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.platform = 'UNIX'     and us.system = 'mpuwms1';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_EXE_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_EXE_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_EXE_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_EXE_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_EXE_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_FULL_LISTING
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_FULL_LISTING;
Create view DAGADMIN.V_USER_ACCESS_FULL_LISTING   as   SELECT   em.EMPLOYEE,           em.LAST_NAME,           em.FIRST_NAME,           em.MIDDLE_INIT,           us.PROFILE,           us.LAST_SIGNON,           um.NAME UNIT_NAME,           dm.NAME DEPT_NAME,           em.EMP_STATUS,           em.TERM_DATE,           us.ACCT_STATUS,           us.PLATFORM,           us.SYSTEM,           us.USERID,           em.BICEPS_ID,           us.USERNAME  FROM     DAGADMIN.EMPLOYEE_MASTER em,           DAGADMIN.USER_SYSTEM us,           DAGADMIN.UNIT_MASTER um,           DAGADMIN.DEPT_MASTER dm  WHERE    em.employee = us.employee_number  AND      em.process_level = um.process_level  AND      em.company = dm.company  AND      em.process_level = dm.process_level  AND      em.department = dm.department;

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_FULL_LISTING
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_FULL_LISTING to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_FULL_LISTING to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_FULL_LISTING to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_FULL_LISTING to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_FULL_LISTING_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_FULL_LISTING_NM;
Create view DAGADMIN.V_USER_ACCESS_FULL_LISTING_NM    (PLATFORM, SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as Select us.PLATFORM, us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS    from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number where em.EMPLOYEE is null     and us.USER_CLASS not in ('MDV');

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_FULL_LISTING_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_FULL_LISTING_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_FULL_LISTING_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_FULL_LISTING_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_FULL_LISTING_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_GEAC_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_GEAC_NM;
Create view DAGADMIN.V_USER_ACCESS_GEAC_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.platform = 'MAINFRAME'     and us.system = 'MCCICS'     and us.profile in ('NFMSAPAY', 'NFMSAPAY2', 'CRMSAPAY', 'RMMSAPAY');

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_GEAC_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_GEAC_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_GEAC_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_GEAC_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_GEAC_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_LAWSON_DEV_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_LAWSON_DEV_NM;
Create view DAGADMIN.V_USER_ACCESS_LAWSON_DEV_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.USER_CLASS not in ('MDV')     and us.platform = 'UNIX'     and us.system = 'egulawas';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_LAWSON_DEV_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_LAWSON_DEV_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_LAWSON_DEV_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_LAWSON_DEV_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_LAWSON_DEV_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_LAWSON_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_LAWSON_NM;
Create view DAGADMIN.V_USER_ACCESS_LAWSON_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.platform = 'UNIX'     and us.system = 'mpulawas1';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_LAWSON_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_LAWSON_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_LAWSON_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_LAWSON_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_LAWSON_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_MAINFRAME_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_MAINFRAME_NM;
Create view DAGADMIN.V_USER_ACCESS_MAINFRAME_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.platform = 'MAINFRAME';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_MAINFRAME_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MAINFRAME_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_MAINFRAME_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MAINFRAME_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MAINFRAME_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_MDV_USERS
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_MDV_USERS;
create view DAGADMIN.v_user_access_mdv_users  as  select PLATFORM, SYSTEM, USERID, EMPLOYEE_NUMBER, USERNAME, PROFILE, ACCT_STATUS, USER_CLASS  from dagadmin.user_system where user_class = 'MDV';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_MDV_USERS
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MDV_USERS to user DAGADMIN;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MDV_USERS to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MDV_USERS to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MDV_USERS to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_MICROSOFT_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_MICROSOFT_NM;
Create view DAGADMIN.V_USER_ACCESS_MICROSOFT_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and (us.platform = 'MICROSOFT'     and us.system = 'Domain');

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_MICROSOFT_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MICROSOFT_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_MICROSOFT_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MICROSOFT_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_MICROSOFT_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_NOTES_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_NOTES_NM;
Create view DAGADMIN.V_USER_ACCESS_NOTES_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and (us.platform = 'MICROSOFT'     and us.system = 'Notes');

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_NOTES_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_NOTES_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_NOTES_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_NOTES_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_NOTES_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_PLANNING_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_PLANNING_NM;
Create view DAGADMIN.V_USER_ACCESS_PLANNING_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and (us.platform = 'Microsoft'     and us.system = 'mp2klawdev');

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_PLANNING_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_PLANNING_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_PLANNING_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_PLANNING_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_PLANNING_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_SWAT_NM
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_SWAT_NM;
Create view DAGADMIN.V_USER_ACCESS_SWAT_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.USER_CLASS not in ('MDV')     and us.platform = 'AS400'     and substr(us.USERID,1,1) <> 'Q';

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_SWAT_NM
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_SWAT_NM to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_SWAT_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_SWAT_NM to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_SWAT_NM to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS_TERMED_STATUS
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS_TERMED_STATUS;
create view DAGADMIN.V_USER_ACCESS_TERMED_STATUS as  SELECT   em.EMPLOYEE,           em.LAST_NAME,           em.FIRST_NAME,           em.MIDDLE_INIT,           us.PROFILE,           us.LAST_SIGNON,           um.NAME UNIT_NAME,           dm.NAME DEPT_NAME,           em.EMP_STATUS,           em.TERM_DATE,           us.ACCT_STATUS,           us.PLATFORM,           us.SYSTEM,           us.USER_CLASS,           us.USERID  FROM     DAGADMIN.EMPLOYEE_MASTER em,           DAGADMIN.USER_SYSTEM us,           DAGADMIN.UNIT_MASTER um,           DAGADMIN.DEPT_MASTER dm  WHERE    em.employee = us.employee_number  AND      em.process_level = um.process_level  AND      em.company = dm.company  AND      em.process_level = dm.process_level  AND      em.department = dm.department  AND      (us.USER_CLASS not in ('MDV') or us.USER_CLASS is null)  AND      substr(em.EMP_STATUS,1,1) in ('D', 'T')  AND      us.acct_status not in ('DISABLED');

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS_TERMED_STATUS
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_TERMED_STATUS to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS_TERMED_STATUS to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_TERMED_STATUS to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS_TERMED_STATUS to user WEB;


--------------------------------------------------
-- Create View DAGADMIN.V_USER_ACCESS__ROOT
--------------------------------------------------
drop view DAGADMIN.V_USER_ACCESS__ROOT;
create view DAGADMIN.v_user_access__root as   select   rtrim(s2.last_name) || ', ' || rtrim(s2.first_name) || ' ' || rtrim(s2.middle_init) as level2_sup,           rtrim(sv.last_name) || ', ' || rtrim(sv.first_name) || ' ' || rtrim(sv.middle_init) as supervisor,     em.employee,           rtrim(em.last_name) || ', ' || rtrim(em.first_name) || ' ' || rtrim(em.middle_init) as employee_name,           pr.profile_desc,           '_______________' function,           us.last_signon,           um.name unit_name,           dm.name dept_name,           sr.system_desc,           us.userid,           '_______________' ActionRequired,           '_______________' Action,           '_______________' DeptMgrChange,             em.emp_status,             em.process_level,             us.platform,             us.system,             us.profile  from     dagadmin.employee_master as em      inner join dagadmin.user_system as us on em.employee = us.employee_number        inner join dagadmin.unit_master as um on em.process_level = um.process_level        inner join dagadmin.dept_master as dm on em.company = dm.company and                     em.process_level = dm.process_level and                   em.department = dm.department        left outer join  (select e.company, e.employee, e.last_name, e.first_name, e.middle_init,              s.super_rpts_to, s.code              from dagadmin.supervisor as s left outer join                  dagadmin.employee_master as e on e.company = s.company and                              e.employee = s.employee               group by e.company, e.employee, e.last_name, e.first_name, e.middle_init,              s.super_rpts_to, s.code) as sv      on  em.company = sv.company and em.supervisor = sv.code           left outer join (select s.super_rpts_to, s2.employee, e.last_name, e.first_name, e.middle_init                  from dagadmin.supervisor as s inner join                   dagadmin.supervisor as s2 on s.super_rpts_to = s2.code inner join                         dagadmin.employee_master as e                     on s2.employee = e.employee and s2.company = e.company                   group by s.super_rpts_to, s2.employee, e.last_name, e.first_name, e.middle_init) as s2           on sv.super_rpts_to = s2.super_rpts_to                             left outer join dagadmin.system_ref as sr on us.platform = sr.platform                                                    and us.system = sr.system           left outer join dagadmin.profile_ref as pr on us.platform = pr.platform                                                    and us.profile = pr.profile  where em.emp_status in ('A1', 'A2', 'A9', 'L1', 'L3', 'YY')    and us.acct_status in ('ACTIVE', 'INQUIRY');

--------------------------------------------------
-- Grant Authorities for DAGADMIN.V_USER_ACCESS__ROOT
--------------------------------------------------
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS__ROOT to user DAGADMIN;
grant select on DAGADMIN.V_USER_ACCESS__ROOT to user DB2INST2 with grant option;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS__ROOT to user ETL;
grant select,update,insert,delete on DAGADMIN.V_USER_ACCESS__ROOT to user WEB;


--------------------------------------------------
-- Create View DB2INST6.V_USER_ACCESS__ROOT
--------------------------------------------------
drop view DB2INST6.V_USER_ACCESS__ROOT;
--create view v_user_access__root as select   rtrim(s2.last_name) || ', ' || rtrim(s2.first_name) || ' ' || rtrim(s2.middle_init) as level2_sup, rtrim(sv.last_name) || ', ' || rtrim(sv.first_name) || ' ' || rtrim(sv.middle_init) as supervisor, em.employee, rtrim(em.last_name) || ', ' || rtrim(em.first_name) || ' ' || rtrim(em.middle_init) as employee_name, pr.profile_desc, '_______________' function, us.last_signon, um.name unit_name, dm.name dept_name, us.system, us.userid, '_______________' ActionRequired, '_______________' Action, us.platform from     dagadmin.employee_master as em inner join dagadmin.user_system as us on em.employee = us.employee_number inner join dagadmin.unit_master as um on em.process_level = um.process_level inner join dagadmin.dept_master as dm on em.company = dm.company and em.process_level = dm.process_level and      											  em.department = dm.department left outer join  (select e.company, e.employee, e.last_name, e.first_name, e.middle_init, s.super_rpts_to, s.code from dagadmin.supervisor as s left outer join dagadmin.employee_master as e on e.company = s.company and e.employee = s.employee group by e.company, e.employee, e.last_name, e.first_name, e.middle_init, 										   s.super_rpts_to, s.code) as sv on  em.company = sv.company and em.supervisor = sv.code left outer join (select s.super_rpts_to, s2.employee, e.last_name, e.first_name, e.middle_init from dagadmin.supervisor as s inner join dagadmin.supervisor as s2 on s.super_rpts_to = s2.code inner join dagadmin.employee_master as e on s2.employee = e.employee and s2.company = e.company group by s.super_rpts_to, s2.employee, e.last_name, e.first_name, e.middle_init) as s2 on sv.super_rpts_to = s2.super_rpts_to left outer join dagadmin.system_ref as sr on us.platform = sr.platform and us.system = sr.system left outer join dagadmin.profile_ref as pr on us.platform = pr.platform and us.profile = pr.profile where em.emp_status in ('A1', 'A2', 'A9', 'L1', 'L3') and us.acct_status in ('ACTIVE', 'INQUIRY');

--------------------------------------------------
-- Grant Authorities for DB2INST6.V_USER_ACCESS__ROOT
--------------------------------------------------
--grant select on DB2INST6.V_USER_ACCESS__ROOT to user DB2INST2 with grant option;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_ALL
--------------------------------------------------
drop view WEB.V_USER_ACCESS_ALL;
create view web.v_user_access_all as   select distinct           sv.super_rpts_to as s2_code,           rtrim(s2.last_name) || ', ' || rtrim(s2.first_name) || ' ' || rtrim(s2.middle_init) as s2_name,           em.supervisor as supervisor_code,           rtrim(sv.last_name) || ', ' || rtrim(sv.first_name) || ' ' || rtrim(sv.middle_init) as super_name,     em.employee, rtrim(em.last_name) || ', ' || rtrim(em.first_name) || ' ' || rtrim(em.middle_init) as employee_name, us.profile,           us.last_signon, um.name unit_name, dm.name dept_name,           em.emp_status, us.acct_status, em.process_level,           em.department, us.system,           us.user_class, us.userid  from dagadmin.employee_master as em      inner join dagadmin.user_system as us on em.employee = us.employee_number        inner join dagadmin.unit_master as um on em.process_level = um.process_level inner join dagadmin.dept_master as dm on em.company = dm.company and                     em.process_level = dm.process_level and em.department = dm.department left outer join  (select distinct e.company, e.employee, e.last_name, e.first_name, e.middle_init, s.super_rpts_to, s.code from dagadmin.supervisor as s left outer join dagadmin.employee_master as e on e.company = s.company and e.employee = s.employee) as sv      on  em.company = sv.company and em.supervisor = sv.code           left outer join (select distinct s.super_rpts_to, s2.employee, e.last_name, e.first_name, e.middle_init from dagadmin.supervisor as s inner join dagadmin.supervisor as s2 on s.super_rpts_to = s2.code inner join dagadmin.employee_master as e on s2.employee = e.employee and s2.company = e.company) as s2 on sv.super_rpts_to = s2.super_rpts_to;

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_ALL
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_ALL to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_ALL to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_ALL to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_ALL to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_AS400
--------------------------------------------------
drop view WEB.V_USER_ACCESS_AS400;
create view web.v_user_access_as400  as  Select em.EMPLOYEE, em.LAST_NAME, em.FIRST_NAME, em.MIDDLE_INIT, us.SYSTEM, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, em.PROCESS_LEVEL, um.NAME UNIT_NAME, em.DEPARTMENT,  dm.NAME DEPT_NAME, em.EMP_STATUS    from DAGADMIN.EMPLOYEE_MASTER em,         DAGADMIN.USER_SYSTEM us,         DAGADMIN.UNIT_MASTER um,         DAGADMIN.DEPT_MASTER dm where em.employee = us.employee_number     and em.process_level = um.process_level and em.company = dm.company     and em.process_level = dm.process_level and em.department = dm.department     and us.platform = 'AS400';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_AS400
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_AS400 to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_AS400 to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_AS400 to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_AS400 to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_BICEPS_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_BICEPS_NM;
Create view web.V_USER_ACCESS_BICEPS_NM    (SYSTEM, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS, CICS_STATUS, CICS_NAME, USERID) as Select us.SYSTEM, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS, xx.ACCT_STATUS CICS_STATUS, xx.USERNAME CICS_NAME, us.USERID from DAGADMIN.EMPLOYEE_MASTER em         right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number         left outer join (select USERID, ACCT_STATUS, USERNAME from DAGADMIN.USER_SYSTEM where platform = 'MAINFRAME' and SYSTEM = 'NPCICS') xx on us.userid = xx.userid   where em.EMPLOYEE is null     and us.USER_CLASS not in ('MDV')     and us.platform = 'BICEPS';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_BICEPS_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_BICEPS_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_BICEPS_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_BICEPS_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_BICEPS_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_DATAMART_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_DATAMART_NM;
Create view web.V_USER_ACCESS_DATAMART_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.USER_CLASS not in ('MDV')     and us.platform = 'UNIX'     and us.system = 'mpunfcdb';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_DATAMART_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_DATAMART_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_DATAMART_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_DATAMART_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_DATAMART_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_ESSBASE_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_ESSBASE_NM;
Create view web.V_USER_ACCESS_ESSBASE_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and (us.platform = 'MICROSOFT'     and us.system = 'Essbase');

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_ESSBASE_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_ESSBASE_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_ESSBASE_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_ESSBASE_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_ESSBASE_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_EXE_DEV_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_EXE_DEV_NM;
Create view web.V_USER_ACCESS_EXE_DEV_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.USER_CLASS not in ('MDV')     and us.platform = 'UNIX'     and us.system = 'eguwms';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_EXE_DEV_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_EXE_DEV_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_EXE_DEV_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_EXE_DEV_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_EXE_DEV_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_EXE_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_EXE_NM;
Create web.view V_USER_ACCESS_EXE_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.platform = 'UNIX'     and us.system = 'mpuwms1';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_EXE_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_EXE_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_EXE_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_EXE_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_EXE_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_FULL_LISTING
--------------------------------------------------
drop view WEB.V_USER_ACCESS_FULL_LISTING;
Create view web.V_USER_ACCESS_FULL_LISTING   as   SELECT   em.EMPLOYEE, em.LAST_NAME,           em.FIRST_NAME,           em.MIDDLE_INIT, us.PROFILE,           us.LAST_SIGNON,           um.NAME UNIT_NAME, dm.NAME DEPT_NAME,           em.EMP_STATUS,           em.TERM_DATE, us.ACCT_STATUS,           us.PLATFORM,           us.SYSTEM, us.USERID,           em.BICEPS_ID,           us.USERNAME  FROM DAGADMIN.EMPLOYEE_MASTER em,           DAGADMIN.USER_SYSTEM us, DAGADMIN.UNIT_MASTER um,           DAGADMIN.DEPT_MASTER dm  WHERE em.employee = us.employee_number  AND      em.process_level = um.process_level AND      em.company = dm.company  AND      em.process_level = dm.process_level AND      em.department = dm.department;

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_FULL_LISTING
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_FULL_LISTING to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_FULL_LISTING to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_FULL_LISTING to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_FULL_LISTING to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_FULL_LISTING_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_FULL_LISTING_NM;
Create view web.V_USER_ACCESS_FULL_LISTING_NM    (PLATFORM, SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as Select us.PLATFORM, us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS    from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number where em.EMPLOYEE is null     and us.USER_CLASS not in ('MDV');

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_FULL_LISTING_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_FULL_LISTING_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_FULL_LISTING_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_FULL_LISTING_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_FULL_LISTING_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_GEAC_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_GEAC_NM;
Create view web.V_USER_ACCESS_GEAC_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.platform = 'MAINFRAME'     and us.system = 'MCCICS'     and us.profile in ('NFMSAPAY', 'NFMSAPAY2', 'CRMSAPAY', 'RMMSAPAY');

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_GEAC_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_GEAC_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_GEAC_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_GEAC_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_GEAC_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_LAWSON_DEV_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_LAWSON_DEV_NM;
Create view web.V_USER_ACCESS_LAWSON_DEV_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.USER_CLASS not in ('MDV')     and us.platform = 'UNIX'     and us.system = 'egulawas';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_LAWSON_DEV_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_LAWSON_DEV_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_LAWSON_DEV_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_LAWSON_DEV_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_LAWSON_DEV_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_LAWSON_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_LAWSON_NM;
Create view web.V_USER_ACCESS_LAWSON_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.platform = 'UNIX'     and us.system = 'mpulawas1';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_LAWSON_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_LAWSON_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_LAWSON_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_LAWSON_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_LAWSON_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_MAINFRAME_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_MAINFRAME_NM;
Create view web.V_USER_ACCESS_MAINFRAME_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.platform = 'MAINFRAME';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_MAINFRAME_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_MAINFRAME_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_MAINFRAME_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_MAINFRAME_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_MAINFRAME_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_MDV_USERS
--------------------------------------------------
drop view WEB.V_USER_ACCESS_MDV_USERS;
create view web.v_user_access_mdv_users  as  select PLATFORM, SYSTEM, USERID, EMPLOYEE_NUMBER, USERNAME, PROFILE, ACCT_STATUS, USER_CLASS  from dagadmin.user_system where user_class = 'MDV';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_MDV_USERS
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_MDV_USERS to user DAGADMIN;
grant select,update,insert,delete on WEB.V_USER_ACCESS_MDV_USERS to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_MDV_USERS to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_MDV_USERS to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_MICROSOFT_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_MICROSOFT_NM;
Create view web.V_USER_ACCESS_MICROSOFT_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and (us.platform = 'MICROSOFT'     and us.system = 'Domain');

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_MICROSOFT_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_MICROSOFT_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_MICROSOFT_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_MICROSOFT_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_MICROSOFT_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_NOTES_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_NOTES_NM;
Create view web.V_USER_ACCESS_NOTES_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and (us.platform = 'MICROSOFT'     and us.system = 'Notes');

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_NOTES_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_NOTES_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_NOTES_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_NOTES_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_NOTES_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_PLANNING_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_PLANNING_NM;
Create view web.V_USER_ACCESS_PLANNING_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and (us.platform = 'Microsoft'     and us.system = 'mp2klawdev');

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_PLANNING_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_PLANNING_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_PLANNING_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_PLANNING_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_PLANNING_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_SWAT_NM
--------------------------------------------------
drop view WEB.V_USER_ACCESS_SWAT_NM;
Create view web.V_USER_ACCESS_SWAT_NM    (SYSTEM, USERID, USERNAME, PROFILE, ACCT_STATUS, LAST_SIGNON, USER_CLASS)   as    Select us.SYSTEM, us.USERID, us.USERNAME, us.PROFILE, us.ACCT_STATUS, us.LAST_SIGNON, us.USER_CLASS from DAGADMIN.EMPLOYEE_MASTER em right outer join DAGADMIN.USER_SYSTEM us on em.employee = us.employee_number   where em.EMPLOYEE is null and us.USER_CLASS not in ('MDV')     and us.platform = 'AS400'     and substr(us.USERID,1,1) <> 'Q';

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_SWAT_NM
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_SWAT_NM to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_SWAT_NM to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_SWAT_NM to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_SWAT_NM to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS_TERMED_STATUS
--------------------------------------------------
drop view WEB.V_USER_ACCESS_TERMED_STATUS;
create view web.V_USER_ACCESS_TERMED_STATUS as  SELECT   em.EMPLOYEE, em.LAST_NAME,           em.FIRST_NAME,           em.MIDDLE_INIT, us.PROFILE,           us.LAST_SIGNON,           um.NAME UNIT_NAME, dm.NAME DEPT_NAME,           em.EMP_STATUS,           em.TERM_DATE, us.ACCT_STATUS,           us.PLATFORM,           us.SYSTEM, us.USER_CLASS,           us.USERID  FROM     DAGADMIN.EMPLOYEE_MASTER em,           DAGADMIN.USER_SYSTEM us,           DAGADMIN.UNIT_MASTER um, DAGADMIN.DEPT_MASTER dm  WHERE    em.employee = us.employee_number AND      em.process_level = um.process_level  AND      em.company = dm.company AND      em.process_level = dm.process_level  AND      em.department = dm.department  AND      (us.USER_CLASS not in ('MDV') or us.USER_CLASS is null)  AND      substr(em.EMP_STATUS,1,1) in ('D', 'T')  AND      us.acct_status not in ('DISABLED');

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS_TERMED_STATUS
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS_TERMED_STATUS to user DAGADMIN;
grant select on WEB.V_USER_ACCESS_TERMED_STATUS to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS_TERMED_STATUS to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS_TERMED_STATUS to user WEB;


--------------------------------------------------
-- Create View WEB.V_USER_ACCESS__ROOT
--------------------------------------------------
drop view WEB.V_USER_ACCESS__ROOT;
create view web.v_user_access__root as select   rtrim(s2.last_name) || ', ' || rtrim(s2.first_name) || ' ' || rtrim(s2.middle_init) as level2_sup, rtrim(sv.last_name) || ', ' || rtrim(sv.first_name) || ' ' || rtrim(sv.middle_init) as supervisor, em.employee, rtrim(em.last_name) || ', ' || rtrim(em.first_name) || ' ' || rtrim(em.middle_init) as employee_name, pr.profile_desc, '_______________' function, us.last_signon, um.name unit_name, dm.name dept_name, us.system, us.userid, '_______________' ActionRequired, '_______________' Action, us.platform from     dagadmin.employee_master as em inner join dagadmin.user_system as us on em.employee = us.employee_number inner join dagadmin.unit_master as um on em.process_level = um.process_level inner join dagadmin.dept_master as dm on em.company = dm.company and em.process_level = dm.process_level and      											  em.department = dm.department left outer join  (select e.company, e.employee, e.last_name, e.first_name, e.middle_init, s.super_rpts_to, s.code from dagadmin.supervisor as s left outer join dagadmin.employee_master as e on e.company = s.company and e.employee = s.employee group by e.company, e.employee, e.last_name, e.first_name, e.middle_init, 										   s.super_rpts_to, s.code) as sv on  em.company = sv.company and em.supervisor = sv.code left outer join (select s.super_rpts_to, s2.employee, e.last_name, e.first_name, e.middle_init from dagadmin.supervisor as s inner join dagadmin.supervisor as s2 on s.super_rpts_to = s2.code inner join dagadmin.employee_master as e on s2.employee = e.employee and s2.company = e.company group by s.super_rpts_to, s2.employee, e.last_name, e.first_name, e.middle_init) as s2 on sv.super_rpts_to = s2.super_rpts_to left outer join dagadmin.system_ref as sr on us.platform = sr.platform and us.system = sr.system left outer join dagadmin.profile_ref as pr on us.platform = pr.platform and us.profile = pr.profile where em.emp_status in ('A1', 'A2', 'A9', 'L1', 'L3') and us.acct_status in ('ACTIVE', 'INQUIRY');

--------------------------------------------------
-- Grant Authorities for WEB.V_USER_ACCESS__ROOT
--------------------------------------------------
grant select,update,insert,delete on WEB.V_USER_ACCESS__ROOT to user DAGADMIN;
grant select on WEB.V_USER_ACCESS__ROOT to user DB2INST2 with grant option;
grant select,update,insert,delete on WEB.V_USER_ACCESS__ROOT to user ETL;
grant select,update,insert,delete on WEB.V_USER_ACCESS__ROOT to user WEB;
