----------------------------------------------------------------------------------
-- po header ---------------------------------------------------------------------
----------------------------------------------------------------------------------

-- database = CRM
SELECT   FACILITYID,
         PO_NBR,
         DATE_ORDERED,
         TYPE,
         STATUS,
         FREIGHT_ALLOW,
         FREIGHT_ALLOW_TYPE,
         LOAD_NBR,
         FLAG_PREPAID,
         FLAG_PREPAY_AND_ADD,
         FLAG_FREIGHT_BILL,
         FLAG_BACKHAUL,
         ACTUAL_TURN_COST,
         ACTUAL_TURN_WEIGHT,
         ACTUAL_TURN_CUBE,
         ACTUAL_TURN_PALLETS,
         ACTUAL_TURN_UNITS,
         ACTUAL_TURN_FACTOR_1,
         ACTUAL_TURN_FACTOR_2,
         PROMO_COST,
         PROMO_WEIGHT,
         PROMO_CUBE,
         PROMO_PALLETS,
         PROMO_UNITS,
         PROMO_FACTOR_1,
         PROMO_FACTOR_2,
         FWD_BUY_COST,
         FWD_BUY_WEIGHT,
         FWD_BUY_CUBE,
         FWD_BUY_PALLETS,
         FWD_BUY_UNITS,
         FWD_BUY_FACTOR_1,
         FWD_BUY_FACTOR_2,
         PICKUP_POINT_CITY,
         PICKUP_POINT_STATE,
         PICKUP_POINT_ZIPCODE,
         LOAD_NBR
FROM     CRMADMIN.T_WHSE_PO_HDR
--WHERE    DATE_ORDERED between '2021-07-18' and '2021-08-14'
--WHERE    DATE_ORDERED between '2021-08-15' and '2021-09-11'
WHERE    DATE_ORDERED between '2021-05-26' and '2021-07-17'
;

-- database = mdvods
SELECT   case d.division_cd 
     when 'NOR' then '070' 
     when 'BAL' then '069' 
     when 'PNS' then '027' 
     when 'SAT' then '029' 
     when 'CSG' then '033' 
     when 'BLM' then '038' 
     when 'OKA' then '039' 
     when 'CSZ' then '080' 
     when 'SAZ' then '090' 
     else '999' 
end FACILITY,
         d.division_cd,
         poh.order_nbr,
         poh.warehouse_id,
         poh.deliver_to_whse_id,
         poh.vendor_cd,
         poh.buyer_id,
         poh.invoice_date,
         poh.order_date,
         poh.required_by_date,
         poh.appointment_tmsp,
         poh.pickup_date,
         poh.receive_date,
         poh.arrival_tmsp,
         poh.master_po_nbr,
         poh.master_po_flg,
         poh.requisition_nbr,
         poh.freight_code,
         poh.ship_instru_txt,
         poh.carrier_desc,
         poh.contact_desc,
         poh.order_qty,
         poh.weight_amt,
         poh.cube_amt,
         poh.pallets_qty,
         poh.status_cd,
         poh.container_desc,
         poh.cases_ordered_qty,
         poh.cases_received_qty,
         poh.pu_add_code,
         poh.product_cost_amt,
         poh.load_number,
         poh.backhaul_amt,
         poh.caw_amt,
         poh.max_frt_allw_amt,
         poh.frt_allw_amt,
         poh.frt_allw_type_cd,
         poh.fuel_surchrg_amt,
         poh.fuel_srchrg_typ_cd,
         poh.backhaul_type_cd,
         poh.invoice_bkhaul_amt,
         poh.item_count,
         poh.scac_carrier_desc,
         poh.pickup_name,
         poh.pickup_address1,
         poh.pickup_address2,
         poh.pickup_city_nm,
         poh.pickup_state_cd,
         poh.pickup_zip_code,
         poh.dssroute_cd,
         poh.total_value_amt,
         poh.po_lastnote_txt,
         poh.ap_vendor_id
FROM     whmgr.mdv_po_hdr poh 
         inner join whmgr.mdv_dept d on poh.warehouse_id = d.dept_cd
--WHERE    (poh.receive_date between '07-18-2021' and '08-14-2021')
--WHERE    (poh.receive_date between '08-15-2021' and '09-11-2021')
WHERE    (poh.receive_date between '05-25-2021' and '07-17-2021')
AND      d.division_cd in ('NOR', 'BAL', 'PNS', 'SAT', 'CSG', 'BLM', 'OKA', 'CSZ', 'SAZ')
--WHERE    DATE_ORDERED between '2021-07-18' and '2021-08-14'
--WHERE    DATE_ORDERED between '2021-08-15' and '2021-09-11'
;


