-- BI_SANDBOX.SBX_BIZ.MARKETING.V_SEN_DISC_REDEEMER_SALES_DAY_STORE source

CREATE OR REPLACE
VIEW V_SEN_DISC_REDEEMER_SALES_DAY_STORE AS
SELECT
	ALL_SENIOR_GROUPS.FISCAL_WEEK_ID,
	ALL_SENIOR_GROUPS.SALES_DT,
	ALL_SENIOR_GROUPS.STORE_NBR,
	ALL_SENIOR_GROUPS.MANAGER,
	ALL_SENIOR_GROUPS.POST_REDEEM,
	ALL_SENIOR_GROUPS.TRANS_TY,
	ALL_SENIOR_GROUPS.SALES_TY,
	ALL_SENIOR_GROUPS.SALES_QTY_TY,
	ALL_SENIOR_GROUPS.PROFIT_TY,
	ALL_SENIOR_GROUPS.TRANS_LY,
	ALL_SENIOR_GROUPS.SALES_LY,
	ALL_SENIOR_GROUPS.SALES_QTY_LY,
	ALL_SENIOR_GROUPS.PROFIT_LY
FROM
	(((
	SELECT
		DISTINCT FEB_21.FISCAL_WEEK_ID,
		FEB_21.SALES_DT,
		FEB_21.STORE_NBR,
		FEB_21.MANAGER,
		FEB_21.POST_REDEEM,
		FEB_21.TRANS_TY,
		FEB_21.SALES_TY,
		FEB_21.SALES_QTY_TY,
		FEB_21.PROFIT_TY,
		FEB_21.TRANS_LY,
		FEB_21.SALES_LY,
		FEB_21.SALES_QTY_LY,
		FEB_21.PROFIT_LY
	FROM
		(
		SELECT
			DISTINCT A.FISCAL_WEEK_ID,
			A.SALES_DT,
			A.STORE_NBR,
			CASE
				WHEN (MAN.HOUSEHOLD_KEY IS NULL) THEN 'N'
				ELSE 'Y'
			END AS MANAGER,
			A.POST_REDEEM,
			SUM(A.TRANS_TY) AS TRANS_TY,
			SUM(A.SALES_TY) AS SALES_TY,
			SUM(A.SALES_QTY_TY) AS SALES_QTY_TY,
			SUM(A.PROFIT_TY) AS PROFIT_TY,
			SUM(A.TRANS_LY) AS TRANS_LY,
			SUM(A.SALES_LY) AS SALES_LY,
			SUM(A.SALES_QTY_LY) AS SALES_QTY_LY,
			SUM(A.PROFIT_LY) AS PROFIT_LY
		FROM
			(
			SELECT
				DISTINCT A.FISCAL_WEEK_ID,
				A.SALES_DT,
				A.STORE_NBR,
				A.HOUSEHOLD_KEY,
				R.FIRST_REDEEM,
				A.STORE_GROUP,
				CASE
					WHEN A.SALES_DT >= R.FIRST_REDEEM THEN 'Y'
					ELSE 'N'
				END AS POST_REDEEM,
				SUM(A.TRANS_TY) AS TRANS_TY,
				SUM(A.SALES_TY) AS SALES_TY,
				SUM(A.SALES_QTY_TY) AS SALES_QTY_TY,
				SUM(A.PROFIT_TY) AS PROFIT_TY,
				SUM(A.TRANS_LY) AS TRANS_LY,
				SUM(A.SALES_LY) AS SALES_LY,
				SUM(A.SALES_QTY_LY) AS SALES_QTY_LY,
				SUM(A.PROFIT_LY) AS PROFIT_LY
			FROM
				(
				SELECT
					DISTINCT CASE
						WHEN (TY.FISCAL_WEEK_ID IS NOT NULL) THEN TY.FISCAL_WEEK_ID
						WHEN (LY.FISCAL_WEEK_ID IS NOT NULL) THEN LY.FISCAL_WEEK_ID
						ELSE NULL
					END AS FISCAL_WEEK_ID,
					CASE
						WHEN (TY.SALES_DT IS NOT NULL) THEN TY.SALES_DT
						WHEN (LY.SALES_DT IS NOT NULL) THEN LY.SALES_DT
						ELSE NULL
					END AS SALES_DT,
					CASE
						WHEN (TY.HOUSEHOLD_KEY IS NOT NULL) THEN TY.HOUSEHOLD_KEY
						WHEN (LY.HOUSEHOLD_KEY IS NOT NULL) THEN LY.HOUSEHOLD_KEY
						ELSE NULL
					END AS HOUSEHOLD_KEY,
					CASE
						WHEN (TY.STORE_NBR IS NOT NULL) THEN TY.STORE_NBR
						WHEN (LY.STORE_NBR IS NOT NULL) THEN LY.STORE_NBR
						ELSE NULL
					END AS STORE_NBR,
					CASE
						WHEN (TY.STORE_GROUP IS NOT NULL) THEN TY.STORE_GROUP
						WHEN (LY.STORE_GROUP IS NOT NULL) THEN LY.STORE_GROUP
						ELSE NULL
					END AS STORE_GROUP,
					CASE
						WHEN (TY.REGISTER_ID IS NOT NULL) THEN TY.REGISTER_ID
						WHEN (LY.REGISTER_ID IS NOT NULL) THEN LY.REGISTER_ID
						ELSE NULL
					END AS REGISTER_ID,
					CASE
						WHEN (TY.TRANS = 0) THEN NULL
						ELSE TY.TRANS
					END AS TRANS_TY,
					CASE
						WHEN (TY.SALES = 0) THEN NULL
						ELSE TY.SALES
					END AS SALES_TY,
					CASE
						WHEN (TY.SALES_QTY = 0) THEN NULL
						ELSE TY.SALES_QTY
					END AS SALES_QTY_TY,
					CASE
						WHEN (TY.PROFIT = 0) THEN NULL
						ELSE TY.PROFIT
					END AS PROFIT_TY,
					CASE
						WHEN (LY.TRANS = 0) THEN NULL
						ELSE LY.TRANS
					END AS TRANS_LY,
					CASE
						WHEN (LY.SALES = 0) THEN NULL
						ELSE LY.SALES
					END AS SALES_LY,
					CASE
						WHEN (LY.SALES_QTY = 0) THEN NULL
						ELSE LY.SALES_QTY
					END AS SALES_QTY_LY,
					CASE
						WHEN (LY.PROFIT = 0) THEN NULL
						ELSE LY.PROFIT
					END AS PROFIT_LY
				FROM
(

				SELECT   D.FISCAL_WEEK_ID,
				         D.SALES_DT,
				         LOYAL.HOUSEHOLD_KEY,
				         LINE.STORE_NBR,
				         A11.REGISTER_ID,
				         STORE_GROUP.STORE_GROUP,
				         COUNT(DISTINCT A11.TRANS_NBR) AS TRANS,
				         SUM(A11.TOTAL_SALES_QTY) AS SALES_QTY,
				         SUM(A11.TOTAL_SALES_AMT) AS SALES,
				         SUM((A11.TOTAL_SALES_AMT - A11.EXT_COST_AMT) + A11.EXT_COST_ALLW_AMT + A11.EXT_BILLBACK_AMT) AS PROFIT
				FROM     SBX_BIZ.MARKETING.RSAL_DY_LN_ITM_TRN A11 
				         JOIN SBX_BIZ.MARKETING.LOYALTY_CARD LOYAL ON A11.LOYALTY_CARD_NBR = LOYAL.LOYALTY_CARD_NBR 
				         JOIN SBX_BIZ.MARKETING.FISCAL_DAY D ON D.SALES_DT = A11.SALES_DT 
				         JOIN SBX_BIZ.MARKETING.LINE LINE ON LINE.SALES_LINE_ID = A11.SALES_LINE_ID 
				         JOIN SBX_BIZ.MARKETING.I_SENIOR_DISCOUNT_STORES STORE_GROUP ON STORE_GROUP.STORE_NBR = LINE.STORE_NBR 
				         JOIN ( SELECT DISTINCT FEB.HH, 'Feb_21' AS STORE_GROUP FROM SBX_BIZ.MARKETING.I_SEN_DISC_REDEEM_FEB21_EXPANSION FEB) RED ON RED.HH = LOYAL.HOUSEHOLD_KEY
				WHERE    STORE_GROUP.STORE_GROUP = 'Feb_21'
				AND      D.SALES_DT > '2021-01-02'
				AND      A11.DEPT_KEY IN (60, 90, 40, 10, 11, 41, 15, 50, 13, 12, 70, 80, 20, 30, 110, 120, 250)
				AND      LINE.FORMAT_TYPE_ID = 'SUPERMKT'
				AND      LOYAL.CARD_TYPE_CD IN ('L', 'A')
				GROUP BY D.FISCAL_WEEK_ID, D.SALES_DT, LOYAL.HOUSEHOLD_KEY, LINE.STORE_NBR, 
				         A11.REGISTER_ID, STORE_GROUP.STORE_GROUP
) TY
FULL JOIN (
				SELECT   D.FISCAL_WEEK_ID,
				         D.SALES_DT,
				         LOYAL.HOUSEHOLD_KEY,
				         LINE.STORE_NBR,
				         A11.REGISTER_ID,
				         STORE_GROUP.STORE_GROUP,
				         COUNT(DISTINCT A11.TRANS_NBR) AS TRANS,
				         SUM(A11.TOTAL_SALES_QTY) AS SALES_QTY,
				         SUM(A11.TOTAL_SALES_AMT) AS SALES,
				         SUM((A11.TOTAL_SALES_AMT - A11.EXT_COST_AMT) + A11.EXT_COST_ALLW_AMT + A11.EXT_BILLBACK_AMT) AS PROFIT
				FROM     SBX_BIZ.MARKETING.RSAL_DY_LN_ITM_TRN A11 
				         JOIN SBX_BIZ.MARKETING.LOYALTY_CARD LOYAL ON A11.LOYALTY_CARD_NBR = LOYAL.LOYALTY_CARD_NBR 
				         JOIN SBX_BIZ.MARKETING.FISCAL_DAY D ON D.LY_SALES_DT = A11.SALES_DT 
				         JOIN SBX_BIZ.MARKETING.LINE LINE ON LINE.SALES_LINE_ID = A11.SALES_LINE_ID 
				         JOIN SBX_BIZ.MARKETING.I_SENIOR_DISCOUNT_STORES STORE_GROUP ON STORE_GROUP.STORE_NBR = LINE.STORE_NBR 
				         JOIN ( SELECT DISTINCT FEB.HH, 'Feb_21' AS STORE_GROUP FROM SBX_BIZ.MARKETING.I_SEN_DISC_REDEEM_FEB21_EXPANSION FEB) RED ON RED.HH = LOYAL.HOUSEHOLD_KEY
				WHERE    STORE_GROUP.STORE_GROUP = 'Feb_21'
				AND      D.SALES_DT BETWEEN '2021-01-02' AND CURRENT_DATE() - 1
				AND      A11.DEPT_KEY IN (60, 90, 40, 10, 11, 41, 15, 50, 13, 12, 70, 80, 20, 30, 110, 120, 250)
				AND      LINE.FORMAT_TYPE_ID = 'SUPERMKT'
				AND      LOYAL.CARD_TYPE_CD IN ('L', 'A')
				GROUP BY D.FISCAL_WEEK_ID, D.SALES_DT, LOYAL.HOUSEHOLD_KEY, LINE.STORE_NBR, 
				         A11.REGISTER_ID, STORE_GROUP.STORE_GROUP
) LY ON TY.FISCAL_WEEK_ID = LY.FISCAL_WEEK_ID AND TY.HOUSEHOLD_KEY = LY.HOUSEHOLD_KEY AND TY.SALES_DT = LY.SALES_DT AND TY.STORE_GROUP = LY.STORE_GROUP AND TY.STORE_NBR = LY.STORE_NBR AND TY.REGISTER_ID = LY.REGISTER_ID
) A

LEFT JOIN (
	SELECT   Distinct RED.HH,
         RED.STORE_GROUP,
         MIN(RED.DT) AS FIRST_REDEEM,
         COUNT(RED.DT) AS REDEMPTIONS
FROM     (
			SELECT   Distinct FEB.HH,
			         FEB.DT,
			         'Feb_21' AS STORE_GROUP
			FROM     SBX_BIZ.MARKETING.I_SEN_DISC_REDEEM_FEB21_EXPANSION FEB
) RED
GROUP BY RED.HH, RED.STORE_GROUP) R ON A.HOUSEHOLD_KEY = R.HH
			GROUP BY
				A.FISCAL_WEEK_ID,
				A.SALES_DT,
				A.STORE_NBR,
				A.HOUSEHOLD_KEY,
				R.FIRST_REDEEM,
				A.STORE_GROUP,
				CASE
					WHEN (A.SALES_DT >= R.FIRST_REDEEM) THEN 'Y'
					ELSE 'N'
				END) A
LEFT JOIN (
			SELECT
				DISTINCT M.HOUSEHOLD_KEY
			FROM
				SBX_BIZ.MARKETING.I_MANAGER_CARDS M) MAN ON
			((A.HOUSEHOLD_KEY = MAN.HOUSEHOLD_KEY)))
		GROUP BY
			A.FISCAL_WEEK_ID,
			A.SALES_DT,
			A.STORE_NBR,
			CASE
				WHEN (MAN.HOUSEHOLD_KEY IS NULL) THEN 'N'
				ELSE 'Y'
			END,
			A.POST_REDEEM) FEB_21)
-----------
UNION (
SELECT
	DISTINCT FF_NORTH.FISCAL_WEEK_ID,
	FF_NORTH.SALES_DT,
	FF_NORTH.STORE_NBR,
	FF_NORTH.MANAGER,
	FF_NORTH.POST_REDEEM,
	FF_NORTH.TRANS_TY,
	FF_NORTH.SALES_TY,
	FF_NORTH.SALES_QTY_TY,
	FF_NORTH.PROFIT_TY,
	FF_NORTH.TRANS_LY,
	FF_NORTH.SALES_LY,
	FF_NORTH.SALES_QTY_LY,
	FF_NORTH.PROFIT_LY
FROM
	(
	SELECT
		DISTINCT A.FISCAL_WEEK_ID,
		A.SALES_DT,
		A.STORE_NBR,
		CASE
			WHEN (MAN.HOUSEHOLD_KEY IS NULL) THEN 'N'
			ELSE 'Y'
		END AS MANAGER,
		A.POST_REDEEM,
		SUM(A.TRANS_TY) AS TRANS_TY,
		SUM(A.SALES_TY) AS SALES_TY,
		SUM(A.SALES_QTY_TY) AS SALES_QTY_TY,
		SUM(A.PROFIT_TY) AS PROFIT_TY,
		SUM(A.TRANS_LY) AS TRANS_LY,
		SUM(A.SALES_LY) AS SALES_LY,
		SUM(A.SALES_QTY_LY) AS SALES_QTY_LY,
		SUM(A.PROFIT_LY) AS PROFIT_LY
	FROM
		((
		SELECT
			DISTINCT A.FISCAL_WEEK_ID,
			A.SALES_DT,
			A.STORE_NBR,
			A.HOUSEHOLD_KEY,
			R.FIRST_REDEEM,
			A.STORE_GROUP,
			CASE
				WHEN (A.SALES_DT >= R.FIRST_REDEEM) THEN 'Y'
				ELSE 'N'
			END AS POST_REDEEM,
			SUM(A.TRANS_TY) AS TRANS_TY,
			SUM(A.SALES_TY) AS SALES_TY,
			SUM(A.SALES_QTY_TY) AS SALES_QTY_TY,
			SUM(A.PROFIT_TY) AS PROFIT_TY,
			SUM(A.TRANS_LY) AS TRANS_LY,
			SUM(A.SALES_LY) AS SALES_LY,
			SUM(A.SALES_QTY_LY) AS SALES_QTY_LY,
			SUM(A.PROFIT_LY) AS PROFIT_LY
		FROM
			((
			SELECT
				DISTINCT CASE
					WHEN (TY.FISCAL_WEEK_ID IS NOT NULL) THEN TY.FISCAL_WEEK_ID
					WHEN (LY.FISCAL_WEEK_ID IS NOT NULL) THEN LY.FISCAL_WEEK_ID
					ELSE NULL
				END AS FISCAL_WEEK_ID,
				CASE
					WHEN (TY.SALES_DT IS NOT NULL) THEN TY.SALES_DT
					WHEN (LY.SALES_DT IS NOT NULL) THEN LY.SALES_DT
					ELSE NULL
				END AS SALES_DT,
				CASE
					WHEN (TY.HOUSEHOLD_KEY IS NOT NULL) THEN TY.HOUSEHOLD_KEY
					WHEN (LY.HOUSEHOLD_KEY IS NOT NULL) THEN LY.HOUSEHOLD_KEY
					ELSE NULL
				END AS HOUSEHOLD_KEY,
				CASE
					WHEN (TY.STORE_NBR IS NOT NULL) THEN TY.STORE_NBR
					WHEN (LY.STORE_NBR IS NOT NULL) THEN LY.STORE_NBR
					ELSE NULL
				END AS STORE_NBR,
				CASE
					WHEN (TY.STORE_GROUP IS NOT NULL) THEN TY.STORE_GROUP
					WHEN (LY.STORE_GROUP IS NOT NULL) THEN LY.STORE_GROUP
					ELSE NULL
				END AS STORE_GROUP,
				CASE
					WHEN (TY.REGISTER_ID IS NOT NULL) THEN TY.REGISTER_ID
					WHEN (LY.REGISTER_ID IS NOT NULL) THEN LY.REGISTER_ID
					ELSE NULL
				END AS REGISTER_ID,
				CASE
					WHEN (TY.TRANS = 0) THEN NULL
					ELSE TY.TRANS
				END AS TRANS_TY,
				CASE
					WHEN (TY.SALES = 0) THEN NULL
					ELSE TY.SALES
				END AS SALES_TY,
				CASE
					WHEN (TY.SALES_QTY = 0) THEN NULL
					ELSE TY.SALES_QTY
				END AS SALES_QTY_TY,
				CASE
					WHEN (TY.PROFIT = 0) THEN NULL
					ELSE TY.PROFIT
				END AS PROFIT_TY,
				CASE
					WHEN (LY.TRANS = 0) THEN NULL
					ELSE LY.TRANS
				END AS TRANS_LY,
				CASE
					WHEN (LY.SALES = 0) THEN NULL
					ELSE LY.SALES
				END AS SALES_LY,
				CASE
					WHEN (LY.SALES_QTY = 0) THEN NULL
					ELSE LY.SALES_QTY
				END AS SALES_QTY_LY,
				CASE
					WHEN (LY.PROFIT = 0) THEN NULL
					ELSE LY.PROFIT
				END AS PROFIT_LY
			FROM
				((
				SELECT
					D.FISCAL_WEEK_ID,
					D.SALES_DT,
					LOYAL.HOUSEHOLD_KEY,
					LINE.STORE_NBR,
					A11.REGISTER_ID,
					STORE_GROUP.STORE_GROUP,
					COUNT(DISTINCT A11.TRANS_NBR) AS TRANS,
					SUM(A11.TOTAL_SALES_QTY) AS SALES_QTY,
					SUM(A11.TOTAL_SALES_AMT) AS SALES,
					SUM((((A11.TOTAL_SALES_AMT - A11.EXT_COST_AMT) + A11.EXT_COST_ALLW_AMT) + A11.EXT_BILLBACK_AMT)) AS PROFIT
				FROM
					(((((SBX_BIZ.MARKETING.RSAL_DY_LN_ITM_TRN A11
				JOIN SBX_BIZ.MARKETING.LOYALTY_CARD LOYAL ON
					((A11.LOYALTY_CARD_NBR = LOYAL.LOYALTY_CARD_NBR)))
				JOIN SBX_BIZ.MARKETING.FISCAL_DAY D ON
					((D.SALES_DT = A11.SALES_DT)))
				JOIN SBX_BIZ.MARKETING.LINE LINE ON
					(((LINE.SALES_LINE_ID) = A11.SALES_LINE_ID)))
				JOIN SBX_BIZ.MARKETING.I_SENIOR_DISCOUNT_STORES STORE_GROUP ON
					((STORE_GROUP.STORE_NBR = LINE.STORE_NBR)))
				JOIN (
					SELECT
						DISTINCT FF_NORTH.HH,
						'FF_North' AS STORE_GROUP
					FROM
						SBX_BIZ.MARKETING.I_SEN_DISC_REDEEM_FF_NORTH FF_NORTH) RED ON
					((RED.HH = LOYAL.HOUSEHOLD_KEY)))
				WHERE
					(((((STORE_GROUP.STORE_GROUP = 'FF_North')
						AND (D.SALES_DT > '2021-01-02'))
						AND (A11.DEPT_KEY IN (60, 90, 40, 10, 11, 41, 15, 50, 13, 12, 70, 80, 20, 30, 110, 120, 250)))
						AND (LINE.FORMAT_TYPE_ID = 'SUPERMKT'))
						AND (LOYAL.CARD_TYPE_CD IN ('L', 'A')))
				GROUP BY
					D.FISCAL_WEEK_ID,
					D.SALES_DT,
					LOYAL.HOUSEHOLD_KEY,
					LINE.STORE_NBR,
					A11.REGISTER_ID,
					STORE_GROUP.STORE_GROUP) TY
			FULL JOIN (
				SELECT
					D.FISCAL_WEEK_ID,
					D.SALES_DT,
					LOYAL.HOUSEHOLD_KEY,
					LINE.STORE_NBR,
					A11.REGISTER_ID,
					STORE_GROUP.STORE_GROUP,
					COUNT(DISTINCT A11.TRANS_NBR) AS TRANS,
					SUM(A11.TOTAL_SALES_QTY) AS SALES_QTY,
					SUM(A11.TOTAL_SALES_AMT) AS SALES,
					SUM((((A11.TOTAL_SALES_AMT - A11.EXT_COST_AMT) + A11.EXT_COST_ALLW_AMT) + A11.EXT_BILLBACK_AMT)) AS PROFIT
				FROM
					(((((SBX_BIZ.MARKETING.RSAL_DY_LN_ITM_TRN A11
				JOIN SBX_BIZ.MARKETING.LOYALTY_CARD LOYAL ON
					((A11.LOYALTY_CARD_NBR = LOYAL.LOYALTY_CARD_NBR)))
				JOIN SBX_BIZ.MARKETING.FISCAL_DAY D ON
					((D.LY_SALES_DT = A11.SALES_DT)))
				JOIN SBX_BIZ.MARKETING.LINE LINE ON
					(((LINE.SALES_LINE_ID) = A11.SALES_LINE_ID)))
				JOIN SBX_BIZ.MARKETING.I_SENIOR_DISCOUNT_STORES STORE_GROUP ON
					((STORE_GROUP.STORE_NBR = LINE.STORE_NBR)))
				JOIN (
					SELECT
						DISTINCT FF_NORTH.HH,
						'FF_North' AS STORE_GROUP
					FROM
						SBX_BIZ.MARKETING.I_SEN_DISC_REDEEM_FF_NORTH FF_NORTH) RED ON
					((RED.HH = LOYAL.HOUSEHOLD_KEY)))
				WHERE
					((((((STORE_GROUP.STORE_GROUP = 'FF_North')
						AND (D.SALES_DT > '2021-01-02'))
						AND (D.SALES_DT < ((
						SELECT
							MAX(E.SALES_DT) AS SALES_DT
						FROM
							SBX_BIZ.MARKETING.EFIN_DAY_LN_DPT E
						WHERE
							(E.TOTAL_SALES_AMT > 0)) + 7)))
						AND (A11.DEPT_KEY IN (60, 90, 40, 10, 11, 41, 15, 50, 13, 12, 70, 80, 20, 30, 110, 120, 250)))
						AND (LINE.FORMAT_TYPE_ID = 'SUPERMKT'))
						AND (LOYAL.CARD_TYPE_CD IN ('L', 'A')))
				GROUP BY
					D.FISCAL_WEEK_ID,
					D.SALES_DT,
					LOYAL.HOUSEHOLD_KEY,
					LINE.STORE_NBR,
					A11.REGISTER_ID,
					STORE_GROUP.STORE_GROUP) LY ON
				(((((((TY.FISCAL_WEEK_ID = LY.FISCAL_WEEK_ID)
					AND (TY.HOUSEHOLD_KEY = LY.HOUSEHOLD_KEY))
					AND (TY.SALES_DT = LY.SALES_DT))
					AND (TY.STORE_GROUP = LY.STORE_GROUP))
					AND (TY.STORE_NBR = LY.STORE_NBR))
					AND (TY.REGISTER_ID = LY.REGISTER_ID))))) A
		LEFT JOIN (
			SELECT
				DISTINCT RED.HH,
				RED.STORE_GROUP,
				MIN(RED.DT) AS FIRST_REDEEM,
				COUNT(RED.DT) AS REDEMPTIONS
			FROM
				(
				SELECT
					DISTINCT FF_NORTH.HH,
					FF_NORTH.DT,
					'FF_North' AS STORE_GROUP
				FROM
					SBX_BIZ.MARKETING.I_SEN_DISC_REDEEM_FF_NORTH FF_NORTH) RED
			GROUP BY
				RED.HH,
				RED.STORE_GROUP) R ON
			((A.HOUSEHOLD_KEY = R.HH)))
		GROUP BY
			A.FISCAL_WEEK_ID,
			A.SALES_DT,
			A.STORE_NBR,
			A.HOUSEHOLD_KEY,
			R.FIRST_REDEEM,
			A.STORE_GROUP,
			CASE
				WHEN (A.SALES_DT >= R.FIRST_REDEEM) THEN 'Y'
				ELSE 'N'
			END) A
	LEFT JOIN (
		SELECT
			DISTINCT M.HOUSEHOLD_KEY
		FROM
			SBX_BIZ.MARKETING.I_MANAGER_CARDS M) MAN ON
		((A.HOUSEHOLD_KEY = MAN.HOUSEHOLD_KEY)))
	GROUP BY
		A.FISCAL_WEEK_ID,
		A.SALES_DT,
		A.STORE_NBR,
		CASE
			WHEN (MAN.HOUSEHOLD_KEY IS NULL) THEN 'N'
			ELSE 'Y'
		END,
		A.POST_REDEEM) FF_NORTH))
