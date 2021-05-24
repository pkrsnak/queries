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
         pod.CORRECTED_LIST_COST
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join CRMADMIN.T_WHSE_PO_HDR poh on pod.ITEM_FAC = poh.VENDOR_FAC and pod.DATE_ORDERED = poh.DATE_ORDERED and pod.PO_NBR = poh.PO_NBR 
         inner join CRMADMIN.T_WHSE_ITEM i on pod.ITEM_FAC = i.BICEPS_DC and pod.ITEM_NBR = i.ITEM_NBR 
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR
WHERE    pod.DATE_ORDERED > '2018-12-29'
--AND      pod.ITEM_FAC = '01'
--) 5,204,567 records
;

--select count(*) from (
SELECT   d.division_cd,
         pod.dept_cd,
         poh.vendor_cd,
         v.vendor_name,
         pod.case_upc_cd,
         i.item_desc,
         i.item_pack_qty,
         i.item_size_desc,
         i.item_upc_cd,
         poh.order_nbr,
         poh.order_date,
         poh.receive_date,
         pod.order_qty,
         pod.received_qty
FROM     whmgr.mdv_po_dtl pod 
         inner join whmgr.mdv_po_hdr poh on pod.order_nbr = poh.order_nbr 
         inner join whmgr.mdv_item i on pod.dept_cd = i.dept_cd and pod.case_upc_cd = i.case_upc_cd 
         inner join whmgr.mdv_dept d on i.dept_cd = d.dept_cd 
         inner join whmgr.mdv_vendor v on i.vendor_id = v.vendor_cd
WHERE    poh.receive_date >= date(current) - 90
--)
;


--select count(*) from (
SELECT   i.FACILITYID,
         od.CUSTOMER_NBR_STND,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_SIZE,
         i.ITEM_SIZE_UOM,
         i.UPC_CASE,
         i.UPC_UNIT,
         od.ORDER_TYPE,
         od.QTY,
         od.NET_QTY,
         od.ORDER_STATUS,
         od.INVOICE_NBR,
         od.ORDER_RECVD_DTE,
         od.ORDER_RECVD_TIME,
         od.SUBMIT_TIME,
         od.BILLING_DATE,
         od.SHIP_DATE,
         od.RTL_ORDER_ID,
         od.DC_ORDER_ID,
         od.LINE_ITEM_ID
FROM     CRMADMIN.T_WHSE_ORDER_DTL od 
         inner join CRMADMIN.T_WHSE_ITEM i on od.FACILITYID = i.FACILITYID and od.ITEM_NBR_HS = i.ITEM_NBR_HS
WHERE    od.ORDER_RECVD_DTE >= current date - 90 day
--AND      od.FACILITYID = '001'
--)
;



--select count(*) from (
SELECT   d.division_cd,
         shd.dept_cd,
         shd.customer_nbr,
         shd.ship_to_id,
         v.vendor_name,
         i.case_upc_cd,
         i.item_desc,
         i.item_pack_qty,
         i.item_size_desc,
         i.item_upc_cd,
         shd.sales_catgy_code,
         shd.sales_catgy_desc,
         shd.order_qty,
         shd.ship_qty,
         shd.ship_date,
         shd.order_nbr,
         shd.order_line_nbr
FROM     whmgr.mdv_sales_hst shd 
         inner join whmgr.mdv_item i on shd.dept_cd = i.dept_cd and shd.upc_cd = i.case_upc_cd 
         inner join whmgr.mdv_dept d on i.dept_cd = d.dept_cd 
         inner join whmgr.mdv_vendor v on i.vendor_id = v.vendor_cd
WHERE    shd.ship_date >= date(current) - 90
--)
;

SELECT   TRANSACTION_DATE,
         FACILITY_ID,
         CUSTOMER_NBR,
         INVOICE_NBR,
         count(*) num_line_items
FROM     WH_OWNER.DC_SALES_HST
WHERE    FACILITY_ID = 1
AND      TRANSACTION_DATE >= '08-26-2020'
GROUP BY TRANSACTION_DATE, FACILITY_ID, CUSTOMER_NBR, INVOICE_NBR
;



/*      Location - Facility FD                                               */

 

Select LPAD(FACILITY_ID,3,0) FACILITY, FACILITY_NAME, UPSTREAM_DC_CD, BILLING_SYSTEM_CD
 from WH_OWNER.DC_FACILITY
;

