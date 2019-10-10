
--Tables Accessed:
--fiscal_day	
--fiscal_week	
--DC_ITEM	
--DC_BILL_ERROR_DTL	
--DC_WHSE_SHIP_DTL	
--DC_BUYER	
--DC_FACILITY	
--SHIP_ERROR	


--SQL Statements:

--Pass0 -
SELECT   a13.FISCAL_WEEK_ID FISCAL_WEEK_ID,
         a11.FACILITY_ID FACILITY_ID,
         a12.BUYER_ID BUYER_ID,
         sum(a11.NOT_SHIP_CASE_QTY) BUYER_OUTS
FROM     DC_BILL_ERROR_DTL a11 
         join DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR) 
         join fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    (a14.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy')
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900)
     AND a11.SHIP_ERROR_CD = 'MK')
GROUP BY a13.FISCAL_WEEK_ID, a11.FACILITY_ID, a12.BUYER_ID
;


--Pass1 - 	[Netezza DSSPRD Database Instance]
--create table T1NLX20T5MD002 as
SELECT   a13.FISCAL_WEEK_ID FISCAL_WEEK_ID,
         a11.FACILITY_ID FACILITY_ID,
         a12.BUYER_ID BUYER_ID,
         sum(a11.NOT_SHIP_CASE_QTY) BUYER_OUTS
FROM     DC_BILL_ERROR_DTL a11 
         join DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR) 
         join fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join SHIP_ERROR a14 on (a11.SHIP_ERROR_CD = a14.SHIP_ERROR_CD) 
         join fiscal_week a15 on (a13.FISCAL_WEEK_ID = a15.FISCAL_WEEK_ID)
WHERE    (a15.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy')
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900)
     AND a14.SHIP_ERROR_GRP_CD not in (6))
GROUP BY a13.FISCAL_WEEK_ID, a11.FACILITY_ID, a12.BUYER_ID
;

--Pass2 - 	[Netezza DSSPRD Database Instance]
--create table T79EJ1XUXMD001 as
SELECT   a13.FISCAL_WEEK_ID FISCAL_WEEK_ID,
         a11.FACILITY_ID FACILITY_ID,
         a12.BUYER_ID BUYER_ID,
         sum(a11.SHIP_CASE_QTY) cases_shipped
FROM     DC_WHSE_SHIP_DTL a11 
         join DC_ITEM a12 on (a11.FACILITY_ID = a12.FACILITY_ID and a11.ITEM_NBR = a12.ITEM_NBR) 
         join fiscal_day a13 on (a11.TRANSACTION_DATE = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    (a14.end_dt = To_Date('10/05/2019', 'mm/dd/yyyy')
     AND a11.FACILITY_ID not in (16)
     AND a11.COMMODITY_CODE not in (900))
GROUP BY a13.FISCAL_WEEK_ID, a11.FACILITY_ID, a12.BUYER_ID
;


--Pass3 - 	[Netezza DSSPRD Database Instance]
SELECT   coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID, pa13.FACILITY_ID) FACILITY_ID,
         max(a15.FACILITY_NAME) FACILITY_NAME,
         coalesce(pa11.FISCAL_WEEK_ID, pa12.FISCAL_WEEK_ID, pa13.FISCAL_WEEK_ID) FISCAL_WEEK_ID,
         max('Week Ending ' || to_char(a16.end_dt, 'mm/dd/yyyy')) WeekEnding,
         coalesce(pa11.BUYER_ID, pa12.BUYER_ID, pa13.BUYER_ID) BUYER_ID,
         max(a14.BUYER_NAME) BUYER_NAME,
         max(pa11.WJXBFS1) WJXBFS1,
         max(pa12.WJXBFS1) WJXBFS2,
         max(pa13.WJXBFS1) WJXBFS3
