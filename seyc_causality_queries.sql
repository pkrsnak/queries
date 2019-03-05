--west
SELECT
                RTRIM(E.EVENT_TYPE_CD) AS EVENT_TYPE_CD,
                E.EVENT_KEY,
                E.AD_EFF_DATE,
                (E.AD_EFF_DATE - (DAYOFWEEK(E.AD_EFF_DATE) - 1) DAYS) AS AD_WEEK_DATE,
                E.AD_EXPIRE_DATE,
                E.HI_PRICE_FORMAT_ID,
                E.HI_PROMO_PRICE_AMT,
                E.HI_BUY_X_QTY,
                E.HI_GET_MULT_QTY,
                RTRIM(E.HI_FRCTN_OFF_AMT) AS HI_FRCTN_OFF_AMT,
                E.HI_DOLLAR_OFF_AMT,
                E.HI_PERCENT_OFF_AMT,
                E.LO_PRICE_FORMAT_ID,
                E.LO_PROMO_PRICE_AMT,
                E.LO_BUY_X_QTY,
                E.LO_GET_MULT_QTY,
                RTRIM(E.LO_FRCTN_OFF_AMT) AS LO_FRCTN_OFF_AMT,
                E.LO_DOLLAR_OFF_AMT,
                E.LO_PERCENT_OFF_AMT,
                DRS.DEPT_SEQ_NBR,
                DRS.DEAL_REASON_ID,
                EE.EMPHASIS_LVL_SEQ,
                RTRIM(EE.EMPHASIS_LVL_DESC) AS EMPHASIS_LVL_DESC,
                RTRIM(ADTHM.AD_THEME_DESC) AS AD_THEME_DESC,
                (E.AD_EFF_DATE - (SC.OFFSET_DAYS_QTY DAYS)) AS AD_EFF_DATE_CALC,
                RTRIM(AF.AD_FEATURE_DESC) AS AD_FEATURE_DESC,
                AF.AD_FEATURE_SEQ
FROM
                PRODDB2.EVENT E
                LEFT JOIN PRODDB2.EVENT_EMPHASIS EE ON 
                                (E.EMPHASIS_LVL_CD = EE.EMPHASIS_LVL_CD)
                LEFT JOIN PRODDB2.AD_THEME ADTHM ON 
                                (E.AD_THEME_CD = ADTHM.AD_THEME_CD)
                LEFT JOIN PRODDB2.AD_FEATURE AF ON
                                (E.AD_FEATURE_CD = AF.AD_FEATURE_CD)
                INNER JOIN PRODDB2.DEAL_RSN_SEQ DRS ON
                                (E.DEAL_REASON_ID = DRS.DEAL_REASON_ID)
                INNER JOIN PRODDB2.SCHEDULE_CNTRL SC ON
                                (E.DEAL_REASON_ID = SC.DEAL_REASON_ID AND
                                E.EVENT_TYPE_CD = SC.EVENT_TYPE_CD AND
                                SC.SCHEDULE_TYPE_CD = 'PEFF' AND
                                '2016-08-28' BETWEEN SC.SCHEDULE_EFF_DT AND VALUE(SC.SCHEDULE_EXPIRE_DT, DATE('12/31/9999')))
WHERE
                E.STATUS_CD = 'PUB' AND
                E.DWNLD_RPT_PRT_FLG = 'Y'
--and e.event_key = 497332
and e.AD_EFF_DATE = '2019-03-10'
ORDER BY
                DRS.DEPT_SEQ_NBR,
                ADTHM.AD_THEME_DESC,
                EE.EMPHASIS_LVL_SEQ,
                AF.AD_FEATURE_SEQ,
                E.EVENT_KEY
;


