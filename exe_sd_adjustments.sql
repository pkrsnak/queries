Select * from CRMADMIN.T_WHSE_EXE_IIALG where date(CREATE_DTIM) = '2019-08-06'
;

Select * from CRMADMIN.T_WHSE_EXE_INV_DTL where FACILITYID = '003' and int(ITEM_NBR_HS) = 0017376 and LIC_PLT_ID = 1043846
;

FACILITYID	ITEM_NBR_HS
003	9301441
;


SELECT   eia.FACILITYID,
         eia.WHSE_ID,
         i.ITEM_DEPT,
         i.ITEM_NBR_HS,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_RES28 AMAZON_RES28,
         lh.RAND_WGT_CD,
         lh.SHIPPING_CASE_WEIGHT,
         eia.LOC_ID,
         eia.IARC_ID ADJ_TYPE,
         eia.ADJ_QTY,
         (eia.ADJ_QTY / i.PACK_CASE) ADJ_CASE_QTY,
         lh.LAYER_COST,
         case lh.RAND_WGT_CD 
              when 'R' then lh.SHIPPING_CASE_WEIGHT 
              else 1 
         end * lh.layer_cost * (eia.ADJ_QTY / i.PACK_CASE) EXT_LAYER_COST,
         date(eia.CREATE_DTIM) create_date,
         date(eia.EXTR_DATE) extract_date,
         eia.CREATE_USER,
         eia.SEL_LOC_ID,
         lh.PO_NBR,
         lh.FISCAL_WEEK,
         i.VENDOR_NBR,
         eia.LIC_PLT_ID
FROM     CRMADMIN.T_WHSE_EXE_IIALG eia 
         inner join CRMADMIN.T_WHSE_ITEM i on eia.FACILITYID = i.FACILITYID and int(eia.PROD_ID) = i.ITEM_NBR_HS 
         inner join (SELECT ROW_NUMBER() OVER(partition by LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS) row_num, LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_NBR, PO_RECEIPT_DTE, RAND_WGT_CD, lh.SHIPPING_CASE_WEIGHT, fc.FISCAL_WEEK, (case when CORRECT_NET_COST <> 0 then CORRECT_NET_COST else NET_COST_PER_CASE end) layer_cost FROM CRMADMIN.T_WHSE_LAYER_HISTORY lh inner join CRMADMIN.V_FISCAL_CALENDAR fc on lh.LAYER_FILE_DTE = fc.DATE_KEY AND fc.FISCAL_WEEK = fc.FISCAL_WEEK_CURRENT - 1 ORDER BY LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_RECEIPT_DTE, PO_NBR) lh on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS and lh.LAYER_FILE_DTE = eia.EXTR_DATE and lh.row_num = 1
WHERE    eia.IARC_ID = 'SD'
;


select * from CRMADMIN.T_WHSE_EXE_IIALG eia 
WHERE    eia.FACILITYID = '001'
--AND      eia.IARC_ID = 'SD'
AND      date(eia.create_dtim) = '2019-07-29'
;


Select * from CRMADMIN.T_WHSE_LAYER_HISTORY where FACILITYID = '003' and ITEM_NBR_HS = '0077834' and LAYER_FILE_DTE > '2019-05-09' -- current date
;



Select * from CRMADMIN.T_WHSE_PO_DTL where PO_NBR = 103368 and FACILITYID = '003' and ITEM_NBR = '007783';



(SELECT   LAYER_FILE_DTE,
         FACILITYID,
         ITEM_NBR_HS,
         PO_NBR,
         PO_RECEIPT_DTE,
         layer_cost
FROM     (SELECT   ROW_NUMBER() OVER(partition by LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS) row_num,
                   LAYER_FILE_DTE,
                   FACILITYID,
                   ITEM_NBR_HS,
                   PO_NBR,
                   PO_RECEIPT_DTE,
                   (case when CORRECT_NET_COST <> 0 then CORRECT_NET_COST else NET_COST_PER_CASE end) layer_cost
          FROM     CRMADMIN.T_WHSE_LAYER_HISTORY
--          WHERE    LAYER_FILE_DTE = '2019-08-04'
--          AND      FACILITYID = '003'
          ORDER BY LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_RECEIPT_DTE, PO_NBR)
WHERE    row_num = 1) lh
;


