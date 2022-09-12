Select DC_ID, count(*) from CRMADMIN.T_WHSE_EXE_AASSG where date(CREATE_DTIM) = '2022-08-11' group by DC_ID
;

Select * from CRMADMIN.T_WHSE_EXE_AASSG where date(CREATE_DTIM) = '2022-08-12' and DC_ID = 61 and ASSG_ID = 96840028
;


Select * from CRMADMIN.T_WHSE_EXE_ASELD where date(CREATE_DTIM) = '2022-08-11' and DC_ID = 61 and ASSG_ID = 96840028
;