SELECT
                E.EVENT_KEY,
                RTRIM(E.CREATE_USER_ID) AS CREATE_USER_ID,
                EI.UPC_CD AS ITEM_UPC_CD,
                RTRIM(EI.ORD_ITEM_CODE) AS ORD_ITEM_CODE,
                RTRIM(EICOST.EST_FCTRD_COST_CD) AS EST_FCTRD_COST_CD,
                EICOST.EST_FCTRD_COST_AMT,
                EICOST.ITEM_PACK_QTY,
                EICOMP.UPC_CD AS ITEM_COMP_UPC_CD,
                RTRIM(EICOMP.EST_FCTRD_COST_CD) AS EST_FCTRD_COMP_COST_CD,
                EICOMP.EST_FCTRD_COST_AMT AS EST_FCTRD_COMP_COST_AMT,
                EICOMP.ITEM_PACK_QTY AS ITEM_COMP_PACK_QTY,
                OI.OFFER_KEY,
                OI.COUPON_CNTRCT_ID AS ITEM_COUPON_CNTRCT_ID,
                RTRIM(OID.DISCOUNT_TYPE_CD) AS ITEM_DISCOUNT_TYPE_CD,
                OID.DISCOUNT_AMT AS ITEM_DISCOUNT_AMT,
                OIC.RFL_UNIT_ALLOW_AMT,
                OIC.BBK_UNIT_ALLOW_AMT,
                OIC.COUPON_CNTRCT_ID AS COMP_COUPON_CNTRCT_ID,
                RTRIM(ICD.DISCOUNT_TYPE_CD) AS COMP_DISCOUNT_TYPE_CD,
                ICD.DISCOUNT_AMT AS COMP_DISCOUNT_AMT,
                ORDI.COMMODITY_KEY,
                RTRIM(ORDI.ORDERABLE_ITEM_DSC) AS ORDERABLE_ITEM_DSC,
                ORDI.ORDERABLE_ITEM_KEY,
                ORDI.PRESELL_FLG,
                ORDRI.MF_MASTER_FLG,
                RI.RETAIL_ITEM_KEY,
                RTRIM(RI.RETAIL_ITEM_DSC) AS RETAIL_ITEM_DSC,
                RI.SIZE_MSR,
                RTRIM(RI.SIZE_UOM_CD) AS SIZE_UOM_CD,
                RI.MDSE_CLASS_KEY,
                RTRIM(IB.ITEM_BRAND_DESC) AS ITEM_BRAND_DESC,
                SMI.SLOW_MOVING_IND,
                WIL_GR.PALLET_TI_MSR AS GR_PALLET_TI_MSR,
                WIL_GR.PALLET_HI_MSR AS GR_PALLET_HI_MSR,
                WIL_PL.PALLET_TI_MSR AS PL_PALLET_TI_MSR,
                WIL_PL.PALLET_HI_MSR AS PL_PALLET_HI_MSR,
                RTRIM(SPENT.ENTERPRISE_ALT_ID) AS ENTERPRISE_ALT_ID,
                MDSEM.CATGY_MANAGER_KEY,
                MDSEC.MDSE_GRP_KEY,
                ORDI.SHIP_UNIT_CD