----------------------------------------------------------------------------------
-- po detail ---------------------------------------------------------------------
----------------------------------------------------------------------------------

-- database = CRM
--select count(*) from (
SELECT   i.FACILITYID,
         poh.FAC_SHIP_TO,
         poh.FAC_SHIP_TO_NAME,
         i.VENDOR_NBR,
         v.VENDOR_NAME,
         v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         v.PAYABLE_VENDOR_NBR,
         poh.PICKUP_POINT_CITY,
         poh.PICKUP_POINT_STATE,
         poh.PICKUP_POINT_ZIPCODE,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         pod.PIECES_IN_RETAIL_PACK,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.UPC_CASE,
         i.UPC_UNIT,
         pod.PO_NBR,
         pod.LINE_STATUS,
         pod.DATE_ORDERED,
         poh.APPOINT_MADE_DATE,
         poh.DATE_ARRIVAL,
         poh.DATE_CANCEL,
         poh.BUYER_ARRIVAL_DATE,
         poh.BUYER_PICKUP_DATE,
         poh.DATE_SHIP,
         poh.DATE_PICKUP,
         poh.DATE_RECEIVED,
         poh.ASN_DELV_DATE,
         poh.DATE_APPOINTMENT,
         poh.PO_DATE_CREATED,
         poh.PO_ORIGINAL_DLVRY_DATE,
         poh.BUYER_ARRIVAL_DATE,
         poh.APPOINT_MADE_DATE,
         pod.DATE_RECEIVED,
         pod.QUANTITY order_qty,
         pod.RECEIVED received_qty,
         pod.LIST_COST,
         pod.CORRECTED_LIST_COST,
         pod.TURN,
         pod.PROMOTION,
         pod.FORWARD_BUY
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join CRMADMIN.T_WHSE_PO_HDR poh on pod.ITEM_FAC = poh.VENDOR_FAC and pod.DATE_ORDERED = poh.DATE_ORDERED and pod.PO_NBR = poh.PO_NBR 
         inner join CRMADMIN.T_WHSE_ITEM i on pod.ITEM_FAC = i.BICEPS_DC and pod.ITEM_NBR = i.ITEM_NBR 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR
--WHERE    pod.DATE_ORDERED between '2021-08-15' and '2021-09-11'  --'08-15-2021' and '09-11-2021'
WHERE    pod.DATE_ORDERED between '2021-05-26' and '2021-07-17'
--AND      pod.ITEM_FAC = '01'
--) 5,204,567 records
;

-- database = mdvods
--select count(*) from (
SELECT   case d.division_cd 
              when 'NOR' then '070' 
              when 'BAL' then '069' 
              when 'PNS' then '027' 
              when 'SAT' then '029' 
              when 'CSG' then '033' 
              when 'BLM' then '038' 
              when 'OKA' then '039' 
     when 'CSZ' then '080' 
     when 'SAZ' then '090' 
              else '999' 
         end FACILITY,
         d.division_cd, poh.deliver_to_whse_id, 
         pod.dept_cd,
         poh.vendor_cd,
         v.vendor_name, poh.scac_carrier_desc, poh.pickup_name, poh.pickup_address1, poh.pickup_address2, poh.pickup_city_nm, poh.pickup_state_cd, poh.pickup_zip_code, 
         pod.case_upc_cd,
         i.item_desc,
         i.item_pack_qty,
         i.item_size_desc,
         i.item_upc_cd,
         poh.order_nbr, poh.load_number, 
         poh.order_date, poh.required_by_date, poh.appointment_tmsp, poh.pickup_date, poh.arrival_tmsp, poh.carrier_desc, poh.ship_instru_txt, poh.contact_desc, 
         poh.receive_date,  
         pod.order_qty,  
         pod.received_qty
FROM     whmgr.mdv_po_dtl pod 
         inner join whmgr.mdv_po_hdr poh on pod.order_nbr = poh.order_nbr 
         inner join whmgr.mdv_item i on pod.dept_cd = i.dept_cd and pod.case_upc_cd = i.case_upc_cd 
         inner join whmgr.mdv_dept d on i.dept_cd = d.dept_cd 
         inner join whmgr.mdv_vendor v on i.vendor_id = v.vendor_cd
--WHERE    (poh.receive_date between '08-15-2021' and '09-11-2021')  --'08-15-2021' and '09-11-2021'
WHERE    (poh.receive_date between '05-25-2021' and '07-17-2021')
AND      d.division_cd in ('NOR', 'BAL', 'PNS', 'SAT', 'CSG', 'BLM', 'OKA', 'CSZ', 'SAZ')
--)
;

