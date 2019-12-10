--SQL Statements:
--create table ZZMD00 as
;
SELECT   bed.FACILITY_ID,
         i.BUYER_ID,
         sum(bed.NOT_SHIP_CASE_QTY) buyer_outs
FROM     DC_BILL_ERROR_DTL bed 
         join DC_ITEM i on (bed.FACILITY_ID = i.FACILITY_ID and bed.ITEM_NBR = i.ITEM_NBR) 
--         join MDSE_CLASS a13 on (i.MDSE_CLASS_KEY = a13.MDSE_CLASS_KEY) 
--         join mdse_catgy a14 on (a13.mdse_catgy_key = a14.mdse_catgy_key) 
--         join mdse_group a15 on (a14.mdse_grp_key = a15.mdse_grp_key) 
         join eisdw01@dss_prd_tcp:whmgr.ship_error se on (bed.SHIP_ERROR_CD = se.SHIP_ERROR_CD) 
         join fiscal_day fd on (bed.TRANSACTION_DATE = fd.SALES_DT) 
         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
WHERE    ((fw.end_dt = '12-07-2019')
     AND bed.FACILITY_ID in (1, 3, 8, 15, 40, 54, 58, 61, 66, 67, 71, 80, 90)
--     AND bed.FACILITY_ID not in (16)
     AND bed.COMMODITY_CODE not in (900)
     AND se.SHIP_ERROR_GRP_CD not in (6))
GROUP BY bed.FACILITY_ID, i.BUYER_ID;

create table ZZSP01 as
select    a11.COMMODITY_CODE  COMMODITY_CODE,
              a11.FACILITY_ID  FACILITY_ID,
              a15.DEPT_KEY  DEPT_KEY,
              a11.TRANSACTION_DATE  SALES_DT,
              a11.CUSTOMER_NBR  CUSTOMER_NBR,
              a12.BUYER_ID  BUYER_ID,
              sum(a11.TOTAL_SALES_AMT)  WJXBFS1
from     DC_SALES_HST  a11
              join        DC_ITEM            a12
                on        (a11.FACILITY_ID = a12.FACILITY_ID and 
              a11.ITEM_NBR = a12.ITEM_NBR)
              join        MDSE_CLASS     a13
                on        (a12.MDSE_CLASS_KEY = a13.MDSE_CLASS_KEY)
              join        mdse_category a14
                on        (a13.mdse_catgy_key = a14.mdse_catgy_key)
              join        mdse_group      a15
                on        (a14.mdse_grp_key = a15.mdse_grp_key)
              join        fiscal_day           a16
                on        (a11.TRANSACTION_DATE = a16.SALES_DT)
              join        fiscal_week        a17
                on        (a16.FISCAL_WEEK_ID = a17.FISCAL_WEEK_ID)
where   (a17.end_dt = To_Date('12/07/2019', 'mm/dd/yyyy')
and a11.FACILITY_ID in (1, 3, 8, 15, 40, 54, 58, 61, 66, 67, 71, 80, 90)
and a11.FACILITY_ID not in (16)
and a11.COMMODITY_CODE not in (900))
group by             a11.COMMODITY_CODE,
              a11.FACILITY_ID,
              a15.DEPT_KEY,
              a11.TRANSACTION_DATE,
              a11.CUSTOMER_NBR,
              a12.BUYER_ID

create table ZZSP02 as
select    a11.COMMODITY_CODE  COMMODITY_CODE,
              a11.FACILITY_ID  FACILITY_ID,
              a15.DEPT_KEY  DEPT_KEY,
              a11.TRANSACTION_DATE  SALES_DT,
              a11.CUSTOMER_NBR  CUSTOMER_NBR,
              a12.BUYER_ID  BUYER_ID,
              sum(a11.SHIP_CASE_QTY)  WJXBFS1
from     DC_WHSE_SHIP_DTL     a11
              join        DC_ITEM            a12
                on        (a11.FACILITY_ID = a12.FACILITY_ID and 
              a11.ITEM_NBR = a12.ITEM_NBR)
              join        MDSE_CLASS     a13
                on        (a12.MDSE_CLASS_KEY = a13.MDSE_CLASS_KEY)
              join        mdse_category a14
                on        (a13.mdse_catgy_key = a14.mdse_catgy_key)
              join        mdse_group      a15
                on        (a14.mdse_grp_key = a15.mdse_grp_key)
              join        fiscal_day           a16
                on        (a11.TRANSACTION_DATE = a16.SALES_DT)
              join        fiscal_week        a17
                on        (a16.FISCAL_WEEK_ID = a17.FISCAL_WEEK_ID)