/*      Location - Facility MDV                                              */

 

SELECT   case division_cd 
     when 'NOR' then '070' 
     when 'BAL' then '069' 
     when 'PNS' then '027' 
     when 'SAT' then '029' 
     when 'CSG' then '033' 
     when 'BLM' then '038' 
     when 'OKA' then '039' 
     else '999' 
end FACILITY,
         division_cd,
         division_name,
         street_1_addr,
         street_2_addr,
         city_name,
         state_cd,
         zip_cd,
         region_cd
FROM     whmgr.mdv_division
where active_flg = 'True' and natl_acct_flg = 'False'
;
 



/*      Location - Vendor FD                                                 */

 

Select lpad(VENDOR_NBR,6,0) VENDOR_NBR , VENDOR_NAME , LPAD(FACILITY_ID,3,0) FACILITY_ID , STREET_1_ADDR , STREET_2_ADDR , CITY_NAME , STATE_CD , ZIP_CD , VENDOR_STATUS_CD 
from WH_OWNER.DC_VENDOR
--where VENDOR_STATUS_CD <> 'D' 

/*      Location - Vendor MDV                                                */

SELECT   vendor_cd,
         vendor_name,
         street_1_addr,
         street_2_addr,
         city_name,
         state_cd,
         zip_cd
FROM     whmgr.mdv_vendor
;

;
/*      Location - Customer FD                                               */
select LPAD(FACILITY_ID,3,0) FACILITY , LPAD(CUSTOMER_NBR,6,0) CUSTOMER_NBR , CUSTOMER_NAME , CUST_ST1_ADDR , CUST_ST2_ADDR , CUST_STATE_CD , CUST_ZIP_CD , CUST_STATUS_CD 
from WH_OWNER.DC_CUSTOMER
where CUST_STATUS_CD <> 'Z'
;

/*      Location - Customer MDV                                              */
SELECT   ship_to_id, ship_to_name , street_1_addr , street_2_addr , city_name , state_cd , zip_cd , export_flg 
FROM     whmgr.mdv_ship_to
;

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
         sum(s.EXT_NET_PRICE_AMT) SALES_AMT,
         sum(s.ORDERED_QTY - s.SHIPPED_QTY) as ORIG_LOST_SALES_QTY,
         sum((s.ORDERED_QTY - s.SHIPPED_QTY) * S.NET_PRICE_AMT) as ORIG_LOST_SALES_CALC_AMT,
         sum(S.EXT_LOST_SALES_AMT) LOST_SALES
FROM     WH_OWNER.DC_SALES_HST S 
         inner join WH_OWNER.FISCAL_DAY D on D.SALES_DT = S.TRANSACTION_DATE 
         inner join WH_OWNER.DC_ITEM i on s.FACILITY_ID = i.FACILITY_ID and s.ITEM_NBR = i.ITEM_NBR
WHERE    TRANSACTION_DATE between '2018-12-29' and '2021-01-02'
--WHERE    TRANSACTION_DATE between '2021-04-14' and '2021-04-14'
AND      s.FACILITY_ID in (80, 90)
--and (s.CUSTOMER_NBR = 29190 and s.FACILITY_ID = 15 and s.INVOICE_NBR = 1625199)
GROUP BY S.INVOICE_NBR, s.FACILITY_ID, s.SHIP_FACILITY_ID, s.ITEM_NBR, 
         s.CUSTOMER_NBR, s.TRANSACTION_DATE, S.DELIVERY_DATE, D.FISCAL_WEEK_ID, 
         i.CASE_PACK_QTY, s.OUT_REASON_CD, S.NET_PRICE_AMT
--) x
;

SELECT   transaction_date,
         facility_id,
         customer_nbr,
         invoice_nbr,
         item_nbr,
         ship_error_cd,
         not_ship_case_qty
FROM     whmgr.dc_bill_error_dtl
WHERE    TRANSACTION_DATE between '12-29-2018' and '01-02-2021'
AND      facility_id = 1  
;


