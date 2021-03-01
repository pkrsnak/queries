--re-selects/waved/gobacks
SELECT   'Waved',
         aseld.FACILITYID,
         aseld.whse_id,
         swhse.WAREHOUSE_CODE_DESC_FAC, 
         sum(prod_qty/unit_ship_cse)
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld,
         CRMADMIN.T_WHSE_WAREHOUSE_CODE swhse
WHERE    aseld.create_dtim between current date - 1 day and current date
AND      aseld.create_user <> 'VVSPA'
AND      aseld.FACILITYID = swhse.FACILITYID
AND      aseld.whse_id = int(swhse.WAREHOUSE_CODE)
GROUP BY aseld.FACILITYID,
         aseld.whse_id,
         swhse.WAREHOUSE_CODE_DESC_FAC

Union

SELECT   'Re-Selected',
         aseld.FACILITYID,
         aseld.whse_id,
         swhse.WAREHOUSE_CODE_DESC_FAC,
         sum(aseld.prod_qty/aseld.unit_ship_cse)
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld,
         CRMADMIN.T_WHSE_WAREHOUSE_CODE swhse
WHERE    aseld.create_dtim between current date - 1 day and current date
AND      aseld.create_user = 'VVSPA'
AND      aseld.dc_id = swhse.FACILITYID
AND      aseld.whse_id = int(swhse.WAREHOUSE_CODE)
GROUP BY aseld.FACILITYID,
         aseld.whse_id,
         swhse.WAREHOUSE_CODE_DESC_FAC

Union

SELECT   'GoBack',
         aseld.FACILITYID,
         aseld.whse_id,
         swhse.WAREHOUSE_CODE_DESC_FAC,
         sum(aseld.act_pick_qty/aseld.unit_ship_cse)
FROM     CRMADMIN.T_WHSE_EXE_ASELD aseld 
         inner join CRMADMIN.T_WHSE_EXE_ASELD aseld2 on aseld.FACILITYID = aseld2.FACILITYID AND aseld.whse_id = aseld2.whse_id AND aseld.ord_id = aseld2.ord_id AND aseld.sgmt_id = aseld2.sgmt_id AND aseld.ordd_id = aseld2.ordd_id AND aseld.prod_id = aseld2.prod_id AND aseld.prdd_id = aseld2.prdd_id 
         inner join CRMADMIN.T_WHSE_WAREHOUSE_CODE swhse on aseld.FACILITYID = swhse.FACILITYID AND aseld.whse_id = int(swhse.WAREHOUSE_CODE)
WHERE    aseld.create_dtim between current date - 1 day and current date
AND      aseld2.create_dtim between current date - 1 day and current date
AND      aseld.prod_qty <> aseld2.prod_qty
AND      aseld.act_pick_qty <> 0
GROUP BY aseld.FACILITYID ,
         aseld.whse_id,
         swhse.WAREHOUSE_CODE_DESC_FAC
ORDER BY 1, 2, 3
;


--cycle count
SELECT   dc_id,
         whse_id,
         sum(qty_o) expected_count
FROM     informix.nfcadjtrx
WHERE    fisc_year = 2021
AND      fisc_week = 6
AND      iarc_id = '+E'
GROUP BY dc_id, whse_id
;



SELECT   dc_id,
         whse_id,
         sum(adj_qty) expected_count,
         sum(abs(adj_qty)) expected_count
FROM     informix.nfcadjtrx
WHERE    fisc_year = 2021
AND      fisc_week = 6
AND      iarc_id = 'CC'
GROUP BY dc_id, whse_id
;