select case when x.lawson_account = '999710' Then '301000' Else x.lawson_account end as Lawson_Account , dc.acntg_unit, d1.COMPANY_WEEK_ID,
d1.company_period_id, d1.company_year_id, 
shd.facilityid, case when (c.NAME like '%FRILL%' or c.NAME like '%NOFR%')
                     then 'NOFR'
                     when (c.NAME like '%BAG%' or c.NAME like '%BNS%') and c.NAME <> 'QUALITY TRANSP BAG'
                     then 'BNS'
                     when c.TERRITORY_NO in (21,27,31)
                     then 'CORP'
                     else 'OTHR'
                 end as CUST_TYP,
 I.ITEM_NBR_HS, I.UPC_UNIT, I.ITEM_DESCRIP, i.ITEM_ADDED_DATE,
x.lawson_dept,  (case when coalesce(i.ITEM_ADDED_DATE,'1800-01-01') between '2011-01-02' and '2011-10-08' then 'Y' Else 'N' end) as New_ITEM,
coalesce(CASE WHEN wsc.PRVT_LBL_FLG ='Y'
           THEN case when wsc.WHOL_SALES_CD in ('126','127','128','129','130','131','132','133','134')
                               then 'NBTC'
                               else 'PL'
                      end
            ELSE 'NAT'
END, 'NAT') as PRVT_LBL_FLG, case when fi.ITEM_NBR is null Then 'N' Else 'Y' end as PKR_LBL , COALESCE(CA.ATTRIB_CDE,'NEN') as PLPP_CUST,

SUM(case when x.lawson_account='999710'
         then 0
         else (case when dc.REGION = 'MIDWEST' 
                  then (case when (shd.out_reason_code in ('004', '011') Or (shd.whol_sales_cd='017' And x.lawson_account='301000')) 
                             then 0 
                             else (CASE WHEN SHD.ORDER_TYPE = 'GB'  
                                        THEN SHD.QTY_SOLD 
                                        ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') 
                                                   THEN 1 
                                                   ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                                               END) 
                                    END) * 
                                   (SHD.FINAL_SELL_AMT - 
                                    SHD.LBL_CASE_CHRGE - 
                                    SHD.FREIGHT_AMT - 
                                    SHD.MRKUP_DLLRS_PER_SHIP_UNT - 
                                    SHD.FUEL_CHRGE_AMT - 
                                    SHD.PRICE_ADJUSTMENT - 
                                    SHD.CITY_EXCISE_TAX - 
                                    SHD.OTHER_EXCISE_TAX_01 - 
                                    SHD.OTHER_EXCISE_TAX_02 - 
                                    SHD.OTHER_EXCISE_TAX_03 - 
                                    SHD.COUNTY_EXCISE_TAX - 
                                    SHD.STATE_EXCISE_TAX + 
                                    SHD.LEAKAGE_AMT + 
                                    SHD.ITEM_LVL_MRKUP_AMT_02 )
                         end) 
                  else (case when (shd.out_reason_code in ('004', '011') Or (x.lawson_account='301000' and (shd.whol_saleS_CD='013' or shd.whol_saleS_CD='016'or shd.whol_saleS_CD='017' ))) 
                             then 0 
                             else (CASE WHEN SHD.ORDER_TYPE = 'GB'  
                                        THEN SHD.QTY_SOLD 
                                        ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') 
                                                   THEN 1 
                                                   ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                                               END) 
                                    END) * 
                                  (SHD.FINAL_SELL_AMT - 
                                   SHD.LBL_CASE_CHRGE - 
                                   SHD.PRICE_ADJUSTMENT - 
                                   SHD.CITY_EXCISE_TAX - 
                                   SHD.OTHER_EXCISE_TAX_01 - 
                                   SHD.OTHER_EXCISE_TAX_02 - 
                                   SHD.OTHER_EXCISE_TAX_03 - 
                                   SHD.COUNTY_EXCISE_TAX - 
                                   SHD.STATE_EXCISE_TAX + 
                                   SHD.LEAKAGE_AMT - 
                                   (CASE WHEN SHD.MRKUP_SPREAD_FLG IN ('1', '2') 
                                         THEN SHD.MRKUP_DLLRS_PER_SHIP_UNT 
                                         ELSE 0 
                                     END) - 
                                   (CASE WHEN SHD.MRKUP_SPREAD_FLG IN ('2') 
                                         THEN SHD.FREIGHT_AMT 
                                         ELSE 0 
                                     END))
                         end) 
               end)
     end) as PURE_SALES_AMOUNT,