/*      Location - Demand History FD                 (check if we need to multiply the qty by pack)                        */
SELECT   S.INVOICE_NBR,
         LPAD(s.FACILITY_ID,3,0) Facility,
         LPAD(NVL(s.SHIP_FACILITY_ID,0),3,0) Stock_facility,
         LPAD(s.ITEM_NBR,7,0) as SKU_UNQ,
         LPAD(s.CUSTOMER_NBR,6,0) CUSTOMER_NBR,
         s.TRANSACTION_DATE,
         S.DELIVERY_DATE,
         D.FISCAL_WEEK_ID,
         i.CASE_PACK_QTY,
         sum(s.SHIPPED_QTY) as UNITS_SOLD,
         sum(s.EXT_NET_PRICE_AMT) SALES_AMT,
         sum(S.EXT_LOST_SALES_AMT) LOST_SALES
FROM     WH_OWNER.DC_SALES_HST S 
         inner join WH_OWNER.FISCAL_DAY D on D.SALES_DT = S.TRANSACTION_DATE 
         inner join WH_OWNER.DC_ITEM i on s.FACILITY_ID = i.FACILITY_ID and s.ITEM_NBR = i.ITEM_NBR
WHERE    TRANSACTION_DATE between '2018-12-29' and '2021-01-02'
and s.FACILITY_ID in (80, 90)
--'12-29-2018' and '01-02-2021'
GROUP BY S.INVOICE_NBR, s.FACILITY_ID, s.SHIP_FACILITY_ID, s.ITEM_NBR, 
         s.CUSTOMER_NBR, s.TRANSACTION_DATE, S.DELIVERY_DATE, D.FISCAL_WEEK_ID, 
         i.CASE_PACK_QTY
HAVING   UNITS_SOLD > 0
;


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
WHERE    (shd.ship_date between '12-29-2018' and '01-02-2021')
--WHERE    (shd.ship_date between '12-29-2018' and '12-28-2019')
--WHERE    (shd.ship_date between '12-29-2019' and '01-02-2021')
and      d.division_cd in ('NOR', 'BAL', 'PNS', 'SAT', 'CSG', 'BLM', 'OKA')
;

--select count(*) from (
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
WHERE    (poh.receive_date between '12-29-2018' and '01-02-2021')
and      d.division_cd in ('NOR', 'BAL', 'PNS', 'SAT', 'CSG', 'BLM', 'OKA')
--)
;


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
         PICKUP_POINT_ZIPCODE
FROM     CRMADMIN.T_WHSE_PO_HDR
WHERE    DATE_ORDERED >= '2021-03-01'
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
WHERE    (poh.receive_date between '12-29-2018' and '01-02-2021')
AND      d.division_cd in ('NOR', 'BAL', 'PNS', 'SAT', 'CSG', 'BLM', 'OKA')
;


MDV_00000000023577330
MDV_00000004200087346
MDV_00000007562072715

;


/*      Product Master                                                       */
Select (LPAD(I.FACILITY_ID,3,0) || LPAD(I.ITEM_NBR,7,0)) KEY,
LPAD(I.FACILITY_ID,3,0) Facility, LPAD(NVL(I.SHIP_FACILITY_ID,0),3,0) SHIP_FACILITY, LPAD(I.ITEM_NBR,7,0) as SKU, I.CASE_UPC_NBR, I.UNIT_UPC_NBR, I.ROOT_ITEM_DESC, DG.DEPT_GRP_NAME SKU_TYPE, 
CASE WHEN DG.DEPT_GRP_KEY in (20,30,60,90,110) THEN MG.MDSE_GRP_NAME ELSE 'NOT-FRESH' END FRESH_TYPE, MG.MDSE_GRP_NAME CAT, MCL.MDSE_CLASS_NAME SUB_CAT,
DG.DEPT_GRP_KEY, DG.DEPT_GRP_NAME, D.DEPT_KEY, D.DEPT_NAME, MG.MDSE_GRP_KEY, MG.MDSE_GRP_NAME, MC.MDSE_CATGY_KEY, MC.MDSE_CATGY_NAME, MCL.MDSE_CLASS_KEY, MCL.MDSE_CLASS_NAME, 
(I.WHSE_TIE_MSR * I.WHSE_TIER_MSR) PALLET_SIZE, '' LOT_SIZE, I.ITEM_SIZE_MSR, I.ITEM_SIZE_UOM_CD,  I.ITEM_ADDED_DATE, I.AVAILABILITY_DATE, I.BILLING_STATUS_DATE , I.SHELF_LIFE_QTY, I.SHIP_CASE_CUBE_MSR, I.SHIP_CASE_WGHT_MSR, I.ITEM_RANK_CD, I.CASE_PACK_QTY, I.MASTER_PACK_QTY, I.RETAIL_PACK_QTY, I.CATALOG_PRICE_AMT
       
