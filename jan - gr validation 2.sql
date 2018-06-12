         decimal(SUM(case x.lawson_account = '301000' and (shd.whol_sales_cd = '002' or
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
                                           else 
               (case when dc.REGION = 'MIDWEST' 
                     then (case when (shd.out_reason_code in ('004', '011') 
--                                  Or (x.lawson_account='301000' and shd.whol_sales_cd='017')) 
                                then 0 
                                else (CASE WHEN SHD.ORDER_TYPE = 'GB' 
                                           THEN SHD.QTY_SOLD 
                                           ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') 
                                                      THEN 1 
                                                      ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                                                 END) 
                                      END) 
                 * (SHD.FINAL_SELL_AMT - SHD.LBL_CASE_CHRGE - SHD.FREIGHT_AMT - SHD.MRKUP_DLLRS_PER_SHIP_UNT 
                    - SHD.FUEL_CHRGE_AMT - SHD.PRICE_ADJUSTMENT 
                    - (case when shd.ITEM_DEPT = '050' 
                            then 0 
                            else (SHD.CITY_EXCISE_TAX + SHD.OTHER_EXCISE_TAX_01 
                            + SHD.OTHER_EXCISE_TAX_02 + SHD.OTHER_EXCISE_TAX_03 
                            + SHD.COUNTY_EXCISE_TAX + SHD.STATE_EXCISE_TAX) 
                       end) + SHD.LEAKAGE_AMT + SHD.ITEM_LVL_MRKUP_AMT_02 ) 
                                                      end) 
                          else (case when (shd.out_reason_code in ('004', '011') 
--                                       Or (x.lawson_account='301000' and (shd.whol_sales_cd in ('013', '016', '017' ))) 
--                                       Or (x.lawson_account='301000' and shd.whol_sales_cd='017' )) 
                                     then 0 
                                     else (case when SHD.ORDER_TYPE = 'GB' 
                                                then SHD.QTY_SOLD 
                                                else (case when (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') 
                                                           then 1 
                                                           else SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                                                      end) 
                                                end) * 
                 (SHD.FINAL_SELL_AMT - SHD.LBL_CASE_CHRGE - SHD.PRICE_ADJUSTMENT 
                  - (case when shd.ITEM_DEPT = '050' 
                          then 0 
                          else (SHD.CITY_EXCISE_TAX + SHD.OTHER_EXCISE_TAX_01 + SHD.OTHER_EXCISE_TAX_02 
                                + SHD.OTHER_EXCISE_TAX_03 + SHD.COUNTY_EXCISE_TAX + SHD.STATE_EXCISE_TAX) 
                     end) + SHD.LEAKAGE_AMT 
                  - (case when SHD.MRKUP_SPREAD_FLG IN ('0', '1', '2') 
                          then SHD.MRKUP_DLLRS_PER_SHIP_UNT 
                          else 0 
                     end) 
                  - (case when SHD.MRKUP_SPREAD_FLG IN ('2') 
                          then SHD.FREIGHT_AMT 
                          else 0 
                          end)) 
                                end) 
                end) 
                     end) ,14,2) as PURE_SALES_AMOUNT,
