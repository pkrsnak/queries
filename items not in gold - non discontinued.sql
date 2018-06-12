Select twi.FACILITYID, twi.ITEM_DEPT, twi.PURCH_STATUS, count(*) 
  from ETLADMIN.T_MDM_ITEM tmi right outer join CRMADMIN.T_WHSE_ITEM twi 
                               on tmi.FACILITYID = twi.FACILITYID and tmi.ISI_ITEM_CODE = twi.ITEM_NBR
where tmi.facilityid is null
  and twi.purch_status not in ('D')
  and twi.ITEM_DEPT in 
('000',
'010',
'012',
'016',
'017',
'018',
'019',
'020',
'025',
'030',
'031',
'035',
--'040',
'045',
'048',
--'050',
--'055',
'060',
'066',
'067',
--'070',
--'072',
--'073',
--'074',
--'075',
--'077',
--'078',
'080',
'084',
'086',
'090',
'094',
'097',
'098',
'099')
group by twi.FACILITYID, twi.ITEM_DEPT, twi.PURCH_STATUS