SELECT   eia.FACILITYID,
         eia.WHSE_ID,
         i.ITEM_DEPT,
         i.ITEM_NBR_HS,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_RES28 AMAZON_RES28,
         lh.RAND_WGT_CD,
         lh.SHIPPING_CASE_WEIGHT,
         eia.LOC_ID,
         eia.IARC_ID ADJ_TYPE,
         eia.ADJ_QTY,
         (eia.ADJ_QTY / i.PACK_CASE) ADJ_CASE_QTY,
         lh.LAYER_COST,
         case lh.RAND_WGT_CD 
              when 'R' then lh.SHIPPING_CASE_WEIGHT 
              else 1 
         end * lh.layer_cost * (eia.ADJ_QTY / i.PACK_CASE) EXT_LAYER_COST,
         date(eia.CREATE_DTIM) create_date,
         date(eia.EXTR_DATE) extract_date,
         eia.CREATE_USER,
         eia.SEL_LOC_ID,
         lh.PO_NBR, po.DATE_ORDERED,
         lh.FISCAL_WEEK,
         i.VENDOR_NBR,
         eia.LIC_PLT_ID, otr.CURR_INVENTORY, otr.CURR_ORDER, otr.CASES_ORDER, otr.DAYS_PROMO, otr.RESERVE_STORAGE_QTY, otr.AD_QUANTITY, otr.CURR_ON_HOLD, otr.DISTANT_OO, otr.DAYS_SUPPLY
FROM     CRMADMIN.T_WHSE_EXE_IIALG eia 
         inner join CRMADMIN.T_WHSE_ITEM i on eia.FACILITYID = i.FACILITYID and int(eia.PROD_ID) = i.ITEM_NBR_HS 
         inner join (SELECT ROW_NUMBER() OVER(partition by LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS) row_num, LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_NBR, PO_RECEIPT_DTE, RAND_WGT_CD, lh.SHIPPING_CASE_WEIGHT, fc.FISCAL_WEEK, (case when CORRECT_NET_COST <> 0 then CORRECT_NET_COST else NET_COST_PER_CASE end) layer_cost FROM CRMADMIN.T_WHSE_LAYER_HISTORY lh inner join CRMADMIN.V_FISCAL_CALENDAR fc on lh.LAYER_FILE_DTE = fc.DATE_KEY AND fc.FISCAL_WEEK = fc.FISCAL_WEEK_CURRENT - 2
/* #prompt('week_offset','integer')# */ ORDER BY LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_RECEIPT_DTE, PO_NBR) lh on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS and lh.LAYER_FILE_DTE = eia.EXTR_DATE and lh.row_num = 1
         left outer join (SELECT ROW_NUMBER() OVER(partition by poh.FACILITYID, poh.PO_NBR ) row_num, poh.FACILITYID, poh.PO_NBR, poh.DATE_ORDERED FROM CRMADMIN.T_WHSE_PO_HDR poh ORDER BY poh.FACILITYID, poh.PO_NBR, poh.DATE_ORDERED desc) po on i.FACILITYID = po.FACILITYID and lh.PO_NBR = po.PO_NBR and po.ROW_NUM = 1
         left outer join CRMADMIN.T_WHSE_ORDER_TRIGGER_RPT otr on i.FACILITYID = otr.RECEIVING_FACILITYID and i.ITEM_NBR_HS = otr.ITEM_NBR_HS and po.DATE_ORDERED = otr.RPT_DATE - 1 day
WHERE    eia.IARC_ID = 'SD'

;

---actual sd report-----

SELECT   eia.FACILITYID,
         eia.WHSE_ID,
         i.ITEM_DEPT,
         i.ITEM_NBR_HS,
         i.UPC_CASE,
         i.UPC_UNIT,
         i.ITEM_DESCRIP,
         i.PACK_CASE,
         i.ITEM_RES28 AMAZON_RES28,
         lh.RAND_WGT_CD,
         lh.SHIPPING_CASE_WEIGHT,
         eia.LOC_ID,
         eia.IARC_ID ADJ_TYPE,
         eia.ADJ_QTY,
         (eia.ADJ_QTY / i.PACK_CASE) ADJ_CASE_QTY,
         lh.LAYER_COST,
         case lh.RAND_WGT_CD 
              when 'R' then lh.SHIPPING_CASE_WEIGHT 
              else 1 
         end * lh.layer_cost * (eia.ADJ_QTY / i.PACK_CASE) EXT_LAYER_COST,
         date(eia.CREATE_DTIM) create_date,
         date(eia.EXTR_DATE) extract_date,
         eia.CREATE_USER,
         eia.SEL_LOC_ID,
         lh.PO_NBR,
         po.DATE_ORDERED,
         lh.FISCAL_WEEK,
         i.VENDOR_NBR,
         eia.LIC_PLT_ID
