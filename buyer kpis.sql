
create view CRMADMIN.V_WHSE_LAYER_HST_WED as
SELECT   lh.*
FROM     CRMADMIN.T_WHSE_LAYER_HISTORY lh 
         inner join CRMADMIN.T_DATE d on lh.LAYER_FILE_DTE = d.DATE_KEY
WHERE    d.DAY_OF_WEEK_ID = 7
AND      d.DATE_KEY between current date - 731 days and current date