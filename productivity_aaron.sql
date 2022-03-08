--warehouse actual selection hours by facility
--source:  crm
SELECT   'distribution' SCORECARD_TYPE,
         'els_actuals' KPI_TYPE,
         x.WEEK_ENDING_DATE DATE_VALUE,
         dx.ENTERPRISE_KEY + 1 DIVISION_ID,
         FACILITYID KEY_VALUE, 
         round(sum(actual_time_on_standard), 2) data_value,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY
from (
;

SELECT   wed.WEEK_ENDING_DATE,
         aassg.FACILITYID,
         aassg.dc_id,
         aassg.whse_id,
         aassg.assoc_id,
         aassg.std_tim,
         value(hour(aassg.std_tim) * 60 + minute(aassg.std_tim) + (decimal(second(aassg.std_tim)) / 60), 0) / 60 std_time,
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
         sum(aseld.PROD_CUB * ((prod_qty - value(out_qty,0)) / unit_ship_cse)) tot_cube,
         sum(aseld.PROD_WGT * ((prod_qty - value(out_qty,0)) / unit_ship_cse)) tot_weight,
         SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) tot_qty,
         c.CUSTOMER_NBR_STND,
         c.NAME cust_name,
         aassg.assg_id,
         aassg.asgt_id
FROM     crmadmin.T_WHSE_EXE_AASSG aassg 
         inner join crmadmin.T_WHSE_EXE_ASELD aseld on aassg.FACILITYID = aseld.FACILITYID and aseld.assg_id = aassg.assg_id 
         inner join CRMADMIN.V_WED wed on wed.LOOKUP_DATE = aassg.RPT_DT
         inner join CRMADMIN.T_WHSE_CUST c on aassg.FACILITYID = c.FACILITYID and aseld.CUST_ID = c.CUSTOMER_NBR_STND
WHERE    wed.WEEK_ENDING_DATE between '2022-01-02' and '2022-02-26' --between '2020-01-25' and current date
and aassg.FACILITYID in ('015')--, '058', '040')
AND      aassg.asta_id = 'C'
AND      aassg.start_dtim IS NOT NULL
AND      aassg.end_dtim IS NOT NULL
AND      aseld.start_dtim IS NOT NULL
AND      aseld.complete_dtim IS NOT NULL
AND      aassg.asgt_id = 'S'
AND      not(aseld.FACILITYID = '001' AND aassg.RPTG_ID in ('X', ''))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST'))
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'E000' and 'E999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'X000' and 'X999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'F000' and 'F999')
AND      not(aseld.FACILITYID = '070' AND aseld.ORDER_TYPE_ID between 'L000' and 'L999')
GROUP BY wed.WEEK_ENDING_DATE, aassg.FACILITYID, aassg.dc_id, aassg.whse_id, 
         aassg.assoc_id, aassg.std_tim, aassg.start_dtim, aassg.end_dtim, 
         (aassg.end_dtim - aassg.start_dtim), aassg.suspend_tim, 
         aassg.walk_tim, aassg.delay_tim, aseld.jcty_id, aseld.jcfn_id, 
         aseld.jcsf_id, aseld.jbcd_id, aassg.assg_id, aassg.asgt_id, c.CUSTOMER_NBR_STND,
         c.NAME
;
) x
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on x.FACILITYID = dx.SWAT_ID
group by x.WEEK_ENDING_DATE, dx.ENTERPRISE_KEY, x.FACILITYID
;



SELECT   aseld.FACILITYID,
         d.WEEK_ENDING_DATE,
         SUM((prod_qty - value(out_qty,0)) / unit_ship_cse) cases_selected
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld 
         inner join CRMADMIN.T_WHSE_EXE_AASSG aassg on aassg.FACILITYID = aseld.FACILITYID AND aassg.phys_whse_id = aseld.phys_whse_id AND aassg.assg_id = aseld.assg_id 
         inner join CRMADMIN.V_WED d on aassg.rpt_dt = d.LOOKUP_DATE and d.WEEK_ENDING_DATE between '2020-01-25' and current date
WHERE    not(aseld.FACILITYID = '001'
     AND aassg.RPTG_ID in ('X', ''))
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID in ('EXP', 'UEXP', 'FLOX', 'CONV', 'UPST'))
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'E000' and 'E999')
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'X000' and 'X999')
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'F000' and 'F999')
AND      not(aseld.FACILITYID = '070'
     AND aseld.ORDER_TYPE_ID between 'L000' and 'L999')
AND      aassg.RPTG_ID is not null
GROUP BY aseld.FACILITYID, d.WEEK_ENDING_DATE