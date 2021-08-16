SELECT   shd.FACILITYID,
         fid.LOGIC_DT po_receipt_date,
         shd.ITEM_NBR_HS,
         shd.ITEM_DESCRIPTION,
         sum(case 
              when shd.BILLING_DATE between fid.LOGIC_DT - 43 days and fid.LOGIC_DT then (shd.QTY_SOLD - shd.QTY_SCRATCHED) 
              else 0 
         end) QTY_SHIPPED,
         sum(case 
              when shd.BILLING_DATE between fid.LOGIC_DT - 43 days and fid.LOGIC_DT then (shd.QTY_SOLD - shd.QTY_SCRATCHED) 
              else 0 
         end * shd.FINAL_SELL_AMT) DOLLARS_SHIPPED,
         sum(case 
              when shd.BILLING_DATE between fid.LOGIC_DT - 43 days and fid.LOGIC_DT then (case 
                                                                                               when vwcf.CORP_CODE = 634001 then (shd.QTY_SOLD - shd.QTY_SCRATCHED) 
                                                                                               else 0 end) 
                                                                                               else 0 
                                                                                          end) AMZ_QTY_SHIPPED,
         sum(case 
              when shd.BILLING_DATE between fid.LOGIC_DT - 43 days and fid.LOGIC_DT then (case 
                                                                                               when vwcf.CORP_CODE = 634001 then ((shd.QTY_SOLD - shd.QTY_SCRATCHED) * shd.FINAL_SELL_AMT) 
                                                                                               else 0 end) 
                                                                                               else 0 
                                                                                          end) AMZ_DOLLARS_SHIPPED,
         sum(case 
              when shd.BILLING_DATE between fid.LOGIC_DT - 43 days and fid.LOGIC_DT then (case 
                                                                                               when vwcf.CORP_CODE <> 634001 then (shd.QTY_SOLD - shd.QTY_SCRATCHED) 
                                                                                               else 0 end) 
                                                                                               else 0 
                                                                                          end) OTH_QTY_SHIPPED,
         sum(case 
              when shd.BILLING_DATE between fid.LOGIC_DT - 43 days and fid.LOGIC_DT then (case 
                                                                                               when vwcf.CORP_CODE <> 634001 then ((shd.QTY_SOLD - shd.QTY_SCRATCHED) * shd.FINAL_SELL_AMT) 
                                                                                               else 0 end) 
                                                                                               else 0 
                                                                                          end) OTH_DOLLARS_SHIPPED
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL shd 
         inner join ETLADMIN.T_TEMP_FAC_ITEM_DATE fid on shd.FACILITYID = fid.FACILITYID and shd.ITEM_NBR_HS = fid.ITEM_NBR 
         inner join CRMADMIN.V_WEB_CUSTOMER_FAC vwcf on shd.FACILITYID_SHIP = vwcf.FACILITYID and shd.CUSTOMER_NBR_STND = vwcf.CUSTOMER_NBR_STND 
         inner join CRMADMIN.V_WEB_CORPORATION vwc on vwcf.CORP_CODE = vwc.CORP_CODE
WHERE    shd.BILLING_DATE >= '2019-01-01'
group by shd.FACILITYID,
         fid.LOGIC_DT,
         shd.ITEM_NBR_HS,
         shd.ITEM_DESCRIPTION