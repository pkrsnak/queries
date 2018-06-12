--union for pivot
SELECT   'Purchasing Disc - not billing' type,
         i.FACILITYID,
         count(*) num_records
FROM     CRMADMIN.T_WHSE_ITEM i inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS = 'D'
AND      i.BILLING_STATUS not in ('D', 'Z')
GROUP BY i.FACILITYID
union all
SELECT   'Billing Disc - not purchasing' type,
		 i.FACILITYID,
         count(*) num_records
FROM     CRMADMIN.T_WHSE_ITEM i inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      i.BILLING_STATUS = 'D'
GROUP BY i.FACILITYID
union all
SELECT   'Items not disced, no sales' type,
		 i.FACILITYID,
         count(*) num_records
FROM     CRMADMIN.T_WHSE_ITEM i inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      i.BILLING_STATUS not in ('D', 'Z')
GROUP BY i.FACILITYID
union all
SELECT   'Items DWO no inv no slot' type,
		 i.FACILITYID,
         count(*) num_records
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      ((d.PLATFORM_TYPE = 'LEGACY'
        AND i.NA_TO_TAG in ('A', '9'))
     OR  (d.PLATFORM_TYPE = 'SWAT'
        AND i.BILLING_STATUS = 'I' ))
AND      trim(i.CURRENT_LOCATION) is null
GROUP BY i.FACILITYID
;


--# of items with Purch status ="D" and billing status <> "D"  ( Shows the items with status out of sync )

SELECT   'Purchasing Disc - not billing' type,
         i.FACILITYID,
         count(*) num_records
FROM     CRMADMIN.T_WHSE_ITEM i inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS = 'D'
AND      i.BILLING_STATUS not in ('D', 'Z')
GROUP BY i.FACILITYID
;


--detail
SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.PURCH_STATUS,
         i.PURCH_STATUS_DATE,
         i.BILLING_STATUS,
         i.BILLING_STATUS_DATE,
         i.CURRENT_LOCATION
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS = 'D'
AND      i.BILLING_STATUS not in ('D', 'Z')
;

--# of items with Billing status ="D" and purch status <> "D"  ( Shows the items with status out of sync )

SELECT   'Billing Disc - not purchasing' type,
		 i.FACILITYID,
         count(*) num_records
FROM     CRMADMIN.T_WHSE_ITEM i inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      i.BILLING_STATUS = 'D'
GROUP BY i.FACILITYID
;

--detail
SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.PURCH_STATUS,
         i.PURCH_STATUS_DATE,
         i.BILLING_STATUS,
         i.BILLING_STATUS_DATE,
         i.CURRENT_LOCATION
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      i.BILLING_STATUS = 'D'
;


--# Items with no sales or receipts > 2 years and P&D status <> "D"  ( Shows the items that are candidates to be deleted )

SELECT   'Items not disced, no sales' type,
		 x.FACILITYID,
         count(*) num_records
FROM     (SELECT   i.FACILITYID,
         i.ITEM_NBR,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE_DESCRIP,
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.RESERVE_COMMITTED,
         i.RESERVE_UNCOMMITTED,
         coalesce(i.ITEM_ADDED_DATE, '1900-01-01') ITEM_ADDED,
         coalesce(sales.TOT_QTY_SHIPPED, 0) QTY_SHIPPED_2YRS,
         coalesce(recpts.TOT_QTY_RECVD, 0) QTY_RECVD_2YRS
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID 
         left outer join (SELECT s.FACILITYID, s.ITEM_NBR, sum(s.QTY_SOLD- s.QTY_SCRATCHED) TOT_QTY_SHIPPED FROM CRMADMIN.T_WHSE_SALES_HISTORY_DTL s WHERE s.BILLING_DATE > current date - 2 years AND s.QTY_SOLD- s.QTY_SCRATCHED <> 0 GROUP BY s.FACILITYID, s.ITEM_NBR) sales on i.FACILITYID = sales.FACILITYID and i.ITEM_NBR = sales.ITEM_NBR 
         left outer join (SELECT r.FACILITYID, r.ITEM_NBR, sum(r.QUANTITY) TOT_QTY_RECVD FROM CRMADMIN.T_WHSE_PO_DTL r WHERE r.DATE_RECEIVED > current date - 2 years and r.QUANTITY <> 0 GROUP BY r.FACILITYID, r.ITEM_NBR) recpts on i.FACILITYID = recpts.FACILITYID and i.ITEM_NBR = recpts.ITEM_NBR
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      i.BILLING_STATUS not in ('D', 'Z')
AND      i.FACILITYID not in ('001')
AND      coalesce(i.ITEM_ADDED_DATE, '1900-01-01') < current date - 1 year
AND      (coalesce(sales.TOT_QTY_SHIPPED, 0) = 0
     AND coalesce(recpts.TOT_QTY_RECVD, 0) = 0)) x
