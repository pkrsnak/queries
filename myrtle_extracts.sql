-- file export path
-- \\spfile01\itworkgroup\Data Management\Temp\myrtle\



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
WHERE    pod.DATE_ORDERED between '2021-08-15' and '2021-09-11'  --'08-15-2021' and '09-11-2021'
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
WHERE    TRANSACTION_DATE between '2021-07-18' and '2021-08-14'
--WHERE    TRANSACTION_DATE between '2021-04-14' and '2021-04-14'
--AND      s.FACILITY_ID in (80, 90)
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
WHERE    (shd.ship_date between '08-15-2021' and '09-11-2021')
--WHERE    (shd.ship_date between '12-29-2018' and '12-28-2019')
--WHERE    (shd.ship_date between '12-29-2019' and '01-02-2021')
and      d.division_cd in ('NOR', 'BAL', 'PNS', 'SAT', 'CSG', 'BLM', 'OKA')
;

-- Sam
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
WHERE    (poh.receive_date between '08-15-2021' and '09-11-2021')  --'08-15-2021' and '09-11-2021'
AND      d.division_cd in ('NOR', 'BAL', 'PNS', 'SAT', 'CSG', 'BLM', 'OKA', 'CSZ', 'SAZ')
--)
;



MDV_00000000023577330
MDV_00000004200087346
MDV_00000007562072715

;

/*      Location - Facility     (Not from NETEZZA anymore, from CRM now                                         */

Select LPAD(FACILITY_ID,3,0) FACILITY, FACILITY_NAME, UPSTREAM_DC_CD, BILLING_SYSTEM_CD
 from WH_OWNER.DC_FACILITY
;


/*      Location - Demand History                    (check if we need to multiply the qty by pack)                        */
Select LPAD(FACILITY_ID,3,0) FACILITY, LPAD(NVL(SHIP_FACILITY_ID,0),3,0) SHIP_FACILITY, LPAD(ITEM_NBR,7,0) as SKU, LPAD(CUSTOMER_NBR,6,0) CUSTOMER_NBR, TRANSACTION_DATE, D.FISCAL_WEEK_ID,
sum(SHIPPED_QTY) as UNITS_SOLD, sum(EXT_NET_PRICE_AMT) SALES_AMT, sum(S.EXT_LOST_SALES_AMT) LOST_SALES
from WH_OWNER.DC_SALES_HST S join WH_OWNER.FISCAL_DAY D on D.SALES_DT = S.TRANSACTION_DATE 
where TRANSACTION_DATE > '2018-12-29'
group by LPAD(FACILITY_ID,3,0) , LPAD(NVL(SHIP_FACILITY_ID,0),3,0), LPAD(ITEM_NBR,7,0) , LPAD(CUSTOMER_NBR,6,0) , TRANSACTION_DATE, D.FISCAL_WEEK_ID
having UNITS_SOLD > 0
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


--CRM
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
WHERE     L.LAYER_FILE_DTE between '2021-06-16' and '2021-07-17'   
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
WHERE    L.LAYER_FILE_DTE between '2021-08-15' and '2021-09-11'
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




 


-- Minimum Order Quantity needs to be combined with results from query above(Product Master)
Select (FACILITYID|| ITEM_NBR_HS) KEY, FACILITYID, ITEM_NBR_HS, MFG_MIN_ORDER_QTY, LIST_COST
from KPIADMIN.V_KPI_ITEM_FACTORS 
order by FACILITYID, ITEM_NBR_HS
;

 
;
--==================================================================================================================================================================================================
--==================================================================================================================================================================================================

 
/*      Location - Vendor FD                                                 */

SELECT   lpad(VENDOR_NBR,6,0) VENDOR_NBR,
         VENDOR_NAME,
         LPAD(FACILITY_ID,3,0) FACILITY_ID,
         STREET_1_ADDR,
         STREET_2_ADDR,
         CITY_NAME,
         STATE_CD,
         ZIP_CD,
         VENDOR_STATUS_CD
FROM     WH_OWNER.DC_VENDOR
--where VENDOR_STATUS_CD <> 'D' 
;

