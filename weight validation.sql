--dss
SELECT   '0' || DHI_ITEM_FACILITY ,
         DINITM_ITEM_NBR,
         DHI_ITEM_DESCRIPTION,
         DHI_ITEM_DEPARTMENT,
         DHI_STORE_PACK,
         DHI_RETAIL_PACK,
         DHI_ITEM_SIZE,
         DHI_ITEM_SIZE_UNIT_MEASURE,
         DHI_SHIPPING_CASE_WEIGHT,
         DINCST_NET_WEIGHT,
         DINITM_WEIGHT
FROM     DATAWHSE.MF_ITEM_MASTER;
--WHERE    dhi_item_facility = '08';



--informix
SELECT   dc_id,
         prod_id,
         prdd_id,
         vend_cse_rtl_unit,
         cse_unit,
         inner_pack_unit,
         unit_ship_cse,
         cse_wgt,
         inner_pack_wgt,
         tare_wgt,
         create_dtim,
         change_dtim
FROM     informix.iprdd
order by prod_id asc;

--dw
Select FACILITYID, ITEM_NBR_CD, ITEM_NBR, ITEM_NBR_HS, sum(TOT_SHIPPED) cases_shipped
  from CRMADMIN.MQT_WHSE_ITEM_SALES_HISTORY_SUM_WEEK
 where wk_end_date > '2007-06-16'
group by FACILITYID, ITEM_NBR_CD, ITEM_NBR, ITEM_NBR_HS