GROUP BY x.FACILITYID
;


SELECT   s.FACILITYID,
         s.ITEM_NBR,
         sum(s.QTY_SOLD- s.QTY_SCRATCHED) TOT_QTY_SHIPPED
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL s
--WHERE    s.BILLING_DATE > current date - 2 years
WHERE    s.BILLING_DATE > current date - 2 days
AND      s.QTY_SOLD- s.QTY_SCRATCHED <> 0
GROUP BY s.FACILITYID, s.ITEM_NBR;

SELECT   r.FACILITYID,
         r.ITEM_NBR,
         sum(r.QUANTITY) TOT_QTY_SHIPPED
FROM     CRMADMIN.T_WHSE_PO_DTL r
--WHERE    r.DATE_RECEIVED > current date - 2 years
WHERE    r.DATE_RECEIVED > current date - 2 days
and r.QUANTITY <> 0
GROUP BY r.FACILITYID, r.ITEM_NBR
;

--full query 20150314
SELECT   i.FACILITYID,
         i.ITEM_NBR,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE_DESCRIP,
         i.PURCH_STATUS,
         i.BILLING_STATUS,
         i.RESERVE_COMMITTED,
         i.RESERVE_UNCOMMITTED,
         coalesce(i.ITEM_ADDED_DATE, '1900-01-01') ITEM_ADDED,
         coalesce(sales.TOT_QTY_SHIPPED, 0) QTY_SHIPPED_2YRS,
         coalesce(recpts.TOT_QTY_RECVD, 0) QTY_RECVD_2YRS
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID 
         left outer join (SELECT s.FACILITYID, s.ITEM_NBR, sum(s.QTY_SOLD- s.QTY_SCRATCHED) TOT_QTY_SHIPPED FROM CRMADMIN.T_WHSE_SALES_HISTORY_DTL s WHERE s.BILLING_DATE > current date - 2 years AND s.QTY_SOLD- s.QTY_SCRATCHED <> 0 GROUP BY s.FACILITYID, s.ITEM_NBR) sales on i.FACILITYID = sales.FACILITYID and i.ITEM_NBR = sales.ITEM_NBR 
         left outer join (SELECT r.FACILITYID, r.ITEM_NBR, sum(r.QUANTITY) TOT_QTY_RECVD FROM CRMADMIN.T_WHSE_PO_DTL r WHERE r.DATE_RECEIVED > current date - 2 years and r.QUANTITY <> 0 GROUP BY r.FACILITYID, r.ITEM_NBR) recpts on i.FACILITYID = recpts.FACILITYID and i.ITEM_NBR = recpts.ITEM_NBR
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      i.BILLING_STATUS not in ('D', 'Z')
AND      i.FACILITYID not in ('001')
AND      coalesce(i.ITEM_ADDED_DATE, '1900-01-01') < current date - 1 year
AND      (coalesce(sales.TOT_QTY_SHIPPED, 0) = 0
     AND coalesce(recpts.TOT_QTY_RECVD, 0) = 0);

