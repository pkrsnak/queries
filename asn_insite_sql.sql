SELECT   v.ap_vendor_nbr,
         apo_main.VENDOR_NBR,
         apo_main.FACILITY_ID FACILITY_ID,
         max(v.VENDOR_NAME) VENDOR_NAME,
         apo_main.SHIP_TO_FAC_ID SHIP_TO_FAC_ID,
         max(df.FACILITY_NAME) FACILITY_NAME,
         v.BUYER_ID BUYER_ID,
         max(db.BUYER_NAME) BUYER_NAME,
         fdm.FISCAL_WEEK_ID FISCAL_WEEK_ID,
         max('Week Ending ' || to_char(fwm.end_dt, 'mm/dd/yyyy')) WeekEnding,
         apo_main.COMPLIANCE_FLG COMPLIANCE_FLG,
         comp_fail_count.PO_NBR PO_NBR,
         comp_fail_count.LOAD_TMSP LOAD_TMSP,
         comp_fail_count.SENDER_ID SENDER_ID,
         comp_fail_count.SHIPMENT_ID SHIPMENT_ID,
         comp_fail_count.REASON_CD REASON_CD,
         max(acr.REASON_DESC) REASON_DESC,
         aplt.HIER_LVL_CD PARENT_HIER_LVL_CD,
         apck.HIER_LVL_CD HIER_LVL_CD,
         max(apck.EXPIRATION_DATE) EXPIRATION_DATE,
         apck.EXPIRATION_FLG EXPIRATION_FLG,
         apck.CASE_UPC_NBR CASE_UPC_NBR,
         apck.FACILITY_ID FACILITY_ID1,
         max(di.ORDERABLE_ITEM_DSC) ROOT_ITEM_DESC,
         max(di.SHELF_LIFE_QTY) SHELF_LIFE_QTY,
         apo_main.SHIPMENT_ID SHIPMENT_ID2,
         apo_main.SENDER_ID SENDER_ID2,
         apo_main.LOAD_TMSP LOAD_TMSP2,
         max(asp.SCHD_DELIVERY_DATE) SCHD_DELIVERY_DATE,
         comp_fail_count.SALES_DT SALES_DT,
         max(comp_fail_count.num_records) num_recs
FROM     (SELECT   comp_fail.SALES_DT SALES_DT,
			         comp_fail.PO_NBR PO_NBR,
			         comp_fail.LOAD_TMSP LOAD_TMSP,
			         comp_fail.SENDER_ID SENDER_ID,
			         comp_fail.SHIPMENT_ID SHIPMENT_ID,
			         comp_fail.REASON_CD REASON_CD,
			         count(*) num_records
			FROM     (SELECT   Distinct DATE(apo.LOAD_TMSP) SALES_DT,
					         apo.PO_NBR PO_NBR,
					         apo.LOAD_TMSP LOAD_TMSP,
					         apo.SENDER_ID SENDER_ID,
					         apo.SHIPMENT_ID SHIPMENT_ID,
					         apc.REASON_CD REASON_CD
					FROM     ASN_PURCHASE_ORDER apo 
					         join ASN_PO_COMPLIANCE apc on (apo.LOAD_TMSP = apc.LOAD_TMSP and apo.PO_NBR = apc.PO_NBR and apo.SENDER_ID = apc.SENDER_ID and apo.SHIPMENT_ID = apc.SHIPMENT_ID) 
					         join fiscal_day fd on (DATE(apo.LOAD_TMSP) = fd.SALES_DT) 
					         join fiscal_week fw on (fd.FISCAL_WEEK_ID = fw.FISCAL_WEEK_ID)
					--WHERE    compliance_flg <> 'Y'
                    ) comp_fail
			GROUP BY comp_fail.SALES_DT, comp_fail.PO_NBR, comp_fail.LOAD_TMSP, 
			         comp_fail.SENDER_ID, comp_fail.SHIPMENT_ID, comp_fail.REASON_CD) comp_fail_count 
         join ASN_PALLET aplt on (comp_fail_count.LOAD_TMSP = aplt.LOAD_TMSP and comp_fail_count.PO_NBR = aplt.PO_NBR and comp_fail_count.SENDER_ID = aplt.SENDER_ID and comp_fail_count.SHIPMENT_ID = aplt.SHIPMENT_ID) 
         join ASN_PURCHASE_ORDER apo_main on (comp_fail_count.LOAD_TMSP = apo_main.LOAD_TMSP and comp_fail_count.PO_NBR = apo_main.PO_NBR and comp_fail_count.SALES_DT = DATE(apo_main.LOAD_TMSP) and comp_fail_count.SENDER_ID = apo_main.SENDER_ID and comp_fail_count.SHIPMENT_ID = apo_main.SHIPMENT_ID) 
         join ASN_PACK apck on (aplt.HIER_LVL_CD = apck.PARENT_HIER_LVL_CD and aplt.LOAD_TMSP = apck.LOAD_TMSP and aplt.SENDER_ID = apck.SENDER_ID and aplt.SHIPMENT_ID = apck.SHIPMENT_ID) 
         join DC_VENDOR v on (apo_main.FACILITY_ID = v.FACILITY_ID and apo_main.VENDOR_NBR = v.VENDOR_NBR) 
         join fiscal_day fdm on (comp_fail_count.SALES_DT = fdm.SALES_DT) 
         join ASN_COMPLNC_REASON acr on (comp_fail_count.REASON_CD = acr.REASON_CD) 
         join DC_ITEM di on (apck.CASE_UPC_NBR = di.CASE_UPC_NBR and apck.FACILITY_ID = di.FACILITY_ID) 
         join fiscal_week fwm on (fdm.FISCAL_WEEK_ID = fwm.FISCAL_WEEK_ID) 
         join ASN_SHIPMENT asp on (apo_main.LOAD_TMSP = asp.LOAD_TMSP and apo_main.SENDER_ID = asp.SENDER_ID and apo_main.SHIPMENT_ID = asp.SHIPMENT_ID) 
         join DC_FACILITY df on (apo_main.SHIP_TO_FAC_ID = df.FACILITY_ID) 
         join DC_BUYER db on (v.BUYER_ID = db.BUYER_ID and di.BUYER_ID = db.BUYER_ID)
WHERE   -- v.ap_vendor_nbr = 100932 
      comp_fail_count.PO_NBR = 50691
GROUP BY v.ap_vendor_nbr, apo_main.VENDOR_NBR, apo_main.FACILITY_ID, 
         apo_main.SHIP_TO_FAC_ID, v.BUYER_ID, fdm.FISCAL_WEEK_ID, 
         apo_main.COMPLIANCE_FLG, comp_fail_count.PO_NBR, 
         comp_fail_count.LOAD_TMSP, comp_fail_count.SENDER_ID, 
         comp_fail_count.SHIPMENT_ID, comp_fail_count.REASON_CD, 
         aplt.SENDER_ID, aplt.LOAD_TMSP, aplt.SHIPMENT_ID, aplt.HIER_LVL_CD, 
         apck.HIER_LVL_CD, apck.EXPIRATION_FLG, apck.CASE_UPC_NBR, 
         apck.FACILITY_ID, apo_main.SHIPMENT_ID, apo_main.SENDER_ID, 
         apo_main.LOAD_TMSP, comp_fail_count.SALES_DT;