--new  Location - Vendor FD 20210715
Select VENDOR_NBR, VENDOR_NAME, FACILITYID, ADDRESS_1, ADDRESS_2, CITY, STATE, ZIP, STATUS VENDOR_STATUS_CD, LEAD_TIME_STATED_WEEKS
from CRMADMIN.T_WHSE_VENDOR
;

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
    i.ITEM_RES33, i.SAFETY_STOCK, i.CYCLE_STOCK
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
    i.ITEM_RES33, i.SAFETY_STOCK, i.CYCLE_STOCK
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
    i.ITEM_RES33, i.SAFETY_STOCK, i.CYCLE_STOCK
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


--CRM
/*      Location - Customer                                                  */
SELECT   cust.FACILITYID,
         LPAD(cust.CUSTOMER_NBR_STND, 6, 0) CUSTOMER_NBR,
         cust.NAME CUSTOMER_NAME,
         cust.ADDRESS1 CUST_ST1_ADDR,
         cust.ADDRES2 CUST_ST2_ADDR,
         cust.STATE_CD CUST_STATE_CD,
         cust.ZIP_CD CUST_ZIP_CD,
         cust.ADDRESS3 CITY,
         cust.STATUS_CD CUST_STATUS_CD,
         cust.HOME_BRANCH FACILITYID_PRIMARY,
         corp.CORP_CODE,
         corp.CORP_NAME,
         cust.MEMBERSHIP_KEY,
         cust.MEMBERSHIP_DESC,
         cust.CUST_CLASS_KEY,
         cust.CUST_CLASS_DESC
FROM     CRMADMIN.T_WHSE_CUST cust 
         inner join CRMADMIN.T_WHSE_CORPORATION_MDM corp on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND AND corp.ACTIVE = 'Y'
         inner join CRMADMIN.V_WEB_FACILITY dx on cust.FACILITYID = dx.FACILITYID

union all

SELECT   '080' FACILITYID,
         LPAD(cust.CUSTOMER_NBR_STND, 6, 0) CUSTOMER_NBR,
         cust.NAME CUSTOMER_NAME,
         cust.ADDRESS1 CUST_ST1_ADDR,
         cust.ADDRES2 CUST_ST2_ADDR,
         cust.STATE_CD CUST_STATE_CD,
         cust.ZIP_CD CUST_ZIP_CD,
         cust.ADDRESS3 CITY,
         cust.STATUS_CD CUST_STATUS_CD,
         '080' FACILITYID_PRIMARY,
         corp.CORP_CODE,
         corp.CORP_NAME,
         cust.MEMBERSHIP_KEY,
         cust.MEMBERSHIP_DESC,
         cust.CUST_CLASS_KEY,
         cust.CUST_CLASS_DESC
FROM     CRMADMIN.T_WHSE_CUST cust 
         inner join CRMADMIN.T_WHSE_CORPORATION_MDM corp on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND AND corp.ACTIVE = 'Y'
WHERE    cust.FACILITYID = '061'

union all

SELECT   '090' FACILITYID,
         LPAD(cust.CUSTOMER_NBR_STND, 6, 0) CUSTOMER_NBR,
         cust.NAME CUSTOMER_NAME,
         cust.ADDRESS1 CUST_ST1_ADDR,
         cust.ADDRES2 CUST_ST2_ADDR,
         cust.STATE_CD CUST_STATE_CD,
         cust.ZIP_CD CUST_ZIP_CD,
         cust.ADDRESS3 CITY,
         cust.STATUS_CD CUST_STATUS_CD,
         '090' FACILITYID_PRIMARY,
         corp.CORP_CODE,
         corp.CORP_NAME,
         cust.MEMBERSHIP_KEY,
         cust.MEMBERSHIP_DESC,
         cust.CUST_CLASS_KEY,
         cust.CUST_CLASS_DESC
FROM     CRMADMIN.T_WHSE_CUST cust 
         inner join CRMADMIN.T_WHSE_CORPORATION_MDM corp on corp.CUSTOMER_NBR_STND = cust.CUSTOMER_NBR_STND AND corp.ACTIVE = 'Y'
WHERE    cust.FACILITYID = '061'
;

/*      Location - Customer MDV                                              */
SELECT   ship_to_id,
         ship_to_name,
         street_1_addr,
         street_2_addr,
         city_name,
         state_cd,
         zip_cd,
         export_flg,
         base_type_cd
FROM     whmgr.mdv_ship_to;

