SELECT   FACILITYID,
         year(CREATE_DTIM) fiscal_year,
         count(*)
FROM     CRMADMIN.T_WHSE_EXE_ASELD
GROUP BY FACILITYID, year(create_dtim);



SELECT   FACILITYID,
         year(CREATE_DTIM) fiscal_year,
         count(*)
FROM     CRMADMIN.T_WHSE_EXE_AASSG
GROUP BY FACILITYID, year(create_dtim);


SELECT   FACILITYID,
         year(CREATE_DTIM) fiscal_year,
         count(*)
FROM     CRMADMIN.T_WHSE_EXE_LABOR_DTL_WORK_UNIT
GROUP BY FACILITYID, year(create_dtim);


