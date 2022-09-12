create or replace view EDW.FD.DC_SALES_HST_VW(
	TRANSACTION_DT,
	INVOICE_DT,
	DELIVERY_DT,
	FACILITY_ID,
	SHIP_FACILITY_ID,
	CUSTOMER_NBR,
	WHSE_CMDTY_ID,
	COMMODITY_CODE,
	BUYER_ID,
	VENDOR_NBR,
	ITEM_NBR,
	MDSE_CLASS_KEY,
	INVOICE_NBR,
	PRESELL_NBR,
	ORDER_TYPE_CD,
	PRICE_ZONE_TYPE_CD,
	SALES_TYPE_CD,
	ITEM_WHOLESALE_CD,
	WHOLESALE_DEPT_ID,
	GL_ACCOUNT_NBR,
	ADV_BUYING_SYS_FLG,
	PRICING_EFF_DATE,
	SPECIAL_PRICE_FLG,
	ORDERED_QTY,
	ADJUSTED_QTY,
	SUBBED_QTY,
	SHIPPED_QTY,
	UNITS_LBS_WHSE_QTY,
	OUT_OF_STOCK_QTY,
	OUT_REASON_CD,
	PRIVATE_LABEL_FLG,
	INVOICE_CNT,
	EXT_RSU_CNT,
	EXT_MOVEMENT_WT,
	CASE_COST_AMT,
	EXT_CASE_COST_AMT,
	NET_COST_AMT,
	EXT_NET_COST_AMT,
	NET_PRICE_AMT,
	EXT_NET_PRICE_AMT,
	EXT_CUST_FEE_AMT,
	EXT_WHSE_SALES_AMT,
	EXT_LOST_SALES_AMT,
	EXT_RETAIL_AMT,
	EXT_FREIGHT_AMT,
	EXT_PALT_DISC_AMT,
	EXT_REFLECT_AMT,
	EXT_PROMO_ALLW_AMT,
	EXT_FUEL_CHRGE_AMT,
	EXT_LEAKAGE_AMT,
	EXT_CASH_DISC_AMT,
	EXT_PROFIT_AMT,
	EXT_FWD_PRICE_AMT,
	EXT_FWD_COST_AMT,
	EXT_ARDA_AMT,
	EXT_ADMIN_FEE_AMT,
	EXT_PRICE_ADJ_AMT,
	EXT_EXCISE_TAX_AMT,
	EXT_CIG_TAX_AMT,
	TOTAL_SALES_AMT,
	CREDIT_REASON_CD,
	ORIGIN_ID,
	SUPPLY_FLAG,
	DEPT_KEY,
	DEPT_GRP_KEY,
	CUSTOMER_HST_ID,
	ITEM_HST_ID,
	VENDOR_HST_ID,
	CORPORATION_ID,
	EXT_ORIG_SALES_AMT,
	UPC_UNIT,
	CREATE_TMSP,
	UPDT_TMSP,
	MDM_SITE_ID,
	SHIP_TO_HS_NBR,
	SHIP_REJECT_CD,
	CUBE_VAL,
	ALLOWANCE_CHRG_CD,
	SALES_HST_TYPE_CD,
	MDV_FDS_FLG,
	ITEM_KEY,
	CUSTOMER_KEY,
	VENDOR_KEY,
	WHOLESALE_DEPT_FK,
	SALES_REC_FLG,
	MILITARY_SALES_FLG,
	CREDIT_REASON_ID,
	OUT_REASON_ID,
	SALES_TYPE_ID,
	SHIP_REJECT_ID,
	FACILITY_SEGMT_ID,
	FISCAL_WEEK_END_DT
) as (
  (
    SELECT
      CASE WHEN S.transaction_dt < Cast(S.create_tmsp AS DATE)
      AND Dayname(
        Cast(S.create_tmsp AS DATE)
      ) = 'Mon'
      AND Dayname(S.transaction_dt) = 'Sun'
      AND Dateadd(
        'dd',
        -1,
        Cast(S.create_tmsp AS DATE)
      ) = S.transaction_dt THEN S.transaction_dt WHEN S.transaction_dt < Cast(S.create_tmsp AS DATE)
      AND Dayname(
        Cast(S.create_tmsp AS DATE)
      ) = 'Mon'
      AND Dayname(S.transaction_dt) = 'Sun'
      AND Dateadd(
        'dd',
        -1,
        Cast(S.create_tmsp AS DATE)
      ) <> S.transaction_dt THEN Cast(S.create_tmsp AS DATE) WHEN S.transaction_dt < Cast(S.create_tmsp AS DATE)
      AND Dayname(
        Cast(S.create_tmsp AS DATE)
      ) = 'Sat' THEN Dateadd(
        'dd',
        -1,
        Cast(S.create_tmsp AS DATE)
      ) WHEN S.transaction_dt < Cast(S.create_tmsp AS DATE) THEN Cast(S.create_tmsp AS DATE) ELSE S.transaction_dt END AS TRANSACTION_DT,
      s.invoice_dt AS INVOICE_DT,
      s.delivery_dt AS DELIVERY_DT,
      s.facility_id AS FACILITY_ID,
      s.facility_id AS SHIP_FACILITY_ID,
      Cast(
        s.customer_nbr AS NUMERIC(38, 0)
      ) AS CUSTOMER_NBR,
      s.whse_commodity_id AS WHSE_CMDTY_ID,
      s.commodity_id AS COMMODITY_CODE,
      d.buyer_nbr AS BUYER_ID,
      cast(
        Iff(
          a.item_nbr = 0
          OR a.item_nbr IS NULL
          OR Trim(a.item_nbr) = '',
          -99999,
          s.pops_vendor_nbr
        ) AS NUMERIC(38, 0)
      ) AS VENDOR_NBR,
     cast(
        CASE WHEN (
          a.item_nbr = 0
          OR a.item_nbr IS NULL
        ) THEN (
          CASE WHEN (
            cc.dept_key = 0
            OR cc.dept_key IS NULL
          ) THEN -999910 ELSE Cast('-9999' || cc.dept_key AS INT) END
        ) ELSE a.item_nbr END as number(38,0)
      ) AS ITEM_NBR,
      --CASE WHEN c.MERCH_CLASS IS NULL OR TRIM(c.MERCH_CLASS)='' THEN s.ITEM_SUBCLASS_ID ELSE CAST(c.MERCH_CLASS AS INT) END as MDSE_CLASS_KEY,
      CASE WHEN (
        c.merch_class IS NULL
        OR Trim(c.merch_class) = ''
      )
      AND (
        a.item_nbr = 0
        OR a.item_nbr IS NULL
      ) THEN (
        CASE WHEN (
          cc.dept_key = 0
          OR cc.dept_key IS NULL
        ) THEN -9910 ELSE Cast('-99' || cc.dept_key AS INT) END
      ) ELSE Cast(c.merch_class AS INT) END AS MDSE_CLASS_KEY,
      s.invoice_nbr AS INVOICE_NBR,
      0 AS PRESELL_NBR,
      'CR' AS ORDER_TYPE_CD,
      'P' AS PRICE_ZONE_TYPE_CD,
      Cast(
        1 AS NUMERIC(38, 0)
      ) AS SALES_TYPE_CD,
      'N A' AS ITEM_WHOLESALE_CD,
      0 AS WHOLESALE_DEPT_ID,
      NULL AS GL_ACCOUNT_NBR,
      'N' AS ADV_BUYING_SYS_FLG,
      NULL AS PRICING_EFF_DATE,
      '' AS SPECIAL_PRICE_FLG,
      credit_charge_qty AS ORDERED_QTY,
      0 AS ADJUSTED_QTY,
      0 AS SUBBED_QTY,
      credit_charge_qty AS SHIPPED_QTY,
      CASE WHEN c.rand_wgt_cd IS NULL
      OR Trim(c.rand_wgt_cd) = '' THEN s.ext_credit_rsu_cnt ELSE s.ext_credit_mvmt_wt END AS UNITS_LBS_WHSE_QTY,
      0 AS OUT_OF_STOCK_QTY,
      '' AS OUT_REASON_CD,
      Iff(
        i.private_label_key IS NULL, 'N', 'Y'
      ) AS PRIVATE_LABEL_FLG,
      0 AS INVOICE_CNT,
      s.ext_credit_rsu_cnt AS EXT_RSU_CNT,
      s.ext_credit_mvmt_wt AS EXT_MOVEMENT_WT,
      s.case_cost_amt,
      s.case_cost_amt AS EXT_CASE_COST_AMT,
      net_cost_amt,
      net_cost_amt AS EXT_NET_COST_AMT,
      net_price_amt,
      net_price_amt AS EXT_NET_PRICE_AMT,
      0 AS EXT_CUST_FEE_AMT,
      ext_credit_chg_amt AS EXT_WHSE_SALES_AMT,
      0 AS EXT_LOST_SALES_AMT,
      ext_retail_amt,
      ext_credit_frg_amt AS EXT_FREIGHT_AMT,
      0 AS EXT_PALT_DISC_AMT,
      0 AS EXT_REFLECT_AMT,
      0 AS EXT_PROMO_ALLW_AMT,
      0 AS EXT_FUEL_CHRGE_AMT,
      0 AS EXT_LEAKAGE_AMT,
      0 AS EXT_CASH_DISC_AMT,
      0 AS EXT_PROFIT_AMT,
      0 AS EXT_FWD_PRICE_AMT,
      0 AS EXT_FWD_COST_AMT,
      0 AS EXT_ARDA_AMT,
      0 AS EXT_ADMIN_FEE_AMT,
      0 AS EXT_PRICE_ADJ_AMT,
      0 AS EXT_EXCISE_TAX_AMT,
      0 AS EXT_CIG_TAX_AMT,
      ext_credit_chg_amt AS TOTAL_SALES_AMT,
      cc.credit_rsn_cd AS CREDIT_REASON_CD,
      'GR-CREDIT' AS ORIGIN_ID,
      CASE WHEN c.item_dept_override = '040' THEN 'Y' WHEN c.supply_flag = 'Y' THEN 'Y' ELSE 'N' END AS SUPPLY_FLG,
      CASE WHEN (
        a.item_nbr = 0
        OR a.item_nbr IS NULL
      ) THEN (
        CASE WHEN (
          cc.dept_key = 0
          OR cc.dept_key IS NULL
        ) THEN 10 ELSE Cast(cc.dept_key AS INT) END
      ) ELSE Cast(m.dept_key AS INT) END AS DEPT_KEY,
      o.dept_grp_key,
      s.customer_hst_id,
      s.item_hst_id,
      s.vendor_hst_id,
      j.cust_corporation_mdm AS CORPORATION_ID,
      Cast(
        0 AS NUMERIC(13, 4)
      ) AS EXT_ORIG_SALES_AMT,
      i.upc_unit AS UPC_UNIT,
      s.create_tmsp,
      s.updt_tmsp,
      s.facility_id  AS MDM_SITE_ID, -- review
      TRY_TO_NUMBER(s.customer_nbr) AS SHIP_TO_HS_NBR,
      CAST('0' AS VARCHAR(10)) AS SHIP_REJECT_CD,
      0 AS CUBE_VAL,
      '' AS ALLOWANCE_CHRG_CD,
      'ACT' AS SALES_HST_TYPE_CD,
      'N' AS MDV_FDS_FLG,
      Cast(
          CASE WHEN (
              a.item_nbr = 0
              OR a.item_nbr IS NULL
            ) THEN (
              CASE WHEN (
                cc.dept_key = 0
                OR cc.dept_key IS NULL
              )
              THEN TO_NUMBER(CONCAT(s.facility_id || 999910)) * -1
              ELSE  TO_NUMBER(CONCAT(s.facility_id || ABS(Cast('9999' || cc.dept_key AS INT)))) * -1  END
            )
            ELSE TO_NUMBER(CONCAT(s.facility_id || LPAD(a.item_nbr,10,'0'))) END AS NUMERIC(38, 0)
       ) AS ITEM_KEY ,

      CAST( CASE WHEN CUSTOMER_NBR<0 THEN TO_NUMBER(CONCAT(s.facility_id || LPAD(CUSTOMER_NBR,6,'0'))) * -1
      ELSE TO_NUMBER(CONCAT(s.facility_id || LPAD(CUSTOMER_NBR,10,'0')))
      END AS NUMERIC(38, 0))  AS CUSTOMER_KEY,

        Cast(
        Iff(
          a.item_nbr = 0
          OR a.item_nbr IS NULL
          OR Trim(a.item_nbr) = '',
          TO_NUMBER(CONCAT(s.facility_id || 99999)) * -1,
          TO_NUMBER(CONCAT(s.facility_id || lpad(s.pops_vendor_nbr,6,'0')))
        ) AS NUMERIC(38, 0)
      ) AS VENDOR_KEY,
      CASE WHEN xf.WHOLESALE_DEPT_PK IS NULL THEN -99 ELSE xf.WHOLESALE_DEPT_PK END AS WHOLESALE_DEPT_FK,
      CASE WHEN J.TERRITORY_NO=29 THEN 'N' ELSE 'Y' END SALES_REC_FLG,
      CASE WHEN J.MEMBERSHIP_CODE=11 THEN 'Y' ELSE 'N' END MILITARY_SALES_FLG,
      CASE WHEN cxf.CREDIT_REASON_PK IS NULL THEN -99 ELSE cxf.CREDIT_REASON_PK END AS CREDIT_REASON_ID,
      -99 AS OUT_REASON_ID,
      stxf.SALES_TYPE_PK AS SALES_TYPE_ID,
      srxf.SHIP_REJECT_PK AS SHIP_REJECT_ID,
      fseg.FACILITY_SEGMT_PK AS FACILITY_SEGMT_ID,
	  dt.FISCAL_WEEK_END_DT
    FROM
      grb_credit_fact s
	  inner join MDM.date_dim dt on CASE WHEN S.transaction_dt < Cast(S.create_tmsp AS DATE) AND Dayname(Cast(S.create_tmsp AS DATE)) = 'Mon' AND Dayname(S.transaction_dt) = 'Sun' AND Dateadd('dd',-1,Cast(S.create_tmsp AS DATE)) 
									= S.transaction_dt THEN S.transaction_dt WHEN S.transaction_dt < Cast(S.create_tmsp AS DATE) AND Dayname(Cast(S.create_tmsp AS DATE)) = 'Mon' AND Dayname(S.transaction_dt) = 'Sun' 
									AND Dateadd('dd',-1,Cast(S.create_tmsp AS DATE)) <> S.transaction_dt THEN Cast(S.create_tmsp AS DATE) WHEN S.transaction_dt < Cast(S.create_tmsp AS DATE) AND Dayname(Cast(S.create_tmsp AS DATE)) = 'Sat' 
									THEN Dateadd('dd',-1,Cast(S.create_tmsp AS DATE)) WHEN S.transaction_dt < Cast(S.create_tmsp AS DATE) THEN Cast(S.create_tmsp AS DATE) ELSE S.transaction_dt END = dt.FULL_DATE
      left join RTL.sales_type stxf on 1=1 and stxf.sales_type_cd=1  AND stxf.ORIGIN<>'MDV'
      left join ship_reject srxf on s.facility_id=srxf.facility_id and srxf.ship_reject_cd='0'
      left join RTL.credit_codes cc ON s.credit_rsn_id = cc.credit_rsn_pk
      left join item_hst a ON a.item_hst_pk = s.item_hst_id
      left join item_sales_dim c ON c.item_sales_pk = a.item_sales_id
      left join MDM.item_dim i ON i.item_pk = a.item_mdm_id
      left join item_procr_dim d ON d.item_procr_pk = a.item_procr_id
      left join customer_hst ch ON ch.customer_hst = s.customer_hst_id
      left join customer_dim j ON j.customer_pk = ch.customer_mdm_id
      left join MDM.mdse_class k ON k.mdse_class_key = CASE WHEN c.merch_class IS NULL
      OR Trim(c.merch_class) = '' THEN 0 ELSE Cast(c.merch_class AS INT) END
      left join MDM.mdse_category l ON k.mdse_catgy_key = l.mdse_catgy_key
      left join MDM.mdse_group m ON l.mdse_grp_key = m.mdse_grp_key --left JOIN MDM.DEPARTMENT n ON m.DEPT_KEY=n.DEPT_KEY
      left join MDM.department n ON CASE WHEN (
        a.item_nbr = 0
        OR a.item_nbr IS NULL
      ) THEN (
        CASE WHEN (
          cc.dept_key = 0
          OR cc.dept_key IS NULL
        ) THEN 10 ELSE Cast(cc.dept_key AS INT) END
      ) ELSE Cast(m.dept_key AS INT) END = n.dept_key
      left join MDM.department_group o ON n.dept_grp_key = o.dept_grp_key
      left join MDM.WHOLESALE_DEPT xf ON s.facility_id=xf.FACILITY_ID and s.commodity_id=xf.WHOLESALE_DEPT_ID and xf.ORIGIN='GR'
	  left join credit_reason_code_dim cxf on s.facility_id=cxf.facility_id and cxf.credit_reason_cd=cc.credit_rsn_cd
      left join MDM.FACILITY_SEGMENT fseg on s.facility_id=fseg.facility_id AND fseg.ORIGIN<>'MDV'
  )
  UNION ALL
    (
      SELECT
        g.TRANSACTION_DATE,
        g.INVOICE_DATE,
        g.DELIVERY_DATE,
        g.facility_id AS FACILITY_ID,
        g.ship_facility_id AS SHIP_FACILITY_ID,
        g.customer_nbr,
        g.whse_cmdty_id,
        g.COMMODITY_CODE,
        b.buyer_id,
        g.vendor_nbr,

          cast(a.item_nbr as number(38,0))  AS ITEM_NBR,

        CASE WHEN c.merch_class IS NULL
        OR Trim(c.merch_class) = '' THEN NULL ELSE Cast(c.merch_class AS INT) END AS MDSE_CLASS_KEY,
        g.invoice_nbr,
        g.presell_nbr,
        g.order_type_cd,
        g.price_zone_type_cd,
        g.sales_type_cd,
        g.item_wholesale_cd,
        g.wholesale_dept_id,
        g.gl_account_nbr,
        g.adv_buying_sys_flg,
        g.PRICING_EFF_DATE,
        g.special_price_flg,
        g.ordered_qty,
        g.adjusted_qty,
        g.subbed_qty,
        g.shipped_qty,
        g.units_lbs_whse_qty,
        g.out_of_stock_qty,
        g.out_reason_cd,
        g.private_label_flg,
        g.invoice_cnt,
        g.ext_rsu_cnt,
        g.ext_movement_wt,
        g.case_cost_amt,
        g.ext_case_cost_amt,
        g.net_cost_amt,
        g.ext_net_cost_amt,
        g.net_price_amt,
        g.ext_net_price_amt,
        g.ext_cust_fee_amt,
        g.ext_whse_sales_amt,
        g.ext_lost_sales_amt,
        g.ext_retail_amt,
        g.ext_freight_amt,
        g.ext_palt_disc_amt,
        g.ext_reflect_amt,
        g.ext_promo_allw_amt,
        g.ext_fuel_chrge_amt,
        g.ext_leakage_amt,
        g.ext_cash_disc_amt,
        g.ext_profit_amt,
        g.ext_fwd_price_amt,
        g.ext_fwd_cost_amt,
        g.ext_arda_amt,
        g.ext_admin_fee_amt,
        g.ext_price_adj_amt,
        g.ext_excise_tax_amt,
        g.ext_cig_tax_amt,
        g.total_sales_amt,
        g.credit_reason_cd,
        g.origin_id,
        CASE WHEN c.item_dept_override = '040' THEN 'Y' WHEN c.supply_flag = 'Y' THEN 'Y' ELSE 'N' END AS SUPPLY_FLG,
        n.dept_key,
        o.dept_grp_key,
        g.customer_hst_id,
        g.item_hst_id,
        g.vendor_hst_id,
        j.cust_corporation_mdm AS CORPORATION_ID,
        g.ext_orig_sales_amt,
        i.upc_unit AS UPC_UNIT,
        g.create_tmsp,
        g.updt_tmsp,
        g.facility_id AS MDM_SITE_ID, -- to review
        TRY_TO_NUMBER(g.customer_nbr) AS SHIP_TO_HS_NBR,
        CAST('0' AS VARCHAR(10)) AS SHIP_REJECT_CD,
        0 AS CUBE_VAL,
        '' AS ALLOWANCE_CHRG_CD,
        'ACT' AS SALES_HST_TYPE_CD,
        'N' AS MDV_FDS_FLG,
        CAST( CASE WHEN a.item_nbr<0 THEN TO_NUMBER(CONCAT(g.facility_id || ABS(a.item_nbr))) * -1
        ELSE TO_NUMBER(CONCAT(g.facility_id || LPAD(a.item_nbr,10,'0')))
        END AS NUMERIC(38, 0))  AS ITEM_KEY,
        CAST( CASE WHEN g.customer_nbr<0 THEN TO_NUMBER(CONCAT(g.facility_id || ABS(g.customer_nbr))) * -1
        ELSE TO_NUMBER(CONCAT(g.facility_id || LPAD(g.customer_nbr,10,'0')))
        END AS NUMERIC(38, 0))  AS CUSTOMER_KEY,
        CAST( CASE WHEN g.vendor_nbr<0 THEN TO_NUMBER(CONCAT(g.facility_id || ABS(g.vendor_nbr))) * -1
        ELSE TO_NUMBER(CONCAT(g.facility_id || LPAD(g.vendor_nbr,6,'0')))
        END AS NUMERIC(38, 0))  AS VENDOR_KEY,
        CASE WHEN xf.WHOLESALE_DEPT_PK IS NULL THEN -99 ELSE xf.WHOLESALE_DEPT_PK END AS WHOLESALE_DEPT_FK,
        CASE WHEN J.TERRITORY_NO =29 THEN 'N' ELSE 'Y' END SALES_REC_FLG,
        CASE WHEN J.MEMBERSHIP_CODE=11 THEN 'Y' ELSE 'N' END MILITARY_SALES_FLG,
        -99 AS CREDIT_REASON_ID,
        case when sxf.SHIP_ERROR_PK IS NULL THEN -99 ELSE sxf.SHIP_ERROR_PK END AS OUT_REASON_ID,
        g.sales_type_cd as sales_type_id,
        srxf.ship_reject_pk as SHIP_REJECT_ID,
        fseg.FACILITY_SEGMT_PK AS FACILITY_SEGMT_ID,
		dt.FISCAL_WEEK_END_DT
      FROM
        grb_sales_fact_mv g
		inner join MDM.date_dim dt on g.TRANSACTION_DATE=dt.full_date
        left join RTL.sales_type stxf on stxf.sales_type_cd=g.sales_type_cd  AND stxf.ORIGIN<>'MDV'
        left join ship_reject srxf on g.facility_id=srxf.facility_id and srxf.ship_reject_cd='0'
        inner join item_hst a ON a.item_hst_pk = g.item_hst_id
        inner join MDM.item_dim i ON i.item_pk = a.item_mdm_id
        left join RTL.buyer b ON b.buyer_pk = g.buyer_id
        inner join item_sales_dim c ON c.item_sales_pk = a.item_sales_id
        inner join customer_hst ch ON ch.customer_hst = g.customer_hst_id
        inner join customer_dim j ON j.customer_pk = ch.customer_mdm_id
        inner join MDM.mdse_class k ON k.mdse_class_key = CASE WHEN c.merch_class IS NULL
        OR Trim(c.merch_class) = '' THEN 0 ELSE Cast(c.merch_class AS INT) END
        inner join MDM.mdse_category l ON k.mdse_catgy_key = l.mdse_catgy_key
        inner join MDM.mdse_group m ON l.mdse_grp_key = m.mdse_grp_key
        inner join MDM.department n ON m.dept_key = n.dept_key
        inner join MDM.department_group o ON n.dept_grp_key = o.dept_grp_key
        left join MDM.WHOLESALE_DEPT xf ON g.facility_id=xf.FACILITY_ID and g.COMMODITY_CODE=xf.WHOLESALE_DEPT_ID and xf.ORIGIN='GR'
        left join MDM.FACILITY_SEGMENT fseg on g.facility_id=fseg.facility_id and fseg.ORIGIN<>'MDV'
		left join ship_error sxf on g.facility_id=sxf.facility_id and sxf.ship_error_cd=g.out_reason_cd
    )
  UNION ALL
    (
      SELECT
        a.billing_date AS TRANSACTION_DT,
        a.billing_date AS INVOICE_DT,
        A.DELIVERY_DATE,
        a.facility_pk AS FACILITY_ID,
        Cast(a.facilityid_ship AS INT) AS SHIP_FACILITY_ID,
        Cast(
          a.customer_nbr AS NUMERIC(38, 0)
        ) AS CUSTOMER_NBR,
        Cast(b.warehouse_code AS INT) AS WHSE_CMDTY_ID,
        CASE WHEN a.fuel_data_flg = 'Y'
        OR a.freight_data_flg = 'Y' THEN 1 ELSE a.commodity_id END AS COMMODITY_CODE,
        c.buyer_nbr AS BUYER_ID,
        Cast(
          Iff (
            a.vendor_nbr IS NULL, -99999, a.vendor_nbr
          ) AS NUMERIC(38, 0)
        ) AS VENDOR_NBR,
        Cast(
          CASE WHEN a.item_hst_id IS NULL THEN -999999 WHEN a.fuel_data_flg = 'Y'
          AND a.facility_pk NOT IN (2, 3, 5, 8, 40, 54, 87) THEN -1 * Cast(
            Substr(a.item_nbr, 2, 5) AS INT
          ) WHEN a.fuel_data_flg = 'Y'
          AND a.facility_pk IN (2, 3, 5, 8, 40, 54, 87) THEN -1 * Cast(
            Substr(i.item_nbr_hs, 2, 6) AS INT
          ) WHEN a.facility_pk NOT IN (2, 3, 5, 8, 40, 54, 87)
          AND a.item_hst_id IS NOT NULL THEN a.item_nbr WHEN a.facility_pk IN (2, 3, 5, 8, 40, 54, 87)
          AND a.item_hst_id IS NOT NULL THEN i.item_nbr_hs ELSE Cast(a.item_nbr AS INT) END AS NUMERIC(38, 0)
        ) AS ITEM_NBR,
        CASE WHEN (a.fuel_data_flg = 'Y') THEN -9999 WHEN a.item_hst_id IS NULL THEN -9999 WHEN b.merch_class IS NULL
        /*OR TRIM(b.MERCH_CLASS)=''*/
        THEN -9999 WHEN b.merch_class = '     ' THEN 0 ELSE Cast(b.merch_class AS INT) END AS MDSE_CLASS_KEY,
        a.invoice_nbr,
        a.booking_nbr AS PRESELL_NBR,
        Cast(
          a.order_type AS VARCHAR(20)
        ) AS ORDER_TYPE_CD,
        Iff (
          a.retail_zone = 0,
          'M',
          Iff(
            a.retail_zone >= 1
            AND a.retail_zone <= 5,
            'H',
            'P'
          )
        ) AS PRICE_ZONE_TYPE_CD,
        Cast(
          CASE WHEN (
            a.standard_items_flg = 'Y'
            OR a.non_standard_inv_flg = 'Y'
            OR a.non_standard_inv_mkup_flg = 'Y'
            OR a.non_standard_inv_mkup_gal_flg = 'Y'
            OR a.arda_lines_flg = 'Y'
          )
          AND Cast(a.item_wholesale_id AS INT) <> 28 THEN '1' WHEN (
            a.standard_items_flg = 'Y'
            OR a.non_standard_inv_flg = 'Y'
            OR a.non_standard_inv_mkup_flg = 'Y'
            OR a.non_standard_inv_mkup_gal_flg = 'Y'
            OR a.arda_lines_flg = 'Y'
          )
          AND Cast(a.item_wholesale_id AS INT) = 28 THEN '2' WHEN (
            a.freight_data_flg = 'Y'
            OR a.fuel_data_flg = 'Y'
          ) THEN '1' WHEN upstream_prft_data_flg = 'Y' THEN '3' ELSE '0' END AS NUMERIC(38, 0)
        ) AS SALES_TYPE_CD,
        Cast(
          CASE WHEN a.fuel_data_flg = 'Y'
          OR a.freight_data_flg = 'Y' THEN '015' ELSE Lpad(a.item_wholesale_id, 3, '0') END AS VARCHAR(20)
        ) AS ITEM_WHOLESALE_CD,
        CASE WHEN (
          a.record_id = '6'
          AND Trim(a.item_dept) = ''
        ) THEN NULL WHEN (
          a.freight_data_flg = 'Y'
          OR a.fuel_data_flg = 'Y'
        ) THEN 10 ELSE Cast(a.item_dept AS INT) END AS WHOLESALE_DEPT_ID,
        Cast(
          d.psfs_gl_account AS VARCHAR(20)
        ) AS GL_ACCOUNT_NBR,
        '' AS ADV_BUYING_SYS_FLG,
        NULL AS PRICING_EFF_DATE,
        '' AS SPECIAL_PRICE_FLG,
        CASE WHEN a.upstream_prft_data_flg = 'Y' THEN 0 ELSE a.qty_ordered END AS ORDERED_QTY,
        CASE WHEN a.upstream_prft_data_flg = 'Y' THEN 0 ELSE a.qty_adjusted END AS ADJUSTED_QTY,
        CASE WHEN a.upstream_prft_data_flg = 'Y' THEN 0 ELSE a.qty_subbed END AS SUBBED_QTY,
        CASE WHEN (
          a.standard_items_flg = 'Y'
          OR a.non_standard_inv_flg = 'Y'
        ) THEN (a.qty_sold - a.qty_scratched) ELSE 0 END AS SHIPPED_QTY,
        Round(
          Iff(
            a.random_wgt_flg = 'R',
            a.random_wgt,
            (
              (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR a.non_standard_inv_flg = 'Y'
                ) THEN (a.qty_sold - a.qty_scratched) ELSE 0 END
              ) * a.store_pack
            )
          ),
          2
        ) AS UNITS_LBS_WHSE_QTY,
        CASE WHEN a.upstream_prft_data_flg = 'Y' THEN 0 ELSE a.qty_scratched END AS OUT_OF_STOCK_QTY,
        a.out_reason_code,
        f.prvt_lbl_flg AS PRIVATE_LABEL_FLG,
        a.invoice_counter AS INVOICE_CNT,
        Round(
          (
            a.store_pack * (
              CASE WHEN (
                a.standard_items_flg = 'Y'
                OR upstream_prft_data_flg = 'Y'
              ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
            )
          ),
          2
        ) AS EXT_RSU_CNT,
        Round(a.ship_case_wgt, 2) AS EXT_MOVEMENT_WT,
        CASE WHEN a.upstream_prft_data_flg = 'Y' THEN 0 WHEN (
          CASE WHEN (
            a.standard_items_flg = 'Y'
            OR upstream_prft_data_flg = 'Y'
          ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
        ) = 0 THEN 0 ELSE (
          CASE WHEN a.fuel_data_flg = 'Y'
          OR a.freight_data_flg = 'Y' THEN 0 ELSE a.layer_ext_cost END
        ) / (
          CASE WHEN (
            a.standard_items_flg = 'Y'
            OR upstream_prft_data_flg = 'Y'
          ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
        ) END AS CASE_COST_AMT,
        Iff(
          a.upstream_prft_data_flg = 'Y',
          0,
          Round(
            CASE WHEN a.fuel_data_flg = 'Y'
            OR a.freight_data_flg = 'Y' THEN 0 ELSE a.layer_ext_cost END,
            2
          )
        ) AS EXT_CASE_COST_AMT,
        Iff(
          a.upstream_prft_data_flg = 'Y',
          0,
          Round(
            (
              CASE WHEN a.fuel_data_flg = 'Y'
              OR a.freight_data_flg = 'Y' THEN 0 ELSE a.layer_ext_cost END / Iff(
                (
                  CASE WHEN (
                    a.standard_items_flg = 'Y'
                    OR upstream_prft_data_flg = 'Y'
                  ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
                ) = 0,
                1,
                (
                  CASE WHEN (
                    a.standard_items_flg = 'Y'
                    OR upstream_prft_data_flg = 'Y'
                  ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
                )
              )
            ),
            2
          )
        ) AS NET_COST_AMT,
        Iff(
          a.upstream_prft_data_flg = 'Y',
          0,
          Round(
            CASE WHEN a.fuel_data_flg = 'Y'
            OR a.freight_data_flg = 'Y' THEN 0 ELSE a.layer_ext_cost END,
            2
          )
        ) AS EXT_NET_COST_AMT,
        Iff(
          a.upstream_prft_data_flg = 'Y',
          0,
          Round(
            (
              CASE WHEN (
                a.standard_items_flg = 'Y'
                OR a.upstream_prft_data_flg = 'Y'
              ) THEN (
                a.final_sell_amt - (
                  CASE WHEN a.admin_alloc_flg = 'Y' THEN 0 ELSE a.lbl_case_chrge END
                ) - a.price_adjustment - a.city_excise_tax - a.other_excise_tax_01 - a.other_excise_tax_02 - a.other_excise_tax_03 - a.county_excise_tax - a.state_excise_tax + (
                  CASE WHEN e.platform_type = 'LEGACY' THEN a.leakage_amt ELSE a.leaker_amt_calc END
                ) + a.item_lvl_mrkup_amt_02 - (
                  CASE WHEN e.platform_type = 'LEGACY' THEN a.freight_amt + a.mrkup_dllrs_per_ship_unt ELSE (
                    CASE WHEN a.mrkup_spread_flg IN ('1', '2') THEN a.mrkup_dllrs_per_ship_unt ELSE 0 END
                  ) - (
                    CASE WHEN a.mrkup_spread_flg IN ('2') THEN a.freight_amt ELSE 0 END
                  ) END
                )
              ) WHEN a.non_standard_inv_flg = 'Y' THEN a.final_sell_amt ELSE 0 END
            ),
            2
          )
        ) AS NET_PRICE_AMT,
        Iff(
          a.upstream_prft_data_flg = 'Y',
          0,
          Round(
            (
              (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR a.upstream_prft_data_flg = 'Y'
                ) THEN (
                  a.final_sell_amt - (
                    CASE WHEN a.admin_alloc_flg = 'Y' THEN 0 ELSE a.lbl_case_chrge END
                  ) - a.price_adjustment - a.city_excise_tax - a.other_excise_tax_01 - a.other_excise_tax_02 - a.other_excise_tax_03 - a.county_excise_tax - a.state_excise_tax + (
                    CASE WHEN e.platform_type = 'LEGACY' THEN a.leakage_amt ELSE a.leaker_amt_calc END
                  ) + a.item_lvl_mrkup_amt_02 - (
                    CASE WHEN e.platform_type = 'LEGACY' THEN a.freight_amt + a.mrkup_dllrs_per_ship_unt ELSE (
                      CASE WHEN a.mrkup_spread_flg IN ('1', '2') THEN a.mrkup_dllrs_per_ship_unt ELSE 0 END
                    ) - (
                      CASE WHEN a.mrkup_spread_flg IN ('2') THEN a.freight_amt ELSE 0 END
                    ) END
                  )
                ) WHEN a.non_standard_inv_flg = 'Y' THEN a.final_sell_amt ELSE 0 END
              ) * (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR upstream_prft_data_flg = 'Y'
                ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
              )
            ),
            2
          )
        ) AS EXT_NET_PRICE_AMT,
        Round(
          (
            CASE WHEN a.non_standard_inv_mkup_flg = 'Y'
            OR a.non_standard_inv_mkup_gal_flg = 'Y' THEN a.final_sell_amt WHEN a.standard_items_flg = 'Y' THEN (
              a.mrkup_dllrs_per_ship_unt * (a.qty_sold - a.qty_scratched)
            ) ELSE 0 END
          ),
          2
        ) AS EXT_CUST_FEE_AMT,
        CASE WHEN a.upstream_prft_data_flg = 'Y' THEN 0 WHEN (
          a.non_standard_inv_mkup_flg = 'Y'
          OR arda_lines_flg = 'Y'
          OR a.non_standard_inv_mkup_gal_flg = 'Y'
        ) THEN Round(a.final_sell_amt, 2) ELSE Round(
          (
            (
              (
                CASE WHEN a.non_standard_inv_flg = 'Y' THEN a.final_sell_amt WHEN (
                  a.standard_items_flg = 'Y'
                  OR a.upstream_prft_data_flg = 'Y'
                ) THEN (
                  a.final_sell_amt - (
                    CASE WHEN a.admin_alloc_flg = 'Y' THEN 0 ELSE a.lbl_case_chrge END
                  ) - a.price_adjustment - a.city_excise_tax - a.other_excise_tax_01 - a.other_excise_tax_02 - a.other_excise_tax_03 - a.county_excise_tax - a.state_excise_tax + (
                    CASE WHEN e.platform_type = 'LEGACY' THEN a.leakage_amt ELSE a.leaker_amt_calc END
                  ) + a.item_lvl_mrkup_amt_02 - (
                    CASE WHEN e.platform_type = 'LEGACY' THEN a.freight_amt + a.mrkup_dllrs_per_ship_unt ELSE (
                      CASE WHEN a.mrkup_spread_flg IN ('1', '2') THEN a.mrkup_dllrs_per_ship_unt ELSE 0 END
                    ) - (
                      CASE WHEN a.mrkup_spread_flg IN ('2') THEN a.freight_amt ELSE 0 END
                    ) END
                  )
                ) ELSE 0 END
              ) + (
                CASE WHEN a.standard_items_flg = 'Y' THEN a.mrkup_dllrs_per_ship_unt WHEN (
                  a.non_standard_inv_mkup_flg = 'Y'
                  OR a.non_standard_inv_mkup_flg = 'Y'
                ) THEN a.final_sell_amt ELSE 0 END
              ) + (
                CASE WHEN d.psfs_lawson_dept = '40'
                AND (
                  arda_lines_flg = 'Y'
                  OR a.non_standard_inv_flg = 'Y'
                  OR a.non_standard_inv_mkup_flg = 'Y'
                  OR a.standard_items_flg = 'Y'
                  OR a.non_standard_inv_mkup_gal_flg = 'Y'
                ) THEN (
                  other_excise_tax_01 + other_excise_tax_02 + other_excise_tax_03 + city_excise_tax + state_excise_tax + county_excise_tax
                ) ELSE 0 END
              )
            ) * (
              CASE WHEN (
                a.standard_items_flg = 'Y'
                OR upstream_prft_data_flg = 'Y'
              ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
            )
          ),
          2
        ) END AS EXT_WHSE_SALES_AMT,
        CASE WHEN upstream_prft_data_flg = 'Y' THEN 0 ELSE Round(
          (
            (a.qty_ordered - a.qty_sold) * b.list_cost
          ),
          2
        ) END AS EXT_LOST_SALES_AMT,
        CASE WHEN (
          a.freight_data_flg = 'Y'
          OR upstream_prft_data_flg = 'Y'
          OR a.fuel_data_flg = 'Y'
        ) THEN 0 WHEN a.record_id = '6' THEN Round(a.retail_price, 2) ELSE Round(
          (
            (
              CASE WHEN (
                a.standard_items_flg = 'Y'
                OR upstream_prft_data_flg = 'Y'
              ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
            ) * Iff(
              a.random_wgt_flg = 'R',
              (a.random_wgt * a.retail_price),
              (
                a.retail_price * (
                  a.store_pack / Iff(a.srp_units = 0, 1, srp_units)
                )
              )
            )
          ),
          2
        ) END AS EXT_RETAIL_AMT,
        Round(
          Iff(
            a.freight_data_flg = 'Y',
            a.final_sell_amt,
            (
              a.freight_amt * (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR upstream_prft_data_flg = 'Y'
                ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
              )
            )
          ),
          2
        ) AS EXT_FREIGHT_AMT,
        0 AS EXT_PALT_DISC_AMT,
        Round(
          (
            (
              (
                CASE WHEN a.standard_items_flg = 'Y' THEN a.reflect_allow_amt ELSE 0 END
              ) - (
                CASE WHEN freight_data_flg = 'Y'
                OR fuel_data_flg = 'Y' THEN 0 ELSE a.ad_allow_amt END
              )
            ) * (
              CASE WHEN (
                a.standard_items_flg = 'Y'
                OR upstream_prft_data_flg = 'Y'
              ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
            )
          ),
          2
        ) AS EXT_REFLECT_AMT,
        Iff(
          a.upstream_prft_data_flg = 'Y',
          0,
          Round(
            (
              a.ad_allow_amt * (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR upstream_prft_data_flg = 'Y'
                ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
              )
            ),
            2
          )
        ) AS EXT_PROMO_ALLW_AMT,
        Round(
          Round(
            CASE WHEN (a.fuel_data_flg = 'Y') THEN a.final_sell_amt ELSE (
              a.fuel_chrge_amt * (
                (
                  CASE WHEN (
                    a.standard_items_flg = 'Y'
                    OR upstream_prft_data_flg = 'Y'
                  ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
                ) * Iff(
                  a.random_wgt > 0, a.random_wgt, a.ship_case_wgt
                )
              )
            ) END,
            4
          ),
          2
        ) AS EXT_FUEL_CHRGE_AMT,
        Round(
          (
            CASE WHEN e.platform_type = 'LEGACY' THEN (
              a.leakage_amt * -1 * (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR upstream_prft_data_flg = 'Y'
                ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
              )
            ) ELSE (
              a.leaker_amt_calc * -1 * (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR upstream_prft_data_flg = 'Y'
                ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
              )
            ) END
          ),
          2
        ) AS EXT_LEAKAGE_AMT,
        0 AS EXT_CASH_DISC_AMT,
        Round(
          (
            (
              (
                (
                  CASE WHEN (
                    a.standard_items_flg = 'Y'
                    OR upstream_prft_data_flg = 'Y'
                  ) THEN (
                    a.final_sell_amt - (
                      CASE WHEN a.admin_alloc_flg = 'Y' THEN 0 ELSE a.lbl_case_chrge END
                    ) - a.price_adjustment - a.city_excise_tax - a.other_excise_tax_01 - a.other_excise_tax_02 - a.other_excise_tax_03 - a.county_excise_tax - a.state_excise_tax + (
                      CASE WHEN e.platform_type = 'LEGACY' THEN a.leakage_amt ELSE a.leaker_amt_calc END
                    ) + a.item_lvl_mrkup_amt_02 - (
                      CASE WHEN e.platform_type = 'LEGACY' THEN a.freight_amt + a.mrkup_dllrs_per_ship_unt ELSE (
                        CASE WHEN a.mrkup_spread_flg IN ('1', '2') THEN a.mrkup_dllrs_per_ship_unt ELSE 0 END
                      ) - (
                        CASE WHEN a.mrkup_spread_flg IN ('2') THEN a.freight_amt ELSE 0 END
                      ) END
                    )
                  ) WHEN a.non_standard_inv_flg = 'Y' THEN a.final_sell_amt ELSE 0 END
                ) + a.ad_allow_amt
              ) * (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR upstream_prft_data_flg = 'Y'
                ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
              )
            ) - (
              CASE WHEN a.fuel_data_flg = 'Y'
              OR a.freight_data_flg = 'Y' THEN 0 ELSE a.layer_ext_cost END
            )
          ),
          2
        ) AS EXT_PROFIT_AMT,
        0 AS EXT_FWD_PRICE_AMT,
        0 AS EXT_FWD_COST_AMT,
        Round(
          (
            CASE WHEN a.standard_items_flg = 'Y' THEN a.item_lvl_mrkup_amt_02 WHEN arda_lines_flg = 'Y' THEN a.final_sell_amt ELSE 0 END
          ),
          2
        ) AS EXT_ARDA_AMT,
        (
          a.lbl_case_chrge * (
            CASE WHEN (
              a.standard_items_flg = 'Y'
              OR upstream_prft_data_flg = 'Y'
            ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
          )
        ) AS EXT_ADMIN_FEE_AMT,
        Round(
          (
            a.price_adjustment * (
              CASE WHEN (
                a.standard_items_flg = 'Y'
                OR upstream_prft_data_flg = 'Y'
              ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
            )
          ),
          2
        ) AS EXT_PRICE_ADJ_AMT,
        Round(
          (
            Iff (
              d.psfs_lawson_dept <> 40,
              (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR a.non_standard_inv_flg = 'Y'
                  OR a.non_standard_inv_mkup_flg = 'Y'
                  OR arda_lines_flg = 'Y'
                  OR a.non_standard_inv_mkup_gal_flg = 'Y'
                ) THEN a.other_excise_tax_01 + a.other_excise_tax_02 + a.other_excise_tax_03 + a.city_excise_tax + a.state_excise_tax + a.county_excise_tax ELSE 0 END
              ),
              0
            ) * (
              CASE WHEN (
                a.standard_items_flg = 'Y'
                OR upstream_prft_data_flg = 'Y'
              ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
            )
          ),
          2
        ) AS EXT_EXCISE_TAX_AMT,
        Round(
          (
            Iff(
              d.psfs_lawson_dept = 40,
              (
                CASE WHEN (
                  a.standard_items_flg = 'Y'
                  OR a.non_standard_inv_flg = 'Y'
                  OR a.non_standard_inv_mkup_flg = 'Y'
                  OR a.arda_lines_flg = 'Y'
                  OR a.non_standard_inv_mkup_gal_flg = 'Y'
                ) THEN a.other_excise_tax_01 + a.other_excise_tax_02 + a.other_excise_tax_03 + a.city_excise_tax + a.state_excise_tax + a.county_excise_tax ELSE 0 END
              ),
              0
            ) * (
              CASE WHEN (
                a.standard_items_flg = 'Y'
                OR a.upstream_prft_data_flg = 'Y'
              ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
            )
          ),
          2
        ) AS EXT_CIG_TAX_AMT,
        CASE WHEN a.upstream_prft_data_flg = 'Y' THEN 0 WHEN (
          a.non_standard_inv_mkup_flg = 'Y'
          OR arda_lines_flg = 'Y'
          OR a.non_standard_inv_mkup_gal_flg = 'Y'
        ) THEN Round(a.final_sell_amt, 2) ELSE Round(
          (
            (
              (
                CASE WHEN a.non_standard_inv_flg = 'Y' THEN a.final_sell_amt WHEN (
                  a.standard_items_flg = 'Y'
                  OR a.upstream_prft_data_flg = 'Y'
                ) THEN (
                  a.final_sell_amt - (
                    CASE WHEN a.admin_alloc_flg = 'Y' THEN 0 ELSE a.lbl_case_chrge END
                  ) - a.price_adjustment - a.city_excise_tax - a.other_excise_tax_01 - a.other_excise_tax_02 - a.other_excise_tax_03 - a.county_excise_tax - a.state_excise_tax + (
                    CASE WHEN e.platform_type = 'LEGACY' THEN a.leakage_amt ELSE a.leaker_amt_calc END
                  ) + a.item_lvl_mrkup_amt_02 - (
                    CASE WHEN e.platform_type = 'LEGACY' THEN a.freight_amt + a.mrkup_dllrs_per_ship_unt ELSE (
                      CASE WHEN a.mrkup_spread_flg IN ('1', '2') THEN a.mrkup_dllrs_per_ship_unt ELSE 0 END
                    ) - (
                      CASE WHEN a.mrkup_spread_flg IN ('2') THEN a.freight_amt ELSE 0 END
                    ) END
                  )
                ) ELSE 0 END
              ) + (
                CASE WHEN a.standard_items_flg = 'Y' THEN a.mrkup_dllrs_per_ship_unt WHEN (
                  a.non_standard_inv_mkup_flg = 'Y'
                  OR a.non_standard_inv_mkup_flg = 'Y'
                ) THEN a.final_sell_amt ELSE 0 END
              ) + (
                CASE WHEN d.psfs_lawson_dept = '40'
                AND (
                  arda_lines_flg = 'Y'
                  OR a.non_standard_inv_flg = 'Y'
                  OR a.non_standard_inv_mkup_flg = 'Y'
                  OR a.standard_items_flg = 'Y'
                  OR a.non_standard_inv_mkup_gal_flg = 'Y'
                ) THEN (
                  other_excise_tax_01 + other_excise_tax_02 + other_excise_tax_03 + city_excise_tax + state_excise_tax + county_excise_tax
                ) ELSE 0 END
              )
            ) * (
              CASE WHEN (
                a.standard_items_flg = 'Y'
                OR upstream_prft_data_flg = 'Y'
              ) THEN (a.qty_sold - a.qty_scratched) WHEN (a.non_standard_inv_flg = 'Y') THEN 1 ELSE 0 END
            )
          ),
          2
        ) END AS TOTAL_SALES_AMT,
        a.credit_reason_cde,
        CASE WHEN a.standard_items_flg = 'Y' THEN 'SWAT-CRM-SI' WHEN a.non_standard_inv_flg = 'Y' THEN 'SWAT-CRM-NSI' WHEN a.fuel_data_flg = 'Y' THEN 'SWAT-CRM-FUEL' --when a.FUEL_ALLOC_FLG='Y' then 'SWAT-CRM-FUEL'
        WHEN a.freight_data_flg = 'Y' THEN 'SWAT-CRM-FRGT' WHEN a.upstream_prft_data_flg = 'Y' THEN 'SWAT-CRM-USPRFT' WHEN a.non_standard_inv_mkup_flg = 'Y' THEN 'SWAT-CRM-NSI-M' WHEN a.non_standard_inv_mkup_gal_flg = 'Y' THEN 'SWAT-CRM-NSI-MG' --when a.ADMIN_ALLOC_FLG='Y' then 'SWAT-CRM-ADMN'
        WHEN a.arda_lines_flg = 'Y' THEN 'SWAT-CRM-ARDA' ELSE 'SWAT' END AS ORIGIN_ID,
        CASE WHEN b.item_dept_override = '040' THEN 'Y' WHEN b.supply_flag = 'Y' THEN 'Y' ELSE 'N' END AS SUPPLY_FLG,
        n.dept_key,
        o.dept_grp_key,
        a.customer_hst_id,
        a.item_hst_id,
        a.vendor_hst_id,
        j.cust_corporation_mdm AS CORPORATION_ID,
        Cast(
          CASE WHEN a.standard_items_flg = 'Y'
          AND a.random_wgt_flg = 'R' THEN a.actual_sales_plan * a.random_wgt * (a.qty_sold - a.qty_scratched) WHEN a.standard_items_flg = 'Y'
          AND a.random_wgt_flg <> 'R' THEN a.actual_sales_plan * (a.qty_sold - a.qty_scratched) ELSE 0 END AS NUMERIC(13, 4)
        ) AS EXT_ORIG_SALES_AMT,
        i.upc_unit AS UPC_UNIT,
        a.create_tmsp,
        a.update_tmsp AS UPDT_TMSP,
        a.facility_pk AS MDM_SITE_ID, -- to review
        CAST(a.customer_nbr AS NUMERIC(38, 0)) AS SHIP_TO_HS_NBR,
        CAST('0' AS VARCHAR(10)) AS SHIP_REJECT_CD,
        0 AS CUBE_VAL,
        '' AS ALLOWANCE_CHRG_CD,
        'ACT' AS SALES_HST_TYPE_CD,
        'N' AS MDV_FDS_FLG,
        Cast(
          CASE
          WHEN a.item_hst_id IS NULL
          THEN TO_NUMBER(CONCAT(a.facility_pk || 9999999)) * -1
          WHEN a.fuel_data_flg = 'Y' AND a.facility_pk NOT IN (2, 3, 5, 8, 40, 54, 87)
          THEN -1 * CONCAT(a.facility_pk ||LPAD(Cast(Substr(a.item_nbr, 2, 5) AS INT),10,'0') )
          WHEN a.fuel_data_flg = 'Y' AND a.facility_pk IN (2, 3, 5, 8, 40, 54, 87)
          THEN -1 * CONCAT(a.facility_pk ||LPAD(Cast(Substr(i.item_nbr_hs, 2, 6) AS INT),10,'0') )
          WHEN a.facility_pk NOT IN (2, 3, 5, 8, 40, 54, 87) AND a.item_hst_id IS NOT NULL
          THEN CONCAT(a.facility_pk ||LPAD(Cast(a.item_nbr AS INT),10,'0') )
          WHEN a.facility_pk IN (2, 3, 5, 8, 40, 54, 87) AND a.item_hst_id IS NOT NULL
          THEN CONCAT(a.facility_pk ||LPAD(cast(i.item_nbr_hs as INT),10,'0') )
          ELSE
          CONCAT(a.facility_pk ||LPAD(Cast(a.item_nbr AS INT),10,'0') )
          END AS NUMERIC(38, 0)
        ) AS ITEM_key,
      CAST( CASE WHEN CUSTOMER_NBR <0 THEN TO_NUMBER(CONCAT(a.facility_pk || CAST(ABS(CUSTOMER_NBR)AS INT))) * -1
      ELSE TO_NUMBER(CONCAT(a.facility_pk || LPAD(CAST(ABS(CUSTOMER_NBR)AS INT),10,'0')))
      END AS NUMERIC(38, 0))  AS CUSTOMER_KEY,
      Cast(
          Iff (
            a.vendor_nbr IS NULL,
            TO_NUMBER(CONCAT(a.facility_pk || 99999)) * -1,
            TO_NUMBER(CONCAT(a.facility_pk ||LPAD(cast(a.vendor_nbr as int),6,'0') ))
          ) AS NUMERIC(38, 0)
        ) AS VENDOR_KEY,
        CASE WHEN xf.WHOLESALE_DEPT_PK IS NULL THEN -99 ELSE xf.WHOLESALE_DEPT_PK END AS WHOLESALE_DEPT_FK,
                    case when (a.freight_data_flg = 'Y'
                            OR a.fuel_data_flg = 'Y'
                            OR a.non_standard_inv_flg = 'Y'
                            OR a.non_standard_inv_mkup_flg = 'Y'
                            OR a.non_standard_inv_mkup_gal_flg = 'Y'
                            OR a.arda_lines_flg = 'Y'
                            OR a.standard_items_flg = 'Y'
                            OR a.upstream_prft_data_flg = 'Y' )
                            and  J.TERRITORY_NO!=29 then 'Y'
                          when  J.TERRITORY_NO=29 then 'N'
                          else 'N' end as SALES_REC_FLG,
      CASE WHEN J.MEMBERSHIP_CODE=11 THEN 'Y' ELSE 'N' END MILITARY_SALES_FLG,
      cxf.CREDIT_REASON_PK AS CREDIT_REASON_ID,
      sxf.SHIP_ERROR_PK AS OUT_REASON_ID,
      stxf.SALES_TYPE_PK AS SALES_TYPE_ID,
      srxf.SHIP_REJECT_PK AS SHIP_REJECT_ID,
      fseg.FACILITY_SEGMT_PK AS FACILITY_SEGMT_ID,
	  dt.FISCAL_WEEK_END_DT
      FROM
        SWAT_SALES_FACT_MV a
		inner join MDM.date_dim dt on a.billing_date=dt.full_date
        left join RTL.sales_type stxf on stxf.sales_type_cd=Cast(CASE WHEN (a.standard_items_flg = 'Y' OR a.non_standard_inv_flg = 'Y' OR a.non_standard_inv_mkup_flg = 'Y'
            OR a.non_standard_inv_mkup_gal_flg = 'Y' OR a.arda_lines_flg = 'Y') AND Cast(a.item_wholesale_id AS INT) <> 28 THEN '1'
            WHEN (a.standard_items_flg = 'Y' OR a.non_standard_inv_flg = 'Y' OR a.non_standard_inv_mkup_flg = 'Y'  OR a.non_standard_inv_mkup_gal_flg = 'Y' OR a.arda_lines_flg = 'Y')  AND Cast(a.item_wholesale_id AS INT) = 28 THEN '2'
            WHEN (a.freight_data_flg = 'Y' OR a.fuel_data_flg = 'Y') THEN '1' WHEN upstream_prft_data_flg = 'Y' THEN '3' ELSE '0' END AS NUMERIC(38, 0)) AND stxf.ORIGIN<>'MDV'
        left join ship_reject srxf on a.facility_pk=srxf.facility_id and srxf.ship_reject_cd='0'
        left join ship_error sxf on a.facility_pk=sxf.facility_id and sxf.ship_error_cd=a.out_reason_code
        left join credit_reason_code_dim cxf on a.facility_pk=cxf.facility_id and cxf.credit_reason_cd=a.credit_reason_cde
        left join item_hst h ON h.item_hst_pk = a.item_hst_id
        left join item_sales_dim b ON b.item_sales_pk = h.item_sales_id
        left join MDM.WHOLESALE_DEPT xf ON a.facility_pk=xf.facility_id and CASE WHEN (a.record_id = '6' AND Trim(a.item_dept) = '') THEN 0 WHEN (a.freight_data_flg = 'Y' OR a.fuel_data_flg = 'Y') THEN 10 ELSE Cast(a.item_dept AS INT) END=xf.WHOLESALE_DEPT_ID  and xf.ORIGIN='SWAT'
        left join item_procr_dim c ON c.item_procr_pk = h.item_procr_id
        left join MDM.item_dim i ON i.item_pk = h.item_mdm_id
        left join customer_hst ch ON ch.customer_hst = a.customer_hst_id
        left join customer_dim j ON j.customer_pk = ch.customer_mdm_id
        left join MDM.mdse_class k ON k.mdse_class_key = CASE WHEN b.merch_class IS NULL
        OR Trim(b.merch_class) = '' THEN 0 ELSE Cast(b.merch_class AS INT) END
        left join MDM.mdse_category l ON k.mdse_catgy_key = l.mdse_catgy_key
        left join MDM.mdse_group m ON l.mdse_grp_key = m.mdse_grp_key
        left join MDM.department n ON m.dept_key = n.dept_key
        left join MDM.department_group o ON n.dept_grp_key = o.dept_grp_key
        inner join MDM.facility_dim e ON a.facility_pk = e.facility_pk
        inner join MDM.item_wholesale f ON a.item_wholesale_id = f.item_wholesale_pk
        inner join RTL.tdwh_whse_lawson_acct_to_wsc_tn_hub d ON a.facility_pk = Cast(d.psfs_facility_id AS INT)
        AND a.territory_no = d.psfs_territory_no
        AND f.item_wholesale_cd = d.psfs_whol_sales_cd
        left join MDM.FACILITY_SEGMENT fseg on a.facility_pk=fseg.facility_id and fseg.ORIGIN<>'MDV'
    )

 UNION ALL
  (
    SELECT
 ms.SHIP_DT                 AS TRANSACTION_DT
,ms.SHIP_DT                 AS INVOICE_DT
,ms.SHIP_DT                 AS DELIVERY_DT
,ms.FACILITY_ID             AS FACILITY_ID
,ms.FACILITY_ID             AS SHIP_FACILITY_ID
,ms.CUSTOMER_NBR            AS CUSTOMER_NBR
,dxf.COMMODITY_KEY            AS WHSE_CMDTY_ID
,dxf.COMMODITY_KEY            AS COMMODITY_CODE
,ms.BUYER_ID                AS BUYER_ID
,ms.VENDOR_NBR              AS VENDOR_NBR
,cast(ms.ITEM_NBR as number(38,0))                AS ITEM_NBR
,ms.MDSE_CLASS_KEY          AS MDSE_CLASS_KEY
,ms.ORDER_NBR               AS INVOICE_NBR
,0                       AS PRESELL_NBR
,ms.ORDER_TYPE_CD           AS ORDER_TYPE_CD
,'P'                     AS PRICE_ZONE_TYPE_CD
,1                       AS SALES_TYPE_CD
,'N A'                   AS ITEM_WHOLESALE_CD
,0                       AS WHOLESALE_DEPT_ID
,CAST(LPAD(ms.GL_ACCT_NBR,6,'0') AS VARCHAR(20))  AS GL_ACCOUNT_NBR
,'N'                     AS ADV_BUYING_SYS_FLG
,NULL                    AS PRICING_EFF_DATE
,''                      AS SPECIAL_PRICE_FLG
,ms.ORDER_QTY               AS ORDERED_QTY
,0                       AS ADJUSTED_QTY
,0                       AS SUBBED_QTY
,ms.SHIP_QTY                AS SHIPPED_QTY
,ms.LINE_WEIGHT_MSR         AS UNITS_LBS_WHSE_QTY
,ms.OUT_OF_STOCK_QTY        AS OUT_OF_STOCK_QTY
,ms.SHIP_ERROR_CD           AS OUT_REASON_CD
,ms.PVT_LBL_FLG             AS PRIVATE_LABEL_FLG
,ms.ORDER_LINE_NBR          AS INVOICE_CNT
,0                       AS EXT_RSU_CNT
,0                       AS EXT_MOVEMENT_WT
,0                       AS CASE_COST_AMT
,ms.EXT_ORDER_COST_AMT      AS EXT_CASE_COST_AMT
,0                       AS NET_COST_AMT
,0                       AS EXT_NET_COST_AMT
,0                       AS NET_PRICE_AMT
,0                       AS EXT_NET_PRICE_AMT
,0                       AS EXT_CUST_FEE_AMT
,ms.EXT_COST_AMT            AS EXT_WHSE_SALES_AMT
,0                       AS EXT_LOST_SALES_AMT
,0                       AS EXT_RETAIL_AMT
,ms.EXT_DRAYAGE_AMT         AS EXT_FREIGHT_AMT
,0                       AS EXT_PALT_DISC_AMT
,CAST(ms.ALLOWANCE_AMT AS NUMBER(38,2)) AS EXT_REFLECT_AMT
,0                       AS EXT_PROMO_ALLW_AMT
,0                       AS EXT_FUEL_CHRGE_AMT
,0                       AS EXT_LEAKAGE_AMT
,0                       AS EXT_CASH_DISC_AMT
,0                       AS EXT_PROFIT_AMT
,0                       AS EXT_FWD_PRICE_AMT
,0                       AS EXT_FWD_COST_AMT
,0                       AS EXT_ARDA_AMT
,0                       AS EXT_ADMIN_FEE_AMT
,0                       AS EXT_PRICE_ADJ_AMT
,0                       AS EXT_EXCISE_TAX_AMT
,0                       AS EXT_CIG_TAX_AMT
,CAST(ms.TOT_ORDER_LINE_AMT AS NUMBER(38,2))     AS TOTAL_SALES_AMT
,''          AS CREDIT_REASON_CD
,'MDV'                 AS ORIGIN_ID
,ms.SUPPLY_FLG              AS SUPPLY_FLG
,ms.DEPT_KEY                AS DEPT_KEY
,ms.DEPT_GRP_KEY            AS DEPT_GRP_KEY
,ms.CUSTOMER_HST_ID         AS CUSTOMER_HST_ID
,ms.ITEM_HST_ID             AS ITEM_HST_ID
,ms.VENDOR_HST_ID           AS VENDOR_HST_ID
,ms.CORPORATION_ID          AS CORPORATION_ID
,0                       AS EXT_ORIG_SALES_AMT
,CAST( ms.UPC_CD  AS VARCHAR(20))                AS UPC_UNIT
,ms.CREATE_TMSP             AS CREATE_TMSP
,ms.UPDATE_TMSP             AS UPDT_TMSP
,ms.MDM_SITE_ID             AS MDM_SITE_ID
,ms.SHIP_TO_NBR             AS SHIP_TO_HS_NBR -- in mdv_sales SHIP_TO_NBR is mapped to ship_to_id from mdv_sales_hst table which carries the same data present in ship_to_nbr column from mdv_ship_to table
,ms.REJECT_CD  AS SHIP_REJECT_CD
,ms.CUBE_QTY                AS CUBE_VAL
,ms.ALLOWANCE_CHRG_CD        AS ALLOWANCE_CHRG_CD
,ms.SALES_HST_TYPE_CD        AS SALES_HST_TYPE_CD
,ms.FDS_FLG             AS FDS_FLG
,CASE WHEN ms.ITEM_NBR IS NULL AND ms.MDM_SITE_ID IS NULL THEN -999999999999
      WHEN ms.ITEM_NBR IS NOT NULL AND ms.MDM_SITE_ID IS NULL THEN TO_NUMBER('999'||LPAD(ms.ITEM_NBR,10,'0'))*-1
      WHEN (ms.ITEM_NBR IS NULL OR ms.ITEM_NBR<0) AND ms.MDM_SITE_ID IS NOT NULL THEN TO_NUMBER(ms.MDM_SITE_ID||'999999999')*-1
      ELSE TO_NUMBER(ms.MDM_SITE_ID||LPAD(ms.ITEM_NBR,10,'0'))
  END AS ITEM_KEY
,CASE WHEN ms.CUSTOMER_NBR IS NULL AND ms.MDM_SITE_ID IS NULL THEN -999999999
      WHEN ms.CUSTOMER_NBR IS NOT NULL AND ms.MDM_SITE_ID IS NULL THEN TO_NUMBER('999'||LPAD(ms.CUSTOMER_NBR,10,'0'))*-1
      WHEN (ms.CUSTOMER_NBR IS NULL OR ms.CUSTOMER_NBR<0) AND ms.MDM_SITE_ID IS NOT NULL THEN TO_NUMBER(ms.MDM_SITE_ID||'999999')*-1
      ELSE TO_NUMBER(ms.MDM_SITE_ID||LPAD(ms.CUSTOMER_NBR,10,'0'))
  END AS CUSTOMER_KEY
,CASE WHEN ms.VENDOR_NBR IS NULL AND ms.MDM_SITE_ID IS NULL THEN -99999999
      WHEN ms.VENDOR_NBR IS NOT NULL AND ms.MDM_SITE_ID IS NULL THEN TO_NUMBER('999'||LPAD(ms.VENDOR_NBR,6,'0'))*-1
      WHEN (ms.VENDOR_NBR IS NULL OR ms.VENDOR_NBR<0) AND ms.MDM_SITE_ID IS NOT NULL THEN TO_NUMBER(ms.MDM_SITE_ID||'99999')*-1
      ELSE TO_NUMBER(ms.MDM_SITE_ID || LPAD(ms.VENDOR_NBR,6,'0'))
  END AS  VENDOR_KEY
,ms.WHOLESALE_DEPT_ID  AS  WHOLESALE_DEPT_FK
,'Y' as SALES_REC_FLG
,CASE WHEN J.MEMBERSHIP_CODE=11 THEN 'Y' ELSE 'N' END MILITARY_SALES_FLG,
-99 AS CREDIT_REASON_ID,
sxf.SHIP_ERROR_PK AS OUT_REASON_ID,
stxf.SALES_TYPE_PK AS SALES_TYPE_ID,
srxf.SHIP_REJECT_PK AS SHIP_REJECT_ID,
fseg.FACILITY_SEGMT_PK AS FACILITY_SEGMENT_ID,
dt.FISCAL_WEEK_END_DT
FROM MDV.MDV_SALES_MV ms
inner join MDM.date_dim dt on ms.ship_dt=dt.full_date
left join RTL.sales_type stxf on ms.SALES_CATGY_CD=stxf.SALES_TYPE_CD and stxf.ORIGIN='MDV'
left join ship_error sxf on ms.facility_id=sxf.facility_id and sxf.ship_error_cd=ms.SHIP_ERROR_CD
left join ship_reject srxf on ms.facility_id=srxf.facility_id and srxf.ship_reject_cd=ms.REJECT_CD
LEFT JOIN CUSTOMER_HST i on ms.CUSTOMER_HST_ID =i.CUSTOMER_HST
LEFT JOIN CUSTOMER_DIM j on i.CUSTOMER_MDM_ID=j.CUSTOMER_PK
LEFT JOIN MDV.MDV_DEPT_FAC_XREF xf ON CAST(ms.WAREHOUSE_CD AS INTEGER)=xf.WAREHOUSE_ID
LEFT JOIN MDV.DC_DEPT_XREF dxf
    on CASE when xf.product_group_cd = 'DRY' then 101
        when xf.product_group_cd = 'FROZEN' then 118
        when xf.product_group_cd = 'CHILLD' then 119
        else 0 end=dxf.DC_DEPT_KEY
left join MDM.FACILITY_SEGMENT fseg on ms.FACILITY_ID=fseg.facility_id and TRY_TO_NUMBER(ms.WAREHOUSE_CD)=fseg.FACILITY_SEGMT_NBR AND fseg.ORIGIN='MDV'
    WHERE ms.FACILITY_ID <> 61
  )

   UNION ALL
  (
   SELECT
  vc.SHIP_DT                 AS TRANSACTION_DT
,vc.SHIP_DT                 AS INVOICE_DT
,vc.SHIP_DT                 AS DELIVERY_DT
,vc.FACILITY_ID             AS FACILITY_ID
,vc.FACILITY_ID             AS SHIP_FACILITY_ID
,mst.MDM_CUSTOMER           AS CUSTOMER_NBR -- ADDING CUSTOMER_NBR
,0                  AS WHSE_CMDTY_ID
,0     AS COMMODITY_CODE
,''     AS BUYER_ID
,99999     AS VENDOR_NBR
,cast(-9999999999 as number(38,0))     AS ITEM_NBR
,0     AS MDSE_CLASS_KEY
,vc.INVOICE_NBR     AS INVOICE_NBR
,0     AS PRESELL_NBR
,'CR'     AS ORDER_TYPE_CD
,''     AS PRICE_ZONE_TYPE_CD
,1     AS SALES_TYPE_CD
,''     AS ITEM_WHOLESALE_CD
,0     AS WHOLESALE_DEPT_ID
,'000000'     AS GL_ACCOUNT_NBR
,''     AS ADV_BUYING_SYS_FLG
,NULL     AS PRICING_EFF_DATE
,''     AS SPECIAL_PRICE_FLG
,0     AS ORDERED_QTY
,0     AS ADJUSTED_QTY
,0     AS SUBBED_QTY
,0     AS SHIPPED_QTY
,0     AS UNITS_LBS_WHSE_QTY
,0     AS OUT_OF_STOCK_QTY
,''     AS OUT_REASON_CD
,''     AS PRIVATE_LABEL_FLG
,0     AS INVOICE_CNT
,0     AS EXT_RSU_CNT
,0     AS EXT_MOVEMENT_WT
,0     AS CASE_COST_AMT
,0     AS EXT_CASE_COST_AMT
,0     AS NET_COST_AMT
,0     AS EXT_NET_COST_AMT
,VC.CREDIT_AMT    AS NET_PRICE_AMT
,0     AS EXT_NET_PRICE_AMT
,0     AS EXT_CUST_FEE_AMT
,0     AS EXT_WHSE_SALES_AMT
,0     AS EXT_LOST_SALES_AMT
,0     AS EXT_RETAIL_AMT
,0     AS EXT_FREIGHT_AMT
,0     AS EXT_PALT_DISC_AMT
,0     AS EXT_REFLECT_AMT
,0     AS EXT_PROMO_ALLW_AMT
,0     AS EXT_FUEL_CHRGE_AMT
,0     AS EXT_LEAKAGE_AMT
,0     AS EXT_CASH_DISC_AMT
,0     AS EXT_PROFIT_AMT
,0     AS EXT_FWD_PRICE_AMT
,0     AS EXT_FWD_COST_AMT
,0     AS EXT_ARDA_AMT
,0     AS EXT_ADMIN_FEE_AMT
,0     AS EXT_PRICE_ADJ_AMT
,0     AS EXT_EXCISE_TAX_AMT
,0     AS EXT_CIG_TAX_AMT
,VC.CREDIT_AMT     AS TOTAL_SALES_AMT
,cast(CC.REASON_NBR as varchar(10))     AS CREDIT_REASON_CD
,'MDVVCMCRDT'    AS ORIGIN_ID
,''     AS SUPPLY_FLG
,-99     AS DEPT_KEY
,-99     AS DEPT_GRP_KEY
,vc.CUSTOMER_HST_ID     AS CUSTOMER_HST_ID
,TO_NUMBER( CONCAT (ABS(NVL(vc.MDM_SITE_ID, -999 )) ||  9999999999 ))  * -1      AS ITEM_HST_ID
,TO_NUMBER( CONCAT (ABS(NVL(vc.MDM_SITE_ID, -999 )) ||  99999 )) * -1     AS VENDOR_HST_ID
,j.cust_corporation_mdm    AS CORPORATION_ID
,0     AS EXT_ORIG_SALES_AMT
,CAST( '-9999999999' AS VARCHAR(20))     AS UPC_UNIT
,vc.CREATE_TMSP             AS CREATE_TMSP
,vc.UPDATE_TMSP             AS UPDT_TMSP
,vc.MDM_SITE_ID             AS MDM_SITE_ID
,mst.SHIP_TO_NBR    AS SHIP_TO_HS_NBR  -- REVIEW,
,CAST('0' AS VARCHAR(10)) AS SHIP_REJECT_CD
,0       AS CUBE_VAL
,''       AS ALLOWANCE_CHRG_CD
,'ACT'    AS SALES_HST_TYPE_CD
,'N'             AS FDS_FLG
,TO_NUMBER( CONCAT (ABS(NVL(vc.MDM_SITE_ID, -999 )) ||  999999999))  * -1 AS  ITEM_KEY
,CASE WHEN mst.MDM_CUSTOMER IS NULL AND vc.MDM_SITE_ID IS NULL THEN -999999999
      WHEN mst.MDM_CUSTOMER IS NOT NULL AND vc.MDM_SITE_ID IS NULL THEN TO_NUMBER('999'||LPAD(mst.MDM_CUSTOMER,10,'0'))*-1
      WHEN (mst.MDM_CUSTOMER IS NULL OR mst.MDM_CUSTOMER<0) AND vc.MDM_SITE_ID IS NOT NULL THEN TO_NUMBER(vc.MDM_SITE_ID||'999999')*-1
      ELSE TO_NUMBER(vc.MDM_SITE_ID||LPAD(mst.MDM_CUSTOMER,10,'0'))
 END AS CUSTOMER_KEY
,TO_NUMBER(CONCAT(ABS(NVL(vc.MDM_SITE_ID, -999)) ||99999))  * -1 AS  VENDOR_KEY
,WHOLESALE_DEPT_ID  AS   WHOLESALE_DEPT_FK
,'Y' as SALES_REC_FLG
,CASE WHEN J.MEMBERSHIP_CODE=11 THEN 'Y' ELSE 'N' END MILITARY_SALES_FLG
,cxf.CREDIT_REASON_PK AS CREDIT_REASON_ID
,-99 AS OUT_REASON_ID
,stxf.SALES_TYPE_PK     AS SALES_TYPE_ID
,srxf.SHIP_REJECT_PK AS SHIP_REJECT_ID
,fseg.FACILITY_SEGMT_PK AS FACILITY_SEGMT_ID,
dt.FISCAL_WEEK_END_DT
from MDV.MDV_VCM_CREDITS vc
inner join MDM.date_dim dt on vc.ship_dt=dt.full_date
LEFT JOIN CUSTOMER_HST i on vc.CUSTOMER_HST_ID =i.CUSTOMER_HST
LEFT JOIN CUSTOMER_DIM j on i.CUSTOMER_MDM_ID=j.CUSTOMER_PK
LEFT JOIN MDV.MDV_SHIP_TO mst ON mst.SHIP_TO_PK = SHIP_TO_ID
left join MDV.MDV_VCM_CREDIT_CODES  cc on cc.REASON_PK =  vc.CREDIT_TYPE_ID
left join credit_reason_code_dim cxf on vc.facility_id=cxf.facility_id and cxf.credit_reason_cd=trim(cast(CC.REASON_NBR as varchar(10)))
left join RTL.sales_type stxf on 1=1 and stxf.sales_type_cd=1 AND stxf.ORIGIN='MDV'
left join ship_reject srxf on vc.facility_id=srxf.facility_id and srxf.ship_reject_cd='0'
left join MDV.MDV_DEPT_FAC_XREF facxref on vc.MDM_SITE_ID=facxref.MDM_SITE_ID AND facxref.MDM_SITE_ID<>0
left join MDM.FACILITY_SEGMENT fseg on CAST(vc.FACILITY_ID AS NUMBER(38,0))=fseg.facility_id and facxref.WAREHOUSE_ID=fseg.FACILITY_SEGMT_NBR AND fseg.ORIGIN='MDV'
WHERE vc.FACILITY_ID <> 61
  )
  UNION ALL
 (
 SELECT
 fdc.INPUT_DT           AS TRANSACTION_DT
,fdc.POSTING_DT            AS INVOICE_DT
,fdc.POSTING_DT            AS DELIVERY_DT
,CAST(fdc.FACILITY_ID AS NUMBER(38,0))    AS FACILITY_ID
,CAST(fdc.FACILITY_ID AS NUMBER(38,0) )          AS SHIP_FACILITY_ID
,fdc.CUSTOMER_NBR                    AS CUSTOMER_NBR
,0                    AS WHSE_CMDTY_ID
,0      AS COMMODITY_CODE
,''     AS BUYER_ID
,fdc.VENDOR_NBR     AS VENDOR_NBR
,cast(fdc.UPC_CD as number(38,0))     AS ITEM_NBR
,fdc.MDSE_CLASS_KEY     AS MDSE_CLASS_KEY
,fdc.ORIG_INV_NBR     AS INVOICE_NBR
,0     AS PRESELL_NBR
,fdc.CREDIT_TYPE_CD     AS ORDER_TYPE_CD
,'P'     AS PRICE_ZONE_TYPE_CD
,1     AS SALES_TYPE_CD
,'N A'     AS ITEM_WHOLESALE_CD
,0     AS WHOLESALE_DEPT_ID
,'000000'     AS GL_ACCOUNT_NBR
,'N'     AS ADV_BUYING_SYS_FLG
,NULL     AS PRICING_EFF_DATE
,'N'     AS SPECIAL_PRICE_FLG
,fdc.ITEM_QTY     AS ORDERED_QTY
,0     AS ADJUSTED_QTY
,0     AS SUBBED_QTY
,fdc.ITEM_QTY     AS SHIPPED_QTY
,0     AS UNITS_LBS_WHSE_QTY
,0     AS OUT_OF_STOCK_QTY
,''     AS OUT_REASON_CD
,'N'     AS PRIVATE_LABEL_FLG
,0     AS INVOICE_CNT
,0     AS EXT_RSU_CNT
,0     AS EXT_MOVEMENT_WT
,fdc.SELL_PRICE_AMT     AS CASE_COST_AMT
,fdc.EXT_COST_AMT     AS EXT_CASE_COST_AMT
,0     AS NET_COST_AMT
,0     AS EXT_NET_COST_AMT
,fdc.SELL_PRICE_AMT     AS NET_PRICE_AMT
,0     AS EXT_NET_PRICE_AMT
,0     AS EXT_CUST_FEE_AMT
,fdc.EXT_COST_AMT     AS EXT_WHSE_SALES_AMT
,0     AS EXT_LOST_SALES_AMT
,( fdc.SELL_PRICE_AMT *  fdc.ITEM_QTY  ) AS EXT_RETAIL_AMT
,0     AS EXT_FREIGHT_AMT
,0     AS EXT_PALT_DISC_AMT
,0     AS EXT_REFLECT_AMT
,0     AS EXT_PROMO_ALLW_AMT
,0     AS EXT_FUEL_CHRGE_AMT
,0     AS EXT_LEAKAGE_AMT
,0     AS EXT_CASH_DISC_AMT
,0     AS EXT_PROFIT_AMT
,0     AS EXT_FWD_PRICE_AMT
,0     AS EXT_FWD_COST_AMT
,0     AS EXT_ARDA_AMT
,0     AS EXT_ADMIN_FEE_AMT
,0     AS EXT_PRICE_ADJ_AMT
,0     AS EXT_EXCISE_TAX_AMT
,0     AS EXT_CIG_TAX_AMT
,CAST(fdc.SELL_PRICE_AMT * fdc.EXT_COST_AMT  AS NUMBER(38,2))   AS TOTAL_SALES_AMT
,CAST(fdc.CREDIT_REASON_CD  AS VARCHAR(20))   AS CREDIT_REASON_CD
,'MDVDGCRDT'     AS ORIGIN_ID
,fdc.SUPPLY_FLG     AS SUPPLY_FLG
,fdc.DEPT_KEY     AS DEPT_KEY
,fdc.DEPT_GRP_KEY     AS DEPT_GRP_KEY
,fdc.CUSTOMER_HST_ID     AS CUSTOMER_HST_ID
,fdc.ITEM_HST_ID     AS ITEM_HST_ID
,fdc.VENDOR_HST_ID     AS VENDOR_HST_ID
,fdc.CORPORATION_ID     AS CORPORATION_ID
,0     AS EXT_ORIG_SALES_AMT
,CAST(fdc.ITEM_NBR AS VARCHAR(20))     AS UPC_UNIT
,fdc.CREATE_TMSP             AS CREATE_TMSP
,fdc.UPDATE_TMSP             AS UPDT_TMSP
,fdc.MDM_SITE_ID             AS MDM_SITE_ID
,mst.SHIP_TO_NBR     AS SHIP_TO_HS_NBR
,CAST('0' AS VARCHAR(10)) AS SHIP_REJECT_CD
,0       AS CUBE_VAL
,''       AS ALLOWANCE_CHRG_CD
,'ACT'    AS SALES_HST_TYPE_CD
,'N'             AS FDS_FLG
,CASE WHEN fdc.UPC_CD IS NULL AND fdc.MDM_SITE_ID IS NULL THEN -999999999999
      WHEN fdc.UPC_CD IS NOT NULL AND fdc.MDM_SITE_ID IS NULL THEN TO_NUMBER('999'||LPAD(fdc.UPC_CD,10,'0'))*-1
      WHEN (fdc.UPC_CD IS NULL OR fdc.UPC_CD<0) AND fdc.MDM_SITE_ID IS NOT NULL THEN TO_NUMBER(fdc.MDM_SITE_ID||'999999999')*-1
      ELSE TO_NUMBER(fdc.MDM_SITE_ID||LPAD(fdc.UPC_CD,10,'0'))
  END AS ITEM_KEY
,CASE WHEN fdc.CUSTOMER_NBR IS NULL AND fdc.MDM_SITE_ID IS NULL THEN -999999999
      WHEN fdc.CUSTOMER_NBR IS NOT NULL AND fdc.MDM_SITE_ID IS NULL THEN TO_NUMBER('999'||LPAD(fdc.CUSTOMER_NBR,10,'0'))*-1
      WHEN (fdc.CUSTOMER_NBR IS NULL OR fdc.CUSTOMER_NBR<0) AND fdc.MDM_SITE_ID IS NOT NULL THEN TO_NUMBER(fdc.MDM_SITE_ID||'999999')*-1
      ELSE TO_NUMBER(fdc.MDM_SITE_ID||LPAD(fdc.CUSTOMER_NBR,10,'0'))
  END AS CUSTOMER_KEY
,CASE WHEN fdc.VENDOR_NBR IS NULL AND fdc.MDM_SITE_ID IS NULL THEN -99999999
      WHEN fdc.VENDOR_NBR IS NOT NULL AND fdc.MDM_SITE_ID IS NULL THEN TO_NUMBER('999'||LPAD(fdc.VENDOR_NBR,6,'0'))*-1
      WHEN (fdc.VENDOR_NBR IS NULL OR fdc.VENDOR_NBR<0) AND fdc.MDM_SITE_ID IS NOT NULL THEN TO_NUMBER(fdc.MDM_SITE_ID||'99999')*-1
      ELSE TO_NUMBER(fdc.MDM_SITE_ID || LPAD(fdc.VENDOR_NBR,6,'0'))
  END AS  VENDOR_KEY
,WHOLESALE_DEPT_ID  AS  WHOLESALE_DEPT_FK
,'Y' as SALES_REC_FLG
,CASE WHEN J.MEMBERSHIP_CODE=11 THEN 'Y' ELSE 'N' END MILITARY_SALES_FLG
,cxf.CREDIT_REASON_PK AS CREDIT_REASON_ID
,-99 AS OUT_REASON_ID
,stxf.sales_type_pk     AS SALES_TYPE_ID
,srxf.SHIP_REJECT_PK AS SHIP_REJECT_ID
,fseg.FACILITY_SEGMT_PK AS FACILITY_SEGMT_ID,
dt.FISCAL_WEEK_END_DT
from MDV_FD_CREDITS fdc
inner join MDM.date_dim dt on fdc.INPUT_DT=dt.full_date
LEFT JOIN CUSTOMER_HST i on fdc.CUSTOMER_HST_ID =i.CUSTOMER_HST
LEFT JOIN CUSTOMER_DIM j on i.CUSTOMER_MDM_ID=j.CUSTOMER_PK
LEFT JOIN MDV.MDV_SHIP_TO mst ON mst.SHIP_TO_PK = fdc.MDV_SHIP_TO_ID
left join credit_reason_code_dim cxf on fdc.facility_id=cxf.facility_id and cxf.credit_reason_cd=trim(CAST(fdc.CREDIT_REASON_CD  AS VARCHAR(20)))
left join RTL.sales_type stxf on 1=1 and stxf.sales_type_cd=1 AND stxf.ORIGIN='MDV'
left join ship_reject srxf on fdc.facility_id=srxf.facility_id and srxf.ship_reject_cd='0'
left join MDM.FACILITY_SEGMENT fseg on CAST(fdc.FACILITY_ID AS NUMBER(38,0))=fseg.facility_id and TRY_TO_NUMBER(fdc.MDV_DEPT_CD)=fseg.FACILITY_SEGMT_NBR AND fseg.ORIGIN='MDV'
WHERE fdc.FACILITY_ID <> 61
 )
);