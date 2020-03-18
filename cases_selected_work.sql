--warehouse cases selected by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         'cases_selected' KPI_TYPE,
          'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
         DATE('2020-02-09') - (DAYOFWEEK(DATE('2020-02-09'))-0) DAYS KPI_DATE,
         FACILITYID KPI_KEY_VALUE,
         sum(cases_selected) KPI_DATA_VALUE
from (
SELECT FACILITYID, SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected FROM CRMADMIN.T_WHSE_EXE_ASELD aseld
WHERE (FACILITYID, assg_id) in (select aassg.FACILITYID, aassg.assg_id from CRMADMIN.T_WHSE_EXE_AASSG aassg
where aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id
AND rpt_dt between DATE('2020-02-09') - (DAYOFWEEK(DATE(''2020-02-09''))+6) DAYS AND DATE(''2020-02-09'') - (DAYOFWEEK(DATE(''2020-02-09''))-0) DAYS)
GROUP BY FACILITYID
) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by dx.ENTERPRISE_KEY, x.FACILITYID
;


SELECT  aseld.* -- aseld.FACILITYID, aseld.WHSE_ID, 
         --SUM((aseld.prod_qty - value(aseld.out_qty,0)) / aseld.unit_ship_cse) cases_selected
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld
WHERE    (FACILITYID, assg_id) in (select aassg.FACILITYID, aassg.assg_id from CRMADMIN.T_WHSE_EXE_AASSG aassg where aassg.FACILITYID = aseld.FACILITYID
     AND aassg.phys_whse_id = aseld.phys_whse_id
     AND aassg.assg_id = aseld.assg_id
     AND aassg.rpt_dt between '2020-02-02' and '2020-02-08')
     AND aseld.FACILITYID = '001'
 --GROUP BY aseld.FACILITYID, aseld.WHSE_ID 

------------------------------------------------------------------
-- tie-out queries
------------------------------------------------------------------

SELECT   FACILITYID,
         SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld
WHERE    (FACILITYID, assg_id) in (select aassg.FACILITYID, aassg.assg_id from CRMADMIN.T_WHSE_EXE_AASSG aassg where aassg.FACILITYID = aseld.FACILITYID
     AND aassg.phys_whse_id = aseld.phys_whse_id
     AND aassg.assg_id = aseld.assg_id
     AND rpt_dt between '2020-01-19' and '2020-01-25');


SELECT   aassg.FACILITYID,
         aassg.assg_id,
         aassg.RPTG_ID
FROM     CRMADMIN.T_WHSE_EXE_AASSG aassg
WHERE    aassg.rpt_dt between '2020-01-19' and '2020-01-25';

SELECT   aseld.FACILITYID,
         d.WEEK_ENDING_DATE,
--         aassg.RPTG_ID,
--         aseld.WHSE_ID,
--         aseld.ORDER_TYPE_ID,
         SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld 
         inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id 
         inner join CRMADMIN.V_WED d on aassg.rpt_dt = d.LOOKUP_DATE and d.WEEK_ENDING_DATE between '2020-01-25' and current date
WHERE    not(aseld.FACILITYID = '001' AND aassg.RPTG_ID in ('X', ''))
--AND      not(aseld.FACILITYID = '070' AND aassg.RPTG_ID in ('A', 'E', 'O'))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST'))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'E000' and 'E999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'X000' and 'X999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'F000' and 'F999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'L000' and 'L999')
AND      aassg.RPTG_ID is not null
--AND aseld.FACILITYID = '070'
GROUP BY aseld.FACILITYID, d.WEEK_ENDING_DATE
--, aassg.RPTG_ID, aseld.WHSE_ID, 
--         aseld.ORDER_TYPE_ID;
;

SELECT aseld.FACILITYID, d.WEEK_ENDING_DATE, SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected FROM CRMADMIN.T_WHSE_EXE_ASELD aseld inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id inner join CRMADMIN.V_WED d on aassg.rpt_dt = d.LOOKUP_DATE and d.WEEK_ENDING_DATE between '2020-01-25' and current date WHERE not(aseld.FACILITYID = '001' AND aassg.RPTG_ID in ('X', '')) AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST')) AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'E000' and 'E999') AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'X000' and 'X999') AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'F000' and 'F999') AND not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'L000' and 'L999') AND aassg.RPTG_ID is not null AND aseld.FACILITYID = '070' GROUP BY aseld.FACILITYID, d.WEEK_ENDING_DATE 


