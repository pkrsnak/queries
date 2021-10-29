--aggregated query
select count(*) from (
SELECT   bed.TRANSACTION_DATE,
         bed.FISCAL_DAY_ID,
         bed.FISCAL_WEEK_ID,
         bed.FISCAL_PERIOD_ID,
         bed.FISCAL_YEAR_ID,
         bed.FACILITY_ID,
         bed.SHIP_FACILITY_ID,
         bed.INVOICE_NBR,
         bed.WHSE_ID,
         i.BUYER_ID,
         i.VENDOR_NBR,
         mgrp.DEPT_KEY,
         cst.CORPORATION_ID,
         cst.CUSTOMER_NBR,
         bed.ITEM_NBR,
         i.ITEM_RANK_CD,
         i.ITEM_RES28_CD,
         bed.COMMODITY_CODE,
         mcls.MDSE_CLASS_KEY,
         mcat.mdse_catgy_key,
         mgrp.mdse_grp_key,
         sum(bed.qty) Ordered_Qty,
         sum((Case when serr.SHIP_ERROR_GRP_CD = 5 then bed.qty else 0 end)) Shipped_Qty,
         sum((Case when serr.SHIP_ERROR_GRP_CD = 6 then bed.qty else 0 end)) Excluded_NS,
         sum((Case when serr.SHIP_ERROR_GRP_CD = 4 then bed.qty else 0 end)) Vendor_NS,
         sum((Case when serr.SHIP_ERROR_GRP_CD = 3 then bed.qty else 0 end)) Unauthorized_NS,
         sum((Case when serr.SHIP_ERROR_GRP_CD = 1 then bed.qty else 0 end)) Buyer_NS,
         sum((Case when serr.SHIP_ERROR_GRP_CD = 2 then bed.qty else 0 end)) SupplyChain_NS,
         sum((Case when bed.SHIP_ERROR_CD = 'MK' then bed.qty else 0 end)) GR_Markout_NS
from (
		SELECT   bed.TRANSACTION_DATE,
		         fd.FISCAL_DAY_ID,
		         fd.FISCAL_WEEK_ID,
		         fd.FISCAL_PERIOD_ID,
		         fd.FISCAL_YEAR_ID,
		         bed.FACILITY_ID,
		         bed.SHIP_FACILITY_ID,
		         bed.WHSE_ID, bed.COMMODITY_CODE, 
		         bed.CUSTOMER_NBR,
		         bed.INVOICE_NBR,
		         bed.ITEM_NBR,
		         bed.SHIP_ERROR_CD,
		         bed.NOT_SHIP_CASE_QTY qty
		FROM     WH_OWNER.DC_BILL_ERROR_DTL bed 
		         inner join WH_OWNER.FISCAL_DAY fd on fd.SALES_DT = bed.TRANSACTION_DATE
		WHERE    fd.FISCAL_WEEK_ID = 202133
                 and bed.FACILITY_ID NOT IN (180,827,847,64,65,9,95,999,29,59,21,28,62,5,115,16,24,105,27,817,33,170,39,145,165,63,38,807,26,69,70)
    		union all
		SELECT   wsd.TRANSACTION_DATE,
		         fd.FISCAL_DAY_ID,
		         fd.FISCAL_WEEK_ID,
		         fd.FISCAL_PERIOD_ID,
		         fd.FISCAL_YEAR_ID,
		         wsd.FACILITY_ID,
		         wsd.SHIP_FACILITY_ID,
		         wsd.WHSE_ID, wsd.COMMODITY_CODE, 
		         wsd.CUSTOMER_NBR,
		         wsd.INVOICE_NBR,
		         wsd.ITEM_NBR,
		         wsd.SHIP_ERROR_CD,
		         wsd.SHIP_CASE_QTY qty
		FROM     WH_OWNER.DC_WHSE_SHIP_DTL wsd 
		         inner join WH_OWNER.FISCAL_DAY fd on fd.SALES_DT = wsd.TRANSACTION_DATE
		WHERE    fd.FISCAL_WEEK_ID = 202133
                 and wsd.FACILITY_ID NOT IN (180,827,847,64,65,9,95,999,29,59,21,28,62,5,115,16,24,105,27,817,33,170,39,145,165,63,38,807,26,69,70)
		) bed
         inner join DC_CUSTOMER cst on (bed.CUSTOMER_NBR = cst.CUSTOMER_NBR and bed.FACILITY_ID = cst.FACILITY_ID) 
         inner join DC_ITEM i on (bed.FACILITY_ID = i.FACILITY_ID and bed.ITEM_NBR = i.ITEM_NBR) 
         inner join MDSE_CLASS mcls on (i.MDSE_CLASS_KEY = mcls.MDSE_CLASS_KEY) 
         inner join mdse_category mcat on (mcls.mdse_catgy_key = mcat.mdse_catgy_key) 
         inner join mdse_group mgrp on (mcat.mdse_grp_key = mgrp.mdse_grp_key) 
         inner join FISCAL_DAY fd on (bed.TRANSACTION_DATE = fd.SALES_DT) 
         inner join SHIP_ERROR serr on (bed.SHIP_ERROR_CD = serr.SHIP_ERROR_CD) 
group by bed.TRANSACTION_DATE,
         bed.FISCAL_DAY_ID,
         bed.FISCAL_WEEK_ID,
         bed.FISCAL_PERIOD_ID,
         bed.FISCAL_YEAR_ID,
         bed.FACILITY_ID,
         bed.SHIP_FACILITY_ID,
         bed.INVOICE_NBR,
         bed.WHSE_ID,
         i.BUYER_ID,
         i.VENDOR_NBR,
         mgrp.DEPT_KEY,
         cst.CORPORATION_ID,
         cst.CUSTOMER_NBR,
         bed.ITEM_NBR,
         i.ITEM_RANK_CD,
         i.ITEM_RES28_CD,
         bed.COMMODITY_CODE,
         mcls.MDSE_CLASS_KEY,
         mcat.mdse_catgy_key,
         mgrp.mdse_grp_key
--having sum((Case when serr.SHIP_ERROR_GRP_CD = 2 then bed.qty else 0 end)) > 0
) x
;

