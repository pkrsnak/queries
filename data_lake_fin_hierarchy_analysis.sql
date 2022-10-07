SELECT   shd.GL_ACCOUNT,
         lawson_acct.LAWSON_DEPT PRODUCT_CODE,
         shd.FACILITYID,
         i.ITEM_NBR_HS,
         i.ITEM_DESCRIP,
         i.ITEM_DEPT,
         mdse.MDSE_CLS_CODE,
         mdse.MDSE_CLS_CODE_DESC,
         mdse.MDSE_CAT_CODE,
         mdse.MDSE_CAT_CODE_DESC,
         mdse.MDSE_GRP_CODE,
         mdse.MDSE_GRP_CODE_DESC,
         mdse.DEPT_CODE,
         mdse.DEPT_CODE_DESC,
         mdse.DEPT_GRP_CODE,
         mdse.DEPT_GRP_CODE_DESC,
         shd.WHOL_SALES_CD,
         shd.TERRITORY_NO,
         sum(shd.QTY_SOLD - shd.QTY_SCRATCHED)
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join crmadmin.T_WHSE_ITEM i on shd.facilityid = i.FACILITYID and shd.ITEM_NBR_HS = i.ITEM_NBR_HS 
         inner join etladmin.V_MDM_MDSE_HIERARCHY mdse on i.MERCH_CLASS = mdse.MDSE_CLS_CODE 
         inner join CRMADMIN.V_WHSE_LAWSON_ACCT_TO_WSC_TN lawson_acct on (shd.whol_sales_cd = lawson_acct.whol_sales_cd and shd.territory_no = lawson_acct.territory_no and shd.facilityid = lawson_acct.facilityid and lawson_acct.business_segment = '2' and lawson_acct.lawson_account in ('50000','50005','50007','50040','50047','53010','54500'))
WHERE    shd.billing_date >= '2022-09-01'
GROUP BY shd.GL_ACCOUNT, lawson_acct.LAWSON_DEPT, shd.FACILITYID, 
         i.ITEM_NBR_HS, i.ITEM_DESCRIP, i.ITEM_DEPT, mdse.MDSE_CLS_CODE, 
         mdse.MDSE_CLS_CODE_DESC, mdse.MDSE_CAT_CODE, mdse.MDSE_CAT_CODE_DESC, 
         mdse.MDSE_GRP_CODE, mdse.MDSE_GRP_CODE_DESC, mdse.DEPT_CODE, 
         mdse.DEPT_CODE_DESC, mdse.DEPT_GRP_CODE, mdse.DEPT_GRP_CODE_DESC, 
         shd.WHOL_SALES_CD, shd.TERRITORY_NO
HAVING   sum(shd.QTY_SOLD - shd.QTY_SCRATCHED) <> 0