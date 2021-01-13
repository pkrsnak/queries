--col-pns item master
SELECT   d.division_cd,
         d.dept_cd,
         d.dept_desc,
         i.case_upc_cd,
         i.item_nbr,
         i.item_upc_cd,
         i.expanded_upc_cd,
         i.item_desc,
         i.commodity_cd,
         i.prod_group_cd,
         i.item_pack_qty,
         i.lbs_msr,
         i.net_msr,
         i.cube_msr,
         i.master_pack_flg,
         i.catch_wgt_flg,
         i.slot_id,
         i.season_cd
FROM     whmgr.mdv_item i 
         inner join whmgr.mdv_dept d on d.dept_cd = i.dept_cd
WHERE    d.division_cd in ('CSG', 'PNS')
;

--col-pns store order
SELECT   d.DIVISION_CD,
         d.DEPT_CD,
         d.DEPT_DESC,
         sh.CASE_UPC_CD,
         sh.ORDER_NBR,
         sh.CUSTOMER_NBR,
         sh.SHIP_TO_ID,
         sh.SHIP_DATE,
         sh.SALES_CATGY_CODE,
         sh.ORDER_CATGY_CD,
         sh.SALES_HST_TYPE_CD,
         sum(sh.WEIGHT_MSR) WEIGHT_MSR,
         sum(sh.ORDER_QTY) ORDER_QTY,
         sum(sh.SHIP_QTY) SHIP_QTY
FROM     WH_OWNER.MDVSLS_DY_CUST_ITM sh 
         inner join WH_OWNER.mdv_dept d on d.dept_cd = sh.dept_cd
WHERE    d.division_cd in ('CSG', 'PNS')
AND      sh.SHIP_DATE between '2020-11-22' and '2020-12-19'
group by d.DIVISION_CD,
         d.DEPT_CD,
         d.DEPT_DESC,
         sh.CASE_UPC_CD,
         sh.ORDER_NBR,
         sh.CUSTOMER_NBR,
         sh.SHIP_TO_ID,
         sh.SHIP_DATE,
         sh.SALES_CATGY_CODE,
         sh.ORDER_CATGY_CD,
         sh.SALES_HST_TYPE_CD
;

--col-pns purchase order
SELECT   d.division_cd,
         d.dept_cd,
         d.dept_desc,
         pod.order_nbr,
         poh.order_date,
         poh.receive_date,
         pod.case_upc_cd,
         poh.vendor_cd,
         v.vendor_name,
         poh.status_cd,
         sum(pod.order_qty) order_qty,
         sum(pod.received_qty) received_qty
FROM     whmgr.mdv_po_dtl pod 
         inner join whmgr.mdv_po_hdr poh on poh.order_nbr = pod.order_nbr 
         inner join whmgr.mdv_vendor v on v.vendor_cd = poh.vendor_cd 
         inner join whmgr.mdv_dept d on d.dept_cd = pod.dept_cd
WHERE    d.division_cd in ('CSG', 'PNS')
AND      poh.order_date between '11-22-2020' and '12-19-2020'
group by d.division_cd,
         d.dept_cd,
         d.dept_desc,
         pod.order_nbr,
         poh.order_date,
         poh.receive_date,
         pod.case_upc_cd,
         poh.vendor_cd,
         v.vendor_name,
         poh.status_cd
;


SELECT   case lh.FACILITYID
              when '027' then 'PNS'
              when '033' then 'CSG'
              when '080' then 'CSG'
         else '000' end division_cd,
         int(lh.ITEM_DEPT) dept_cd,
         lh.UPC_CASE case_upc_cd,
         lh.LAYER_FILE_DTE snapshot_date,
         sum(lh.INVENTORY_TURN) on_hand_qty
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on lh.FACILITYID = dx.SWAT_ID
where lh.LAYER_FILE_DTE between '2020-11-22' and '2020-12-19'
and dx.SWAT_ID in ('027', '033', '080')
group by lh.FACILITYID,
         lh.ITEM_DEPT,
         lh.UPC_CASE,
         lh.LAYER_FILE_DTE
