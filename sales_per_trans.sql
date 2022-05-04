--converted for snowflake
SELECT   pa11.day_of_week day_of_week,
         max(a15.WEEKDAY_DESC) day_of_week0,
         pa11.enterprise_id enterprise_id,
         max(a16.enterprise_desc) enterprise_desc,
         pa11.FORMAT_TYPE_ID FORMAT_TYPE_ID,
         max(TRIM(BOTH ' ' FROM a14.format_type_desc)) format_type_desc,
         pa11.SALES_CHAIN_ID SALES_CHAIN_ID,
         max(a13.chain_short_desc) chain_short_desc,
         max(pa12.WJXBFS1) WJXBFS1,
         max(pa12.WJXBFS2) WJXBFS2
FROM     (

SELECT   a13.WEEKDAY_NBR day_of_week,
         a12.FORMAT_TYPE_ID FORMAT_TYPE_ID,
         a11.SALES_CHAIN_PK SALES_CHAIN_ID,
         a14.enterprise_id enterprise_id
FROM     EDW.RTL.CHAIN a11 
         join SBX_BIZ.MARKETING.LINE a12 on (a11.SALES_CHAIN_PK = a12.SALES_CHAIN_ID) cross 
         join SBX_BIZ.MARKETING.FISCAL_DAY a13 
         join EDW.RTL.CHANNEL a14 on (a11.SALES_CHANNEL_ID = a14.SALES_CHANNEL_PK)
WHERE    (a11.SALES_CHAIN_PK in (110, 210, 250, 270, 280, 420, 410, 400, 230)
     AND ((a13.WEEKDAY_NBR) in (select s22.WEEKDAY_NBR from SBX_BIZ.MARKETING.FISCAL_WEEK s21 join SBX_BIZ.MARKETING.FISCAL_DAY s22 on (s21.FISCAL_WEEK_ID = s22.FISCAL_WEEK_ID) where s21.END_DT = To_Date('04/30/2022', 'mm/dd/yyyy') group by s22.WEEKDAY_NBR)))
GROUP BY a13.WEEKDAY_NBR, a12.FORMAT_TYPE_ID, a11.SALES_CHAIN_PK, 
         a14.enterprise_id
) pa11 
         left outer join (

SELECT   a13.SALES_CHAIN_ID SALES_CHAIN_ID,
         a13.FORMAT_TYPE_ID FORMAT_TYPE_ID,
         a12.WEEKDAY_NBR day_of_week,
         sum(a11.ADJ_TRANS_CNT) WJXBFS1,
         sum(a11.TOTAL_SALES_AMT) WJXBFS2
FROM     SBX_BIZ.MARKETING.EFIN_DAY_LINE a11 
         join SBX_BIZ.MARKETING.FISCAL_DAY a12 on (a11.SALES_DT = a12.SALES_DT) 
         join SBX_BIZ.MARKETING.LINE a13 on (a11.SALES_LINE_ID = a13.SALES_LINE_ID) 
         join SBX_BIZ.MARKETING.FISCAL_WEEK a14 on (a12.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    (a11.comp_status_key in (1)
     AND a13.SALES_CHAIN_ID in (110, 210, 250, 270, 280, 420, 410, 400, 230)
     AND a14.END_DT = To_Date('04/30/2022', 'mm/dd/yyyy'))
GROUP BY a13.SALES_CHAIN_ID, a13.FORMAT_TYPE_ID, a12.WEEKDAY_NBR


) pa12 on (pa11.FORMAT_TYPE_ID = pa12.FORMAT_TYPE_ID and pa11.SALES_CHAIN_ID = pa12.SALES_CHAIN_ID and pa11.day_of_week = pa12.day_of_week) 
         join chain a13 on (pa11.SALES_CHAIN_ID = a13.SALES_CHAIN_ID) 
         join sales_line_format a14 on (pa11.FORMAT_TYPE_ID = a14.FORMAT_TYPE_ID) 
         join FISCAL_DAY a15 on (pa11.day_of_week = a15.WEEKDAY_NBR) 
         join enterprise a16 on (pa11.enterprise_id = a16.enterprise_id)
WHERE    (pa11.SALES_CHAIN_ID in (110, 210, 250, 270, 280, 420, 410, 400, 230)
     AND ((pa11.day_of_week) in (select s22.WEEKDAY_NBR from FISCAL_WEEK s21 join FISCAL_DAY s22 on (s21.FISCAL_WEEK_ID = s22.FISCAL_WEEK_ID) where s21.END_DT = To_Date('04/30/2022', 'mm/dd/yyyy') group by s22.WEEKDAY_NBR)))
GROUP BY pa11.day_of_week, pa11.enterprise_id, pa11.FORMAT_TYPE_ID, 
         pa11.SALES_CHAIN_ID
;



-- EDW.RTL.RETAIL_SALES_DEPT_COUNT_VW source

create or replace view RETAIL_SALES_DEPT_COUNT_VW(
	SALES_DATE_ID,
	STORE_NBR,
	DEPT_KEY,
	EVENT_CD,
	DISCOUNT_TYPE_CD,
	ITEM_CNT,
	DEPT_ADJ_TRANS_CNT,
	ADJ_TRANS_CNT,
	CREATE_TMSP,
	UPDATE_TMSP
) as                
SELECT                                                       
  SALES_DATE_ID,                                             
  STORE_NBR,                                                 
  DEPT_KEY,                                                  
  EVENT_CD,                                                  
  DISCOUNT_TYPE_CD,                                          
  SUM(ITEM_CNT) ITEM_CNT,                                    
  CAST(                                                      
    SUM(DEPT_ADJ_TRANS_CNT) AS NUMBER(18, 0)                 
  ) DEPT_ADJ_TRANS_CNT,                                      
  CAST(                                                      
    SUM(ADJ_TRANS_CNT) AS NUMBER(18, 0)                      
  ) ADJ_TRANS_CNT,                                           
  CREATE_TMSP,                                               
  UPDATE_TMSP                                                
FROM                                                         
  (                                                          
    SELECT   A.SALES_DATE_ID,
         A.STORE_NBR,
         A.DEPT_KEY,
         'REG' AS EVENT_CD,
         '00' AS DISCOUNT_TYPE_CD,
         SUM(TOTAL_SALES_QTY) AS ITEM_CNT,
         COUNT( DISTINCT DISCOUNT_TYPE_CD || TRANS_NBR || REGISTER_ID ) AS DEPT_ADJ_TRANS_CNT,
         0 AS ADJ_TRANS_CNT,
         TO_TIMESTAMP_NTZ( DATE(A.SALES_DATE_ID, 'YYYYMMDD') ) CREATE_TMSP,
         TO_TIMESTAMP_NTZ( DATE(A.SALES_DATE_ID, 'YYYYMMDD') ) UPDATE_TMSP
FROM     str_trans_dtl_ctmsp_mv A
WHERE    LINE_TYPE IN ('N0', 'N2', 'N8', 'T0', 'T2', 'T8')
GROUP BY 1, 2, 3                   
    UNION                                                    
    SELECT   A.SALES_DATE_ID,
         A.STORE_NBR,
         MAX(A.DEPT_KEY) DEPT_KEY,
         'REG' AS EVENT_CD,
         '00' AS DISCOUNT_TYPE_CD,
         0 AS ITEM_CNT,
         0 AS DEPT_ADJ_TRANS_CNT,
         COUNT( DISTINCT DISCOUNT_TYPE_CD || TRANS_NBR || REGISTER_ID ) AS ADJ_TRANS_CNT,
         TO_TIMESTAMP_NTZ( DATE(A.SALES_DATE_ID, 'YYYYMMDD') ) CREATE_TMSP,
         TO_TIMESTAMP_NTZ( DATE(A.SALES_DATE_ID, 'YYYYMMDD') ) UPDATE_TMSP
FROM     str_trans_dtl_ctmsp_mv A
WHERE    LINE_TYPE IN ('N0', 'N2', 'N8', 'T0', 'T2', 'T8')
GROUP BY 1, 2                          
  ) SALESAGG                                                 
GROUP BY                                                     
  1,                                                         
  2,                                                         
  3,                                                         
  4,                                                         
  5,                                                         
  9,                                                         
  10;



create table TCFWZC57BOL000 as


--Pass1 - 	[Netezza DSSPRD Database Instance]
--	Query Pass Start Time:		4/25/2022 8:51:29 AM
--	Query Pass End Time:		4/25/2022 8:51:30 AM
--	Query Execution:	0:00:00.91
--	Data Fetching and Processing:	0:00:00.00
--	  Data Transfer from Datasource(s):	0:00:00.00
--	Other Processing:	0:00:00.43
create table T47F1L6RDOL001 as


--Pass2 - 	[Netezza DSSPRD Database Instance]
--	Query Pass Start Time:		4/25/2022 8:51:30 AM
--	Query Pass End Time:		4/25/2022 8:51:31 AM
--	Query Execution:	0:00:00.73
--	Data Fetching and Processing:	0:00:00.00
--	  Data Transfer from Datasource(s):	0:00:00.00
--	Other Processing:	0:00:00.43
--	Rows selected: 112
SELECT   pa11.day_of_week day_of_week,
         max(a15.WEEKDAY_DESC) day_of_week0,
         pa11.enterprise_id enterprise_id,
         max(a16.enterprise_desc) enterprise_desc,
         pa11.FORMAT_TYPE_ID FORMAT_TYPE_ID,
         max(TRIM(BOTH ' ' FROM a14.format_type_desc)) format_type_desc,
         pa11.SALES_CHAIN_ID SALES_CHAIN_ID,
         max(a13.chain_short_desc) chain_short_desc,
         max(pa12.WJXBFS1) WJXBFS1,
         max(pa12.WJXBFS2) WJXBFS2
FROM     (

SELECT   a13.WEEKDAY_NBR day_of_week,
         a12.FORMAT_TYPE_ID FORMAT_TYPE_ID,
         a11.SALES_CHAIN_ID SALES_CHAIN_ID,
         a14.enterprise_id enterprise_id
FROM     chain a11 
         join LINE a12 on (a11.SALES_CHAIN_ID = a12.SALES_CHAIN_ID) cross 
         join FISCAL_DAY a13 
         join channel a14 on (a11.sales_channel_id = a14.sales_channel_id)
WHERE    (a11.SALES_CHAIN_ID in (110, 210, 250, 270, 280, 420, 410, 400, 230)
     AND ((a13.WEEKDAY_NBR) in (select s22.WEEKDAY_NBR from FISCAL_WEEK s21 join FISCAL_DAY s22 on (s21.FISCAL_WEEK_ID = s22.FISCAL_WEEK_ID) where s21.END_DT = To_Date('04/30/2022', 'mm/dd/yyyy') group by s22.WEEKDAY_NBR)))
GROUP BY a13.WEEKDAY_NBR, a12.FORMAT_TYPE_ID, a11.SALES_CHAIN_ID, 
         a14.enterprise_id

) pa11 
         left outer join (select a13.SALES_CHAIN_ID SALES_CHAIN_ID, a13.FORMAT_TYPE_ID FORMAT_TYPE_ID, a12.WEEKDAY_NBR day_of_week, sum(a11.ADJ_TRANS_CNT) WJXBFS1, sum(a11.TOTAL_SALES_AMT) WJXBFS2 from efin_day_line a11 
         join FISCAL_DAY a12 on (a11.SALES_DT = a12.SALES_DT) 
         join LINE a13 on (a11.SALES_LINE_ID = a13.SALES_LINE_ID) 
         join FISCAL_WEEK a14 on (a12.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID) where (a11.comp_status_key in (1) and a13.SALES_CHAIN_ID in (110, 210, 250, 270, 280, 420, 410, 400, 230) and a14.END_DT = To_Date('04/30/2022', 'mm/dd/yyyy')) group by a13.SALES_CHAIN_ID, a13.FORMAT_TYPE_ID, a12.WEEKDAY_NBR) pa12 on (pa11.FORMAT_TYPE_ID = pa12.FORMAT_TYPE_ID and pa11.SALES_CHAIN_ID = pa12.SALES_CHAIN_ID and pa11.day_of_week = pa12.day_of_week) 
         join chain a13 on (pa11.SALES_CHAIN_ID = a13.SALES_CHAIN_ID) 
         join sales_line_format a14 on (pa11.FORMAT_TYPE_ID = a14.FORMAT_TYPE_ID) 
         join FISCAL_DAY a15 on (pa11.day_of_week = a15.WEEKDAY_NBR) 
         join enterprise a16 on (pa11.enterprise_id = a16.enterprise_id)
WHERE    (pa11.SALES_CHAIN_ID in (110, 210, 250, 270, 280, 420, 410, 400, 230)
     AND ((pa11.day_of_week) in (select s22.WEEKDAY_NBR from FISCAL_WEEK s21 join FISCAL_DAY s22 on (s21.FISCAL_WEEK_ID = s22.FISCAL_WEEK_ID) where s21.END_DT = To_Date('04/30/2022', 'mm/dd/yyyy') group by s22.WEEKDAY_NBR)))
GROUP BY pa11.day_of_week, pa11.enterprise_id, pa11.FORMAT_TYPE_ID, 
         pa11.SALES_CHAIN_ID
--Pass3 - 	Query Pass Start Time:		4/25/2022 8:51:31 AM
--	Query Pass End Time:		4/25/2022 8:51:31 AM
--	Query Execution:	0:00:00.00
--	Data Fetching and Processing:	0:00:00.00
--	  Data Transfer from Datasource(s):	0:00:00.00
--	Other Processing:	0:00:00.24
--[Populate Report Data]
--
--Pass4 - 	[Netezza DSSPRD Database Instance]
--	Query Pass Start Time:		4/25/2022 8:51:31 AM
--	Query Pass End Time:		4/25/2022 8:51:31 AM
--	Query Execution:	0:00:00.01
--	Data Fetching and Processing:	0:00:00.00
--	  Data Transfer from Datasource(s):	0:00:00.00
--	Other Processing:	0:00:00.20
--drop table T47F1L6RDOL001
--
--Pass5 - 	[Netezza DSSPRD Database Instance]
--	Query Pass Start Time:		4/25/2022 8:51:31 AM
--	Query Pass End Time:		4/25/2022 8:51:31 AM
--	Query Execution:	0:00:00.01
--	Data Fetching and Processing:	0:00:00.00
--	  Data Transfer from Datasource(s):	0:00:00.00
--	Other Processing:	0:00:00.20
--drop table TCFWZC57BOL000