--# items DWO with 0 on hand 0 on order and no pick slot  ( Shows items that should be flagged Disc)
--	For the Midwest its the Na Tag,  there are several options for DWO. A= pack change and 9 = Pending disc are the 2 that would be used as DWO
--	For the Swat DC's its the billing status of  W but its an I in the DW

--stats
SELECT   'Items DWO no inv no slot' type,
		 i.FACILITYID,
         count(*) num_records
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      ((d.PLATFORM_TYPE = 'LEGACY'
        AND i.NA_TO_TAG in ('A', '9'))
     OR  (d.PLATFORM_TYPE = 'SWAT'
        AND i.BILLING_STATUS = 'I' ))
AND      trim(i.CURRENT_LOCATION) is null
GROUP BY i.FACILITYID
;

--detail
SELECT   i.FACILITYID,
         i.ITEM_NBR_HS,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.PURCH_STATUS,
         i.PURCH_STATUS_DATE,
         i.BILLING_STATUS,
         i.BILLING_STATUS_DATE,
         i.CURRENT_LOCATION
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DIV_XREF d on i.FACILITYID = d.SWAT_ID
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      ((d.PLATFORM_TYPE = 'LEGACY'
        AND i.NA_TO_TAG in ('A', '9'))
     OR  (d.PLATFORM_TYPE = 'SWAT'
        AND i.BILLING_STATUS = 'I' ))
AND      trim(i.CURRENT_LOCATION) is null;

--# of items in Biceps but not in EXE or the billing systems. ( This woudl show items that did not flow to one of the systems)
Select 	facilityid,
	item_nbr,
	sum(case when systemid = 'BCP' then 1 else 0 end) biceps,
	sum(case when systemid = 'MWB' then 1 when systemid = 'SWB' then 1 else 0 end) billing,
	sum(case when systemid = 'EXE' then 1 else 0 end) exe
from CRMADMIN.T_ITEM_SYNC_VALIDATION
group by facilityid, item_nbr
having --(sum(case when systemid = 'BCP' then 1 else 0 end) = 1 and 
(sum(case when systemid = 'MWB' then 1 when systemid = 'SWB' then 1 else 0 end) = 0 or sum(case when systemid = 'EXE' then 1 else 0 end) = 0) --)
;
--# of items in the billing system but not in Biceps. ( This would show items that did not purge from Billing)



--number of items owned by MDM
SELECT   v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         case ic.READY_FOR_CONVERT_FLAG when 'Y' then '2 Recent' when 'N' then '3 Converted' else '1 Not Converted' end CONVERT_FLAG,
         i.FACILITYID,
         d.DEPT_CODE,
         d.DEPT_DESCRIPTION,
         sum(case when trim(i.ROOT_ITEM_NBR) is null then 0 else 1 end) converted,
         sum(case when trim(i.ROOT_ITEM_NBR) is null then 1 else 0 end) unconverted
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_DEPT d on i.ITEM_DEPT = d.DEPT_CODE 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR 
         left outer join ETLADMIN.T_TEMP_MDM_ITEM_CONV_DRIVER ic on v.MASTER_VENDOR = ic.MASTER_VENDOR
WHERE    i.PURCH_STATUS not in ('D', 'Z')
AND      i.FACILITYID = '001'
GROUP BY v.MASTER_VENDOR, v.MASTER_VENDOR_DESC, i.FACILITYID, d.DEPT_CODE, 
         d.DEPT_DESCRIPTION, ic.READY_FOR_CONVERT_FLAG
;



Select MASTER_VENDOR, MASTER_VENDOR_DESC, READY_FOR_CONVERT_FLAG, USER_MODIFIED, PROCESS_TIMESTAMP 
from ETLADMIN.T_TEMP_MDM_ITEM_CONV_DRIVER
--where READY_FOR_CONVERT_FLAG = 'Y'
;

