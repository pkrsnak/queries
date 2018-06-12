--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_DIV_XREF_U2
--------------------------------------------------
create unique Index CRMADMIN.T_WHSE_DIV_XREF_U4 
	on CRMADMIN.T_WHSE_DIV_XREF 
	(SWAT_ID) 
	Include (PROCESS_ACTIVE_FLAG)   Allow Reverse Scans;


--------------------------------------------------
-- Create Index CRMADMIN.T_WHSE_CORPORATION_MDM_X2
--------------------------------------------------
drop index CRMADMIN.T_WHSE_CORPORATION_MDM_X2;
create  Index CRMADMIN.T_WHSE_CORPORATION_MDM_X2 
	on CRMADMIN.T_WHSE_CORPORATION_MDM 
	(CUSTOMER_NBR_STND, ACTIVE_MDM_FLG)    Allow Reverse Scans;