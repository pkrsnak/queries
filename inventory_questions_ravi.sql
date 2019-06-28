SELECT   *
FROM     CRMADMIN.T_WHSE_PO_DTL
WHERE    DATE_ORDERED = current date - 365 days
and FORWARD_BUY > 0 and RECEIVED = 0
and LINE_STATUS = 'D'
;


SELECT   pod.FACILITYID,
         ltrim(rtrim(char(T_DATE.COMPANY_YEAR_ID))) || ' - ' || case when T_DATE.COMPANY_PERIOD_ID between 1 and 9 then '0' else '' end || char(T_DATE.COMPANY_PERIOD_ID) period,
         sum(pod.FORWARD_BUY) fwd_buy_qty,
         sum(pod.FORWARD_BUY * pod.LIST_COST) fwd_buy_ext_cost
FROM     CRMADMIN.T_DATE T_DATE 
         inner JOIN CRMADMIN.T_WHSE_PO_DTL pod on T_DATE.DATE_KEY = pod.DATE_ORDERED 
         inner join CRMADMIN.T_WHSE_ITEM i on i.FACILITYID = pod.FACILITYID and i.ITEM_NBR = pod.ITEM_NBR
WHERE    pod.DATE_ORDERED between date('2017-12-31') and date('2018-12-29')
AND      pod.LINE_STATUS in ('D')
AND      pod.FORWARD_BUY > 0
AND      pod.RECEIVED <> 0
GROUP BY pod.FACILITYID, 
         ltrim(rtrim(char(T_DATE.COMPANY_YEAR_ID))) || ' - ' || case when T_DATE.COMPANY_PERIOD_ID between 1 and 9 then '0' else '' end || char(T_DATE.COMPANY_PERIOD_ID)