----------------------------------------------------------------------------------
-- sales history -----------------------------------------------------------------
----------------------------------------------------------------------------------

--Netezza Sam Rahman ('2021-07-17')
/*      Location - Demand History FD                 (check if we need to multiply the qty by pack)                        */
--select count(*) from (
SELECT   S.INVOICE_NBR,
         LPAD(s.FACILITY_ID,3,0) Facility,
         LPAD(NVL(s.SHIP_FACILITY_ID,0),3,0) Stock_facility,
         LPAD(s.ITEM_NBR,7,0) as SKU_UNQ,
         LPAD(s.CUSTOMER_NBR,6,0) CUSTOMER_NBR,
         s.TRANSACTION_DATE,
         S.DELIVERY_DATE,
         D.FISCAL_WEEK_ID,
         i.CASE_PACK_QTY,
         s.OUT_REASON_CD, S.NET_PRICE_AMT, 
         sum(s.ORDERED_QTY) as ORIG_ORD_QTY,
         sum(s.ADJUSTED_QTY) as ADJ_ORD_QTY,
         sum(s.SHIPPED_QTY) as UNITS_SOLD,
--         sum(s.EXT_NET_PRICE_AMT) SALES_AMT,
         sum(case when s.FACILITY_ID in (80, 90) then S.EXT_WHSE_SALES_AMT else s.EXT_NET_PRICE_AMT end) SALES_AMT,
         sum(s.ORDERED_QTY - s.SHIPPED_QTY) as ORIG_LOST_SALES_QTY,
         sum((s.ORDERED_QTY - s.SHIPPED_QTY) * S.NET_PRICE_AMT) as ORIG_LOST_SALES_CALC_AMT,
         sum(S.EXT_LOST_SALES_AMT) LOST_SALES
FROM     WH_OWNER.DC_SALES_HST S 
         inner join WH_OWNER.FISCAL_DAY D on D.SALES_DT = S.TRANSACTION_DATE 
         inner join WH_OWNER.DC_ITEM i on s.FACILITY_ID = i.FACILITY_ID and s.ITEM_NBR = i.ITEM_NBR
WHERE    TRANSACTION_DATE between '2021-05-26' and '2021-07-17'
--WHERE    TRANSACTION_DATE between '2021-04-14' and '2021-04-14'
--AND      s.FACILITY_ID in (80, 90)
--and (s.CUSTOMER_NBR = 29190 and s.FACILITY_ID = 15 and s.INVOICE_NBR = 1625199)
GROUP BY S.INVOICE_NBR, s.FACILITY_ID, s.SHIP_FACILITY_ID, s.ITEM_NBR, 
         s.CUSTOMER_NBR, s.TRANSACTION_DATE, S.DELIVERY_DATE, D.FISCAL_WEEK_ID, 
         i.CASE_PACK_QTY, s.OUT_REASON_CD, S.NET_PRICE_AMT
--) x
;


--mdvods Sam Rahman ('2021-07-17')
/*      Location - Demand History MDV                (check if we need to multiply the qty by pack)                        */

SELECT   case d.division_cd 
              when 'NOR' then '070' 
              when 'BAL' then '069' 
              when 'PNS' then '027' 
              when 'SAT' then '029' 
              when 'CSG' then '033' 
              when 'BLM' then '038' 
              when 'OKA' then '039' 
              else '999' 
         end FACILITY,
         d.division_cd,
         shd.dept_cd,
         shd.customer_nbr,
         shd.ship_to_id, v.vendor_cd, 
         v.vendor_name,
         i.case_upc_cd,
         i.item_desc,
         i.item_pack_qty,
         i.item_size_desc,
         i.item_upc_cd,
         shd.sales_catgy_code,
         shd.sales_catgy_desc,
         shd.order_qty,
         shd.ship_qty, shd.ext_cost_amt, shd.ext_drayage_amt, shd.tot_order_line_amt, 
         shd.ship_date,
         shd.order_nbr,
         shd.order_line_nbr
FROM     whmgr.mdv_sales_hst shd 
         inner join whmgr.mdv_item i on shd.dept_cd = i.dept_cd and shd.upc_cd = i.case_upc_cd 
         inner join whmgr.mdv_dept d on i.dept_cd = d.dept_cd 
         inner join whmgr.mdv_vendor v on i.vendor_id = v.vendor_cd
