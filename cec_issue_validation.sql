SELECT   cpr.PROMOTION,
         cpr.CEC_STORE,
         cpr.CEC_UPC,
         cec.CEC_VENDOR,
         cec.CEC_MOVE_QTY,
         sum(round(cpr.CEC_SOLD_QTY,0)) CEC_SOLD_QTY
FROM     CRMADMIN.T_CEC_PROMO_REPT cpr 
         left outer join (SELECT cps.PROMOTION, cps.CEC_STORE, cps.CEC_UPC, cps.CEC_VENDOR, sum(cps.CEC_MOVE_QTY) CEC_MOVE_QTY FROM CRMADMIN.T_CEC_PROMO_STRUPC cps WHERE cps.PROMOTION in ('08/2717DAL', '08/2717FIF', '09/0317DAL', '09/0317FIF', '09/1017DAL', '09/1017FIF', '09/1717DAL', '09/1717FIF', 'A1017EVE35', 'A1017EVE36', 'A1017EVE37', 'A1017EVE38') GROUP BY cps.PROMOTION, cps.CEC_STORE, cps.CEC_UPC, cps.CEC_VENDOR) cec on cpr.PROMOTION = cec.PROMOTION and cpr.CEC_STORE = cec.CEC_STORE and cpr.CEC_UPC = cec.CEC_UPC
WHERE    cpr.PROMOTION in ('08/2717DAL', '08/2717FIF', '09/0317DAL', '09/0317FIF', '09/1017DAL', '09/1017FIF', '09/1717DAL', '09/1717FIF', 'A1017EVE35', 'A1017EVE36', 'A1017EVE37', 'A1017EVE38')
GROUP BY cpr.PROMOTION, cpr.CEC_STORE, cpr.CEC_UPC, cec.CEC_VENDOR, 
         cec.CEC_MOVE_QTY;