Select * from LAWADMIN.HREMPUSF where FIELD_KEY = 52;


SELECT   e.COMPANY,
         e.EMPLOYEE,
case when trim(h.ALT_EMPLOYEE) > 0 then h.ALT_EMPLOYEE else e.EMPLOYEE end new_emp,         
e.LAST_NAME,
         e.FIRST_NAME,
         e.MIDDLE_INIT,
         e.MIDDLE_NAME,
         e.NICK_NAME,
         e.EMP_STATUS,
         e.PROCESS_LEVEL,
         e.DEPARTMENT,
         e.USER_LEVEL,
         e.HM_DIST_CO,
         e.HM_ACCT_UNIT,
         e.HM_ACCOUNT,
         e.HM_SUB_ACCT,
         e.JOB_CODE,
         e.SUPERVISOR,
         e.TERM_DATE,
         e.WORK_STATE,
         e.TAX_STATE,
         e.NEW_HIRE_DATE,
         substr(e.FICA_NBR,8,4),
         e.EMAIL_ADDRESS,
         h.ALT_EMPLOYEE
FROM     LAWADMIN.EMPLOYEE e 
         left outer join (select COMPANY, EMP_APP, EMPLOYEE, FIELD_KEY, int(A_FIELD) ALT_EMPLOYEE FROM LAWADMIN.HREMPUSF WHERE FIELD_KEY = 52 AND EMP_APP = 0) h on e.COMPANY = h.COMPANY and e.EMPLOYEE = h.EMPLOYEE 
--where (e.term_date > '2013-11-19' or e.term_date = '1800-01-01') 
;


EMPLOYEE.COMPANY = HREMPUSF.COMPANY
ZEROES                          = HREMPUSF.EMP_APP
EMPLOYEE.EMPLOYEE = HREMPUSF.EMPLOYEE
52                                    =  HREMPUSF.FIELD_KEY
RETURN HREMPUSF.A_FIELD = PS EMP ID (PSUEDO ID).