----------------------------------------------------------------------------------------------------------
-- els hours
----------------------------------------------------------------------------------------------------------

SELECT   wed.WEEK_ENDING_DATE,
         aassg.FACILITYID,
         aassg.dc_id,
         aassg.whse_id,
         aassg.assoc_id,
         aassg.std_tim,
         aassg.start_dtim,
         aassg.end_dtim,
         (aassg.end_dtim - aassg.start_dtim) elapse_tim,
         value(hour(aassg.end_dtim - aassg.start_dtim) * 60 + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60), 0) / 60 elapse_time,
         aassg.suspend_tim,
         value(hour(aassg.suspend_tim) * 60 + minute(aassg.suspend_tim) + (decimal(second(aassg.suspend_tim)) / 60), 0) / 60 suspend_time,
         aassg.walk_tim,
         value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0) / 60 walk_time,
         aassg.delay_tim,
         value(hour(aassg.delay_tim) * 60 + minute(aassg.delay_tim) + (decimal(second(aassg.delay_tim)) / 60), 0) / 60 delay_time,
         (value(hour(aassg.end_dtim - aassg.start_dtim) * 60 + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60), 0) / 60) - (value(hour(aassg.suspend_tim) * 60 + minute(aassg.suspend_tim) + (decimal(second(aassg.suspend_tim)) / 60), 0) / 60) - (value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0) / 60) - (value(hour(aassg.delay_tim) * 60 + minute(aassg.delay_tim) + (decimal(second(aassg.delay_tim)) / 60), 0) / 60) actual_time_on_standard,
         aseld.jcty_id,
         aseld.jcfn_id,
         aseld.jcsf_id,
         aseld.jbcd_id,
         aassg.assg_id,
         aassg.asgt_id
FROM     crmadmin.T_WHSE_EXE_AASSG aassg 
         inner join crmadmin.T_WHSE_EXE_ASELD aseld on aassg.FACILITYID = aseld.FACILITYID and aseld.assg_id = aassg.assg_id 
         inner join CRMADMIN.V_WED wed on wed.LOOKUP_DATE = aassg.RPT_DT
WHERE    wed.WEEK_ENDING_DATE between '2020-01-25' and current date
AND      aassg.asta_id = 'C'
AND      aassg.start_dtim IS NOT NULL
AND      aassg.end_dtim IS NOT NULL
AND      aseld.start_dtim IS NOT NULL
AND      aseld.complete_dtim IS NOT NULL
AND      aassg.asgt_id = 'S'
GROUP BY wed.WEEK_ENDING_DATE, aassg.FACILITYID, aassg.dc_id, aassg.whse_id, 
         aassg.assoc_id, aassg.std_tim, aassg.start_dtim, aassg.end_dtim, 
         (aassg.end_dtim - aassg.start_dtim), aassg.suspend_tim, 
         aassg.walk_tim, aassg.delay_tim, aseld.jcty_id, aseld.jcfn_id, 
         aseld.jcsf_id, aseld.jbcd_id, aassg.assg_id, aassg.asgt_id
;


----------------------------------------------------------------------------------------------------------
-- bad queries for labor hours
----------------------------------------------------------------------------------------------------------

