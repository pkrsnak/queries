SELECT EVTUSERID , EVTALTID , EVTDCRE , EVTDMAJ , EVTTRAIT , EVTLASTUSER , EVTDCREGOLD , EVTDMAJGOLD, 
       case when length(trim(substr(EVTMESS,28,2))) = 1 then '0' || substr(EVTMESS,28,2) else substr(EVTMESS,28,2) end dc,
--       substr(EVTMESS,28,2) dc, 
       case when substr(substr(EVTMESS,35,7),1,1) = ':' then substr(substr(EVTMESS,35,7),2,6) else substr(EVTMESS,35,7) end item, 
       EVTMESS FROM adg.EVTMSG --
-- WHERE substr(trim(EVTMESS),1,4)  in ('2009', '2010')
--   and trim(substr(EVTMESS,28,2)) not in ('0', 'nu', 'ot')
;

SELECT	case when length(trim(case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then 						substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end)) = 1 then '0' || case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end else case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end end dc,
       	trim(substr(EVTMESS, INSTR(EVTMESS,'Code') + 5, 6)) item_nbr,
		EVTUSERID, 
		EVTALTID, 
		EVTDCRE, 
		EVTDMAJ, 
		EVTTRAIT, 
		EVTLASTUSER, 
		EVTDCREGOLD, 
		EVTDMAJGOLD, 
       	EVTMESS
  FROM adg.EVTMSG 
 where case when length(trim(case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end)) = 1 then '0' || case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end else case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end end not in ('00')
;


SELECT  case when INSTR(EVTMESS,'Item:') > 0 then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'Item:') + 6, 3)),1,2) else (case when length(trim(case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then 						substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end)) = 1 then '0' || case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end else case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end end) end  dc,
       	case when INSTR(EVTMESS,'Item:') > 0 then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'Item:') + 6, 9)),3,6) when INSTR(EVTMESS,'BICEPS item') > 0 then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'BICEPS item') + 12, 8)),3,6) else trim(substr(EVTMESS, INSTR(EVTMESS,'Code') + 5, 6)) end item_nbr,
		EVTUSERID, 
		EVTALTID, 
		EVTDCRE, 
		EVTDMAJ, 
		EVTTRAIT, 
		EVTLASTUSER, 
		EVTDCREGOLD, 
		EVTDMAJGOLD, 
       	EVTMESS
  FROM adg.EVTMSG 
 where case when INSTR(EVTMESS,'Item:') > 0 then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'Item:') + 6, 3)),1,2) else (case when length(trim(case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then 						substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end)) = 1 then '0' || case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end else case when instr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)), '.') > 0  then substr(trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)),1,1) else trim(substr(EVTMESS, INSTR(EVTMESS,'DC') + 3, 2)) end end) end not in ('00')
 
;

SELECT EVTALTID, count(*)
  from adg.EVTMSG
group by EVTALTID
having count(*) > 1;



















--
select isi_dc_code, isi_item_code, isi_status, isi_date_create, isi_date_update, isi_last_prog, isi_biceps_read, isi_biceps_exists, isi_biceps_read_time, isi_biceps_tranid 
from adg.nf_item 
where isi_item_code = '40337882' 
or isi_item_code = '01232266' 
or isi_item_code = '01232268';