Select * from CRMADMIN.T_WHSE_CUST where NAME like '%GORDY%' and FACILITYID in ('002', '008', '054') and STATUS_CD not in ('Z') ;

update CRMADMIN.T_WHSE_CUST set CUST_CORPORATION = 279
where NAME like '%GORDY%' and FACILITYID in ('002', '008', '054') and STATUS_CD not in ('Z') ;

Select * from CRMADMIN.T_WHSE_CUST where NAME like '%MEGA FOODS%'and FACILITYID in ('002', '008', '054') and STATUS_CD not in ('Z') ;

update CRMADMIN.T_WHSE_CUST set CUST_CORPORATION = 279 where NAME like '%MEGA FOODS%'and FACILITYID in ('002', '008', '054') and STATUS_CD not in ('Z') ;


select distinct CUST_CORPORATION from CRMADMIN.T_WHSE_CUST;