from WH_OWNER.DEPARTMENT_GROUP DG 
	join WH_OWNER.DEPARTMENT D on D.DEPT_GRP_KEY = DG.DEPT_GRP_KEY 
	join WH_OWNER.MDSE_GROUP MG on MG.DEPT_KEY = D.DEPT_KEY
    join WH_OWNER.MDSE_CATEGORY MC on MC.MDSE_GRP_KEY = MG.MDSE_GRP_KEY
    join WH_OWNER.MDSE_CLASS MCL on MCL.MDSE_CATGY_KEY = MC.MDSE_CATGY_KEY
    join WH_OWNER.DC_ITEM I on I.MDSE_CLASS_KEY = MCL.MDSE_CLASS_KEY
Where I.PURCH_STATUS_CD <> 'Z' and I.BILLING_STATUS_CD <>'Z' 
and i.facility_id = 66
;



/*      Location - Facility     (Not from NETEZZA anymore, from CRM now                                         */

Select LPAD(FACILITY_ID,3,0) FACILITY, FACILITY_NAME, UPSTREAM_DC_CD, BILLING_SYSTEM_CD
 from WH_OWNER.DC_FACILITY
;


/*      Location - Vendor                                                    */

Select lpad(VENDOR_NBR,6,0) VENDOR_NBR , VENDOR_NAME , LPAD(FACILITY_ID,3,0) FACILITY , STREET_1_ADDR , STREET_2_ADDR , CITY_NAME , STATE_CD , ZIP_CD , VENDOR_STATUS_CD 
from WH_OWNER.DC_VENDOR
--where VENDOR_STATUS_CD <> 'D' 

;
/*      Location - Customer                                                  */
select LPAD(FACILITY_ID,3,0) FACILITY , LPAD(CUSTOMER_NBR,6,0) CUSTOMER_NBR , CUSTOMER_NAME , CUST_ST1_ADDR , CUST_ST2_ADDR , CUST_STATE_CD , CUST_ZIP_CD , CUST_STATUS_CD 
from WH_OWNER.DC_CUSTOMER
where CUST_STATUS_CD <> 'Z'

;



/*      Location - Demand History                    (check if we need to multiply the qty by pack)                        */
Select LPAD(FACILITY_ID,3,0) FACILITY, LPAD(NVL(SHIP_FACILITY_ID,0),3,0) SHIP_FACILITY, LPAD(ITEM_NBR,7,0) as SKU, LPAD(CUSTOMER_NBR,6,0) CUSTOMER_NBR, TRANSACTION_DATE, D.FISCAL_WEEK_ID,
sum(SHIPPED_QTY) as UNITS_SOLD, sum(EXT_NET_PRICE_AMT) SALES_AMT, sum(S.EXT_LOST_SALES_AMT) LOST_SALES
from WH_OWNER.DC_SALES_HST S join WH_OWNER.FISCAL_DAY D on D.SALES_DT = S.TRANSACTION_DATE 
where TRANSACTION_DATE > '2018-12-29'
group by LPAD(FACILITY_ID,3,0) , LPAD(NVL(SHIP_FACILITY_ID,0),3,0), LPAD(ITEM_NBR,7,0) , LPAD(CUSTOMER_NBR,6,0) , TRANSACTION_DATE, D.FISCAL_WEEK_ID
having UNITS_SOLD > 0

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
         inner join whmgr.mdv_dept d on i.DEPT_CD = d.dept_cd
;



select   
     --a11.BILLING_DATE  SALES_DT,
     a13.FISCAL_WEEK_NBR FISCAL_WEEK_NBR,
     a11.FACILITY_ID  FACILITY_ID,
    --a11.SEL_LOC_ID  SEL_LOC_ID,
    --a11.LOC_ID  LOC_ID,
    --a11.LIC_PLT_ID  LIC_PLT_ID,
    a11.INVTRY_ADJUST_CD  INVTRY_ADJUST_CD,
    --a11.INVTRY_ADJ_DATE  BILLING_DATE,
    --a11.FACILITY_ID  FACILITY_ID0,
    --a11.ERFB_FLG  ERFB_FLG,
    --a11.CREATE_USER_ID  CREATE_USER_ID,
    --a11.CREATE_TMSP  CREATE_TMSP,
    sum(a11.LAYER_COST_AMT)  LAYER_COST,
    sum(a11.EXT_LAYER_COST_AMT)  EXT_LAYER_COST,
    sum(a11.INV_ADJ_CASE_QTY)  FD_INV_ADJ_CASE_QTY,
    sum(a11.INVTRY_ADJ_QTY)  FD_INV_ADJ_RETAIL_QTY
