--root query
Select facilityid,
       item_nbr,
       sum(case when systemid = 'MDM' then 1 else 0 end) mdm,
       sum(case when systemid = 'SUS' then 1 else 0 end) superset,
       sum(case when systemid = 'BCP' then 1 else 0 end) biceps,
       sum(case when systemid = 'MWB' then 1 when systemid = 'SWB' then 1 else 0 end) billing,
       sum(case when systemid = 'EXE' then 1 else 0 end) exe,
       sum(case when systemid = 'DWH' then 1 else 0 end) data_warehouse
  from CRMADMIN.T_ITEM_SYNC_VALIDATION
  where facilityid in ('001', '058')
group by facilityid,
         item_nbr;

--ignore unconverted
select facilityid, item_nbr, mdm, superset, biceps, billing, exe, data_warehouse, (mdm + superset + biceps + billing + exe + data_warehouse) from          
		(Select facilityid,
		       item_nbr,
		       sum(case when systemid = 'MDM' then 1 else 0 end) mdm,
		       sum(case when systemid = 'SUS' then 1 else 0 end) superset,
		       sum(case when systemid = 'BCP' then 1 else 0 end) biceps,
		       sum(case when systemid = 'MWB' then 1 when systemid = 'SWB' then 1 else 0 end) billing,
		       sum(case when systemid = 'EXE' then 1 else 0 end) exe,
		       sum(case when systemid = 'DWH' then 1 else 0 end) data_warehouse
		  from CRMADMIN.T_ITEM_SYNC_VALIDATION
		  where facilityid in ('058')
		group by facilityid,
	         	 item_nbr)
where mdm <> 0
and (mdm + superset + biceps + billing + exe + data_warehouse) < 6;	      


select * from  CRMADMIN.T_ITEM_SYNC_VALIDATION where facilityid = '001' and SYSTEMID = 'EXE'  	;



Select 	facilityid,
	item_nbr,
	sum(case when systemid = 'MDM' then 1 else 0 end) mdm,
	sum(case when systemid = 'SUS' then 1 else 0 end) superset,
	sum(case when systemid = 'BCP' then 1 else 0 end) biceps,
	sum(case when systemid = 'MWB' then 1 when systemid = 'SWB' then 1 else 0 end) billing,
	sum(case when systemid = 'EXE' then 1 else 0 end) exe,
	sum(case when systemid = 'DWH' then 1 else 0 end) data_warehouse
from CRMADMIN.T_ITEM_SYNC_VALIDATION
group by facilityid, item_nbr;        