--==================================================================================================================================================================================================
--CAITO
--==================================================================================================================================================================================================
--Netezza
--Caito sales 
SELECT   s.DOCUMENT_NBR,
         LPAD(s.FACILITY_ID,3,0) Facility,
         s.ITEM_2_NBR as SKU_UNQ,
         s.CUSTOMER_NBR,
         s.INVOICE_DT,
         s.ACTUAL_SHIP_DT,
         D.FISCAL_WEEK_ID,
         s.REASON_CD,
         s.UNIT_COST_AMT,
         sum(s.ORDER_UNIT_QTY) as ORIG_ORD_QTY,
         sum(s.SHIP_UNIT_QTY) as UNITS_SOLD,
         sum(s.EXT_PRICE_AMT) SALES_AMT,
         0 as ORIG_LOST_SALES_QTY,
         0 as ORIG_LOST_SALES_CALC_AMT,
         0 LOST_SALES
FROM     WH_OWNER.CAITO_SALES_HST s 
         inner join WH_OWNER.FISCAL_DAY D on D.SALES_DT = s.INVOICE_DT
where s.INVOICE_DT between '01-01-2020' and '06-12-2021'
GROUP BY s.DOCUMENT_NBR, s.FACILITY_ID, s.ITEM_2_NBR, s.CUSTOMER_NBR, 
         s.INVOICE_DT, s.ACTUAL_SHIP_DT, D.FISCAL_WEEK_ID, s.REASON_CD, 
         s.UNIT_COST_AMT
;
--cafods
--Caito product
SELECT   item_2_nbr,
         item_3_nbr,
         item_desc,
         item_line_desc,
         search_txt,
         cmprss_search_txt,
         sls_family_cd,
         sls_section_cd,
         sls_catgy_3_cd,
         sls_catgy_4_cd,
         cmdty_class_cd,
         cmdty_subclass_cd,
         mstr_plan_fam_cd,
         whse_prcs_grp_2_cd,
         whse_prcs_grp_3_cd,
         item_pool_cd,
         buyer_nbr,
         primary_uom_cd,
         secondary_uom_cd,
         purch_uom_cd,
         pricing_uom_cd,
         ship_uom_cd,
         production_uom_cd,
         compnt_uom_cd,
         weight_uom_cd,
         volumne_uom_cd,
         vol_or_wght_uom_cd,
         cycle_cnt_catgy_cd,
         gl_catgy_cd
FROM     whmgr.caito_item
;

--cafods
--Caito customer
SELECT   customer_nbr,
         customer_desc,
         customer_nm,
         comprssd_cust_nm,
         search_type_cd,
         empl_type_cd,
         mstr_customer_nbr,
         payer_nbr,
         account_mgr_nbr
FROM     whmgr.caito_customer
;

--cafods
--Caito vendor
SELECT   vendor_nbr,
         vendor_desc,
         vendor_name,
         comprssd_vndr_nm,
         search_type_cd,
         empl_type_cd
FROM     whmgr.caito_vendor
;

---------------------- 2021-08-19 Alicia Additions -------------------------

Also, below are the SQL statements that were used to send the files they requested:
----FD items with first 3 levels of hierarchy
Select FACILITYID , ITEM_NBR_HS , ITEM_DESCRIP , PACK_CASE , PURCH_STATUS, BILLING_STATUS, MERCH_DEPT_GRP, MERCH_DEPT_GRP_DESC, MERCH_DEPT, MERCH_DEPT_DESC, MERCH_GRP, MERCH_GRP_DESC
from CRMADMIN.T_WHSE_ITEM
where BILLING_STATUS <> 'D'
;
 
------
-- connect to GOLD CLOUD PRD
--mdv items with first 3 levels of hierarchy
Select ISI_DC_CODE, ISI_ITEM_CODE, ISI_ITEM_DESC, ISI_MASTER_PACK, ISI_PURCHASING_STATUS, ISI_GPC_DEPT_GRP_CODE, ISI_GPC_DEPT_GRP_DESC, ISI_GPC_DEPT_CODE, ISI_GPC_DEPT_DESC, ISI_GPC_MDSE_GRP_CODE, ISI_GPC_MDSE_GRP_DESC
from ADG.NF_ITEM
where ISI_DSS_EXISTS = 1
;
