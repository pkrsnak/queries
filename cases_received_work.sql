--cases_received
--source:  datawhse02, entods
SELECT   'distribution' SCORECARD_TYPE, --irctd.whse_id, --irctd.dc_id, irctd.whse_id, irctd.lic_plt_id, irctd.receipt_dtim, 
         'figure out' DIVISION_ID, --irctd.load_batch_id, 
         'cases_received' KPI_TYPE,
         'F' DATA_GRANULARITY,
         'W' TIME_GRANULARITY,
--         DATE('08/09/2020') - (WEEKDAY(DATE('08/09/2020')) + 1) UNITS DAY KPI_DATE,
        '09-21-2020' KPI_DATE,
         irctd.facility_id KPI_KEY_VALUE,
         sum(irctd.rct_qty / irctd.item_pack_qty) KPI_DATA_VALUE
--         irctd.rct_qty / irctd.item_pack_qty KPI_DATA_VALUE
FROM     WHMGR.ent_irctd irctd
         inner join whmgr.ent_irctl irctl on irctd.dc_id = irctl.dc_id and irctd.whse_id = irctl.whse_id and irctd.lic_plt_id = irctl.lic_plt_id and irctd.po_id = irctl.po_id and irctd.prod_id = irctl.prod_id and irctl.extr_flag = 'Y'
WHERE    date(irctd.receipt_dtim) between '05-17-2020' and '06-13-2020'
and    ((irctd.facility_id = 1 and  irctd.whse_id not in (12, 13, 14, 15, 44, 45, 71, 72, 75))
or     (irctd.facility_id <>1))
--WHERE    date(irctd.receipt_dtim) = '09-20-2020' 
--WHERE    date(irctd.receipt_dtim) between DATE('08/09/2020') - (WEEKDAY(DATE('08/09/2020')) + 7) UNITS DAY and DATE('08/09/2020') - (WEEKDAY(DATE('08/09/2020')) + 1) UNITS DAY
GROUP BY 1, 2, 3, 4, 5, 6, 7 --, 8
; 


  SELECT irct.dc_id, irct.whse_id, irct.po_id, irct.rcpt_id, irct.user_id, irct.appt_id ",
         FROM irct, ipod, ipo ,
         WHERE irct.verify_dtim BETWEEN '", f_s_dtim, "' AND '", f_e_dtim , "’ “,
         AND irct.dc_id BETWEEN , m_input.s_dc_id, " AND ", m_input.e_dc_id, " ",
         AND irct.whse_id BETWEEN , m_input.s_whse_id, " AND ", m_input.e_whse_id, " ",
         AND ipod.dc_id = irct.dc_id ,
         AND ipod.po_id = irct.po_id ,
         AND ipod.plst_id IN ('C', 'B') ,                                                                                            -- PO detail is either closed or Backordered                    
         AND ipo.dc_id = ipod.dc_id ,
         AND ipo.po_id = ipod.po_id ,
         AND ipo.po_type = '", m_input.po_type, "' ",
         ORDER BY irct.dc_id, irct.whse_id, irct.po_id
';

12 Grocery Outside Whse. Columbia
     13 Grocery Direct Ship Whse
     14 Grocery Outside Whse. 76th St.
     15 Grocery Temp Outside Storage
     44 G.M. Satellite Warehouse
     45 Charlotte Support Services (GM
     71 GR Perish. Outside Storage Whs
     72 GR Perish. 2nd Outside Storage
     75 In Case Of Emergency Meat/Dair



SELECT   *
FROM     whmgr.ent_irctd
WHERE    dc_id = 58
AND      whse_id = 8
AND      lic_plt_id = 3991879
;


SELECT   *
FROM     whmgr.ent_irctl
WHERE    dc_id = 58
AND      whse_id = 8
AND      lic_plt_id = 3991879
;


SELECT   ITEM_FAC, LINE_STATUS, sum(RECEIVED) rec_qty
FROM     CRMADMIN.T_WHSE_PO_DTL
where DATE_RECEIVED between '2020-05-17' and '2020-06-13'
and ITEM_FAC = '01'
group by ITEM_FAC, LINE_STATUS 