SUM((case when shd.out_reason_code in ('004', '011') 
          then 0 
          else (CASE WHEN SHD.ORDER_TYPE = 'GB'  
                     THEN SHD.QTY_SOLD 
                     ELSE (CASE WHEN (shd.RECORD_ID='6' or shd.no_chrge_itm_cde='*') 
                                THEN 1 
                                ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED 
                            END) 
                 END) 
      end) *  (case when x.lawson_account='999710' AND SHD.ORDER_SOURCE <> 'I'
                   Then SHD.FINAL_SELL_AMT 
                   Else SHD.MRKUP_DLLRS_PER_SHIP_UNT
               end)
   ) as mrkup,

SUM(CASE WHEN SHD.ORDER_TYPE = 'GB'  THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END)  as quantity,
SUM((CASE WHEN SHD.ORDER_TYPE = 'GB'  THEN SHD.QTY_SOLD ELSE SHD.QTY_SOLD - SHD.QTY_SCRATCHED END) * coalesce(p.PALL_CONV_FACTOR,1))  as adj_qty


    from CRMADMIN.T_WHSE_SALES_HISTORY_DTL SHD inner join
 CRMADMIN.V_WHSE_LAWSON_ACCT x 
   on shd.whol_sales_cd = x.whol_sales_cd 
   and shd.territory_no=x.territory_no
   and shd.facilityid=x.facilityid
    inner join CRMADMIN.t_date d1
  on shd.billing_date=d1.date_key

  inner join CRMADMIN.T_WHSE_DIV_XREF dc
     on dc.swat_id=shd.facilityid

  inner join CRMADMIN.T_WHSE_DIV_USDS usds
     on usds.facilityid = shd.facilityid
     and usds.facilityid_ship = shd.facilityid_ship
     and usds.USDS_FLG = 'D'

    left outer join CRMADMIN.v_whse_cust c
    on shd.facilityid=c.facilityid
    and shd.customer_no=c.customer_no
    and shd.territory_no=c.territory_no
    
left outer join CRMADMIN.T_WHSE_WSC wsc
on shd.whol_sales_cd= wsc.WHOL_SALES_CD

left outer join ETLADMIN.t_temp_FAC_ITEM FI on FI.FACILITYID = shd.FACILITYID and fi.ITEM_NBR = shd.ITEM_NBR_HS

left outer join CRMADMIN.T_MDM_CUST_ATTRIBUTE CA on CA.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND and CA.CLASS_CDE = 'PLPC' and shd.BILLING_DATE between ca.START_DATE and ca.END_DATE 

left outer join CRMADMIN.T_WHSE_ITEM I on I.FACILITYID = shd.FACILITYID and I.ITEM_NBR_HS = shd.ITEM_NBR_HS 
left outer join  ETLADMIN.T_TEMP_PALL_CONV P on P.FACILITYID = SHD.FACILITYID and P.ITEM_NBR = SHD.ITEM_NBR_HS

 where d1.date_key between '2011-01-02' and '2011-10-08'
  and x.BUSINESS_SEGMENT='2' and 
 x.lawson_account in ('301000', '321000', '331000', '333000', '333010', '345000', '345200', '345300', '345500', '349500', '353100', '999710') 
  and shd.territory_no not in (29,39,46,49,58,59,69,70)
  and SHD.RECORD_ID not in ( '8', '2')
  and shd.PRVT_LBL_FLG = 'Y'
  and substr(I.UPC_UNIT,8,5) in ('70253', '41270', '45400')

 group by  case when x.lawson_account = '999710' Then '301000' Else x.lawson_account end  , dc.acntg_unit, d1.COMPANY_WEEK_ID,
d1.company_period_id, d1.company_year_id, 
shd.facilityid, case when (c.NAME like '%FRILL%' or c.NAME like '%NOFR%')
                     then 'NOFR'
                     when (c.NAME like '%BAG%' or c.NAME like '%BNS%') and c.NAME <> 'QUALITY TRANSP BAG'
                     then 'BNS'
                     when c.TERRITORY_NO in (21,27,31)
                     then 'CORP'
                     else 'OTHR'
                 end,
I.ITEM_NBR_HS, I.UPC_UNIT, I.ITEM_DESCRIP, i.ITEM_ADDED_DATE,
x.lawson_dept,  (case when coalesce(i.ITEM_ADDED_DATE,'1800-01-01') between  '2011-01-02' and '2011-10-08' then 'Y' Else 'N' end),
coalesce(CASE WHEN wsc.PRVT_LBL_FLG ='Y'
           THEN case when wsc.WHOL_SALES_CD in ('126','127','128','129','130','131','132','133','134')
                               then 'NBTC'
                               else 'PL'
                      end
            ELSE 'NAT'
END, 'NAT'), case when fi.ITEM_NBR is null Then 'N' Else 'Y' end , COALESCE(CA.ATTRIB_CDE,'NEN')
having (case when coalesce(i.ITEM_ADDED_DATE,'1800-01-01') between  '2011-01-02' and '2011-10-08' then 'Y' Else 'N' end) = 'Y';