WHERE    (shd.ship_date between '05-25-2021' and '07-17-2021') --'08-15-2021' and '09-11-2021')
--WHERE    (shd.ship_date between '12-29-2018' and '12-28-2019')
--WHERE    (shd.ship_date between '12-29-2019' and '01-02-2021')
and      d.division_cd in ('NOR', 'BAL', 'PNS', 'SAT', 'CSG', 'BLM', 'OKA')
;

----------------------------------------------------------------------------------
-- inventory ---------------------------------------------------------------------
----------------------------------------------------------------------------------

-- CRM Sam Rahman ('2021-07-17') 
--Victor's SQL
select count(*) from (
;
SELECT   L.ITEM_NBR_HS,
         L.UPC_CASE,
         L.UPC_UNIT,
         L.FACILITYID,
         L.PO_NBR,
         SUM(( INVENTORY_TURN + INVENTORY_PROMOTION + INVENTORY_FWD_BUY)* (CASE WHEN L.RAND_WGT_CD = 'R' THEN L.SHIPPING_CASE_WEIGHT ELSE COALESCE(L.STORE_PACK,0) END) ) QTY_UNIT,
         SUM( L.INVENTORY_TURN + L.INVENTORY_PROMOTION + L.INVENTORY_FWD_BUY) QTY_CASE,
         SUM((L.INVENTORY_TURN + L.INVENTORY_PROMOTION + L.INVENTORY_FWD_BUY) * ((case when L.CORRECT_NET_COST <> 0 then L.CORRECT_NET_COST else L.NET_COST_PER_CASE end) * case when dx.ENTERPRISE_KEY = 1 then (case when L.RAND_WGT_CD = 'R' then L.SHIPPING_CASE_WEIGHT else 1 end) else 1 end)) EXT_CASE_COST,
         sum(L.INVENTORY_TURN) as INVENTORY_TURN,
         sum(L.INVENTORY_PROMOTION) as INVENTORY_PROMOTION,
         SUM(L.INVENTORY_FWD_BUY) as INVENTORY_FWD_BUY,
         L.LAYER_FILE_DTE,
         L.RAND_WGT_CD,
         L.SHIPPING_CASE_WEIGHT,
         L.STORE_PACK,
         L.SHIPPING_CASE_WEIGHT
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY L 
         join CRMADMIN.T_DATE D on D.DATE_KEY = l.LAYER_FILE_DTE --and d.DAY_OF_WEEK_ID = 7 
         join CRMADMIN.T_WHSE_DIV_XREF dx on L.FACILITYID = dx.SWAT_ID
--WHERE    L.LAYER_FILE_DTE between '2021-08-15' and '2021-09-11'
WHERE    L.LAYER_FILE_DTE between '2021-05-25' and '2021-07-17'
--WHERE    (D.COMPANY_YEAR_ID = 2020 and D.COMPANY_QUARTER_ID = 1)
--WHERE    (D.COMPANY_YEAR_ID = 2020 and D.COMPANY_QUARTER_ID = 2)
--WHERE    (D.COMPANY_YEAR_ID = 2020 and D.COMPANY_QUARTER_ID = 3)
--WHERE    (D.COMPANY_YEAR_ID = 2020 and D.COMPANY_QUARTER_ID = 4)
--WHERE    (D.COMPANY_YEAR_ID = 2021 and D.COMPANY_QUARTER_ID = 1)
--WHERE    (D.COMPANY_YEAR_ID = 2021 and D.COMPANY_QUARTER_ID = 2 and d.COMPANY_WEEK_ID between 21 and 23)
--WHERE    l.LAYER_FILE_DTE = current date - 1 day
GROUP BY L.ITEM_NBR_HS, L.UPC_CASE, L.UPC_UNIT, L.FACILITYID, L.PO_NBR, 
         LPAD(STOCK_FAC,3,0), L.LAYER_FILE_DTE, L.RAND_WGT_CD, 
         L.SHIPPING_CASE_WEIGHT, L.STORE_PACK, 
         ( INVENTORY_TURN + INVENTORY_PROMOTION + INVENTORY_FWD_BUY), 
         L.SHIPPING_CASE_WEIGHT
HAVING   SUM( INVENTORY_TURN + INVENTORY_PROMOTION + INVENTORY_FWD_BUY) >0
;
)
;

----------------------------------------------------------------------------------
-- product master ----------------------------------------------------------------
----------------------------------------------------------------------------------

