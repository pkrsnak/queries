Actual Hours on STD
Select SUM(end_dtim - start_dtim) std_tim,                                             
SUM(suspend_tim + walk_tim + wgt_tim + ftg_adj_tim 
+ wgt_adj_tim + dly_adj_tim) dly_tim
from aassg                                                                     
where phys_whse_id = 1                                                         
and rpt_dt between '11/10/2019' and '11/16/2019'                               
and asgt_id = 'S'                                                              
and asta_id = 'C'                                                              
and assoc_id is not null                                                       
INTO TEMP act_hours_std with no log;

select SUM(std_tim - dly_tim)
from act_hours_std
where 1 = 1


(sum)              
                   
         3 12:09:04
= 84.15

STD Hours;
select SUM(std_tim)                             
from aassg                                      
where phys_whse_id = 1                               
and rpt_dt between '11/10/2019' and '11/16/2019'
and asgt_id = 'S'   

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

Total Cases;
select SUM(prod_qty / unit_ship_cse)
from aseld
where phys_whse_id = 1
and assg_id in (select assg_id from aassg
where aassg.phys_whse_id = aseld.phys_whse_id
and aassg.assg_id = aseld.assg_id
and rpt_dt between '11/10/2019' and '11/16/2019')
union
select SUM(prod_qty / unit_ship_cse)
from aselh
where phys_whse_id = 1
and assg_id in (select assg_id from aassg
where aassg.phys_whse_id = aselh.phys_whse_id
and aassg.assg_id = aselh.assg_id
and rpt_dt between '11/10/2019' and '11/16/2019')

           (sum)
                
3595.00000000000
5284.00000000000
= 8879
