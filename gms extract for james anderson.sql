SELECT   sd.BRANCH_NBR,
         sd.DELIVERY_DATE,
         sd.INVOICE_NUM,
         sd.CUST_NBR,
         im.DHI_PRODUCT_GROUP,
         im.DHI_PRODUCT_SUB_GROUP,
         im.DHI_VENDOR_NO,
         im.DHI_ITEM_NUMBER,
         sd.ITEM_NBR,
         sd.PVT_LABEL_FLAG,
         sd.DEPT,
         sd.ORDER_TYPE,
         sd.OUT_CODE,
         DECODE (branch_nbr, '065', DECODE (sd.qty_marked_out, 0, sd.qty_recd_sign * sd.qty_recd_by_cust, (sd.qty_recd_sign * sd.qty_recd_by_cust) - sd.qty_marked_out), sd.qty_recd_sign * sd.qty_recd_by_cust ) AS qty_shipped,
          sd.qty_marked_out AS outs,
          (sd.qty_recd_sign * sd.layer_cost_ext) AS layer_cost_total,
          (sd.qty_recd_sign * sd.inv_cost_ext) AS inv_cost_total,
          (sd.qty_recd_sign * sd.spread_cost_ext) AS spread_cost_total,
          (sd.qty_recd_sign * sd.invoice_sell_ext) AS invoice_sell_total,
          (sd.qty_recd_sign * sd.retl_ext) AS retl_total,
          (sd.qty_recd_sign * sd.unit_inv_cost) AS unit_inv_cost_total,
          (DECODE (sd.branch_nbr, 
               '015', (DECODE (sd.order_type, 'CR', 0, 'OO', 0, 'OR', 0, sd.qty_recd_sign * sd.inv_cost_ext)),
               '058', (DECODE (sd.order_type, 'CR', 0, 'OO', 0, 'OR', 0, sd.qty_recd_sign * sd.inv_cost_ext)),
               '059', (DECODE (sd.order_type, 'CR', 0, 'OO', 0, 'OR', 0, sd.qty_recd_sign * sd.inv_cost_ext)),
               '061', (DECODE (sd.order_type, 'CR', 0, 'OO', 0, 'OR', 0, sd.qty_recd_sign * sd.inv_cost_ext)),
               '062', (DECODE (sd.order_type, 'CR', 0, 'OO', 0, 'OR', 0, sd.qty_recd_sign * sd.inv_cost_ext)),
               '063', (DECODE (sd.order_type, 'CR', 0, 'OO', 0, 'OR', 0, sd.qty_recd_sign * sd.inv_cost_ext)),
               '064', (DECODE (sd.order_type, 'CR', 0, 'OO', 0, 'OR', 0, sd.qty_recd_sign * sd.inv_cost_ext)),
               '066', (DECODE (sd.order_type, 'CR', 0, 'OO', 0, 'OR', 0, sd.qty_recd_sign * sd.inv_cost_ext)),
               '065', (DECODE (sd.qty_marked_out, 0, (sd.qty_recd_sign * sd.inv_cost_ext), DECODE (sd.qty_recd_by_cust, 0, (sd.inv_cost_ext * -1), (sd.inv_cost_ext - ((sd.inv_cost_ext / sd.qty_recd_by_cust) * sd.qty_marked_out))))),
                sd.qty_recd_sign * sd.inv_cost_ext
               )
              ) AS scorecard_sales
FROM     DATAWHSE.MF_SUMBY_DATA sd 
         inner join DATAWHSE.MF_ITEM_MASTER im on sd.BRANCH_NBR = '0' || im.DHI_ITEM_FACILITY and sd.ITEM_NBR = '00' || substr(im.DHI_ITEM_NUMBER,1,5)
WHERE    sd.BRANCH_NBR = '065'
AND      sd.WK_END_DATE in ('aug-12-2012')

;


Select PRIM_DC, lpad(trim(PRIM_STORE_NO), 8, '0') PRIM_STORE, FACILITYID, STORE_NO, STORE_NAME, NASH_FINCH_STORE
 from ETLADMIN.T_WHSE_CUST_GMS

;


SELECT   branch_nbr, 
    wk_end_date, 
    item_nbr,
    cust_nbr,
          SUM (DECODE (branch_nbr, 
               '065', DECODE (qty_marked_out, 0, qty_recd_sign * qty_recd_by_cust, (qty_recd_sign * qty_recd_by_cust) - qty_marked_out),
               qty_recd_sign * qty_recd_by_cust
               )
              ) AS qty_shipped,
          SUM (qty_marked_out) AS outs,
          SUM (qty_recd_sign * layer_cost_ext) AS layer_cost_total,
          SUM (qty_recd_sign * inv_cost_ext) AS inv_cost_total,
          SUM (qty_recd_sign * spread_cost_ext) AS spread_cost_total,
          SUM (qty_recd_sign * invoice_sell_ext) AS invoice_sell_total,
          SUM (qty_recd_sign * retl_ext) AS retl_total,
          SUM (qty_recd_sign * unit_inv_cost) AS unit_inv_cost_total,
          SUM (DECODE (branch_nbr, 
               '015', (DECODE (order_type, 'CR', 0, 'OO', 0, 'OR', 0, qty_recd_sign * inv_cost_ext)),
               '058', (DECODE (order_type, 'CR', 0, 'OO', 0, 'OR', 0, qty_recd_sign * inv_cost_ext)),
               '059', (DECODE (order_type, 'CR', 0, 'OO', 0, 'OR', 0, qty_recd_sign * inv_cost_ext)),
               '061', (DECODE (order_type, 'CR', 0, 'OO', 0, 'OR', 0, qty_recd_sign * inv_cost_ext)),
               '062', (DECODE (order_type, 'CR', 0, 'OO', 0, 'OR', 0, qty_recd_sign * inv_cost_ext)),
               '063', (DECODE (order_type, 'CR', 0, 'OO', 0, 'OR', 0, qty_recd_sign * inv_cost_ext)),
               '064', (DECODE (order_type, 'CR', 0, 'OO', 0, 'OR', 0, qty_recd_sign * inv_cost_ext)),
               '066', (DECODE (order_type, 'CR', 0, 'OO', 0, 'OR', 0, qty_recd_sign * inv_cost_ext)),
               '065', (DECODE (qty_marked_out, 0, (qty_recd_sign * inv_cost_ext), DECODE (qty_recd_by_cust, 0, (inv_cost_ext * -1), (inv_cost_ext - ((inv_cost_ext / qty_recd_by_cust) * qty_marked_out))))),
                qty_recd_sign * inv_cost_ext
               )
              ) AS scorecard_sales
    FROM MF_SUMBY_DATA 
WHERE wk_end_date = TO_DATE(week_ending_date, 'YYYYMMDD') 
GROUP BY wk_end_date, 
   branch_nbr,
   cust_nbr,
   item_nbr

;




