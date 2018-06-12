         decimal(SUM(case when x.lawson_account = '999710' 
                           or (x.lawson_account = '301000' and (shd.whol_sales_cd = '002' or
                                                                shd.whol_sales_cd = '009' or
                                                                shd.whol_sales_cd = '011' or
                                                                shd.whol_sales_cd = '013' or
                                                                shd.whol_sales_cd = '016' or
                                                                shd.whol_sales_cd = '017' or
                                                                shd.whol_sales_cd = '052' or
                                                                shd.whol_sales_cd = '060' or
                                                                shd.whol_sales_cd = '095' or
                                                                shd.whol_sales_cd = '114' or
                                                                shd.whol_sales_cd = '155' or
                                                                shd.whol_sales_cd = '156' or
                                                                shd.whol_sales_cd = '157' or
                                                                shd.whol_sales_cd = '163' or
                                                                shd.whol_sales_cd = '164')
                              ) 
               then (case when shd.out_reason_code in ('004', '011') then 0 
                           else (CASE WHEN SHD.ORDER_TYPE = 'GB' 
                                      THEN SHD.QTY_SOLD 
                                      ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') 
                                                 THEN 1 
                                                 ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                                            END) 
                                 END) 
                      end) 
                 * (case when (x.lawson_account='999710' AND SHD.ORDER_SOURCE <> 'I') 
                         Then SHD.FINAL_SELL_AMT 
                         Else SHD.MRKUP_DLLRS_PER_SHIP_UNT 
                    end) 
               else 0
               end ) ,14,2) as mrkup_new,


-- original

         decimal(SUM((case when shd.out_reason_code in ('004', '011') then 0 
                           else (CASE WHEN SHD.ORDER_TYPE = 'GB' 
                                      THEN SHD.QTY_SOLD 
                                      ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') 
                                                 THEN 1 
                                                 ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                                            END) 
                                 END) 
                      end) 
                 * (case when x.lawson_account='999710' AND SHD.ORDER_SOURCE <> 'I' 
                         Then SHD.FINAL_SELL_AMT 
                         Else SHD.MRKUP_DLLRS_PER_SHIP_UNT 
                    end) ) ,14,2)as mrkup,


         decimal(SUM((case when shd.out_reason_code in ('004', '011') then 0 
                           else (CASE WHEN SHD.ORDER_TYPE = 'GB' 
                                      THEN SHD.QTY_SOLD 
                                      ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') 
                                                 THEN 1 
                                                 ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                                            END) 
                                 END) 
                      end) 
                 * (case when (x.lawson_account='999710' AND SHD.ORDER_SOURCE <> 'I') 
--                           or (x.lawson_account='301000' and (shd.whol_sales_cd='013' or shd.whol_sales_cd='016'))
                           or (x.lawson_account='301000' and shd.whol_sales_cd='016')
                         Then SHD.FINAL_SELL_AMT 
                         Else SHD.MRKUP_DLLRS_PER_SHIP_UNT 
                    end) ) ,14,2)as mrkup_new,