from    MDV_D_FAC_INVCTRL_ADJ    a11
    join    FISCAL_DAY    a12
      on     (a11.BILLING_DATE = a12.SALES_DT)
    join    fiscal_week    a13
      on     (a12.FISCAL_WEEK_ID = a13.FISCAL_WEEK_ID)
    join    fiscal_quarter    a14
      on     (a12.FISCAL_QUARTER_ID = a14.FISCAL_QUARTER_ID)
where    (a11.FACILITY_ID in (27, 29, 33, 38, 39, 69, 70)
 and a14.FISCAL_YEAR_ID in (2020))
group BY
    a13.FISCAL_WEEK_NBR,
    --a11.BILLING_DATE,
    a11.INVTRY_ADJUST_CD,
    a11.FACILITY_ID,
    a11.BILLING_DATE
ORDER BY a11.BILLING_DATE,a11.facility_id, a11.INVTRY_ADJUST_CD
;



select
    a11.BILLING_DATE  SALES_DT,
    a11.FACILITY_ID  FACILITY_ID,
    a11.DEPT_CD DEPARTMENT,
    a11.CASE_UPC_CD CASE_UPC,
    mi.ITEM_DESC,
       a11.INVTRY_ADJUST_CD  INVTRY_ADJUST_CD,
       sum(a11.LAYER_COST_AMT)  LAYER_COST,
       sum(a11.EXT_LAYER_COST_AMT)  EXT_LAYER_COST,
       sum(a11.INV_ADJ_CASE_QTY)  INV_ADJ_CASE_QTY,
       sum(a11.INVTRY_ADJ_QTY)  INV_ADJ_RETAIL_QTY
from   MDV_D_FAC_INVCTRL_ADJ     a11
       join   FISCAL_DAY   a12
         on   (a11.BILLING_DATE = a12.SALES_DT)
       join   fiscal_quarter      a14
         on   (a12.FISCAL_QUARTER_ID = a14.FISCAL_QUARTER_ID)
       JOIN  MDV_ITEM mi
         ON    (mi.CASE_UPC_CD = a11.CASE_UPC_CD AND mi.DEPT_CD = a11.DEPT_CD)
where  (a11.FACILITY_ID in (27, 29, 33, 38, 39, 69, 70, 80, 90)
and a14.FISCAL_YEAR_ID in (2020))
group BY
    a11.BILLING_DATE,
    a11.FACILITY_ID,
    a11.DEPT_CD,
    a11.CASE_UPC_CD,
    mi.ITEM_DESC,
       a11.INVTRY_ADJUST_CD
ORDER BY
       a11.BILLING_DATE,
       a11.facility_id,
       a11.DEPT_CD,
       a11.CASE_UPC_CD,
       a11.INVTRY_ADJUST_CD
;



SELECT   pod.PO_NBR,
         pod.DATE_ORDERED,
         pod.FACILITYID,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP, poh.VENDOR_NBR PO_VENDOR_NBR, poh.VENDOR_NAME PO_VENDOR_NAME,
         i.VENDOR_NBR,
         v.VENDOR_NAME,
         v.MASTER_VENDOR,
         v.MASTER_VENDOR_DESC,
         v.VENDOR_TYPE
FROM     CRMADMIN.T_WHSE_PO_DTL pod 
         inner join CRMADMIN.T_WHSE_ITEM i on pod.FACILITYID = i.FACILITYID and pod.ITEM_NBR = i.ITEM_NBR 
         inner join CRMADMIN.T_WHSE_PO_HDR poh on pod.FACILITYID = poh.FACILITYID and pod.PO_NBR = poh.PO_NBR and pod.DATE_ORDERED = poh.DATE_ORDERED
         inner join CRMADMIN.T_WHSE_VENDOR v on i.FACILITYID = v.FACILITYID and i.VENDOR_NBR = v.VENDOR_NBR
WHERE    pod.PO_NBR = 787572
;



