--crm - order lines
SELECT   ITEM_FAC,
         DATE_ORDERED,
--         LINE_STATUS,
         count(*)
FROM     CRMADMIN.T_WHSE_PO_DTL
WHERE    DATE_ORDERED between current date - 365 days and current date
GROUP BY ITEM_FAC, DATE_ORDERED
         --LINE_STATUS
;


--netezza - sales lines
SELECT   SHIP_FACILITY_ID,
         TRANSACTION_DATE,
         'sales_lines',
         count(*)
FROM     WH_OWNER.DC_SALES_HST
where TRANSACTION_DATE between '2019-03-10' and '2020-03-08'
group by SHIP_FACILITY_ID,
         TRANSACTION_DATE
;

--dag - user counts
SELECT   PLATFORM,
         SYSTEM, --PROCESS_TIMESTAMP, ACCT_STATUS, 
         count( *)
FROM     DAGADMIN.USER_SYSTEM
where SYSTEM like 'sptnash17:%'
GROUP BY PLATFORM, SYSTEM --, PROCESS_TIMESTAMP , ACCT_STATUS
;