Select   FACILITYID
		,ITEM_NBR
		,ITEM_NBR_HS
		,ITEM_DESCRIPTION
		,LAYER_FILE_DTE
		,STATUS_CDE
		,MASTER_VENDOR_NBR
		,VENDOR_NBR
		,FIN_APVEND_NO
		,LEG_APVEND_NO
		,STORE_PACK
		,SIZE
		,ITEM_DEPT
		,PURCH_STATUS
		,PRODUCT_GRP
		,PRODUCT_SUBGRP
		,BUYER_NBR
		,LAST_SHIPPED_DATE
		,VENDOR_LIST_PRICE
		,CATALOG_PRICE
		,NET_COST_PER_CASE
		,CORRECT_NET_COST
--		,ADJ_UNIT_LAYER_COST
--		,ADJ_CASE_LAYER_COST
		,ON_ORDER_TOTAL
		,ON_ORDER_TURN
		,ON_ORDER_PROMO
		,ON_ORDER_FWD_BUY
		,QTY_ADJ
		,INVENTORY_TURN
		,TURN_QTY_SOLD
		,INVENTORY_PROMOTION
		,PROMO_QTY_SOLD
		,INVENTORY_FWD_BUY
		,FWD_BUY_SOLD
--		,EXT_INVENTORY_QOH
--		,EXT_TURN_INV_VALUE
--		,EXT_PROMO_INV_VALUE
--		,EXT_FWD_BUY_INV_VALUE
--		,EXT_INVENTORY_VALUE
  from CRMADMIN.T_WHSE_LAYER_HISTORY
 where LAYER_FILE_DTE = '2011-02-16'