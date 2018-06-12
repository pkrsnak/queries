--Detail - RPAs
Select (case DIS_ACCOUNT when 385300 then 'Performance Promo Allowance - 385300'
                           when 385305 then 'Perf. Promo Exception vendor  - 385305'
                           else ' ' end) as Type,
       VENDOR, INVOICE, PROC_LEVEL, DESCRIPTION, DIST_COMPANY, DIS_ACCT_UNIT, DIS_ACCOUNT, ORIG_TRAN_AMT, DISTRIB_DATE
  from LAWADMIN.APDISTRIB
 where DIS_ACCOUNT in (385300, 385305)
   and DISTRIB_DATE between '2006-12-31' and '2007-12-29';


--Summary -  RPAs
Select VENDOR, (case DIS_ACCOUNT when 385300 then 'Performance Promo Allowance - 385300'
                           when 385305 then 'Perf. Promo Exception vendor  - 385305'
                           else ' ' end) as Type,
       PROC_LEVEL, DESCRIPTION, DIST_COMPANY, DIS_ACCT_UNIT, sum(ORIG_TRAN_AMT) as Amount
  from LAWADMIN.APDISTRIB
 where DIS_ACCOUNT in (385300, 385305)
   and DISTRIB_DATE between '2006-12-31' and '2007-12-29'
group by VENDOR, (case DIS_ACCOUNT when 385300 then 'Performance Promo Allowance - 385300'
                           when 385305 then 'Perf. Promo Exception vendor  - 385305'
                           else ' ' end),
       PROC_LEVEL, DESCRIPTION, DIST_COMPANY, DIS_ACCT_UNIT;
       
       
       
--Detail - RPA Admin Fee 385325 385326
Select (case DIS_ACCOUNT when 385325 then 'Performance Promo Allowance - 385325'
                           when 385326 then 'Perf. Promo Exception vendor  - 385326'
                           else ' ' end) as Type,
       VENDOR, INVOICE, PROC_LEVEL, DESCRIPTION, DIST_COMPANY, DIS_ACCT_UNIT, DIS_ACCOUNT, ORIG_TRAN_AMT, DISTRIB_DATE
  from LAWADMIN.APDISTRIB
 where DIS_ACCOUNT in (385325, 385326)
   and DISTRIB_DATE between '2006-12-31' and '2007-12-29'
;

--Summary -  RPA Admin Fee
Select VENDOR, (case DIS_ACCOUNT when 385325 then 'Performance Promo Admin Fee - 385325'
                           when 385326 then 'Perf. Promo Exception vendor Admin Fee  - 385326'
                           else ' ' end) as Type,
       PROC_LEVEL, DESCRIPTION, DIST_COMPANY, DIS_ACCT_UNIT, sum(ORIG_TRAN_AMT) as Amount
  from LAWADMIN.APDISTRIB
 where DIS_ACCOUNT in (385325, 385326)
   and DISTRIB_DATE between '2006-12-31' and '2007-12-29'
group by VENDOR, (case DIS_ACCOUNT when 385325 then 'Performance Promo Admin Fee - 385325'
                           when 385326 then 'Perf. Promo Exception vendor Admin Fee  - 385326'
                           else ' ' end),
       PROC_LEVEL, DESCRIPTION, DIST_COMPANY, DIS_ACCT_UNIT;   
       
       
--Manual adjustments RPAs
Select COMPANY,	
	   FISCAL_YEAR,
	   ACCT_PERIOD,
	   STATUS,
	   ACCT_UNIT,
	   ACCOUNT,
	   SOURCE_CODE,
	   R_DATE,
	   REFERENCE,
	   DESCRIPTION,
	   POSTING_DATE,
	   TRAN_AMOUNT,
	   OPERATOR
  from LAWADMIN.GLTRANS
 where ACCOUNT in (385300, 385305)
   and fiscal_year = 2007 -- between '2007-11-04' and '2007-12-01'
--   and acct_period = 12
   and SOURCE_CODE <> 'AD'
   and status not in (8);  --Accounts Payable;
           
           
--Manual adjustments RPA Admin Fees
Select COMPANY,	
	   FISCAL_YEAR,
	   ACCT_PERIOD,
	   STATUS,
	   ACCT_UNIT,
	   ACCOUNT,
	   SOURCE_CODE,
	   R_DATE,
	   REFERENCE,
	   DESCRIPTION,
	   POSTING_DATE,
	   TRAN_AMOUNT,
	   OPERATOR
  from LAWADMIN.GLTRANS
 where ACCOUNT in (385325, 385326)
   and fiscal_year = 2007 -- between '2007-11-04' and '2007-12-01'
--   and acct_period = 12
   and SOURCE_CODE <> 'AD'
   and status not in (8);  --Accounts Payable;
   
------------------------------------------------------------------------------------------------------------------
-- COOP
------------------------------------------------------------------------------------------------------------------
   
--351160 0000	     Co Op Advertising Income
--351161 0000	     Co Op Advertising Income Private Label
--386190 0000	     Advertising Margin, Central Division   
   
--Detail - COOP
Select (case DIS_ACCOUNT when 351160 then 'Co Op Advertising Income - 351160'
                           when 351161 then 'Co Op Advertising Income Private Label  - 351161'
                           when 386190 then 'Advertising Margin, Central Division  - 386190'
                           else ' ' end) as Type,
       VENDOR, INVOICE, PROC_LEVEL, DESCRIPTION, DIST_COMPANY, DIS_ACCT_UNIT, DIS_ACCOUNT, ORIG_TRAN_AMT, DISTRIB_DATE
  from LAWADMIN.APDISTRIB
 where DIS_ACCOUNT in (351160, 351161, 386190)
   and DISTRIB_DATE between '2006-12-31' and '2007-12-29';


--Summary -  COOP
Select (case DIS_ACCOUNT when 351160 then 'Co Op Advertising Income - 351160'
                           when 351161 then 'Co Op Advertising Income Private Label  - 351161'
                           when 386190 then 'Advertising Margin, Central Division  - 386190'
                           else ' ' end) as Type,
       PROC_LEVEL, DESCRIPTION, DIST_COMPANY, DIS_ACCT_UNIT, sum(ORIG_TRAN_AMT) as Amount
  from LAWADMIN.APDISTRIB
 where DIS_ACCOUNT in (351160, 351161, 386190)
   and DISTRIB_DATE between '2006-12-31' and '2007-12-29'
group by VENDOR, (case DIS_ACCOUNT when 351160 then 'Co Op Advertising Income - 351160'
                           when 351161 then 'Co Op Advertising Income Private Label  - 351161'
                           when 386190 then 'Advertising Margin, Central Division  - 386190'
                           else ' ' end),
       PROC_LEVEL, DESCRIPTION, DIST_COMPANY, DIS_ACCT_UNIT;
          

--Manual adjustments COOP
Select COMPANY,	
	   FISCAL_YEAR,
	   ACCT_PERIOD,
	   STATUS,
	   ACCT_UNIT,
	   ACCOUNT,
	   SOURCE_CODE,
	   R_DATE,
	   REFERENCE,
	   DESCRIPTION,
	   POSTING_DATE,
	   TRAN_AMOUNT,
	   OPERATOR
  from LAWADMIN.GLTRANS
 where ACCOUNT in (351160, 351161, 386190)
   and fiscal_year = 2007 -- between '2007-11-04' and '2007-12-01'
--   and acct_period = 12
   and SOURCE_CODE <> 'AD'
   and status not in (8);  --Accounts Payable;
           