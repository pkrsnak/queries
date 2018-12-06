SELECT   RUN_DATE,
         FC_ID,
         SN_CODE,
         ITEMS_PER_INNER_PACK,
         COST_AMOUNT,
         PRODUCT_TIER_ID,
         UPC,
         UPC_ALT1,
         UPC_ALT2,
         UPC_ALT3,
         UPC_ALT4,
         UPC_ALT5,
         PARENT_ASIN,
         ITEM_NBR_HS,
         ITEM_NBR_HS_AMZ,
         ITEM_NAME,
         FORECAST_OVERRIDE_FLG,
         FORECAST_WEEK,
         decrypt_char( FORECAST_AMT, 'Fe=6bNzaGb8i') forecast_amt
--         decrypt_char( FORECAST_AMT, 'Test Phrase') forecast_amt
FROM     CRMADMIN.T_WHSE_AMAZON_FORECAST
where RUN_DATE = '2018-11-03' and RUN_DATE = '2018-11-03'
;


select RUN_DATE, FORECAST_WEEK, count(*)
FROM     CRMADMIN.T_WHSE_AMAZON_FORECAST
--where RUN_DATE = '2018-11-03'
group by RUN_DATE, FORECAST_WEEK
;

Fe=6bNzaGb8i