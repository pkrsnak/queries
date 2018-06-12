--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_SALES_HISTORY_DTL_X1
--------------------------------------------------
create  Index CRMADMIN.T_WHSE_LAYER_HISTORY_X1
	on CRMADMIN.T_WHSE_LAYER_HISTORY 
	(FACILITYID, ITEM_NBR_HS, LAYER_FILE_DTE)    Allow Reverse Scans;
	
--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_SALES_HISTORY_DTL_X2
--------------------------------------------------
create  Index CRMADMIN.T_WHSE_LAYER_HISTORY_X2
	on CRMADMIN.T_WHSE_LAYER_HISTORY 
	(FACILITYID, VENDOR_NBR, ITEM_NBR_HS, LAYER_FILE_DTE)    Allow Reverse Scans;
	
--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_SALES_HISTORY_DTL_X3
--------------------------------------------------
create  Index CRMADMIN.T_WHSE_LAYER_HISTORY_X3
	on CRMADMIN.T_WHSE_LAYER_HISTORY 
	(FACILITYID, UPC_UNIT, LAYER_FILE_DTE)    Allow Reverse Scans;
	
	
--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_SALES_HISTORY_DTL_X4
--------------------------------------------------
create  Index CRMADMIN.T_WHSE_LAYER_HISTORY_X4
	on CRMADMIN.T_WHSE_LAYER_HISTORY 
	(FACILITYID, UPC_CASE, LAYER_FILE_DTE)    Allow Reverse Scans;
	
--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_SALES_HISTORY_DTL_X5
--------------------------------------------------
create  Index CRMADMIN.T_WHSE_LAYER_HISTORY_X5
	on CRMADMIN.T_WHSE_LAYER_HISTORY 
	(FACILITYID, PRODUCT_GRP, LAYER_FILE_DTE)    Allow Reverse Scans;
	
--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_SALES_HISTORY_DTL_X6
--------------------------------------------------
create  Index CRMADMIN.T_WHSE_LAYER_HISTORY_X6
	on CRMADMIN.T_WHSE_LAYER_HISTORY 
	(FACILITYID, PRODUCT_SUBGRP, LAYER_FILE_DTE)    Allow Reverse Scans;

--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_SALES_HISTORY_DTL_X7
--------------------------------------------------
create  Index CRMADMIN.T_WHSE_LAYER_HISTORY_X7
	on CRMADMIN.T_WHSE_LAYER_HISTORY 
	(FACILITYID, ITEM_DEPT, LAYER_FILE_DTE)    Allow Reverse Scans;
