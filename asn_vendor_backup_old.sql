
--create table TSSECJ7WCOT000 as
SELECT   Distinct a11.SCH_RECEIVED_DATE SALES_DT,
         a11.PO_NBR PO_NBR,
         a11.ORDERED_DATE ORDERED_DATE,
         a11.PO_TYPE_CD PO_TYPE_CD,
         a12.ITEM_NBR ITEM_ID,
         a12.FACILITY_ID FACILITY_ID,
         a11.PO_NBR WJXBFS1,
         a11.ORDERED_DATE WJXBFS2
FROM     PO_HDR a11 
         join PO_DTL a12 on (a11.ORDERED_DATE = a12.ORDERED_DATE and a11.PO_NBR = a12.PO_NBR) 
         join fiscal_day a13 on (a11.SCH_RECEIVED_DATE = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    (a14.end_dt = To_Date('06/08/2019', 'mm/dd/yyyy')
     AND a11.SCH_RECEIVED_DATE < To_Date('06/04/2019', 'mm/dd/yyyy'))
;



SELECT   pa11.PO_NBR PO_NBR,
         pa11.ORDERED_DATE ORDERED_DATE,
         max(a12.RECEIVED_DATE) RECEIVED_DATE,
         a12.STATUS_CD STATUS_CD,
         max(a110.STATUS_DESC) STATUS_DESC,
         a12.VENDOR_NBR VENDOR_NBR,
         a12.FACILITY_ID FACILITY_ID,
         max(a13.VENDOR_NAME) VENDOR_NAME,
         a12.ASN_FLG ASN_FLG,
         a13.BUYER_ID BUYER_ID,
         max(a114.BUYER_NAME) BUYER_NAME,
         pa11.PO_TYPE_CD PO_TYPE_CD,
         max(a19.PO_TYPE_DESC) PO_TYPE_DESC,
         a12.SHIP_TO_FAC_ID FACILITY_ID0,
         max(a112.FACILITY_NAME) FACILITY_NAME,
         a18.FISCAL_WEEK_ID FISCAL_WEEK_ID,
         max('Week Ending ' || to_char(a113.end_dt, 'mm/dd/yyyy')) WeekEnding,
         a13.MSTR_VENDOR_NBR VENDOR_NBR0,
         max(a13.MSTR_VENDOR_NAME) VENDOR_NAME0,
         a17.DEPT_KEY DEPT_KEY,
         max(a111.dept_name) dept_name,
         pa11.ITEM_ID ITEM_ID,
         pa11.FACILITY_ID FACILITY_ID1,
         max(a14.ORDERABLE_ITEM_DSC) item_description,
         pa11.SALES_DT SALES_DT,
         count(*) WJXBFS1
FROM     (SELECT   Distinct a11.SCH_RECEIVED_DATE SALES_DT,
         a11.PO_NBR PO_NBR,
         a11.ORDERED_DATE ORDERED_DATE,
         a11.PO_TYPE_CD PO_TYPE_CD,
         a12.ITEM_NBR ITEM_ID,
         a12.FACILITY_ID FACILITY_ID,
         a11.PO_NBR WJXBFS1,
         a11.ORDERED_DATE WJXBFS2
FROM     PO_HDR a11 
         join PO_DTL a12 on (a11.ORDERED_DATE = a12.ORDERED_DATE and a11.PO_NBR = a12.PO_NBR) 
         join fiscal_day a13 on (a11.SCH_RECEIVED_DATE = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    (a14.end_dt = To_Date('06/08/2019', 'mm/dd/yyyy')
     AND a11.SCH_RECEIVED_DATE < To_Date('06/04/2019', 'mm/dd/yyyy'))
) pa11 
         join PO_HDR a12 on (pa11.ORDERED_DATE = a12.ORDERED_DATE and pa11.PO_NBR = a12.PO_NBR and pa11.PO_TYPE_CD = a12.PO_TYPE_CD and pa11.SALES_DT = a12.SCH_RECEIVED_DATE) 
         join DC_VENDOR a13 on (a12.FACILITY_ID = a13.FACILITY_ID and a12.VENDOR_NBR = a13.VENDOR_NBR) 
         join DC_ITEM a14 on (pa11.FACILITY_ID = a14.FACILITY_ID and pa11.ITEM_ID = a14.ITEM_NBR) 
         join MDSE_CLASS a15 on (a14.MDSE_CLASS_KEY = a15.MDSE_CLASS_KEY) 
         join mdse_category a16 on (a15.mdse_catgy_key = a16.mdse_catgy_key) 
         join mdse_group a17 on (a16.mdse_grp_key = a17.mdse_grp_key) 
         join fiscal_day a18 on (pa11.SALES_DT = a18.SALES_DT) 
         join PO_TYPE a19 on (pa11.PO_TYPE_CD = a19.PO_TYPE_CD) 
         join PO_STATUS a110 on (a12.STATUS_CD = a110.STATUS_CD) 
         join department a111 on (a17.DEPT_KEY = a111.DEPT_KEY) 
         join DC_FACILITY a112 on (a12.SHIP_TO_FAC_ID = a112.FACILITY_ID) 
         join fiscal_week a113 on (a18.FISCAL_WEEK_ID = a113.FISCAL_WEEK_ID) 
         join DC_BUYER a114 on (a13.BUYER_ID = a114.BUYER_ID and a14.BUYER_ID = a114.BUYER_ID)
GROUP BY pa11.PO_NBR, pa11.ORDERED_DATE, a12.STATUS_CD, a12.VENDOR_NBR, 
         a12.FACILITY_ID, a12.ASN_FLG, a13.BUYER_ID, pa11.PO_TYPE_CD, 
         a12.SHIP_TO_FAC_ID, a18.FISCAL_WEEK_ID, a13.MSTR_VENDOR_NBR, 
         a17.DEPT_KEY, pa11.ITEM_ID, pa11.FACILITY_ID, pa11.SALES_DT
;


--For ASN Compliance Report w/ Issue Counts:-----------------------------------------------------------------------------------------------------------

--create table ZZOT00 as
SELECT   Distinct DATE(a11.LOAD_TMSP) SALES_DT,
         a11.PO_NBR PO_NBR,
         a11.LOAD_TMSP LOAD_TMSP,
         a11.SENDER_ID SENDER_ID,
         a11.SHIPMENT_ID SHIPMENT_ID,
         a12.REASON_CD REASON_CD,
         a11.PO_NBR WJXBFS1,
         a11.LOAD_TMSP WJXBFS2,
         a11.SENDER_ID WJXBFS3,
         a11.SHIPMENT_ID WJXBFS4
FROM     ASN_PURCHASE_ORDER a11 
         join ASN_PO_COMPLIANCE a12 on (a11.LOAD_TMSP = a12.LOAD_TMSP and a11.PO_NBR = a12.PO_NBR and a11.SENDER_ID = a12.SENDER_ID and a11.SHIPMENT_ID = a12.SHIPMENT_ID) 
         join fiscal_day a13 on (DATE(a11.LOAD_TMSP) = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    a14.end_dt = To_Date('06/08/2019', 'mm/dd/yyyy')
;


SELECT   a12.VENDOR_NBR VENDOR_NBR,
         a12.FACILITY_ID FACILITY_ID,
         max(a13.VENDOR_NAME) VENDOR_NAME,
         a12.SHIP_TO_FAC_ID FACILITY_ID0,
         max(a16.FACILITY_NAME) FACILITY_NAME,
         a13.BUYER_ID BUYER_ID,
         max(a18.BUYER_NAME) BUYER_NAME,
         a14.FISCAL_WEEK_ID FISCAL_WEEK_ID,
         max('Week Ending ' || to_char(a17.end_dt, 'mm/dd/yyyy')) WeekEnding,
         a12.COMPLIANCE_FLG COMPLIANCE_FLG,
         pa11.PO_NBR PO_NBR,
         pa11.LOAD_TMSP LOAD_TMSP,
         pa11.SENDER_ID SENDER_ID,
         pa11.SHIPMENT_ID SHIPMENT_ID,
         pa11.REASON_CD REASON_CD,
         max(a15.REASON_DESC) REASON_DESC,
         a13.MSTR_VENDOR_NBR VENDOR_NBR0,
         max(a13.MSTR_VENDOR_NAME) VENDOR_NAME0,
         pa11.SALES_DT SALES_DT,
         count(*) WJXBFS1
FROM     (SELECT   Distinct DATE(a11.LOAD_TMSP) SALES_DT,
         a11.PO_NBR PO_NBR,
         a11.LOAD_TMSP LOAD_TMSP,
         a11.SENDER_ID SENDER_ID,
         a11.SHIPMENT_ID SHIPMENT_ID,
         a12.REASON_CD REASON_CD,
         a11.PO_NBR WJXBFS1,
         a11.LOAD_TMSP WJXBFS2,
         a11.SENDER_ID WJXBFS3,
         a11.SHIPMENT_ID WJXBFS4
FROM     ASN_PURCHASE_ORDER a11 
         join ASN_PO_COMPLIANCE a12 on (a11.LOAD_TMSP = a12.LOAD_TMSP and a11.PO_NBR = a12.PO_NBR and a11.SENDER_ID = a12.SENDER_ID and a11.SHIPMENT_ID = a12.SHIPMENT_ID) 
         join fiscal_day a13 on (DATE(a11.LOAD_TMSP) = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    a14.end_dt = To_Date('06/08/2019', 'mm/dd/yyyy')) pa11 
         join ASN_PURCHASE_ORDER a12 on (pa11.LOAD_TMSP = a12.LOAD_TMSP and pa11.PO_NBR = a12.PO_NBR and pa11.SALES_DT = DATE(a12.LOAD_TMSP) and pa11.SENDER_ID = a12.SENDER_ID and pa11.SHIPMENT_ID = a12.SHIPMENT_ID) 
         join DC_VENDOR a13 on (a12.FACILITY_ID = a13.FACILITY_ID and a12.VENDOR_NBR = a13.VENDOR_NBR) 
         join fiscal_day a14 on (pa11.SALES_DT = a14.SALES_DT) 
         join ASN_COMPLNC_REASON a15 on (pa11.REASON_CD = a15.REASON_CD) 
         join DC_FACILITY a16 on (a12.SHIP_TO_FAC_ID = a16.FACILITY_ID) 
         join fiscal_week a17 on (a14.FISCAL_WEEK_ID = a17.FISCAL_WEEK_ID) 
         join DC_BUYER a18 on (a13.BUYER_ID = a18.BUYER_ID)
GROUP BY a12.VENDOR_NBR, a12.FACILITY_ID, a12.SHIP_TO_FAC_ID, a13.BUYER_ID, 
         a14.FISCAL_WEEK_ID, a12.COMPLIANCE_FLG, pa11.PO_NBR, pa11.LOAD_TMSP, 
         pa11.SENDER_ID, pa11.SHIPMENT_ID, pa11.REASON_CD, a13.MSTR_VENDOR_NBR, 
         pa11.SALES_DT
;


---------------------------------------------------------------------------------------------------------------------------
select      distinct DATE(a11.LOAD_TMSP)  SALES_DT,
               a11.PO_NBR  PO_NBR,
               a11.LOAD_TMSP  LOAD_TMSP,
               a11.SENDER_ID  SENDER_ID,
               a11.SHIPMENT_ID  SHIPMENT_ID,
               a12.REASON_CD  REASON_CD,
               a11.PO_NBR  WJXBFS1,
               a11.LOAD_TMSP  WJXBFS2,
               a11.SENDER_ID  WJXBFS3,
               a11.SHIPMENT_ID  WJXBFS4
from        ASN_PURCHASE_ORDER   a11
               join          ASN_PO_COMPLIANCE      a12
                 on         (a11.LOAD_TMSP = a12.LOAD_TMSP and 
               a11.PO_NBR = a12.PO_NBR and 
               a11.SENDER_ID = a12.SENDER_ID and 
               a11.SHIPMENT_ID = a12.SHIPMENT_ID)
               join          fiscal_day              a13
                 on         (DATE(a11.LOAD_TMSP) = a13.SALES_DT)
               join          fiscal_week            a14
                on         (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
where     a14.end_dt = To_Date('06/01/2019', 'mm/dd/yyyy')
;

--create table ZZMD01 as
select      pa11.SALES_DT  SALES_DT,
               pa11.PO_NBR  PO_NBR,
               pa11.LOAD_TMSP  LOAD_TMSP,
               pa11.SENDER_ID  SENDER_ID,
               pa11.SHIPMENT_ID  SHIPMENT_ID,
               pa11.REASON_CD  REASON_CD,
               count(*)  WJXBFS1
from        (SELECT   Distinct DATE(a11.LOAD_TMSP) SALES_DT,
         a11.PO_NBR PO_NBR,
         a11.LOAD_TMSP LOAD_TMSP,
         a11.SENDER_ID SENDER_ID,
         a11.SHIPMENT_ID SHIPMENT_ID,
         a12.REASON_CD REASON_CD,
         a11.PO_NBR WJXBFS1,
         a11.LOAD_TMSP WJXBFS2,
         a11.SENDER_ID WJXBFS3,
         a11.SHIPMENT_ID WJXBFS4
FROM     ASN_PURCHASE_ORDER a11 
         join ASN_PO_COMPLIANCE a12 on (a11.LOAD_TMSP = a12.LOAD_TMSP and a11.PO_NBR = a12.PO_NBR and a11.SENDER_ID = a12.SENDER_ID and a11.SHIPMENT_ID = a12.SHIPMENT_ID) 
         join fiscal_day a13 on (DATE(a11.LOAD_TMSP) = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    a14.end_dt = To_Date('06/08/2019', 'mm/dd/yyyy'))  pa11
group by pa11.SALES_DT,
               pa11.PO_NBR,
               pa11.LOAD_TMSP,
               pa11.SENDER_ID,
               pa11.SHIPMENT_ID,
               pa11.REASON_CD
;


select      a13.VENDOR_NBR  VENDOR_NBR,
               a13.FACILITY_ID  FACILITY_ID,
               max(a15.VENDOR_NAME)  VENDOR_NAME,
               a13.SHIP_TO_FAC_ID  FACILITY_ID0,
               max(a111.FACILITY_NAME)  FACILITY_NAME,
               a15.BUYER_ID  BUYER_ID,
               max(a112.BUYER_NAME)  BUYER_NAME,
               a16.FISCAL_WEEK_ID  FISCAL_WEEK_ID,
               max('Week Ending ' || to_char(a19.end_dt, 'mm/dd/yyyy'))  WeekEnding,
               a13.COMPLIANCE_FLG  COMPLIANCE_FLG,
               pa11.PO_NBR  PO_NBR,
               pa11.LOAD_TMSP  LOAD_TMSP,
               pa11.SENDER_ID  SENDER_ID,
               pa11.SHIPMENT_ID  SHIPMENT_ID,
               pa11.REASON_CD  REASON_CD,
               max(a17.REASON_DESC)  REASON_DESC,
               a12.SENDER_ID  SENDER_ID1,
               a12.LOAD_TMSP  LOAD_TMSP1,
               a12.SHIPMENT_ID  SHIPMENT_ID1,
               a12.HIER_LVL_CD  PARENT_HIER_LVL_CD,
               a14.HIER_LVL_CD  HIER_LVL_CD,
               max(a14.EXPIRATION_DATE)  EXPIRATION_DATE,
               a14.EXPIRATION_FLG  EXPIRATION_FLG,
               a14.CASE_UPC_NBR  CASE_UPC_NBR,
               a14.FACILITY_ID  FACILITY_ID1,
               max(a18.ORDERABLE_ITEM_DSC)  ROOT_ITEM_DESC,
               max(a18.SHELF_LIFE_QTY)  SHELF_LIFE_QTY,
               a13.SHIPMENT_ID  SHIPMENT_ID2,
               a13.SENDER_ID  SENDER_ID2,
               a13.LOAD_TMSP  LOAD_TMSP2,
               max(a110.SCHD_DELIVERY_DATE)  SCHD_DELIVERY_DATE,
               pa11.SALES_DT  SALES_DT,
               max(pa11.WJXBFS1)  WJXBFS1
from        (select      pa11.SALES_DT  SALES_DT,
               pa11.PO_NBR  PO_NBR,
               pa11.LOAD_TMSP  LOAD_TMSP,
               pa11.SENDER_ID  SENDER_ID,
               pa11.SHIPMENT_ID  SHIPMENT_ID,
               pa11.REASON_CD  REASON_CD,
               count(*)  WJXBFS1
from        (SELECT   Distinct DATE(a11.LOAD_TMSP) SALES_DT,
         a11.PO_NBR PO_NBR,
         a11.LOAD_TMSP LOAD_TMSP,
         a11.SENDER_ID SENDER_ID,
         a11.SHIPMENT_ID SHIPMENT_ID,
         a12.REASON_CD REASON_CD,
         a11.PO_NBR WJXBFS1,
         a11.LOAD_TMSP WJXBFS2,
         a11.SENDER_ID WJXBFS3,
         a11.SHIPMENT_ID WJXBFS4
FROM     ASN_PURCHASE_ORDER a11 
         join ASN_PO_COMPLIANCE a12 on (a11.LOAD_TMSP = a12.LOAD_TMSP and a11.PO_NBR = a12.PO_NBR and a11.SENDER_ID = a12.SENDER_ID and a11.SHIPMENT_ID = a12.SHIPMENT_ID) 
         join fiscal_day a13 on (DATE(a11.LOAD_TMSP) = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    a14.end_dt = To_Date('06/08/2019', 'mm/dd/yyyy'))  pa11
group by pa11.SALES_DT,
               pa11.PO_NBR,
               pa11.LOAD_TMSP,
               pa11.SENDER_ID,
               pa11.SHIPMENT_ID,
               pa11.REASON_CD) pa11
               join          ASN_PALLET        a12
                 on         (pa11.LOAD_TMSP = a12.LOAD_TMSP and 
               pa11.PO_NBR = a12.PO_NBR and 
               pa11.SENDER_ID = a12.SENDER_ID and 
               pa11.SHIPMENT_ID = a12.SHIPMENT_ID)
               join          ASN_PURCHASE_ORDER   a13
                 on         (pa11.LOAD_TMSP = a13.LOAD_TMSP and 
               pa11.PO_NBR = a13.PO_NBR and 
               pa11.SALES_DT = DATE(a13.LOAD_TMSP) and 
               pa11.SENDER_ID = a13.SENDER_ID and 
               pa11.SHIPMENT_ID = a13.SHIPMENT_ID)
               join          ASN_PACK            a14
                 on         (a12.HIER_LVL_CD = a14.PARENT_HIER_LVL_CD and 
               a12.LOAD_TMSP = a14.LOAD_TMSP and 
               a12.SENDER_ID = a14.SENDER_ID and 
               a12.SHIPMENT_ID = a14.SHIPMENT_ID)
               join          DC_VENDOR        a15
                 on         (a13.FACILITY_ID = a15.FACILITY_ID and 
               a13.VENDOR_NBR = a15.VENDOR_NBR)
               join          fiscal_day              a16
                 on         (pa11.SALES_DT = a16.SALES_DT)
               join          ASN_COMPLNC_REASON  a17
                 on         (pa11.REASON_CD = a17.REASON_CD)
               join          DC_ITEM               a18
                 on         (a14.CASE_UPC_NBR = a18.CASE_UPC_NBR and 
               a14.FACILITY_ID = a18.FACILITY_ID)
               join          fiscal_week            a19
                 on         (a16.FISCAL_WEEK_ID = a19.FISCAL_WEEK_ID)
               join          ASN_SHIPMENT   a110
                 on         (a13.LOAD_TMSP = a110.LOAD_TMSP and 
               a13.SENDER_ID = a110.SENDER_ID and 
               a13.SHIPMENT_ID = a110.SHIPMENT_ID)
               join          DC_FACILITY        a111
                 on         (a13.SHIP_TO_FAC_ID = a111.FACILITY_ID)
               join          DC_BUYER           a112
                 on         (a15.BUYER_ID = a112.BUYER_ID and 
               a18.BUYER_ID = a112.BUYER_ID)
group by a13.VENDOR_NBR,
               a13.FACILITY_ID,
               a13.SHIP_TO_FAC_ID,
               a15.BUYER_ID,
               a16.FISCAL_WEEK_ID,
               a13.COMPLIANCE_FLG,
               pa11.PO_NBR,
               pa11.LOAD_TMSP,
               pa11.SENDER_ID,
               pa11.SHIPMENT_ID,
               pa11.REASON_CD,
               a12.SENDER_ID,
               a12.LOAD_TMSP,
               a12.SHIPMENT_ID,
               a12.HIER_LVL_CD,
               a14.HIER_LVL_CD,
               a14.EXPIRATION_FLG,
               a14.CASE_UPC_NBR,
               a14.FACILITY_ID,
               a13.SHIPMENT_ID,
               a13.SENDER_ID,
               a13.LOAD_TMSP,
               pa11.SALES_DT
;

-------------------------------------------------------------------------------------------------------------------------------------------
select      distinct DATE(a11.LOAD_TMSP)  SALES_DT,
               a11.PO_NBR  PO_NBR,
               a11.LOAD_TMSP  LOAD_TMSP,
               a11.SENDER_ID  SENDER_ID,
               a11.SHIPMENT_ID  SHIPMENT_ID,
               a12.REASON_CD  REASON_CD,
               a11.PO_NBR  WJXBFS1,
               a11.LOAD_TMSP  WJXBFS2,
               a11.SENDER_ID  WJXBFS3,
               a11.SHIPMENT_ID  WJXBFS4
from        ASN_PURCHASE_ORDER   a11
               join          ASN_PO_COMPLIANCE      a12
                 on         (a11.LOAD_TMSP = a12.LOAD_TMSP and 
               a11.PO_NBR = a12.PO_NBR and 
               a11.SENDER_ID = a12.SENDER_ID and 
               a11.SHIPMENT_ID = a12.SHIPMENT_ID)
               join          fiscal_day              a13
                 on         (DATE(a11.LOAD_TMSP) = a13.SALES_DT)
               join          fiscal_week            a14
                on         (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
where     a14.end_dt = To_Date('06/01/2019', 'mm/dd/yyyy')
;

--create table ZZMD01 as
--select      pa11.SALES_DT  SALES_DT,
--               pa11.PO_NBR  PO_NBR,
--               pa11.LOAD_TMSP  LOAD_TMSP,
--               pa11.SENDER_ID  SENDER_ID,
--               pa11.SHIPMENT_ID  SHIPMENT_ID,
--               pa11.REASON_CD  REASON_CD,
--               count(*)  WJXBFS1
--from        ZZOT00  pa11
--group by pa11.SALES_DT,
--               pa11.PO_NBR,
--               pa11.LOAD_TMSP,
--               pa11.SENDER_ID,
--               pa11.SHIPMENT_ID,
--               pa11.REASON_CD
;
SELECT   pa11.SALES_DT SALES_DT,
         pa11.PO_NBR PO_NBR,
         pa11.LOAD_TMSP LOAD_TMSP,
         pa11.SENDER_ID SENDER_ID,
         pa11.SHIPMENT_ID SHIPMENT_ID,
         pa11.REASON_CD REASON_CD,
         count(*) WJXBFS1
FROM     (SELECT   Distinct DATE(a11.LOAD_TMSP) SALES_DT,
         a11.PO_NBR PO_NBR,
         a11.LOAD_TMSP LOAD_TMSP,
         a11.SENDER_ID SENDER_ID,
         a11.SHIPMENT_ID SHIPMENT_ID,
         a12.REASON_CD REASON_CD,
         a11.PO_NBR WJXBFS1,
         a11.LOAD_TMSP WJXBFS2,
         a11.SENDER_ID WJXBFS3,
         a11.SHIPMENT_ID WJXBFS4
FROM     ASN_PURCHASE_ORDER a11 
         join ASN_PO_COMPLIANCE a12 on (a11.LOAD_TMSP = a12.LOAD_TMSP and a11.PO_NBR = a12.PO_NBR and a11.SENDER_ID = a12.SENDER_ID and a11.SHIPMENT_ID = a12.SHIPMENT_ID) 
         join fiscal_day a13 on (DATE(a11.LOAD_TMSP) = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID)
WHERE    a14.end_dt = To_Date('06/01/2019', 'mm/dd/yyyy')) pa11
GROUP BY pa11.SALES_DT, pa11.PO_NBR, pa11.LOAD_TMSP, pa11.SENDER_ID, 
         pa11.SHIPMENT_ID, pa11.REASON_CD;


SELECT   a13.VENDOR_NBR VENDOR_NBR,
         a13.FACILITY_ID FACILITY_ID,
         max(a15.VENDOR_NAME) VENDOR_NAME,
         a13.SHIP_TO_FAC_ID FACILITY_ID0,
         max(a111.FACILITY_NAME) FACILITY_NAME,
         a15.BUYER_ID BUYER_ID,
         max(a112.BUYER_NAME) BUYER_NAME,
         a16.FISCAL_WEEK_ID FISCAL_WEEK_ID,
         max('Week Ending ' || to_char(a19.end_dt, 'mm/dd/yyyy')) WeekEnding,
         a13.COMPLIANCE_FLG COMPLIANCE_FLG,
         pa11.PO_NBR PO_NBR,
         pa11.LOAD_TMSP LOAD_TMSP,
         pa11.SENDER_ID SENDER_ID,
         pa11.SHIPMENT_ID SHIPMENT_ID,
         pa11.REASON_CD REASON_CD,
         max(a17.REASON_DESC) REASON_DESC,
         a12.SENDER_ID SENDER_ID1,
         a12.LOAD_TMSP LOAD_TMSP1,
         a12.SHIPMENT_ID SHIPMENT_ID1,
         a12.HIER_LVL_CD PARENT_HIER_LVL_CD,
         a14.HIER_LVL_CD HIER_LVL_CD,
         max(a14.EXPIRATION_DATE) EXPIRATION_DATE,
         a14.EXPIRATION_FLG EXPIRATION_FLG,
         a14.CASE_UPC_NBR CASE_UPC_NBR,
         a14.FACILITY_ID FACILITY_ID1,
         max(a18.ORDERABLE_ITEM_DSC) ROOT_ITEM_DESC,
         max(a18.SHELF_LIFE_QTY) SHELF_LIFE_QTY,
         a13.SHIPMENT_ID SHIPMENT_ID2,
         a13.SENDER_ID SENDER_ID2,
         a13.LOAD_TMSP LOAD_TMSP2,
         max(a110.SCHD_DELIVERY_DATE) SCHD_DELIVERY_DATE,
         pa11.SALES_DT SALES_DT,
         max(pa11.WJXBFS1) WJXBFS1
FROM     (select pa11.SALES_DT SALES_DT, pa11.PO_NBR PO_NBR, pa11.LOAD_TMSP LOAD_TMSP, pa11.SENDER_ID SENDER_ID, pa11.SHIPMENT_ID SHIPMENT_ID, pa11.REASON_CD REASON_CD, count(*) WJXBFS1 from (select distinct DATE(a11.LOAD_TMSP) SALES_DT, a11.PO_NBR PO_NBR, a11.LOAD_TMSP LOAD_TMSP, a11.SENDER_ID SENDER_ID, a11.SHIPMENT_ID SHIPMENT_ID, a12.REASON_CD REASON_CD, a11.PO_NBR WJXBFS1, a11.LOAD_TMSP WJXBFS2, a11.SENDER_ID WJXBFS3, a11.SHIPMENT_ID WJXBFS4 from ASN_PURCHASE_ORDER a11 
         join ASN_PO_COMPLIANCE a12 on (a11.LOAD_TMSP = a12.LOAD_TMSP and a11.PO_NBR = a12.PO_NBR and a11.SENDER_ID = a12.SENDER_ID and a11.SHIPMENT_ID = a12.SHIPMENT_ID) 
         join fiscal_day a13 on (DATE(a11.LOAD_TMSP) = a13.SALES_DT) 
         join fiscal_week a14 on (a13.FISCAL_WEEK_ID = a14.FISCAL_WEEK_ID) where a14.end_dt = To_Date('06/01/2019', 'mm/dd/yyyy')) pa11 group by pa11.SALES_DT, pa11.PO_NBR, pa11.LOAD_TMSP, pa11.SENDER_ID, pa11.SHIPMENT_ID, pa11.REASON_CD) pa11 
         join ASN_PALLET a12 on (pa11.LOAD_TMSP = a12.LOAD_TMSP and pa11.PO_NBR = a12.PO_NBR and pa11.SENDER_ID = a12.SENDER_ID and pa11.SHIPMENT_ID = a12.SHIPMENT_ID) 
         join ASN_PURCHASE_ORDER a13 on (pa11.LOAD_TMSP = a13.LOAD_TMSP and pa11.PO_NBR = a13.PO_NBR and pa11.SALES_DT = DATE(a13.LOAD_TMSP) and pa11.SENDER_ID = a13.SENDER_ID and pa11.SHIPMENT_ID = a13.SHIPMENT_ID) 
         join ASN_PACK a14 on (a12.HIER_LVL_CD = a14.PARENT_HIER_LVL_CD and a12.LOAD_TMSP = a14.LOAD_TMSP and a12.SENDER_ID = a14.SENDER_ID and a12.SHIPMENT_ID = a14.SHIPMENT_ID) 
         join DC_VENDOR a15 on (a13.FACILITY_ID = a15.FACILITY_ID and a13.VENDOR_NBR = a15.VENDOR_NBR) 
         join fiscal_day a16 on (pa11.SALES_DT = a16.SALES_DT) 
         join ASN_COMPLNC_REASON a17 on (pa11.REASON_CD = a17.REASON_CD) 
         join DC_ITEM a18 on (a14.CASE_UPC_NBR = a18.CASE_UPC_NBR and a14.FACILITY_ID = a18.FACILITY_ID) 
         join fiscal_week a19 on (a16.FISCAL_WEEK_ID = a19.FISCAL_WEEK_ID) 
         join ASN_SHIPMENT a110 on (a13.LOAD_TMSP = a110.LOAD_TMSP and a13.SENDER_ID = a110.SENDER_ID and a13.SHIPMENT_ID = a110.SHIPMENT_ID) 
         join DC_FACILITY a111 on (a13.SHIP_TO_FAC_ID = a111.FACILITY_ID) 
         join DC_BUYER a112 on (a15.BUYER_ID = a112.BUYER_ID and a18.BUYER_ID = a112.BUYER_ID)
GROUP BY a13.VENDOR_NBR, a13.FACILITY_ID, a13.SHIP_TO_FAC_ID, a15.BUYER_ID, 
         a16.FISCAL_WEEK_ID, a13.COMPLIANCE_FLG, pa11.PO_NBR, pa11.LOAD_TMSP, 
         pa11.SENDER_ID, pa11.SHIPMENT_ID, pa11.REASON_CD, a12.SENDER_ID, 
         a12.LOAD_TMSP, a12.SHIPMENT_ID, a12.HIER_LVL_CD, a14.HIER_LVL_CD, 
         a14.EXPIRATION_FLG, a14.CASE_UPC_NBR, a14.FACILITY_ID, 
         a13.SHIPMENT_ID, a13.SENDER_ID, a13.LOAD_TMSP, pa11.SALES_DT
