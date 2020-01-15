--Actual Hours on STD
select FACILITYID, sum(final_std_tim)
from (
SELECT   FACILITYID,
         ASGT_ID,
         ASTA_ID,
         ASSOC_ID,
         end_dtim,
         start_dtim,
         suspend_tim,
         walk_tim,
         wgt_tim,
         ftg_adj_tim,
         wgt_adj_tim,
         dly_adj_tim,
         (end_dtim - start_dtim) std_tim,
         ((hour(end_dtim - start_dtim) * 60) + minute(end_dtim - start_dtim) + (decimal(second(end_dtim - start_dtim)) / 60)) std_tim,
         value(hour(suspend_tim) * 60 + minute(SUSPEND_TIM) + (decimal(second(SUSPEND_TIM)) / 60), 0) suspend_time,
         value(hour(walk_tim) * 60 + minute(walk_tim) + (decimal(second(walk_tim)) / 60), 0) walk_time,
         value(hour(wgt_tim) * 60 + minute(wgt_tim) + (decimal(second(wgt_tim)) / 60), 0) wgt_time,
         value(hour(ftg_adj_tim) * 60 + minute(ftg_adj_tim) + (decimal(second(ftg_adj_tim)) / 60), 0) ftg_adj_time,
         value(hour(wgt_adj_tim) * 60 + minute(wgt_adj_tim) + (decimal(second(wgt_adj_tim)) / 60), 0) wgt_adj_time,
         value(hour(dly_adj_tim) * 60 + minute(dly_adj_tim) + (decimal(second(dly_adj_tim)) / 60), 0) dly_adj_time,
         ((hour(end_dtim - start_dtim) * 60) + minute(end_dtim - start_dtim) + (decimal(second(end_dtim - start_dtim)) / 60)) - value(hour(suspend_tim) * 60 + minute(SUSPEND_TIM) + (decimal(second(SUSPEND_TIM)) / 60), 0) - value(hour(walk_tim) * 60 + minute(walk_tim) + (decimal(second(walk_tim)) / 60), 0) - value(hour(wgt_tim) * 60 + minute(wgt_tim) + (decimal(second(wgt_tim)) / 60), 0) - value(hour(ftg_adj_tim) * 60 + minute(ftg_adj_tim) + (decimal(second(ftg_adj_tim)) / 60), 0) - value(hour(wgt_adj_tim) * 60 + minute(wgt_adj_tim) + (decimal(second(wgt_adj_tim)) / 60), 0) - value(hour(dly_adj_tim) * 60 + minute(dly_adj_tim) + (decimal(second(dly_adj_tim)) / 60), 0) final_std_tim
FROM     CRMADMIN.T_WHSE_EXE_AASSG
WHERE    rpt_dt between '2020-01-05' and '2020-01-11'
AND      asgt_id = 'S'
AND      asta_id = 'C'
AND      assoc_id is not null) x
group by FACILITYID
;

(hour(current timestamp) * 60) + minute(current timestamp) + (decimal(second(current timestamp)) / 60),
 current timestamp - (current timestamp - 14 hour),


select SUM(std_tim - dly_tim)
from act_hours_std
where 1 = 1


(sum)              
                   
         3 12:09:04
= 84.15

;
--STD Hours;
select FACILITYID, SUM(value(hour(std_tim) * 60 + minute(std_tim) + (decimal(second(std_tim)) / 60), 0))                             
from CRMADMIN.T_WHSE_EXE_AASSG                                      
WHERE    rpt_dt between '2020-01-05' and '2020-01-11'
--where phys_whse_id = 1                               
--and rpt_dt between '11/10/2019' and '11/16/2019'
and asgt_id = 'S'   
group by FACILITYID 
;
        55:47:52                            

Total Pallets;
select count(unique curr_pal_no)
from aseld
where phys_whse_id = 1
and assg_id in (select assg_id from aassg
where aassg.phys_whse_id = aseld.phys_whse_id
and aassg.assg_id = aseld.assg_id
and rpt_dt between '11/10/2019' and '11/16/2019')
union
select count(unique curr_pal_no)
from aselh
where phys_whse_id = 1
and assg_id in (select assg_id from aassg
where aassg.phys_whse_id = aselh.phys_whse_id
and aassg.assg_id = aselh.assg_id
and rpt_dt between '11/10/2019' and '11/16/2019')

(count)
        
     191
     263
   = 454

;

--Total Cases;

select FACILITYID, SUM(prod_qty / unit_ship_cse) cases_selected
from CRMADMIN.T_WHSE_EXE_ASELD aseld
where (FACILITYID, assg_id) in 
(select aassg.FACILITYID, aassg.assg_id from CRMADMIN.T_WHSE_EXE_AASSG aassg
where aassg.FACILITYID = aseld.FACILITYID and aassg.phys_whse_id = aseld.phys_whse_id
and aassg.assg_id = aseld.assg_id
and rpt_dt between '2020-01-05' and '2020-01-11')
group by FACILITYID
union
select FACILITYID, SUM(prod_qty / unit_ship_cse) cases_selected
from CRMADMIN.T_WHSE_EXE_ASELH aselh
where (FACILITYID, assg_id) in (select aassg.FACILITYID, aassg.assg_id from CRMADMIN.T_WHSE_EXE_AASSG aassg
where aassg.FACILITYID = aselh.FACILITYID and aassg.phys_whse_id = aselh.phys_whse_id
and aassg.assg_id = aselh.assg_id
and rpt_dt between '2020-01-05' and '2020-01-11')
group by FACILITYID
;
           (sum)
                
3595.00000000000
5284.00000000000
= 8879