--CRM
/*      Product Master                                                       */
--select count(*) from (
SELECT
	I.FACILITYID || I.ITEM_NBR_HS KEY,
	I.FACILITYID Facility,
	I.STOCK_FAC SHIP_FACILITY,
	I.ITEM_NBR_HS SKU,
	I.UPC_CASE CASE_UPC_NBR,
	I.UPC_UNIT UNIT_UPC_NBR,
	I.ROOT_DESC ROOT_ITEM_DESC,
	mds.DEPT_GRP_CODE_DESC SKU_TYPE,
	CASE
		WHEN mds.DEPT_GRP_CODE IN (20, 30, 60, 90, 110) THEN mds.MDSE_GRP_CODE_DESC
		ELSE 'NOT-FRESH'
	END FRESH_TYPE,
	mds.MDSE_GRP_CODE_DESC CAT,
	mds.MDSE_CLS_CODE_DESC SUB_CAT,
	mds.DEPT_GRP_CODE DEPT_GRP_KEY,
	mds.DEPT_GRP_CODE_DESC DEPT_GRP_NAME,
	mds.DEPT_CODE DEPT_KEY,
	mds.DEPT_CODE_DESC DEPT_NAME,
	mds.MDSE_GRP_CODE MDSE_GRP_KEY,
	mds.MDSE_GRP_CODE_DESC MDSE_GRP_NAME,
	mds.MDSE_CAT_CODE MDSE_CATGY_KEY,
	mds.MDSE_CAT_CODE_DESC MDSE_CATGY_NAME,
	mds.MDSE_CLS_CODE MDSE_CLASS_KEY,
	mds.MDSE_CLS_CODE_DESC MDSE_CLASS_NAME,
	(I.WHSE_TIE * I.WHSE_TIER) PALLET_SIZE,
	'' LOT_SIZE,
	I.ITEM_SIZE ITEM_SIZE_MSR,
	I.ITEM_SIZE_UOM ITEM_SIZE_UOM_CD,
	I.ITEM_ADDED_DATE ITEM_ADDED_DATE,
	I.AVAILABILITY_DATE AVAILABILITY_DATE,
	I.BILLING_STATUS_DATE BILLING_STATUS_DATE,
	I.SHELF_LIFE SHELF_LIFE_QTY,
	i.SHIPPING_CASE_CUBE SHIP_CASE_CUBE_MSR,
	i.SHIPPING_CASE_WEIGHT SHIP_CASE_WGHT_MSR,
	CASE
		WHEN I.SERVICE_LEVEL_CODE IN ('A', 'B', 'C', 'D', 'E') THEN I.SERVICE_LEVEL_CODE
		ELSE 'U'
	END ITEM_RANK_CD,
	I.PACK_CASE CASE_PACK_QTY,
	I.MASTER_PACK MASTER_PACK_QTY,
	I.RETAIL_PACK RETAIL_PACK_QTY,
	I.CATALOG_PRICE CATALOG_PRICE_AMT,
	I.CODE_DATE_FLAG,
	I.CODE_DATE_MIN,
	I.CODE_DATE_MAX,
	i.WAREHOUSE_CODE,
	wc.WAREHOUSE_CODE_DESC_FAC,
	wc.WAREHOUSE_CODE_TEMP_ZONE, 
    i.RAND_WGT_CD, 
    i.ITEM_RES33 --, i.SAFETY_STOCK, i.CYCLE_STOCK
FROM
	CRMADMIN.T_WHSE_ITEM I
inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mds ON
	mds.MDSE_CLS_CODE = i.MERCH_CLASS
inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc ON
	wc.FACILITYID = i.FACILITYID
	AND wc.WAREHOUSE_CODE = i.WAREHOUSE_CODE
WHERE
	I.PURCH_STATUS <> 'Z'
	AND I.BILLING_STATUS_BACKSCREEN <> 'Z' 

union all

SELECT
	'080' || I.ITEM_NBR_HS KEY,
	'080' Facility,
	'080' SHIP_FACILITY,
	I.ITEM_NBR_HS SKU,
	I.UPC_CASE CASE_UPC_NBR,
	I.UPC_UNIT UNIT_UPC_NBR,
	I.ROOT_DESC ROOT_ITEM_DESC,
	mds.DEPT_GRP_CODE_DESC SKU_TYPE,
	CASE
		WHEN mds.DEPT_GRP_CODE IN (20, 30, 60, 90, 110) THEN mds.MDSE_GRP_CODE_DESC
		ELSE 'NOT-FRESH'
	END FRESH_TYPE,
	mds.MDSE_GRP_CODE_DESC CAT,
	mds.MDSE_CLS_CODE_DESC SUB_CAT,
	mds.DEPT_GRP_CODE DEPT_GRP_KEY,
	mds.DEPT_GRP_CODE_DESC DEPT_GRP_NAME,
	mds.DEPT_CODE DEPT_KEY,
	mds.DEPT_CODE_DESC DEPT_NAME,
	mds.MDSE_GRP_CODE MDSE_GRP_KEY,
	mds.MDSE_GRP_CODE_DESC MDSE_GRP_NAME,
	mds.MDSE_CAT_CODE MDSE_CATGY_KEY,
	mds.MDSE_CAT_CODE_DESC MDSE_CATGY_NAME,
	mds.MDSE_CLS_CODE MDSE_CLASS_KEY,
	mds.MDSE_CLS_CODE_DESC MDSE_CLASS_NAME,
	(I.WHSE_TIE * I.WHSE_TIER) PALLET_SIZE,
	'' LOT_SIZE,
	I.ITEM_SIZE ITEM_SIZE_MSR,
	I.ITEM_SIZE_UOM ITEM_SIZE_UOM_CD,
	I.ITEM_ADDED_DATE ITEM_ADDED_DATE,
	I.AVAILABILITY_DATE AVAILABILITY_DATE,
	I.BILLING_STATUS_DATE BILLING_STATUS_DATE,
	I.SHELF_LIFE SHELF_LIFE_QTY,
	i.SHIPPING_CASE_CUBE SHIP_CASE_CUBE_MSR,
	i.SHIPPING_CASE_WEIGHT SHIP_CASE_WGHT_MSR,
	CASE
		WHEN I.SERVICE_LEVEL_CODE IN ('A', 'B', 'C', 'D', 'E') THEN I.SERVICE_LEVEL_CODE
		ELSE 'U'
	END ITEM_RANK_CD,
	I.PACK_CASE CASE_PACK_QTY,
	I.MASTER_PACK MASTER_PACK_QTY,
	I.RETAIL_PACK RETAIL_PACK_QTY,
	I.CATALOG_PRICE CATALOG_PRICE_AMT,
	I.CODE_DATE_FLAG,
	I.CODE_DATE_MIN,
	I.CODE_DATE_MAX,
	i.WAREHOUSE_CODE,
	wc.WAREHOUSE_CODE_DESC_FAC,
	wc.WAREHOUSE_CODE_TEMP_ZONE, 
    i.RAND_WGT_CD, 
    i.ITEM_RES33 --, i.SAFETY_STOCK, i.CYCLE_STOCK
FROM
	CRMADMIN.T_WHSE_ITEM I
inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mds ON
	mds.MDSE_CLS_CODE = i.MERCH_CLASS
inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc ON
	wc.FACILITYID = i.FACILITYID
	AND wc.WAREHOUSE_CODE = i.WAREHOUSE_CODE
WHERE
	I.PURCH_STATUS <> 'Z'
	AND I.BILLING_STATUS_BACKSCREEN <> 'Z' 
    AND i.FACILITYID = '061'

union all

SELECT
	'090' || I.ITEM_NBR_HS KEY,
	'090' Facility,
	'090' SHIP_FACILITY,
	I.ITEM_NBR_HS SKU,
	I.UPC_CASE CASE_UPC_NBR,
	I.UPC_UNIT UNIT_UPC_NBR,
	I.ROOT_DESC ROOT_ITEM_DESC,
	mds.DEPT_GRP_CODE_DESC SKU_TYPE,
	CASE
		WHEN mds.DEPT_GRP_CODE IN (20, 30, 60, 90, 110) THEN mds.MDSE_GRP_CODE_DESC
		ELSE 'NOT-FRESH'
	END FRESH_TYPE,
	mds.MDSE_GRP_CODE_DESC CAT,
	mds.MDSE_CLS_CODE_DESC SUB_CAT,
	mds.DEPT_GRP_CODE DEPT_GRP_KEY,
	mds.DEPT_GRP_CODE_DESC DEPT_GRP_NAME,
	mds.DEPT_CODE DEPT_KEY,
	mds.DEPT_CODE_DESC DEPT_NAME,
	mds.MDSE_GRP_CODE MDSE_GRP_KEY,
	mds.MDSE_GRP_CODE_DESC MDSE_GRP_NAME,
	mds.MDSE_CAT_CODE MDSE_CATGY_KEY,
	mds.MDSE_CAT_CODE_DESC MDSE_CATGY_NAME,
	mds.MDSE_CLS_CODE MDSE_CLASS_KEY,
	mds.MDSE_CLS_CODE_DESC MDSE_CLASS_NAME,
	(I.WHSE_TIE * I.WHSE_TIER) PALLET_SIZE,
	'' LOT_SIZE,
	I.ITEM_SIZE ITEM_SIZE_MSR,
	I.ITEM_SIZE_UOM ITEM_SIZE_UOM_CD,
	I.ITEM_ADDED_DATE ITEM_ADDED_DATE,
	I.AVAILABILITY_DATE AVAILABILITY_DATE,
	I.BILLING_STATUS_DATE BILLING_STATUS_DATE,
	I.SHELF_LIFE SHELF_LIFE_QTY,
	i.SHIPPING_CASE_CUBE SHIP_CASE_CUBE_MSR,
	i.SHIPPING_CASE_WEIGHT SHIP_CASE_WGHT_MSR,
	CASE
		WHEN I.SERVICE_LEVEL_CODE IN ('A', 'B', 'C', 'D', 'E') THEN I.SERVICE_LEVEL_CODE
		ELSE 'U'
	END ITEM_RANK_CD,
	I.PACK_CASE CASE_PACK_QTY,
	I.MASTER_PACK MASTER_PACK_QTY,
	I.RETAIL_PACK RETAIL_PACK_QTY,
	I.CATALOG_PRICE CATALOG_PRICE_AMT,
	I.CODE_DATE_FLAG,
	I.CODE_DATE_MIN,
	I.CODE_DATE_MAX,
	i.WAREHOUSE_CODE,
	wc.WAREHOUSE_CODE_DESC_FAC,
	wc.WAREHOUSE_CODE_TEMP_ZONE, 
    i.RAND_WGT_CD, 
    i.ITEM_RES33 --, i.SAFETY_STOCK, i.CYCLE_STOCK
FROM
	CRMADMIN.T_WHSE_ITEM I
inner join ETLADMIN.V_MDM_MDSE_HIERARCHY mds ON
	mds.MDSE_CLS_CODE = i.MERCH_CLASS
inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE wc ON
	wc.FACILITYID = i.FACILITYID
	AND wc.WAREHOUSE_CODE = i.WAREHOUSE_CODE
WHERE
	I.PURCH_STATUS <> 'Z'
	AND I.BILLING_STATUS_BACKSCREEN <> 'Z' 
    AND i.FACILITYID = '061'
--);

