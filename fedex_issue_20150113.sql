SELECT   *
FROM     CRMADMIN.T_WHSE_FEDEX
WHERE    CREATE_TIMESTAMP > current date - 1 day
;



select * from CRMADMIN.T_WHSE_XTREME_HST_TRX where TRACKNUM = '357698470179750';

Select * from CRMADMIN.T_WHSE_FEDEX where TRACK_NBR = '357698486015219';
Select * from CRMADMIN.T_WHSE_FEDEX where TRACK_NBR = '357698485926790';

Select * from CRMADMIN.T_WHSE_SALES_HISTORY_DTL_EXT where PALLET_ID = 87270013
--3646899
;

select *
from 
(
Select a.* ,
row_number() over (partition by FACILITYID, TRACKNUM order by shipdate desc) as rownum
from crmadmin.T_WHSE_XTREME_HST_TRX a
)
where rownum = 1
and TRACKNUM = '357698470179750'
;

--Check duplicates:

select FACILITYID, TRACKNUM, INVOICENO from 
(
select FACILITYID, TRACKNUM, INVOICENO
from 
(
Select FACILITYID, TRACKNUM, INVOICENO, 
row_number() over (partition by FACILITYID, TRACKNUM order by shipdate desc) as rownum
from crmadmin.T_WHSE_XTREME_HST_TRX
)
where rownum = 1
)
group by FACILITYID, TRACKNUM, INVOICENO
having count (*) > 1;