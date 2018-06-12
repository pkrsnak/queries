SELECT   wis.FACILITYID,
         wis.ITEM_NBR_HS,
         wi.ITEM_DESCRIP,
         wi.PACK_CASE,
         wi.ITEM_SIZE_DESCRIP,
         wi.ITEM_SIZE,
         wi.ITEM_SIZE_UOM,
         wi.UPC_CASE,
         wi.UPC_UNIT,
         wi.LIST_COST,
         wi.BASE_SELL,
         wi.CATALOG_PRICE,
         wi.PURCH_STATUS,
         wi.BILLING_STATUS,
         wi.ITEM_DEPT,
         wi.LAST_COST,
         sum(wis.TOT_SHIPPED) shipped
 FROM    CRMADMIN.MQT_WHSE_ITEM_SALES_HISTORY_SUM_WK wis,
         CRMADMIN.T_WHSE_ITEM wi
WHERE    wis.FACILITYID = wi.FACILITYID
AND      wis.ITEM_NBR_CD = wi.ITEM_NBR_CD
AND      wis.FACILITYID in ('058')
--AND		 wis.WK_END_DATE > current date - 365 days
AND      wi.PURCH_STATUS not in ('D')
group by wis.FACILITYID,
         wis.ITEM_NBR_HS,
         wi.ITEM_DESCRIP,
         wi.PACK_CASE,
         wi.ITEM_SIZE_DESCRIP,
         wi.ITEM_SIZE,
         wi.ITEM_SIZE_UOM,
         wi.UPC_CASE,
         wi.UPC_UNIT,
         wi.LIST_COST,
         wi.BASE_SELL,
         wi.CATALOG_PRICE,
         wi.PURCH_STATUS,
         wi.BILLING_STATUS,
         wi.ITEM_DEPT,
         wi.LAST_COST;
         
         
SELECT   wis.FACILITYID,
         wis.ITEM_NBR_HS,
         wi.ITEM_DESCRIP,
         wi.PACK_CASE,
         wi.ITEM_SIZE_DESCRIP,
         wi.ITEM_SIZE,
         wi.ITEM_SIZE_UOM,
         wi.UPC_CASE,
         wi.UPC_UNIT,
         wi.LIST_COST,
         wi.BASE_SELL,
         wi.CATALOG_PRICE,
         wi.PURCH_STATUS,
         wi.BILLING_STATUS,
         wi.ITEM_DEPT,
         sum(wis.QTY_SOLD) shipped
 FROM    CRMADMIN.T_WHSE_SALES_HISTORY_DTL wis,
         CRMADMIN.T_WHSE_ITEM wi
WHERE    wis.FACILITYID = wi.FACILITYID
AND      wis.ITEM_NBR_CD = wi.ITEM_NBR_CD
AND      wis.FACILITYID in ('058')
AND		 wis.billing_date > current date - 365 days
AND      wi.PURCH_STATUS not in ('D')
AND 	 wis.CUSTOMER_NO in ('1106', '1218', '1358', '1469', '5420', '5421', '5423', '5433', '5434', '5461', '5463', '5464', '5465', '5466', 							 '5467', '5602', '7101')
group by wis.FACILITYID,
         wis.ITEM_NBR_HS,
         wi.ITEM_DESCRIP,
         wi.PACK_CASE,
         wi.ITEM_SIZE_DESCRIP,
         wi.ITEM_SIZE,
         wi.ITEM_SIZE_UOM,
         wi.UPC_CASE,
         wi.UPC_UNIT,
         wi.LIST_COST,
         wi.BASE_SELL,
         wi.CATALOG_PRICE,
         wi.PURCH_STATUS,
         wi.BILLING_STATUS,
         wi.ITEM_DEPT;


