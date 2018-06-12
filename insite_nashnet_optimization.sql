--Lookup Marketing Groups:
SELECT   mdm.CUSTOMER_NBR_CORP,
         mdm.CUSTOMER_NO,
         mdm.CUSTOMER_NBR_STND,
         mdm.FACILITYID,
         mdm.GROUP_TYPE_KEY,
         mdm.AUDIT_SOURCE_ID,
         mdm.GROUP_TYPE_CD,
         di.VALUE as "di.VALUE",
         di.ID as "di.ID",
         di.UPDATED_BY as "di.UPDATED",
         trim(mdm.GROUP_TYPE_DESC) as "mdm.GROUP_TYPE_DESC",
         mdm.GROUP_CD,
         mdm.FACILITYID||','||mdm.GROUP_CD AS "FACILITY,GROUP_CD",
         mg.NAME as "mg.NAME",
         mg.VALUE as "mg.VALUE",
         mg.id AS "mg.ID",
         mg.UPDATED_BY as "mg.UPDATED"
FROM     NASHNET.WHSE_CUST_GRP_MDM mdm 
         left JOIN COMMON.DATA_ITEMS di ON mdm.AUDIT_SOURCE_ID = di.NAME 
         left JOIN COMMON.DATA_ITEMS mg ON mdm.FACILITYID||','||mdm.GROUP_CD = mg.NAME
WHERE    mdm.CUSTOMER_NBR_STND in ('561061', '561089', '341', '574', '1065')
AND      mdm.group_type_key = di.value
AND      ((di.GROUP_NAME='Promo Group_Type xref'
        AND mg.GROUP_NAME='Promo Group xref')
     OR  (di.GROUP_NAME='Ad Group_Type xref'
        AND mg.GROUP_NAME='Ad Group xref'))
ORDER BY CUSTOMER_NBR_STND, mdm.FACILITYID, mdm.GROUP_TYPE_DESC
;

mdm.FACILITYID
mdm.CUSTOMER_NBR_STND
mdm.AUDIT_SOURCE_ID
mdm.group_type_key

--Ad Survey List:
SELECT   Distinct d.FACILITYID,
         d.AD_START_DATE,
         d.AD_END_DATE,
         d.MKTG_GROUP_NAME,
         d.AD_WEEK_ID,
         d.BOOKING_NBR,
         d.THEME_NAME,
         d.DEAL_DEPT_CD,
         d.DELV_START_DATE,
         d.DELV_END_DATE,
         d.PUBLISH_START_DATE,
         d.PUBLISH_END_DATE,
         rs.ORDER_STATUS_CD,
         rs.CUST_NO_FULL
FROM     NASHNET.DEAL d 
         left join (select BOOKING_NBR, DEAL_DEPT_CD, FACILITYID, ORDER_STATUS_CD, CUST_NO_FULL from NASHNET.ORDER where CUST_NO_FULL = '1065') rs on ( d.BOOKING_NBR = rs.BOOKING_NBR AND d.DEAL_DEPT_CD = rs.DEAL_DEPT_CD AND d.FACILITYID = rs.FACILITYID )
WHERE    d.MKTG_GROUP_NAME in ('LOIGAAd')
ORDER BY D.AD_START_DATE desc, D.AD_START_DATE desc, D.BOOKING_NBR desc, 
         D.DEAL_DEPT_CD


--Ad Survey Details:
select d.FACILITYID, trim(f.DIV_NAME) as FACILITY_NAME,	
	d.AD_START_DATE, d.AD_END_DATE, d.AD_WEEK_ID, d.BOOKING_NBR,
	d.THEME_NAME, d.DELV_START_DATE,  d.DELV_END_DATE, d.PUBLISH_START_DATE, d.PUBLISH_END_DATE, d.MKTG_GROUP_NAME, 
	d.DEAL_DEPT_CD, d.DEAL_ID, rs.ORDER_STATUS_CD, 
	 min(rs.ORDER_ID) as ORDER_ID,
	i.ITEM_NBR, i.ITEM_UPC_CD,
         min(i.ITEM_DESC) as ITEM_DESC,
       i.DEAL_ID, i.CASE_UPC_CD, i.CASE_PACK_QTY, i.CATALOG_PRC_AMT, i.OFF_INV_AMT, i.RPA_AMT, i.NET_CS_PRC_AMT, i.UNIT_SCAN_AMT,
       i.CPN_VAL_QTY, i.UNIT_PRC_AMT, i.AD_SRP_AMT_CD, i.GROSS_PROFIT_AMT, i.AD_POSITION_DESC      
from "NASHNET"."DEAL" d

left join (select facilityid, order_id, order_status_cd, confirmation_nbr, desired_deliv_date, BOOKING_NBR, DEAL_DEPT_CD from
	(
	select o.facilityid, o.order_id, o.order_status_cd, o.confirmation_nbr, o.desired_deliv_date, BOOKING_NBR, DEAL_DEPT_CD
	from "NASHNET"."ORDER" o
	where o.cust_no_full = '1065'))rs
	on (d.BOOKING_NBR=rs.BOOKING_NBR AND d.FACILITYID = rs.FACILITYID) 

inner join "NASHNET"."WHSE_DIV_XREF" f on d.FACILITYID=f.NF_DIV_NUM
	full join "NASHNET"."DEAL_ITEM" i on (d.DEAL_ID=i.DEAL_ID and d.FACILITYID=i.FACILITYID)

where d.MKTG_GROUP_NAME = 'LOIGAAd'
	and d.FACILITYID = '058'
	and d.BOOKING_NBR= '67653'
	and d.DEAL_DEPT_CD = 'Dairy'

group by d.FACILITYID, f.DIV_NAME, 
	d.AD_START_DATE, d.AD_END_DATE, d.AD_WEEK_ID, d.BOOKING_NBR,
	d.THEME_NAME, d.DELV_START_DATE,  d.DELV_END_DATE, d.PUBLISH_START_DATE, d.PUBLISH_END_DATE, d.MKTG_GROUP_NAME, 
	d.DEAL_DEPT_CD, d.DEAL_ID, rs.ORDER_STATUS_CD,
	i.ITEM_NBR, i.ITEM_UPC_CD,
	i.DEAL_ID, i.CASE_UPC_CD, i.CASE_PACK_QTY,
       i.CATALOG_PRC_AMT, i.OFF_INV_AMT, i.RPA_AMT, i.NET_CS_PRC_AMT, i.UNIT_SCAN_AMT, 
       i.CPN_VAL_QTY, i.UNIT_PRC_AMT, i.AD_SRP_AMT_CD, i.GROSS_PROFIT_AMT, i.AD_POSITION_DESC
 ORDER BY d.DEAL_DEPT_CD, i.DEAL_ID, i.ITEM_NBR       