;

SELECT   case d.division_cd 
     when 'NOR' then '070' 
     when 'BAL' then '069' 
     when 'PNS' then '027' 
     when 'SAT' then '029' 
     when 'CSG' then '033' 
     when 'BLM' then '038' 
     when 'OKA' then '039' 
     else '999' 
end FACILITY,
         d.division_cd,
         i.DEPT_CD, 
         d.DEPT_DESC,
         i.CASE_UPC_CD,
         i.VENDOR_ID,
         i.AP_VENDOR_ID,
         i.ITEM_DESC,
         i.ITEM_PACK_QTY,
         i.ITEM_SIZE_DESC,
         i.PROD_GROUP_CD,
         i.COMMODITY_CD,
         i.LBS_MSR,
         i.NET_MSR,
         i.CUBE_MSR,
         i.MASTER_PACK_FLG,
         i.ITEM_STATUS_CD,
         i.PURCHASE_RANK_CD,
         i.UOM_CD,
         i.CATCH_WGT_FLG,
         i.CASE_COST_AMT,
         i.SELL_PRICE_AMT,
         i.FEE_AMT,
         i.FEE_METHOD_CD,
         i.BIRTH_DATE,
         i.LAST_SALE_DATE,
         i.LAST_PO_DATE,
         i.DECA_PHS_DATE,
         i.LAST_RECEIPT_DATE,
         i.ITEM_UPC_CD,
         i.EXPANDED_UPC_CD,
         i.SHIPPING_GTIN_NBR,
         i.ITEM_GTIN_NBR,
         i.PURCHASE_GTIN_NBR,
         i.SEASON_CD,
         i.UPSTREAM_FLG,
         i.ABC_CLASS_CD,
         i.PO_RESTRICT_CD,
         i.CODE_DATE_FLG,
         i.ECON_ORDER_QTY,
         i.LEAD_TIME_ID,
         i.EFF_ECON_ORDER_QTY,
         i.CUSTOMER_GRP_NBR,
         i.EXP_PO_UPC_CD,
         i.EXP_BILL_UPC_CD,
         i.STD_PROD_COST_AMT,
         i.STD_ITEM_COST_AMT,
         i.STD_ITEM_SELL_AMT,
         i.ITEM_DELETE_FLG,
         i.BUYER_DELETE_FLG,
         i.PS_PROD_CD,
         i.PRIVATE_LABEL_DESC,
         i.SHELF_LIFE_NBR,
         i.ORDER_POINT_QTY,
         i.MIN_LAYERS_QTY