FROM
                PRODDB2.EVENT E
                INNER JOIN PRODDB2.EVENT_ITM EI ON
                                (E.EVENT_KEY = EI.EVENT_KEY)
                INNER JOIN PRODDB2.EVENT_ITM_COST EICOST ON
                                (EI.EVENT_ITM_KEY = EICOST.EVENT_ITM_KEY)
                LEFT JOIN PRODDB2.EVENT_ITM_CMPNT EICOMP ON
                                (EI.EVENT_ITM_KEY = EICOMP.EVENT_ITM_KEY)
                INNER JOIN PRODDB2.ORDERABLE_ITEM ORDI ON
                                (EI.ORD_ITEM_CODE = ORDI.ORD_ITEM_CODE)
                INNER JOIN PRODDB2.ORD_RETAIL_ITEM ORDRI ON 
                                (ORDI.ORDERABLE_ITEM_KEY = ORDRI.ORDERABLE_ITEM_KEY)
                INNER JOIN PRODDB2.RETAIL_ITEM RI ON 
                                (ORDRI.RETAIL_ITEM_KEY = RI.RETAIL_ITEM_KEY AND
                                ((((EI.UPC_CD = RI.UNIT_UPC_CD OR
                                EI.UPC_CD = ORDI.PSEUDO_UPC_NBR) AND
                                EICOMP.UPC_CD IS NULL) OR
                                EICOMP.UPC_CD = RI.UNIT_UPC_CD) OR 
                                ((EI.UPC_CD = RI.PLU_CD AND
                                EICOMP.UPC_CD IS NULL) OR 
                                EICOMP.UPC_CD = RI.PLU_CD)))
                LEFT JOIN PRODDB2.SPARTAN_ENTERPRISE SPENT ON
                                (ORDI.ITEM_XDOCK_FLG = 'Y' AND
                                ORDI.ENTERPRISE_KEY = SPENT.ENTERPRISE_KEY)
                LEFT JOIN PRODDB2.OFFER_EVENT OE ON
                                (E.EVENT_KEY = OE.EVENT_KEY)
                LEFT JOIN PRODDB2.OFFER O ON
                                (OE.OFFER_KEY = O.OFFER_KEY)
                LEFT JOIN PRODDB2.OFFER_ITEM OI ON
                                (OI.OFFER_KEY = O.OFFER_KEY AND
                                OI.ORD_ITEM_CODE = EI.ORD_ITEM_CODE)
                LEFT JOIN PRODDB2.OFFER_ITEM_DISC OID ON
                                (OI.OFFER_KEY = OID.OFFER_KEY AND
                                OI.OFFER_ITEM_SEQ = OID.OFFER_ITEM_SEQ)
                LEFT JOIN PRODDB2.OFFER_ITEM_CMPNT OIC ON
                                (OI.OFFER_KEY = OIC.OFFER_KEY AND
                                OI.OFFER_ITEM_SEQ = OIC.OFFER_ITEM_SEQ AND
                                EICOMP.UPC_CD = OIC.UPC_CD)
                LEFT JOIN PRODDB2.ITEM_CMPNT_DISC ICD ON
                                (OIC.OFFER_KEY = ICD.OFFER_KEY AND
                                OIC.OFFER_ITEM_SEQ = ICD.OFFER_ITEM_SEQ AND
                                OIC.CMPNT_ITEM_SEQ = ICD.CMPNT_ITEM_SEQ)
                LEFT JOIN PRODDB2.ITEM_BRAND IB ON RI.ITEM_BRAND_KEY = IB.ITEM_BRAND_KEY
                LEFT JOIN PRODDB2.SLOW_MOVING_ITEM SMI ON 
                                (ORDI.ORDERABLE_ITEM_KEY = SMI.ORDERABLE_ITEM_KEY)
                LEFT JOIN PRODDB2.WHSE_COMMODITY WC_GR ON
                                (ORDI.COMMODITY_KEY = WC_GR.COMMODITY_KEY AND
                                WC_GR.FACILITY_CODE = 1)
                LEFT JOIN PRODDB2.WHSE_ITEM_LOCATION WIL_GR ON
                                (ORDI.ORDERABLE_ITEM_KEY = WIL_GR.ORDERABLE_ITEM_KEY AND
                                WIL_GR.WHSE_COMMODITY_KEY = WC_GR.WHSE_COMMODITY_KEY AND
                                WIL_GR.WHSE_ITM_STATUS_CD <> 'DELETED')
                LEFT JOIN PRODDB2.WHSE_COMMODITY WC_PL ON
                                (ORDI.COMMODITY_KEY = WC_PL.COMMODITY_KEY AND
                                WC_PL.FACILITY_CODE = 2)
                LEFT JOIN PRODDB2.WHSE_ITEM_LOCATION WIL_PL ON
                                (ORDI.ORDERABLE_ITEM_KEY = WIL_PL.ORDERABLE_ITEM_KEY AND
                                WIL_PL.WHSE_COMMODITY_KEY = WC_PL.WHSE_COMMODITY_KEY AND
                                WIL_PL.WHSE_ITM_STATUS_CD <> 'DELETED')
                LEFT JOIN PRODDB2.MDSE_CLASS MDSECL ON RI.MDSE_CLASS_KEY = MDSECL.MDSE_CLASS_KEY
                LEFT JOIN PRODDB2.MDSE_CLASS_MANAGER MDSEM ON MDSECL.MDSE_CLASS_KEY = MDSEM.MDSE_CLASS_KEY
                LEFT JOIN PRODDB2.MDSE_CATEGORY MDSEC ON MDSECL.MDSE_CATGY_KEY = MDSEC.MDSE_CATGY_KEY
WHERE                 (ICD.OFFER_KEY IS NULL OR
                OIC.OFFER_KEY = ICD.OFFER_KEY)
AND
                (EI.SRC_OFFER_KEY = OI.OFFER_KEY OR
                ((EI.SRC_OFFER_KEY IS NULL OR EI.SRC_OFFER_KEY = 0) AND
                OI.OFFER_KEY IS NULL)) 
--and e.event_key = 497332
and e.AD_EFF_DATE = '2019-03-10'

ORDER BY 
                OI.OFFER_KEY,
                EI.UPC_CD,
                EI.ORD_ITEM_CODE,
                EICOMP.UPC_CD
FOR READ ONLY
;

--east
SELECT   DEAL.DEAL_DEPT_CD,
         DEAL.AD_START_DATE,
         DEAL.AD_WEEK_ID,
         DEAL.FACILITYID, item.AD_POSITION_DESC, DEAL.THEME_NAME, 
         trim(ITEM.ITEM_NBR)
FROM     NASHNET.DEAL DEAL 
         INNER JOIN NASHNET.DEAL_ITEM ITEM ON (DEAL.DEAL_ID=ITEM.DEAL_ID and DEAL.FACILITYID = ITEM.FACILITYID)
WHERE    AD_START_DATE = '2019-03-10' --between '2018-12-30' and '2019-12-08'
GROUP BY DEAL.DEAL_DEPT_CD, DEAL.AD_START_DATE, DEAL.AD_WEEK_ID, 
         DEAL.FACILITYID, ITEM.ITEM_NBR, item.AD_POSITION_DESC, DEAL.THEME_NAME
ORDER BY ITEM.ITEM_NBR, DEAL.FACILITYID