where   (a17.end_dt = To_Date('12/07/2019', 'mm/dd/yyyy')
and a11.FACILITY_ID in (1, 3, 8, 15, 40, 54, 58, 61, 66, 67, 71, 80, 90)
and a11.FACILITY_ID not in (16)
and a11.COMMODITY_CODE not in (900))
group by             a11.COMMODITY_CODE,
              a11.FACILITY_ID,
              a15.DEPT_KEY,
              a11.TRANSACTION_DATE,
              a11.CUSTOMER_NBR,
              a12.BUYER_ID

create table ZZMD03 as
select    coalesce(pa11.COMMODITY_CODE, pa12.COMMODITY_CODE)  COMMODITY_CODE,
              coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID)  FACILITY_ID,
              coalesce(pa11.DEPT_KEY, pa12.DEPT_KEY)  DEPT_KEY,
              coalesce(pa11.SALES_DT, pa12.SALES_DT)  SALES_DT,
              coalesce(pa11.CUSTOMER_NBR, pa12.CUSTOMER_NBR)  CUSTOMER_NBR,
              coalesce(pa11.BUYER_ID, pa12.BUYER_ID)  BUYER_ID,
              pa11.WJXBFS1  WJXBFS1,
              pa12.WJXBFS1  WJXBFS2
from     ZZSP01  pa11
              full outer join    ZZSP02  pa12
                on        (pa11.BUYER_ID = pa12.BUYER_ID and 
              pa11.COMMODITY_CODE = pa12.COMMODITY_CODE and 
              pa11.CUSTOMER_NBR = pa12.CUSTOMER_NBR and 
              pa11.DEPT_KEY = pa12.DEPT_KEY and 
              pa11.FACILITY_ID = pa12.FACILITY_ID and 
              pa11.SALES_DT = pa12.SALES_DT)

create table ZZMD04 as
select    a11.COMMODITY_CODE  COMMODITY_CODE,
              a11.FACILITY_ID  FACILITY_ID,
              a15.DEPT_KEY  DEPT_KEY,
              a11.TRANSACTION_DATE  SALES_DT,
              a11.CUSTOMER_NBR  CUSTOMER_NBR,
              a12.BUYER_ID  BUYER_ID,
              sum(a11.NOT_SHIP_CASE_QTY)  WJXBFS1
from     DC_BILL_ERROR_DTL     a11
              join        DC_ITEM            a12
                on        (a11.FACILITY_ID = a12.FACILITY_ID and 
              a11.ITEM_NBR = a12.ITEM_NBR)
              join        MDSE_CLASS     a13
                on        (a12.MDSE_CLASS_KEY = a13.MDSE_CLASS_KEY)
              join        mdse_category a14
                on        (a13.mdse_catgy_key = a14.mdse_catgy_key)
              join        mdse_group      a15
                on        (a14.mdse_grp_key = a15.mdse_grp_key)
              join        fiscal_day           a16
                on        (a11.TRANSACTION_DATE = a16.SALES_DT)
              join        fiscal_week        a17
                on        (a16.FISCAL_WEEK_ID = a17.FISCAL_WEEK_ID)
where   (a17.end_dt = To_Date('12/07/2019', 'mm/dd/yyyy')
and a11.FACILITY_ID in (1, 3, 8, 15, 40, 54, 58, 61, 66, 67, 71, 80, 90)
and a11.FACILITY_ID not in (16)
and a11.COMMODITY_CODE not in (900)
and a11.SHIP_ERROR_CD = 'MK')
group by             a11.COMMODITY_CODE,
              a11.FACILITY_ID,
              a15.DEPT_KEY,
              a11.TRANSACTION_DATE,
              a11.CUSTOMER_NBR,
              a12.BUYER_ID