FROM     T1NLX20T5MD002 pa11 
         full outer join T79EJ1XUXMD001 pa12 on (pa11.BUYER_ID = pa12.BUYER_ID and pa11.FACILITY_ID = pa12.FACILITY_ID and pa11.FISCAL_WEEK_ID = pa12.FISCAL_WEEK_ID) 
         full outer join TZP9X50SNMD000 pa13 on (coalesce(pa11.BUYER_ID, pa12.BUYER_ID) = pa13.BUYER_ID and coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID) = pa13.FACILITY_ID and coalesce(pa11.FISCAL_WEEK_ID, pa12.FISCAL_WEEK_ID) = pa13.FISCAL_WEEK_ID) 
         join DC_BUYER a14 on (coalesce(pa11.BUYER_ID, pa12.BUYER_ID, pa13.BUYER_ID) = a14.BUYER_ID) 
         join DC_FACILITY a15 on (coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID, pa13.FACILITY_ID) = a15.FACILITY_ID) 
         join fiscal_week a16 on (coalesce(pa11.FISCAL_WEEK_ID, pa12.FISCAL_WEEK_ID, pa13.FISCAL_WEEK_ID) = a16.FISCAL_WEEK_ID)
GROUP BY coalesce(pa11.FACILITY_ID, pa12.FACILITY_ID, pa13.FACILITY_ID), 
         coalesce(pa11.FISCAL_WEEK_ID, pa12.FISCAL_WEEK_ID, pa13.FISCAL_WEEK_ID), 
         coalesce(pa11.BUYER_ID, pa12.BUYER_ID, pa13.BUYER_ID)
Pass4 - 	Query Pass Start Time:		10/9/2019 11:19:46 AM
	Query Pass End Time:		10/9/2019 11:19:46 AM
	Query Execution:	0:00:00.00
	Data Fetching and Processing:	0:00:00.00
	  Data Transfer from Datasource(s):	0:00:00.00
	Other Processing:	0:00:00.17
[Populate Report Data]

Pass5 - 	[Netezza DSSPRD Database Instance]
	Query Pass Start Time:		10/9/2019 11:19:46 AM
	Query Pass End Time:		10/9/2019 11:19:46 AM
	Query Execution:	0:00:00.02
	Data Fetching and Processing:	0:00:00.00
	  Data Transfer from Datasource(s):	0:00:00.00
	Other Processing:	0:00:00.20
drop table T1NLX20T5MD002

Pass6 - 	[Netezza DSSPRD Database Instance]
	Query Pass Start Time:		10/9/2019 11:19:46 AM
	Query Pass End Time:		10/9/2019 11:19:46 AM
	Query Execution:	0:00:00.01
	Data Fetching and Processing:	0:00:00.00
	  Data Transfer from Datasource(s):	0:00:00.00
	Other Processing:	0:00:00.20
drop table T79EJ1XUXMD001

Pass7 - 	[Netezza DSSPRD Database Instance]
	Query Pass Start Time:		10/9/2019 11:19:46 AM
	Query Pass End Time:		10/9/2019 11:19:46 AM
	Query Execution:	0:00:00.01
	Data Fetching and Processing:	0:00:00.00
	  Data Transfer from Datasource(s):	0:00:00.00
	Other Processing:	0:00:00.20
drop table TZP9X50SNMD000

[Analytical engine calculation steps:
	1.  Calculate metric: <Fill Rate> in the dataset

	
	
	select	[Buyer]@[BUYER_ID],
		[Buyer]@[BUYER_NAME],
		[Facility]@[FACILITY_ID],
		[Facility]@[FACILITY_NAME],
		[Fiscal Week]@[FISCAL_WEEK_ID],
		[Fiscal Week]@[WeekEnding],
		[Not Shipped Case Qty],
		[fact.Shipped Case Qty],
		[Not Shipped (Markout)]
	from	Fill Rate Outs by Buyer
	
	2.  Calculate metric: <Fill Rate> in the view
	3.  Perform cross-tabbing