/*
SELECT   FACILITYID,
         ASSG_ID,
         WHSE_ID,
         ASGT_ID,
         ASTA_ID,
         ASSOC_ID,
         SPLIT_ASSG_ID,
         ASSG_DTIM,
         CHANGE_DTIM,
         CHANGE_USER,
         CREATE_DTIM,
         CREATE_USER,
         SPMD_ID,
         STDT_ID,
         RPTG_ID,
         RPT_DT,
         CKPT_ID,
         ACCUM_WGT,
         EQPT_TIM,
         ASSG_PROD_WGT,
         end_dtim,
         start_dtim,
         suspend_tim,
         walk_tim,
         wgt_tim,
         ftg_adj_tim,
         wgt_adj_tim,
         dly_adj_tim,
         LVL_TIM,
         value(hour(lvl_tim) * 60 + minute(lvl_tim) + (decimal(second(lvl_tim)) / 60), 0) lvl_time,
         value(hour(std_tim) * 60 + minute(std_tim) + (decimal(second(std_tim)) / 60), 0) std_tim,
         ((hour(end_dtim - start_dtim) * 60) + minute(end_dtim - start_dtim) + (decimal(second(end_dtim - start_dtim)) / 60)) act_tim,
         value(hour(suspend_tim) * 60 + minute(SUSPEND_TIM) + (decimal(second(SUSPEND_TIM)) / 60), 0) suspend_time,
         value(hour(walk_tim) * 60 + minute(walk_tim) + (decimal(second(walk_tim)) / 60), 0) walk_time,
         value(hour(wgt_tim) * 60 + minute(wgt_tim) + (decimal(second(wgt_tim)) / 60), 0) wgt_time,
         value(hour(ftg_adj_tim) * 60 + minute(ftg_adj_tim) + (decimal(second(ftg_adj_tim)) / 60), 0) ftg_adj_time,
         value(hour(wgt_adj_tim) * 60 + minute(wgt_adj_tim) + (decimal(second(wgt_adj_tim)) / 60), 0) wgt_adj_time,
         value(hour(dly_adj_tim) * 60 + minute(dly_adj_tim) + (decimal(second(dly_adj_tim)) / 60), 0) dly_adj_time,
         ((hour(LVL_TIM) * 60) + minute(LVL_TIM) + (decimal(second(LVL_TIM)) / 60)) - (value(hour(suspend_tim) * 60 + minute(SUSPEND_TIM) + (decimal(second(SUSPEND_TIM)) / 60), 0)) - (value(hour(walk_tim) * 60 + minute(walk_tim) + (decimal(second(walk_tim)) / 60), 0)) - (value(hour(wgt_tim) * 60 + minute(wgt_tim) + (decimal(second(wgt_tim)) / 60), 0)) - (value(hour(ftg_adj_tim) * 60 + minute(ftg_adj_tim) + (decimal(second(ftg_adj_tim)) / 60), 0)) - (value(hour(wgt_adj_tim) * 60 + minute(wgt_adj_tim) + (decimal(second(wgt_adj_tim)) / 60), 0)) - (value(hour(dly_adj_tim) * 60 + minute(dly_adj_tim) + (decimal(second(dly_adj_tim)) / 60), 0)) final_lvl_tim,
         ((hour(end_dtim - start_dtim) * 60) + minute(end_dtim - start_dtim) + (decimal(second(end_dtim - start_dtim)) / 60)) - (value(hour(suspend_tim) * 60 + minute(SUSPEND_TIM) + (decimal(second(SUSPEND_TIM)) / 60), 0)) - (value(hour(walk_tim) * 60 + minute(walk_tim) + (decimal(second(walk_tim)) / 60), 0)) - (value(hour(wgt_tim) * 60 + minute(wgt_tim) + (decimal(second(wgt_tim)) / 60), 0)) - (value(hour(ftg_adj_tim) * 60 + minute(ftg_adj_tim) + (decimal(second(ftg_adj_tim)) / 60), 0)) - (value(hour(wgt_adj_tim) * 60 + minute(wgt_adj_tim) + (decimal(second(wgt_adj_tim)) / 60), 0)) - (value(hour(dly_adj_tim) * 60 + minute(dly_adj_tim) + (decimal(second(dly_adj_tim)) / 60), 0)) final_act_tim
FROM     CRMADMIN.T_WHSE_EXE_AASSG 
WHERE    rpt_dt between '2020-03-08' and '2020-03-14'
AND      not(FACILITYID = '001'
     AND RPTG_ID in ('X', ''))
AND      not(FACILITYID = '070'
     AND RPTG_ID in ('A', 'E', 'O'))
AND      RPTG_ID is not null
AND      asgt_id = 'S'
AND      asta_id = 'C'
AND      assoc_id is not null
;


SELECT   aseld.FACILITYID,
         aseld.ASSG_ID,
         aseld.WHSE_ID,
--         d.WEEK_ENDING_DATE,
         sum(value(hour(aseld.COMPLETE_DTIM - aseld.START_DTIM) * 60 + minute(aseld.COMPLETE_DTIM - aseld.START_DTIM) + (decimal(second(aseld.COMPLETE_DTIM - aseld.START_DTIM)) / 60), 0)) actual_time
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld 
         inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id 
--         inner join CRMADMIN.V_WED d on aassg.rpt_dt = d.LOOKUP_DATE and d.WEEK_ENDING_DATE = '2020-03-14'
WHERE    aassg.rpt_dt between '2020-03-08' and '2020-03-14'
GROUP BY aseld.FACILITYID, aseld.ASSG_ID, aseld.WHSE_ID
;


;

SELECT   aassg.FACILITYID, 
         aassg.WHSE_ID,
         aseld.PHYS_WHSE_ID, 
         aassg.ASSG_ID,
         aassg.ASGT_ID,
         aassg.ASTA_ID,
         aassg.ASSOC_ID,
         aassg.end_dtim,
         aassg.start_dtim,
         aassg.suspend_tim,
         aassg.walk_tim,
         aassg.wgt_tim,
         aassg.ftg_adj_tim,
         aassg.wgt_adj_tim,
         aassg.dly_adj_tim,
         aassg.LVL_TIM, 
         aseld.actual_time,
         value(hour(aassg.std_tim) * 60 + minute(aassg.std_tim) + (decimal(second(aassg.std_tim)) / 60), 0) std_tim,
--         (end_dtim - start_dtim) std_tim,
         ((hour(aassg.end_dtim - aassg.start_dtim) * 60) + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60)) / 60 act_tim,
         value(hour(aassg.suspend_tim) * 60 + minute(aassg.SUSPEND_TIM) + (decimal(second(aassg.SUSPEND_TIM)) / 60), 0) / 60 suspend_time,
         value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0) / 60 walk_time,
         value(hour(aassg.wgt_tim) * 60 + minute(aassg.wgt_tim) + (decimal(second(aassg.wgt_tim)) / 60), 0) / 60 wgt_time,
         value(hour(aassg.ftg_adj_tim) * 60 + minute(aassg.ftg_adj_tim) + (decimal(second(aassg.ftg_adj_tim)) / 60), 0) / 60 ftg_adj_time,
         value(hour(aassg.wgt_adj_tim) * 60 + minute(aassg.wgt_adj_tim) + (decimal(second(aassg.wgt_adj_tim)) / 60), 0) / 60 wgt_adj_time,
         value(hour(aassg.dly_adj_tim) * 60 + minute(aassg.dly_adj_tim) + (decimal(second(aassg.dly_adj_tim)) / 60), 0) / 60 dly_adj_time,
         ((hour(aassg.end_dtim - aassg.start_dtim) * 60) + minute(aassg.end_dtim - aassg.start_dtim) + (decimal(second(aassg.end_dtim - aassg.start_dtim)) / 60)) - (value(hour(aassg.suspend_tim) * 60 + minute(aassg.SUSPEND_TIM) + (decimal(second(aassg.SUSPEND_TIM)) / 60), 0)) - (value(hour(aassg.walk_tim) * 60 + minute(aassg.walk_tim) + (decimal(second(aassg.walk_tim)) / 60), 0)) - (value(hour(aassg.wgt_tim) * 60 + minute(aassg.wgt_tim) + (decimal(second(aassg.wgt_tim)) / 60), 0)) - (value(hour(aassg.ftg_adj_tim) * 60 + minute(aassg.ftg_adj_tim) + (decimal(second(aassg.ftg_adj_tim)) / 60), 0)) - (value(hour(aassg.wgt_adj_tim) * 60 + minute(aassg.wgt_adj_tim) + (decimal(second(aassg.wgt_adj_tim)) / 60), 0)) - (value(hour(aassg.dly_adj_tim) * 60 + minute(aassg.dly_adj_tim) + (decimal(second(aassg.dly_adj_tim)) / 60), 0)) / 60 final_act_tim
FROM     CRMADMIN.T_WHSE_EXE_AASSG aassg 
         left outer join (SELECT aseld.FACILITYID, aseld.ASSG_ID, aseld.phys_whse_id, sum(value(hour(aseld.COMPLETE_DTIM - aseld.START_DTIM) * 60 + minute(aseld.COMPLETE_DTIM - aseld.START_DTIM) + (decimal(second(aseld.COMPLETE_DTIM - aseld.START_DTIM)) / 60), 0)) actual_time FROM CRMADMIN.T_WHSE_EXE_ASELD aseld inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id WHERE aassg.rpt_dt between '2020-01-19' and '2020-01-25' GROUP BY aseld.FACILITYID, aseld.ASSG_ID, aseld.phys_whse_id
) aseld on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id
--WHERE    aassg.rpt_dt between '2020-03-08' and '2020-03-14'
WHERE    aassg.rpt_dt between '2020-01-19' and '2020-01-25'
AND      aassg.asgt_id = 'S'
AND      aassg.asta_id = 'C'
AND      aassg.assoc_id is not null
;

*/