select count(*) from (
--no agg query
SELECT   bed.TRANSACTION_DATE,
         bed.FISCAL_DAY_ID,
         bed.FISCAL_WEEK_ID,
         bed.FISCAL_PERIOD_ID,
         bed.FISCAL_YEAR_ID,
         bed.FACILITY_ID,
         bed.SHIP_FACILITY_ID,
         bed.INVOICE_NBR,
         bed.WHSE_ID,
         i.BUYER_ID,
         i.VENDOR_NBR,
         mgrp.DEPT_KEY,
         cst.CORPORATION_ID,
         cst.CUSTOMER_NBR,
         bed.ITEM_NBR,
         i.ITEM_RANK_CD,
         i.ITEM_RES28_CD,
         bed.COMMODITY_CODE,
         mcls.MDSE_CLASS_KEY,
         mcat.mdse_catgy_key,
         mgrp.mdse_grp_key,
         bed.qty Ordered_Qty,
         (Case when serr.SHIP_ERROR_GRP_CD = 5 then bed.qty else 0 end) Shipped_Qty,
         (Case when serr.SHIP_ERROR_GRP_CD = 6 then bed.qty else 0 end) Excluded_NS,
         (Case when serr.SHIP_ERROR_GRP_CD = 4 then bed.qty else 0 end) Vendor_NS,
         (Case when serr.SHIP_ERROR_GRP_CD = 3 then bed.qty else 0 end) Unauthorized_NS,
         (Case when serr.SHIP_ERROR_GRP_CD = 1 then bed.qty else 0 end) Buyer_NS,
         (Case when serr.SHIP_ERROR_GRP_CD = 2 then bed.qty else 0 end) SupplyChain_NS,
         (Case when bed.SHIP_ERROR_CD = 'MK' then bed.qty else 0 end) GR_Markout_NS
from (
		SELECT   bed.TRANSACTION_DATE,
		         fd.FISCAL_DAY_ID,
		         fd.FISCAL_WEEK_ID,
		         fd.FISCAL_PERIOD_ID,
		         fd.FISCAL_YEAR_ID,
		         bed.FACILITY_ID,
		         bed.SHIP_FACILITY_ID,
		         bed.WHSE_ID, bed.COMMODITY_CODE, 
		         bed.CUSTOMER_NBR,
		         bed.INVOICE_NBR,
		         bed.ITEM_NBR,
		         bed.SHIP_ERROR_CD,
		         bed.NOT_SHIP_CASE_QTY qty
		FROM     WH_OWNER.DC_BILL_ERROR_DTL bed 
		         inner join WH_OWNER.FISCAL_DAY fd on fd.SALES_DT = bed.TRANSACTION_DATE
		WHERE    fd.FISCAL_WEEK_ID = 202133
                 and bed.FACILITY_ID NOT IN (180,827,847,64,65,9,95,999,29,59,21,28,62,5,115,16,24,105,27,817,33,170,39,145,165,63,38,807,26,69,70)
    		union all
		SELECT   wsd.TRANSACTION_DATE,
		         fd.FISCAL_DAY_ID,
		         fd.FISCAL_WEEK_ID,
		         fd.FISCAL_PERIOD_ID,
		         fd.FISCAL_YEAR_ID,
		         wsd.FACILITY_ID,
		         wsd.SHIP_FACILITY_ID,
		         wsd.WHSE_ID, wsd.COMMODITY_CODE, 
		         wsd.CUSTOMER_NBR,
		         wsd.INVOICE_NBR,
		         wsd.ITEM_NBR,
		         wsd.SHIP_ERROR_CD,
		         wsd.SHIP_CASE_QTY qty
		FROM     WH_OWNER.DC_WHSE_SHIP_DTL wsd 
		         inner join WH_OWNER.FISCAL_DAY fd on fd.SALES_DT = wsd.TRANSACTION_DATE
		WHERE    fd.FISCAL_WEEK_ID = 202133
                 and wsd.FACILITY_ID NOT IN (180,827,847,64,65,9,95,999,29,59,21,28,62,5,115,16,24,105,27,817,33,170,39,145,165,63,38,807,26,69,70)
		) bed
         inner join DC_CUSTOMER cst on (bed.CUSTOMER_NBR = cst.CUSTOMER_NBR and bed.FACILITY_ID = cst.FACILITY_ID) 
         inner join DC_ITEM i on (bed.FACILITY_ID = i.FACILITY_ID and bed.ITEM_NBR = i.ITEM_NBR) 
         inner join MDSE_CLASS mcls on (i.MDSE_CLASS_KEY = mcls.MDSE_CLASS_KEY) 
         inner join mdse_category mcat on (mcls.mdse_catgy_key = mcat.mdse_catgy_key) 
         inner join mdse_group mgrp on (mcat.mdse_grp_key = mgrp.mdse_grp_key) 
         inner join FISCAL_DAY fd on (bed.TRANSACTION_DATE = fd.SALES_DT) 
         inner join SHIP_ERROR serr on (bed.SHIP_ERROR_CD = serr.SHIP_ERROR_CD) 
) x