select    coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID, pa13.FACILITY_ID)  FACILITY_ID,
              max(a18.FACILITY_NAME)  FACILITY_NAME,
              a15.FISCAL_WEEK_ID  FISCAL_WEEK_ID,
              max('Week Ending ' || to_char(a111.end_dt, 'mm/dd/yyyy'))  WeekEnding,
              coalesce(pa11.COMMODITY_CODE, pa12.COMMODITY_CODE, pa13.COMMODITY_CODE)  COMMODITY_CODE,
              max(a19.COMMODITY_DESC)  COMMODITY_DESC,
              coalesce(pa11.DEPT_KEY, pa12.DEPT_KEY, pa13.DEPT_KEY)  DEPT_KEY,
              max(a17.dept_name)  dept_name,
              coalesce(pa11.BUYER_ID, pa12.BUYER_ID, pa13.BUYER_ID)  BUYER_ID,
              max(a16.BUYER_NAME)  BUYER_NAME,
              coalesce(pa11.CUSTOMER_NBR, pa12.CUSTOMER_NBR, pa13.CUSTOMER_NBR)  CUSTOMER_NBR,
              max(a14.CUSTOMER_NAME)  CUSTOMER_NAME,
              coalesce(pa11.SALES_DT, pa12.SALES_DT, pa13.SALES_DT)  SALES_DT,
              a14.CORPORATION_ID  CORPORATION_ID,
              max(a110.CORPORATION_NAME)  CORPORATION_NAME,
              max(pa11.WJXBFS1)  WJXBFS1,
              max(pa12.WJXBFS1)  WJXBFS2,
              max(pa12.WJXBFS2)  WJXBFS3,
              max(pa13.WJXBFS1)  WJXBFS4
from     ZZMD00              pa11
              full outer join    ZZMD03              pa12
                on        (pa11.BUYER_ID = pa12.BUYER_ID and 
              pa11.COMMODITY_CODE = pa12.COMMODITY_CODE and 
              pa11.CUSTOMER_NBR = pa12.CUSTOMER_NBR and 
              pa11.DEPT_KEY = pa12.DEPT_KEY and 
              pa11.FACILITY_ID = pa12.FACILITY_ID and 
              pa11.SALES_DT = pa12.SALES_DT)
              full outer join    ZZMD04              pa13
                on        (coalesce(pa11.BUYER_ID, pa12.BUYER_ID) = pa13.BUYER_ID and 
              coalesce(pa11.COMMODITY_CODE, pa12.COMMODITY_CODE) = pa13.COMMODITY_CODE and 
              coalesce(pa11.CUSTOMER_NBR, pa12.CUSTOMER_NBR) = pa13.CUSTOMER_NBR and 
              coalesce(pa11.DEPT_KEY, pa12.DEPT_KEY) = pa13.DEPT_KEY and 
              coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID) = pa13.FACILITY_ID and 
              coalesce(pa11.SALES_DT, pa12.SALES_DT) = pa13.SALES_DT)
              join        DC_CUSTOMER a14
                on        (coalesce(pa11.CUSTOMER_NBR, pa12.CUSTOMER_NBR, pa13.CUSTOMER_NBR) = a14.CUSTOMER_NBR and 
              coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID, pa13.FACILITY_ID) = a14.FACILITY_ID)
              join        fiscal_day           a15
                on        (coalesce(pa11.SALES_DT, pa12.SALES_DT, pa13.SALES_DT) = a15.SALES_DT)
              join        DC_BUYER         a16
                on        (coalesce(pa11.BUYER_ID, pa12.BUYER_ID, pa13.BUYER_ID) = a16.BUYER_ID)
              join        department       a17
                on        (coalesce(pa11.DEPT_KEY, pa12.DEPT_KEY, pa13.DEPT_KEY) = a17.DEPT_KEY)
              join        DC_FACILITY      a18
                on        (coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID, pa13.FACILITY_ID) = a18.FACILITY_ID)
              join        COMMODITY    a19
                on        (coalesce(pa11.COMMODITY_CODE, pa12.COMMODITY_CODE, pa13.COMMODITY_CODE) = a19.COMMODITY_CODE)
              join        DC_CORPORATION         a110
                on        (a14.CORPORATION_ID = a110.CORPORATION_ID)
              join        fiscal_week        a111
                on        (a15.FISCAL_WEEK_ID = a111.FISCAL_WEEK_ID)
group by             coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID, pa13.FACILITY_ID),
              a15.FISCAL_WEEK_ID,
              coalesce(pa11.COMMODITY_CODE, pa12.COMMODITY_CODE, pa13.COMMODITY_CODE),
              coalesce(pa11.DEPT_KEY, pa12.DEPT_KEY, pa13.DEPT_KEY),
              coalesce(pa11.BUYER_ID, pa12.BUYER_ID, pa13.BUYER_ID),
              coalesce(pa11.CUSTOMER_NBR, pa12.CUSTOMER_NBR, pa13.CUSTOMER_NBR),
              coalesce(pa11.SALES_DT, pa12.SALES_DT, pa13.SALES_DT),
              a14.CORPORATION_ID


drop table ZZMD00

drop table ZZSP01

drop table ZZSP02

drop table ZZMD03

drop table ZZMD04
