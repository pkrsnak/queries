--Missing master broker

SELECT   v.FACILITYID,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         v.MASTER_BROKER,
         mb.MSTRBKR_NUMBER
FROM     CRMADMIN.T_WHSE_DIV_XREF d 
         inner join CRMADMIN.T_WHSE_VENDOR v on v.FACILITYID = D.SWAT_ID 
         left outer join CRMADMIN.T_WHSE_VENDOR_MASTERBROKER mb on v.MASTER_BROKER = mb.MSTRBKR_NUMBER
WHERE    v.STATUS not in ('D', 'Z')
AND      d.ACTIVE_FLAG = 'Y'
AND      v.VENDOR_TYPE = 'B'
AND      mb.MSTRBKR_NUMBER is null
--AND      (trim(v.BROKER_NUMBER) <> '' and v.BROKER_NUMBER <> '000000')
;


--Active B record with no corresponding V record

SELECT   b.FACILITYID,
         b.VENDOR_NBR broker_nbr,
         b.VENDOR_NAME broker_name
FROM     CRMADMIN.T_WHSE_DIV_XREF d 
         inner join (select facilityid, VENDOR_NBR, VENDOR_NAME, VENDOR_TYPE from CRMADMIN.T_WHSE_VENDOR where VENDOR_TYPE = 'B' and status not in ('D', 'Z')) b on b.FACILITYID = d.SWAT_ID 
         left outer join (select facilityid, VENDOR_NBR, BROKER_NUMBER, STATUS from CRMADMIN.T_WHSE_VENDOR where VENDOR_TYPE <> 'B' and status not in ('D', 'Z') and trim(BROKER_NUMBER) <> '') v on v.FACILITYID = b.FACILITYID and v.BROKER_NUMBER = b.VENDOR_NBR
WHERE    d.ACTIVE_FLAG = 'Y'
AND      v.VENDOR_NBR is null
;


--Missing AP number


SELECT   v.FACILITYID,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         v.PAYABLE_VENDOR_NBR,
         ap.AP_VENDOR_NBR,
         sum(case i.PURCH_STATUS when 'D' then 0 when 'Z' then 0 else 1 end ) num_items
FROM     CRMADMIN.T_WHSE_DIV_XREF d 
         inner join CRMADMIN.T_WHSE_VENDOR v on v.FACILITYID = D.SWAT_ID 
         left outer join CRMADMIN.T_WHSE_ITEM i on v.FACILITYID = i.FACILITYID and v.VENDOR_NBR = i.VENDOR_NBR 
         left outer join CRMADMIN.T_WHSE_PS_AP_VENDOR ap on trim(v.PAYABLE_VENDOR_NBR) = trim(ap.AP_VENDOR_NBR)
WHERE    v.STATUS not in ('D', 'Z')
AND      v.VENDOR_TYPE <> 'B'
AND      d.ACTIVE_FLAG = 'Y'
AND      ((cast(case ascii(trim(v.PAYABLE_VENDOR_NBR)) when 0 then 0 else trim(v.PAYABLE_VENDOR_NBR) end as bigint) <> cast(case when ascii(trim(ap.AP_VENDOR_NBR)) = 0 then 0 when ap.AP_VENDOR_NBR is null then 0 else trim(ap.AP_VENDOR_NBR) end as bigint))
     OR  cast(case ascii(trim(v.PAYABLE_VENDOR_NBR)) when 0 then 0 else trim(v.PAYABLE_VENDOR_NBR) end as bigint) = 0
     OR  ap.AP_VENDOR_NBR is null)
GROUP BY v.FACILITYID, v.VENDOR_NBR, v.VENDOR_NAME, v.PAYABLE_VENDOR_NBR, 
         ap.AP_VENDOR_NBR;



--Invalid AP number (usually 0)
--Missing AP number
;

--Inactive AP number - number populated but does not correspond to an active AP record.
SELECT   v.FACILITYID,
         v.VENDOR_NBR,
         v.VENDOR_NAME,
         v.PAYABLE_VENDOR_NBR,
         ap.AP_VENDOR_NBR, ap.AP_VENDOR_1_NM, ap.VENDOR_STATUS AP_VENDOR_STATUS,
         sum(case i.PURCH_STATUS when 'D' then 0 when 'Z' then 0 else 1 end ) num_items
FROM     CRMADMIN.T_WHSE_DIV_XREF d 
         inner join CRMADMIN.T_WHSE_VENDOR v on v.FACILITYID = D.SWAT_ID 
         left outer join CRMADMIN.T_WHSE_ITEM i on v.FACILITYID = i.FACILITYID and v.VENDOR_NBR = i.VENDOR_NBR 
         left outer join CRMADMIN.T_WHSE_PS_AP_VENDOR ap on trim(v.PAYABLE_VENDOR_NBR) = trim(ap.AP_VENDOR_NBR)
WHERE    v.STATUS not in ('D', 'Z')
AND      v.VENDOR_TYPE <> 'B'
AND      d.ACTIVE_FLAG = 'Y'
and      ap.VENDOR_STATUS not in ('A')
GROUP BY v.FACILITYID, v.VENDOR_NBR, v.VENDOR_NAME, v.PAYABLE_VENDOR_NBR, ap.AP_VENDOR_1_NM, 
         ap.AP_VENDOR_NBR, ap.VENDOR_STATUS;