SELECT   --L.ITEM_NBR_HS, L.UPC_CASE, L.UPC_UNIT, 
        dx.ENTERPRISE_KEY, L.FACILITYID, L.ITEM_DEPT, '' dept_lookup, '' dept_description, --L.PO_NBR, 
         --LPAD(STOCK_FAC,3,0) STOCK_FAC, remove because it is supposed to be the same as Facility
         SUM(( INVENTORY_TURN + INVENTORY_PROMOTION + INVENTORY_FWD_BUY)*
          (CASE WHEN L.RAND_WGT_CD = 'R' 
                THEN L.SHIPPING_CASE_WEIGHT
                ELSE COALESCE(L.STORE_PACK,0)
            END)
         ) QTY_UNIT,
         SUM( L.INVENTORY_TURN + L.INVENTORY_PROMOTION + L.INVENTORY_FWD_BUY) QTY_CASE, 
         SUM((L.INVENTORY_TURN + L.INVENTORY_PROMOTION + L.INVENTORY_FWD_BUY) * 
             ((case when L.CORRECT_NET_COST <> 0 
                     then L.CORRECT_NET_COST 
                     else L.NET_COST_PER_CASE 
                end) * 
              case when dx.ENTERPRISE_KEY = 1 
                   then (case when L.RAND_WGT_CD = 'R' 
                              then L.SHIPPING_CASE_WEIGHT
                              else 1 
                         end) 
                   else 1 
              end)) EXT_CASE_COST,
         sum(L.INVENTORY_TURN)  as INVENTORY_TURN, sum(L.INVENTORY_PROMOTION) as INVENTORY_PROMOTION , SUM(L.INVENTORY_FWD_BUY) as INVENTORY_FWD_BUY,
         L.LAYER_FILE_DTE --,
--         L.RAND_WGT_CD,
--         L.SHIPPING_CASE_WEIGHT,
--         L.STORE_PACK,
--         L.SHIPPING_CASE_WEIGHT
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY L 
         join CRMADMIN.T_DATE D on D.DATE_KEY = l.LAYER_FILE_DTE and d.DAY_OF_WEEK_ID = 7
         join CRMADMIN.T_WHSE_DIV_XREF dx on L.FACILITYID = dx.SWAT_ID
WHERE     L.LAYER_FILE_DTE between '2018-12-30' and '2021-04-12'   
       -- and  L.FACILITYID in ('080', '090') and L.UPC_CASE <> L.UPC_UNIT
group by --L.ITEM_NBR_HS, L.UPC_CASE, L.UPC_UNIT, 
        dx.ENTERPRISE_KEY, L.FACILITYID, L.ITEM_DEPT, --L.PO_NBR, 
--         LPAD(STOCK_FAC,3,0) , 
         L.LAYER_FILE_DTE --,
--         L.RAND_WGT_CD,
--         L.SHIPPING_CASE_WEIGHT,
--         L.STORE_PACK,
--         ( INVENTORY_TURN + INVENTORY_PROMOTION + INVENTORY_FWD_BUY), L.SHIPPING_CASE_WEIGHT

 

HAVING   SUM( INVENTORY_TURN + INVENTORY_PROMOTION + INVENTORY_FWD_BUY) >0; 

SELECT   '1' || DEPT_CODE,
         DEPT_DESCRIPTION
FROM     CRMADMIN.T_WHSE_DEPT
;

SELECT   '20' ||  wc.WAREHOUSE_CODE , wc.WAREHOUSE_CODE_DESC_FAC 
FROM     CRMADMIN.T_WHSE_WAREHOUSE_CODE wc 
         inner join CRMADMIN.T_WHSE_DIV_XREF dx on dx.SWAT_ID = wc.FACILITYID
WHERE    dx.ENTERPRISE_KEY = 2
;

SELECT   dsh.FACILITY_ID,
         fd.FISCAL_PERIOD_ID,
         sum(dsh.ORDERED_QTY) ord,
         sum(dsh.ADJUSTED_QTY) adj,
         sum(dsh.SHIPPED_QTY) ship,
         sum(dsh.EXT_LOST_SALES_AMT)
FROM     WH_OWNER.DC_SALES_HST dsh 
         inner join WH_OWNER.FISCAL_DAY fd on dsh.TRANSACTION_DATE = fd.SALES_DT
WHERE    dsh.FACILITY_ID = 1
AND      dsh.TRANSACTION_DATE between '12-29-2019' and '01-02-2021'
GROUP BY dsh.FACILITY_ID, fd.FISCAL_PERIOD_ID
;