SELECT   
--         d1.DATE_KEY as Billing_Date,
         shd.facilityid,
--         shd.ORDER_TYPE ,
         x.lawson_dept, x.LAWSON_ACCOUNT,
--         x.lawson_account,
--         shd.territory_no,
--         shd.WHOL_SALES_CD,
         decimal(SUM(case when x.lawson_account = '999710' 
--                           or (x.lawson_account = '301000' and (shd.whol_sales_cd = '002' or
--                                                                shd.whol_sales_cd = '009' or
--                                                                shd.whol_sales_cd = '011' or
--                                                                shd.whol_sales_cd = '013' or
--                                                                shd.whol_sales_cd = '016' or
--                                                                shd.whol_sales_cd = '017' or
--                                                                shd.whol_sales_cd = '052' or
--                                                                shd.whol_sales_cd = '060' or
--                                                                shd.whol_sales_cd = '095' or
--                                                                shd.whol_sales_cd = '114' or
--                                                                shd.whol_sales_cd = '155' or
--                                                                shd.whol_sales_cd = '156' or
--                                                                shd.whol_sales_cd = '157' or
--                                                                shd.whol_sales_cd = '163' or
--                                                                shd.whol_sales_cd = '164')
--                              ) 
               then 0 
               else 
               (case when dc.REGION = 'MIDWEST' 
                     then (case when (shd.out_reason_code in ('004', '011')) 
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
                          else (case when (shd.out_reason_code in ('004', '011')) 
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
                  - (case when SHD.MRKUP_SPREAD_FLG IN ('1', '2') 
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
                     
--(x.lawson_account='301000' and (shd.whol_sales_cd='013' or shd.whol_sales_cd='016')

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
--(x.lawson_account='301000' and (shd.whol_sales_cd='013' or shd.whol_sales_cd='016')

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
               then 
(case when shd.out_reason_code in ('004', '011') then 0 
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

         decimal(SUM(CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END),14,2) as qty,
         decimal(SUM(CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_ORDERED ELSE shd.QTY_ADJUSTED END),14,2) as adj_order_qty
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL SHD 
         inner join CRMADMIN.V_WHSE_LAWSON_ACCT x on shd.whol_sales_cd = x.whol_sales_cd and shd.territory_no=x.territory_no and shd.facilityid=x.facilityid 
         inner join CRMADMIN.t_date d1 on shd.billing_date=d1.date_key 
         inner join CRMADMIN.T_WHSE_DIV_XREF dc on dc.swat_id=shd.facilityid 
         inner join CRMADMIN.T_WHSE_DIV_USDS usds on usds.facilityid = shd.facilityid and usds.facilityid_ship = shd.facilityid_ship and usds.USDS_FLG = 'D'
WHERE    d1.date_key between '2014-08-31' and '2014-09-06'
AND      shd.facilityid ='058'
AND      x.BUSINESS_SEGMENT='2'
AND      x.lawson_account in ('301000', '331000', '349500', '999710')
AND      shd.territory_no not in (29,39,46,49,58,59,69,70)
--AND      shd.WHOL_SALES_CD NOT in ('027', '031', '101', '159', '320', '524', '535', '680', '703', '718', '860', '000')
AND      SHD.RECORD_ID not in ( '8', '2')
--AND      shd.WHOL_SALES_CD = '016'
GROUP BY 
--         d1.DATE_KEY, 
         shd.facilityid, 
--shd.ORDER_TYPE,
         d1.DATE_KEY + int(7- int(d1.DAY_OF_WEEK_ID )) days, x.lawson_dept, x.LAWSON_ACCOUNT
--         x.lawson_account, shd.territory_no
--shd.WHOL_SALES_CD
;


;

--READ-ONLY GR Sales

SELECT   
--         d1.DATE_KEY as Billing_Date,
         shd.facilityid, 
         x.lawson_dept,  x.lawson_account,--shd.MRKUP_SPREAD_FLG, shd.ORDER_SOURCE, shd.ORDER_TYPE,
         decimal(SUM(case when x.lawson_account='999710' then 0 else (case when dc.REGION = 'MIDWEST' then (case when (shd.out_reason_code in ('004', '011') Or (shd.whol_sales_cd='017' And x.lawson_account='301000')) then 0 else (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') THEN 1 ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END) * (SHD.FINAL_SELL_AMT - SHD.LBL_CASE_CHRGE - SHD.FREIGHT_AMT - SHD.MRKUP_DLLRS_PER_SHIP_UNT - SHD.FUEL_CHRGE_AMT - SHD.PRICE_ADJUSTMENT - SHD.CITY_EXCISE_TAX - SHD.OTHER_EXCISE_TAX_01 - SHD.OTHER_EXCISE_TAX_02 - SHD.OTHER_EXCISE_TAX_03 - SHD.COUNTY_EXCISE_TAX - SHD.STATE_EXCISE_TAX + SHD.LEAKAGE_AMT + SHD.ITEM_LVL_MRKUP_AMT_02 ) end) else (case when (shd.out_reason_code in ('004', '011') Or (x.lawson_account='301000' and (shd.whol_saleS_CD='013' or shd.whol_saleS_CD='016'or shd.whol_saleS_CD='017' ))) then 0 else (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') THEN 1 ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END) * (SHD.FINAL_SELL_AMT - SHD.LBL_CASE_CHRGE - SHD.PRICE_ADJUSTMENT - SHD.CITY_EXCISE_TAX - SHD.OTHER_EXCISE_TAX_01 - SHD.OTHER_EXCISE_TAX_02 - SHD.OTHER_EXCISE_TAX_03 - SHD.COUNTY_EXCISE_TAX - SHD.STATE_EXCISE_TAX + SHD.LEAKAGE_AMT - (CASE WHEN SHD.MRKUP_SPREAD_FLG IN ('1', '2') THEN SHD.MRKUP_DLLRS_PER_SHIP_UNT ELSE 0 END) - (CASE WHEN SHD.MRKUP_SPREAD_FLG IN ('2') THEN SHD.FREIGHT_AMT ELSE 0 END)) end) end) end) ,14,2) as PURE_SALES_AMOUNT,
         decimal(SUM((case when shd.out_reason_code in ('004', '011') then 0 else (CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') THEN 1 ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) END) end) * (case when x.lawson_account='999710' AND SHD.ORDER_SOURCE <> 'I' Then SHD.FINAL_SELL_AMT Else SHD.MRKUP_DLLRS_PER_SHIP_UNT end) ) ,14,2)as mrkup,
         decimal(SUM(CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END),14,2) as qty,
         decimal(SUM(CASE WHEN SHD.ORDER_TYPE = 'GB' THEN SHD.QTY_ORDERED ELSE shd.QTY_ADJUSTED END),14,2) as adj_order_qty
FROM     CRMADMIN.T_WHSE_SALES_HISTORY_DTL SHD 
         inner join CRMADMIN.V_WHSE_LAWSON_ACCT x on shd.whol_sales_cd = x.whol_sales_cd and shd.territory_no=x.territory_no and shd.facilityid=x.facilityid 
         inner join CRMADMIN.t_date d1 on shd.billing_date=d1.date_key 
         inner join CRMADMIN.T_WHSE_DIV_XREF dc on dc.swat_id=shd.facilityid 
         inner join CRMADMIN.T_WHSE_DIV_USDS usds on usds.facilityid = shd.facilityid and usds.facilityid_ship = shd.facilityid_ship and usds.USDS_FLG = 'D' 
WHERE    d1.date_key between '2014-08-31' and '2014-09-06'
--WHERE    d1.date_key = '#bDate#'
AND      x.BUSINESS_SEGMENT='2'
AND      x.lawson_account in ('301000', '331000', '349500', '999710')
AND      shd.territory_no not in (29,39,46,49,58,59,69,70)
AND      SHD.RECORD_ID not in ( '8', '2')
GROUP BY 
--         d1.DATE_KEY, 
         shd.facilityid, x.lawson_dept,  x.lawson_account, --shd.MRKUP_SPREAD_FLG, shd.ORDER_SOURCE, shd.ORDER_TYPE, 
         d1.DATE_KEY + int(7- int(d1.DAY_OF_WEEK_ID )) days
;


--gr sales
case when x.lawson_account='999710' then 0 else ( -- remove the markup from sales
	case when dc.REGION = 'MIDWEST' then (
		case when (shd.out_reason_code in ('004', '011') Or (shd.whol_sales_cd='017' And x.lawson_account='301000')) --weekly service fee
			 then 0 else (CASE WHEN SHD.ORDER_TYPE = 'GB' 
                               THEN SHD.QTY_SOLD 
                               ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') --qty for extension for manual bills
                                          THEN 1 
                                          ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                                     END) 
                          END) * (SHD.FINAL_SELL_AMT - SHD.LBL_CASE_CHRGE - SHD.FREIGHT_AMT - SHD.MRKUP_DLLRS_PER_SHIP_UNT - SHD.FUEL_CHRGE_AMT - SHD.PRICE_ADJUSTMENT - SHD.CITY_EXCISE_TAX - SHD.OTHER_EXCISE_TAX_01 - SHD.OTHER_EXCISE_TAX_02 - SHD.OTHER_EXCISE_TAX_03 - SHD.COUNTY_EXCISE_TAX - SHD.STATE_EXCISE_TAX + SHD.LEAKAGE_AMT + SHD.ITEM_LVL_MRKUP_AMT_02 ) 
        end) 
             else (case when (shd.out_reason_code in ('004', '011') Or (x.lawson_account='301000' and (shd.whol_saleS_CD='013' or shd.whol_saleS_CD='016'or shd.whol_saleS_CD='017' ))) --remove frozen, dairy markup and service fees from sales
                        then 0 
                        else (CASE WHEN SHD.ORDER_TYPE = 'GB' 
                                   THEN SHD.QTY_SOLD 
                                   ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') --qty for extension for manual bills
                                              THEN 1 
                                              ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                                         END) 
                              END) * (SHD.FINAL_SELL_AMT - SHD.LBL_CASE_CHRGE - SHD.PRICE_ADJUSTMENT - SHD.CITY_EXCISE_TAX - SHD.OTHER_EXCISE_TAX_01 - SHD.OTHER_EXCISE_TAX_02 - SHD.OTHER_EXCISE_TAX_03 - SHD.COUNTY_EXCISE_TAX - SHD.STATE_EXCISE_TAX + SHD.LEAKAGE_AMT
- (CASE WHEN SHD.MRKUP_SPREAD_FLG IN ('1', '2') 
        THEN SHD.MRKUP_DLLRS_PER_SHIP_UNT 
        ELSE 0 
   END) - (CASE WHEN SHD.MRKUP_SPREAD_FLG IN ('2') 
                THEN SHD.FREIGHT_AMT 
                ELSE 0 
           END)) 
   end) 
end) 
end




--cognos
shd.FINAL_SELL_AMT -
  (shd.LBL_CASE_CHRGE +
   shd.PRICE_ADJUSTMENT +
   (shd.LEAKAGE_AMT * -1)) -  --qty for extension for manual bills
   (case when shd.ITEM_DEPT = '050'
         then 0
         else (shd.CITY_EXCISE_TAX +
               shd.COUNTY_EXCISE_TAX +
               shd.STATE_EXCISE_TAX +
               shd.OTHER_EXCISE_TAX_01 +
               shd.OTHER_EXCISE_TAX_02 +
               shd.OTHER_EXCISE_TAX_03)
    end
  ) -
  (case dc.PLATFORM_TYPE   
   when 'LEGACY'
   then (shd.FUEL_CHRGE_AMT +
         shd.FREIGHT_AMT +
         shd.MRKUP_DLLRS_PER_SHIP_UNT +
         shd.ITEM_LVL_MRKUP_AMT_02)
   when 'SWAT'
   then ((case when shd.MRKUP_SPREAD_FLG    in ('2') 
               then shd.FREIGHT_AMT  
               else 0 
          end) +
         (case when shd.MRKUP_SPREAD_FLG    in ('1', '2') 
               then shd.MRKUP_DLLRS_PER_SHIP_UNT  
               else 0 
          end))
   else 0
   end
  )