UNION (
SELECT
	DISTINCT VG.FISCAL_WEEK_ID,
	VG.SALES_DT,
	VG.STORE_NBR,
	VG.MANAGER,
	VG.POST_REDEEM,
	VG.TRANS_TY,
	VG.SALES_TY,
	VG.SALES_QTY_TY,
	VG.PROFIT_TY,
	VG.TRANS_LY,
	VG.SALES_LY,
	VG.SALES_QTY_LY,
	VG.PROFIT_LY
FROM
	(
	SELECT
		DISTINCT A.FISCAL_WEEK_ID,
		A.SALES_DT,
		A.STORE_NBR,
		CASE
			WHEN (MAN.HOUSEHOLD_KEY IS NULL) THEN 'N'
			ELSE 'Y'
		END AS MANAGER,
		A.POST_REDEEM,
		SUM(A.TRANS_TY) AS TRANS_TY,
		SUM(A.SALES_TY) AS SALES_TY,
		SUM(A.SALES_QTY_TY) AS SALES_QTY_TY,
		SUM(A.PROFIT_TY) AS PROFIT_TY,
		SUM(A.TRANS_LY) AS TRANS_LY,
		SUM(A.SALES_LY) AS SALES_LY,
		SUM(A.SALES_QTY_LY) AS SALES_QTY_LY,
		SUM(A.PROFIT_LY) AS PROFIT_LY
	FROM
		((
		SELECT
			DISTINCT A.FISCAL_WEEK_ID,
			A.SALES_DT,
			A.STORE_NBR,
			A.HOUSEHOLD_KEY,
			R.FIRST_REDEEM,
			A.STORE_GROUP,
			CASE
				WHEN (A.SALES_DT >= R.FIRST_REDEEM) THEN 'Y'
				ELSE 'N'
			END AS POST_REDEEM,
			SUM(A.TRANS_TY) AS TRANS_TY,
			SUM(A.SALES_TY) AS SALES_TY,
			SUM(A.SALES_QTY_TY) AS SALES_QTY_TY,
			SUM(A.PROFIT_TY) AS PROFIT_TY,
			SUM(A.TRANS_LY) AS TRANS_LY,
			SUM(A.SALES_LY) AS SALES_LY,
			SUM(A.SALES_QTY_LY) AS SALES_QTY_LY,
			SUM(A.PROFIT_LY) AS PROFIT_LY
		FROM
			((
			SELECT
				DISTINCT CASE
					WHEN (TY.FISCAL_WEEK_ID IS NOT NULL) THEN TY.FISCAL_WEEK_ID
					WHEN (LY.FISCAL_WEEK_ID IS NOT NULL) THEN LY.FISCAL_WEEK_ID
					ELSE NULL
				END AS FISCAL_WEEK_ID,
				CASE
					WHEN (TY.SALES_DT IS NOT NULL) THEN TY.SALES_DT
					WHEN (LY.SALES_DT IS NOT NULL) THEN LY.SALES_DT
					ELSE NULL
				END AS SALES_DT,
				CASE
					WHEN (TY.HOUSEHOLD_KEY IS NOT NULL) THEN TY.HOUSEHOLD_KEY
					WHEN (LY.HOUSEHOLD_KEY IS NOT NULL) THEN LY.HOUSEHOLD_KEY
					ELSE NULL
				END AS HOUSEHOLD_KEY,
				CASE
					WHEN (TY.STORE_NBR IS NOT NULL) THEN TY.STORE_NBR
					WHEN (LY.STORE_NBR IS NOT NULL) THEN LY.STORE_NBR
					ELSE NULL
				END AS STORE_NBR,
				CASE
					WHEN (TY.STORE_GROUP IS NOT NULL) THEN TY.STORE_GROUP
					WHEN (LY.STORE_GROUP IS NOT NULL) THEN LY.STORE_GROUP
					ELSE NULL
				END AS STORE_GROUP,
				CASE
					WHEN (TY.REGISTER_ID IS NOT NULL) THEN TY.REGISTER_ID
					WHEN (LY.REGISTER_ID IS NOT NULL) THEN LY.REGISTER_ID
					ELSE NULL
				END AS REGISTER_ID,
				CASE
					WHEN (TY.TRANS = 0) THEN NULL
					ELSE TY.TRANS
				END AS TRANS_TY,
				CASE
					WHEN (TY.SALES = 0) THEN NULL
					ELSE TY.SALES
				END AS SALES_TY,
				CASE
					WHEN (TY.SALES_QTY = 0) THEN NULL
					ELSE TY.SALES_QTY
				END AS SALES_QTY_TY,
				CASE
					WHEN (TY.PROFIT = 0) THEN NULL
					ELSE TY.PROFIT
				END AS PROFIT_TY,
				CASE
					WHEN (LY.TRANS = 0) THEN NULL
					ELSE LY.TRANS
				END AS TRANS_LY,
				CASE
					WHEN (LY.SALES = 0) THEN NULL
					ELSE LY.SALES
				END AS SALES_LY,
				CASE
					WHEN (LY.SALES_QTY = 0) THEN NULL
					ELSE LY.SALES_QTY
				END AS SALES_QTY_LY,
				CASE
					WHEN (LY.PROFIT = 0) THEN NULL
					ELSE LY.PROFIT
				END AS PROFIT_LY
			FROM
				((
				SELECT
					D.FISCAL_WEEK_ID,
					D.SALES_DT,
					LOYAL.HOUSEHOLD_KEY,
					LINE.STORE_NBR,
					A11.REGISTER_ID,
					STORE_GROUP.STORE_GROUP,
					COUNT(DISTINCT A11.TRANS_NBR) AS TRANS,
					SUM(A11.TOTAL_SALES_QTY) AS SALES_QTY,
					SUM(A11.TOTAL_SALES_AMT) AS SALES,
					SUM((((A11.TOTAL_SALES_AMT - A11.EXT_COST_AMT) + A11.EXT_COST_ALLW_AMT) + A11.EXT_BILLBACK_AMT)) AS PROFIT
				FROM
					(((((SBX_BIZ.MARKETING.RSAL_DY_LN_ITM_TRN A11
				JOIN SBX_BIZ.MARKETING.LOYALTY_CARD LOYAL ON
					((A11.LOYALTY_CARD_NBR = LOYAL.LOYALTY_CARD_NBR)))
				JOIN SBX_BIZ.MARKETING.FISCAL_DAY D ON
					((D.SALES_DT = A11.SALES_DT)))
				JOIN SBX_BIZ.MARKETING.LINE LINE ON
					(((LINE.SALES_LINE_ID) = A11.SALES_LINE_ID)))
				JOIN SBX_BIZ.MARKETING.I_SENIOR_DISCOUNT_STORES STORE_GROUP ON
					((STORE_GROUP.STORE_NBR = LINE.STORE_NBR)))
				JOIN (
					SELECT
						DISTINCT VG.HH,
						'VG' AS STORE_GROUP
					FROM
						SBX_BIZ.MARKETING.I_SEN_DISC_REDEEM_VG VG) RED ON
					((RED.HH = LOYAL.HOUSEHOLD_KEY)))
				WHERE
					(((((STORE_GROUP.STORE_GROUP = 'VG')
						AND (D.SALES_DT > '2021-01-02'))
						AND (A11.DEPT_KEY IN (60, 90, 40, 10, 11, 41, 15, 50, 13, 12, 70, 80, 20, 30, 110, 120, 250)))
						AND (LINE.FORMAT_TYPE_ID = 'SUPERMKT'))
						AND (LOYAL.CARD_TYPE_CD IN ('L', 'A')))
				GROUP BY
					D.FISCAL_WEEK_ID,
					D.SALES_DT,
					LOYAL.HOUSEHOLD_KEY,
					LINE.STORE_NBR,
					A11.REGISTER_ID,
					STORE_GROUP.STORE_GROUP) TY
			FULL JOIN (
				SELECT
					D.FISCAL_WEEK_ID,
					D.SALES_DT,
					LOYAL.HOUSEHOLD_KEY,
					LINE.STORE_NBR,
					A11.REGISTER_ID,
					STORE_GROUP.STORE_GROUP,
					COUNT(DISTINCT A11.TRANS_NBR) AS TRANS,
					SUM(A11.TOTAL_SALES_QTY) AS SALES_QTY,
					SUM(A11.TOTAL_SALES_AMT) AS SALES,
					SUM((((A11.TOTAL_SALES_AMT - A11.EXT_COST_AMT) + A11.EXT_COST_ALLW_AMT) + A11.EXT_BILLBACK_AMT)) AS PROFIT
				FROM
					(((((SBX_BIZ.MARKETING.RSAL_DY_LN_ITM_TRN A11
				JOIN SBX_BIZ.MARKETING.LOYALTY_CARD LOYAL ON
					((A11.LOYALTY_CARD_NBR = LOYAL.LOYALTY_CARD_NBR)))
				JOIN SBX_BIZ.MARKETING.FISCAL_DAY D ON
					((D.LY_SALES_DT = A11.SALES_DT)))
				JOIN SBX_BIZ.MARKETING.LINE LINE ON
					(((LINE.SALES_LINE_ID) = A11.SALES_LINE_ID)))
				JOIN SBX_BIZ.MARKETING.I_SENIOR_DISCOUNT_STORES STORE_GROUP ON
					((STORE_GROUP.STORE_NBR = LINE.STORE_NBR)))
				JOIN (
					SELECT
						DISTINCT VG.HH,
						'VG' AS STORE_GROUP
					FROM
						SBX_BIZ.MARKETING.I_SEN_DISC_REDEEM_VG VG) RED ON
					((RED.HH = LOYAL.HOUSEHOLD_KEY)))
				WHERE
					((((((STORE_GROUP.STORE_GROUP = 'VG')
						AND (D.SALES_DT > '2021-01-02'))
						AND (D.SALES_DT < ((
						SELECT
							MAX(E.SALES_DT) AS SALES_DT
						FROM
							SBX_BIZ.MARKETING.EFIN_DAY_LN_DPT E
						WHERE
							(E.TOTAL_SALES_AMT > 0)) + 7)))
						AND (A11.DEPT_KEY IN (60, 90, 40, 10, 11, 41, 15, 50, 13, 12, 70, 80, 20, 30, 110, 120, 250)))
						AND (LINE.FORMAT_TYPE_ID = 'SUPERMKT'))
						AND (LOYAL.CARD_TYPE_CD IN ('L', 'A')))
				GROUP BY
					D.FISCAL_WEEK_ID,
					D.SALES_DT,
					LOYAL.HOUSEHOLD_KEY,
					LINE.STORE_NBR,
					A11.REGISTER_ID,
					STORE_GROUP.STORE_GROUP) LY ON
				(((((((TY.FISCAL_WEEK_ID = LY.FISCAL_WEEK_ID)
					AND (TY.HOUSEHOLD_KEY = LY.HOUSEHOLD_KEY))
					AND (TY.SALES_DT = LY.SALES_DT))
					AND (TY.STORE_GROUP = LY.STORE_GROUP))
					AND (TY.STORE_NBR = LY.STORE_NBR))
					AND (TY.REGISTER_ID = LY.REGISTER_ID))))) A
		LEFT JOIN (
			SELECT
				DISTINCT RED.HH,
				RED.STORE_GROUP,
				MIN(RED.DT) AS FIRST_REDEEM,
				COUNT(RED.DT) AS REDEMPTIONS
			FROM
				(
				SELECT
					DISTINCT VG.HH,
					VG.DT,
					'VG' AS STORE_GROUP
				FROM
					SBX_BIZ.MARKETING.I_SEN_DISC_REDEEM_VG VG) RED
			GROUP BY
				RED.HH,
				RED.STORE_GROUP) R ON
			((A.HOUSEHOLD_KEY = R.HH)))
		GROUP BY
			A.FISCAL_WEEK_ID,
			A.SALES_DT,
			A.STORE_NBR,
			A.HOUSEHOLD_KEY,
			R.FIRST_REDEEM,
			A.STORE_GROUP,
			CASE
				WHEN (A.SALES_DT >= R.FIRST_REDEEM) THEN 'Y'
				ELSE 'N'
			END) A
	LEFT JOIN (
		SELECT
			DISTINCT M.HOUSEHOLD_KEY
		FROM
			SBX_BIZ.MARKETING.I_MANAGER_CARDS M) MAN ON
		((A.HOUSEHOLD_KEY = MAN.HOUSEHOLD_KEY)))
	GROUP BY
		A.FISCAL_WEEK_ID,
		A.SALES_DT,
		A.STORE_NBR,
		CASE
			WHEN (MAN.HOUSEHOLD_KEY IS NULL) THEN 'N'
			ELSE 'Y'
		END,
		A.POST_REDEEM) VG)) ALL_SENIOR_GROUPS;