FROM     CRMADMIN.T_WHSE_EXE_IIALG eia 
         inner join CRMADMIN.T_WHSE_ITEM i on eia.FACILITYID = i.FACILITYID and int(eia.PROD_ID) = i.ITEM_NBR_HS 
         inner join (SELECT ROW_NUMBER() OVER(partition by LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS) row_num, LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_NBR, PO_RECEIPT_DTE, RAND_WGT_CD, lh.SHIPPING_CASE_WEIGHT, fc.FISCAL_WEEK, (case when CORRECT_NET_COST <> 0 then CORRECT_NET_COST else NET_COST_PER_CASE end) layer_cost FROM CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.V_FISCAL_CALENDAR fc on lh.LAYER_FILE_DTE = fc.DATE_KEY and lh.LAYER_FILE_DTE between current date - #prompt('start_days_back', 'integer')# days and current date - #prompt('end_days_back', 'integer')# days ORDER BY LAYER_FILE_DTE, FACILITYID, ITEM_NBR_HS, PO_RECEIPT_DTE, PO_NBR) lh on lh.FACILITYID = i.FACILITYID and lh.ITEM_NBR_HS = i.ITEM_NBR_HS and lh.LAYER_FILE_DTE = eia.EXTR_DATE and lh.row_num = 1 
         left outer join (SELECT poh.FACILITYID, poh.PO_NBR, max(poh.DATE_ORDERED) date_ordered FROM CRMADMIN.T_WHSE_PO_HDR poh group BY poh.FACILITYID, poh.PO_NBR) po on lh.FACILITYID = po.FACILITYID and lh.PO_NBR = po.PO_NBR
WHERE    eia.IARC_ID = 'SD'
;


-------------sd metrics report----------------------
SELECT   fc.FISCAL_YEAR,
         fc.FISCAL_PERIOD,
         fc.FISCAL_WEEK,
         adj.FACILITYID,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.LIST_COST,
         i.CATALOG_PRICE,
         adj.IALG_ID,
         adj.DC_ID,
         adj.WHSE_ID,
         adj.LOC_ID,
         adj.PROD_ID,
         adj.IARC_ID,
         adj.QTY_O,
         adj.ADJ_QTY,
         abs( case i.RAND_WGT_CD when 'R' then i.SHIPPING_CASE_WEIGHT else 1 end * i.LIST_COST * (adj.ADJ_QTY / i.PACK_CASE)) EXT_COST,
         adj.CREATE_DTIM,
         adj.CREATE_USER,
         adj.SEL_LOC_ID,
         adj.ROW_STAT,
         adj.ROLL_FLAG,
         adj.PRDD_ID,
         adj.DOC_NO,
         adj.AUTH_KEY,
         adj.PO_ID,
         adj.RCPT_ID,
         adj.EXTR_FLAG,
         adj.EXTR_DATE,
         adj.CATCH_WGT,
         adj.CUST_ID,
         adj.WHSE_GNRT_FLOW_FLG,
         adj.VEND_ID,
         adj.LIC_PLT_ID
FROM     CRMADMIN.T_WHSE_EXE_IIALG adj 
         left outer join CRMADMIN.T_WHSE_ITEM i on adj.FACILITYID = i.FACILITYID and int(trim(adj.PROD_ID)) = int(i.ITEM_NBR_HS) 
         inner join CRMADMIN.V_FISCAL_CALENDAR fc on fc.DATE_KEY = adj.EXTR_DATE
WHERE    fc.FISCAL_WEEK = fc.FISCAL_WEEK_CURRENT
AND      adj.ADJ_QTY <> 0