FROM     WH_OWNER.MDV_ITEM_ODS i 
         inner join wh_owner.mdv_dept d on i.DEPT_CD = d.dept_cd
;


----------------------------------------------------------------------------------
-- customer master ---------------------------------------------------------------
----------------------------------------------------------------------------------






----------------------------------------------------------------------------------
-- SQL DIRECT LINKS --------------------------------------------------------------
----------------------------------------------------------------------------------


--crm
SELECT   i.FACILITYID,
         i.STOCK_FAC,
         i.VENDOR_NBR,
         v.STATUS VEND_STATUS,
         i.ITEM_NBR_HS,
         i.UPC_UNIT,
         i.PURCH_STATUS,
         i.ORDER_INTERVAL_WEEKS,
         (i.ORDER_INTERVAL_WEEKS * 7) ORDER_INTERVAL_DAYS
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR
WHERE    i.PURCH_STATUS not in ('Z')
AND      v.VENDOR_TYPE = 'V'
AND      v.STATUS not in ('Z')
;


--netezza
SELECT   DEPT_CD,
         CASE_UPC_CD,
         EXPANDED_UPC_CD
FROM     WH_OWNER.MDV_ITEM_ODS
WHERE    DEPT_CD in (80, 90)
;

--netezza
SELECT   se.SHIP_ERROR_GRP_CD,
         seg.SHIP_ERROR_GRP_DESC,
         se.SHIP_ERROR_CD,
         se.SHIP_ERROR_DESC
