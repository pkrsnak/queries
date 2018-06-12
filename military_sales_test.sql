SELECT   FACILITYID,
		 VENDOR_NBR, 
 		 VENDOR_NAME, 
		 INVOICE_NBR,
		 BILLING_DATE,
         CUSTOMER_NO_FULL,
         ITEM_NBR_HS,
         ITEM_DESCRIPTION,
         STORE_PACK,
         SIZE,
         QTY_SOLD, 
         LAYER_EXT_COST,
         EXTENDED_SALES_AMT
FROM     crmadmin.t_whse_sales_history_dtl
WHERE    facilityid = '040'
AND      item_nbr_hs in ('1813906', '1813823', '1813864', '1813849', '1818467', '1818483', '1818509')
AND      TERRITORY_NO = 14
AND      BILLING_DATE between '2007-10-07' and '2007-10-13';



SELECT   td.COMPANY_YEAR_ID,
		 td.COMPANY_PERIOD_ID,
		 wsh.FACILITYID,  
		 wsh.VENDOR_NBR, 
 		 wsh.VENDOR_NAME, 
		 wsh.INVOICE_NBR,
		 wsh.BILLING_DATE,
         wsh.CUSTOMER_NO_FULL,
         wsh.ITEM_NBR_HS,
         wsh.ITEM_DESCRIPTION,
         wsh.STORE_PACK,
         wsh.SIZE,
         case when wsh.qty_sold = 0 then wsh.layer_ext_cost else (wsh.LAYER_EXT_COST / wsh.QTY_SOLD) end unit_layer,
--         wsh.QTY_SOLD tot_qty_sold, 
--         wsh.LAYER_EXT_COST ext_layer_cost,
--         wsh.EXTENDED_SALES_AMT ext_sales_amt
         sum(wsh.QTY_SOLD) tot_qty_sold, 
         sum(wsh.LAYER_EXT_COST) ext_layer_cost,
         sum(wsh.EXTENDED_SALES_AMT) ext_sales_amt
FROM     crmadmin.t_whse_sales_history_dtl wsh,
		 crmadmin.t_date td
WHERE    wsh.billing_date = td.date_key
and		 facilityid = '040'
--AND      item_nbr_hs in ('1813906', '1813823', '1813864', '1813849', '1818467', '1818483', '1818509')
and 	 wsh.VENDOR_NBR in ('005850', '094565', '020065', '004151')
AND      wsh.TERRITORY_NO = 14
AND      td.date_key between '2006-05-22' and '2007-11-15' --'2006-06-17'--
group by td.COMPANY_YEAR_ID,
		 td.COMPANY_PERIOD_ID,
		 wsh.FACILITYID,  
		 wsh.VENDOR_NBR, 
 		 wsh.VENDOR_NAME, 
		 wsh.INVOICE_NBR,
		 wsh.BILLING_DATE,
         wsh.CUSTOMER_NO_FULL,
         wsh.ITEM_NBR_HS,
         wsh.ITEM_DESCRIPTION,
         wsh.STORE_PACK,
         wsh.SIZE,
		 case when wsh.qty_sold = 0 then wsh.layer_ext_cost else (wsh.LAYER_EXT_COST / wsh.QTY_SOLD) end ;