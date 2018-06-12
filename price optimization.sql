--  product file
SELECT   wi.FACILITYID,
         wi.UPC_CASE,
         wi.UPC_UNIT,
         wi.ITEM_NBR_HS,
         wi.ITEM_DESCRIP,
         wi.ITEM_SIZE,
         wi.ITEM_SIZE_UOM,
         wi.ITEM_DEPT,
         wi.PRODUCT_GROUP,
         wi.PRODUCT_SUB_GROUP,  
         wi.COST_LINK_GROUP,
--         wi.ITEM_RES13, 
--         wi.PURCH_STATUS,
         ssb1.IMSTAT_BILLING_STATUS billing_status
FROM     CRMADMIN.T_WHSE_ITEM wi,
		 CRMADMIN.T_STAGE_SWAT_BKSCR_01 ssb1
where facilityid = '058'
  and (ssb1.BICEPS_DC = wi.BICEPS_DC
  and ssb1.ITEM_NBR_CD = wi.ITEM_NBR_CD)
  and ITEM_DEPT in ('010', '012', '016', '017', '020', '025', '030', '035', '048', '060', '066', '067', '080', '084', '086')
  and ssb1.IMSTAT_BILLING_STATUS not in ('I', 'D', 'W')
  and wi.ITEM_RES13 not in ('P');


-- price-cost  ---SWAT connection
Select 940066, 
	   'NF' vendor, 
	   '058' store, 
	   i.IMUPIT upc, 
	   r.SMITEM item, 
	   round(s.WSSELL/i.IMPACK,2) unit_cost, 
	   max(case when r.SMGRPG = 2 then r.SMSRPU else 0 end) srp_unit_2,
	   max(case when r.SMGRPG = 2 then r.SMSRP else 0 end) srp_2, 
	   max(case when r.SMGRPG = 940066 then r.SMSRPU else 0 end) srp_unit_940066,
	   max(case when r.SMGRPG = 940066 then r.SMSRP else 0 end) srp_940066
  from LODATA01.RZ0PSRPM r,
       LODATA01.IM0PITEM i,
       LODATA01.MC0PSELL s
where  r.SMITEM = i.IMITEM
  and  r.SMITEM = s.WSITEM
  and  i.imdept in (10, 12, 16, 17, 20, 25, 30, 35, 48, 60, 66, 67, 80, 84, 86)
  and  i.IMSTAT not in ('I', 'D', 'W')
  and  i.IMRS13 not in ('P')  
  and  WSSPN = 2
  and  r.SMGRPG in (940066, 2)
group by 940066,
	   'NF', 
	   '058', 
	   i.IMUPIT, 
	   r.SMITEM, 
--	   r.SMSRP, 
	   round(s.WSSELL/i.IMPACK,2);  

-- DEAL 

Select i.IMUPIT upc, 
	   940066, 
	   'NF' vendor, 
	   '058' store, 
	   r.ACITEM item, 
	   r.ACSDTE start_date,
	   r.ACEDTE end_date,
	   r.ACALAM amount,
	   'OI' deal_type,
	   i.IMSIZE
  from LODATA01.PM0PALCS r,
       LODATA01.IM0PITEM i
where  r.ACITEM = i.IMITEM
  and  i.imdept in (10, 12, 16, 17, 20, 25, 30, 35, 48, 60, 66, 67, 80, 84, 86)
  and  i.IMSTAT not in ('I', 'D', 'W')
  and  i.IMRS13 not in ('P')  
--  and  WSSPN = 2
  and  r.ACGRPG in (1)
  and  r.ACALAM > 0
  and  (r.ACSDTE < (20080409 + 28)
  and  r.ACEDTE > 20080409);



----------------------------------------------------------------------------------------------------------------------------------
SELECT   FACILITYID,
         ITEM_NBR_HS,
         ITEM_DESCRIP,
         PACK_CASE,
         ITEM_SIZE_DESCRIP,
         ITEM_SIZE,
         ITEM_SIZE_UOM,
         UPC_CASE,
         UPC_UNIT,
         PURCH_STATUS,
         BILLING_STATUS,
         PRODUCT_GROUP,
         PRODUCT_SUB_GROUP
FROM     crmadmin.t_whse_item
WHERE    (facilityid, product_sub_group) in ( select facilityid, product_sub_group from ( Select distinct facilityid, product_group, product_sub_group from CRMADMIN.T_WHSE_ITEM where facilityid = '058'
        AND product_sub_group not in ('9999')
        AND purch_status in ('A', 'S')) x where purch_status in ('A', 'S') group by facilityid, product_sub_group having count(*) > 1)