FROM     WH_OWNER.SHIP_ERROR se 
         inner join WH_OWNER.SHIP_ERROR_GRP seg on seg.SHIP_ERROR_GRP_CD = se.SHIP_ERROR_GRP_CD
;








SELECT   i.FACILITYID,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.VENDOR_NBR,
         v.VENDOR_NAME,
         i.BUYER_NBR,
         i.MASTER_PACK,
         i.PACK_CASE,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.MASTER_CASE_CUBE,
         i.SHIPPING_CASE_CUBE,
         i.VENDOR_PALLET_FACTOR,
         nvl(i.VENDOR_TIE, 0) VENDOR_TIE,
         nvl(i.VENDOR_TIER, 0) VENDOR_TIER,
         nvl(i.WHSE_TIE, 0) WHSE_TIE,
         nvl(i.WHSE_TIER, 0) WHSE_TIER,
         nvl(i.CYCLE_STOCK, 0) CYCLE_STOCK,
         nvl(i.SAFETY_STOCK, 0) SAFETY_STOCK,
         nvl(i.INVENTORY_TURN, 0) INVENTORY_TURN,
         nvl(i.INVENTORY_PROMOTION, 0) INVENTORY_PROMOTION,
         nvl(i.INVENTORY_FWD_BUY, 0) INVENTORY_FWD_BUY,
         nvl(i.ON_ORDER_TOTAL, 0) ON_ORDER_TOTAL,
         CASE 
              WHEN i.VENDOR_PALLET_FACTOR = 'C' THEN nvl(i.SAFETY_STOCK, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'L' THEN nvl(i.WHSE_TIE, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'N' THEN 0 
              WHEN i.VENDOR_PALLET_FACTOR = 'P' THEN nvl(i.VENDOR_TIE, 0) * nvl(i.VENDOR_TIER, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'T' THEN nvl(i.VENDOR_TIE, 0) 
              WHEN i.VENDOR_PALLET_FACTOR = 'U' THEN 1 
              WHEN i.VENDOR_PALLET_FACTOR = 'W' THEN nvl(i.WHSE_TIE, 0) * nvl(i.WHSE_TIER, 0) 
              ELSE -99 
         END mfg_min_order_qty,
         v.CURRENT_BKT_TYPE,
         v.CURRENT_BKT_QUANTITY
FROM     CRMADMIN.T_WHSE_ITEM i 
         inner join CRMADMIN.T_WHSE_VENDOR v on v.FACILITYID = i.FACILITYID and v.VENDOR_NBR = i.VENDOR_NBR
WHERE    i.PURCH_STATUS not in 'Z'
--AND      i.FACILITYID in ('003', '008', '015', '040', '058', '086')
AND      i.FACILITYID in ('002', '071', '054')