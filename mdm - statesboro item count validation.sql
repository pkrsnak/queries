

-- vendor pivot
SELECT   
         substr(T_WHSE_ITEM.UPC_UNIT, 7, 6) mfg_upc,
         T_WHSE_VENDOR.MASTER_VENDOR,
         T_WHSE_ITEM.FACILITYID,
         T_WHSE_ITEM.VENDOR_NBR,
         T_WHSE_VENDOR.VENDOR_NAME, 
         case when ascii(trim(T_WHSE_VENDOR.MASTER_VENDOR)) = 0 then 1 else 0 end NULL_VENDOR,
         count(distinct T_WHSE_ITEM.UPC_UNIT || T_WHSE_ITEM.UPC_CASE || char(T_WHSE_ITEM.MASTER_PACK) ) num_lvs
--         count(T_WHSE_ITEM.UPC_UNIT)
FROM     CRMADMIN.T_WHSE_ITEM T_WHSE_ITEM,
         CRMADMIN.T_WHSE_VENDOR T_WHSE_VENDOR
WHERE    T_WHSE_VENDOR.FACILITYID = T_WHSE_ITEM.FACILITYID
AND      T_WHSE_VENDOR.VENDOR_NBR = T_WHSE_ITEM.VENDOR_NBR
--AND      T_WHSE_ITEM.FACILITYID in ('062')
AND	       T_WHSE_VENDOR.MASTER_VENDOR not in ('000016', '010900', '011132', '013000', '014500', '014800', '015000', '017000', '018000',                                               '018001', '021000', '023700', '024000', '025000', '026800', '028000', '030000', '031000',                                               '031100', '031600', '033200', '033700', '034000', '035000', '036000', '036632', '037000',                                               '037100', '037600', '038000', '038057', '038900', '039400', '040000', '041483', '041500',                                               '041900', '042400', '044600', '045100', '046500', '048001', '051000', '051500', '052100',                                               '067150', '070074', '070200', '070252', '070640', '071923', '075925', '090500', '091945',                                               '300870', '900017', '900019', '900022', '900027', '900043', '900048', '900061', '900067',                                               '900070', '900071', '900074', '031200', '041800', '050200', '011115', '042000')
AND      substr(T_WHSE_ITEM.UPC_UNIT, 7, 6) not in ('499999', '088888', '888888')  --, '070253', '041270', '041290', '045400', '074520')
--AND      substr(T_WHSE_ITEM.UPC_UNIT, 7, 6) > '009999'
AND      T_WHSE_VENDOR.VENDOR_TYPE NOT in ('B')
AND      T_WHSE_ITEM.PURCH_STATUS NOT in ('D', 'Z')
AND      T_WHSE_VENDOR.STATUS NOT in ('D', 'I')
AND      T_WHSE_ITEM.ITEM_DEPT in ('010', '012', '020', '025', '030', '035', '050', '055', '060', '084', '086')
GROUP BY 
         substr(T_WHSE_ITEM.UPC_UNIT, 7, 6)
       , T_WHSE_VENDOR.MASTER_VENDOR
       , T_WHSE_ITEM.FACILITYID
       , case when ascii(trim(T_WHSE_VENDOR.VENDOR_NBR)) = 0 then 1 else 0 end
       , T_WHSE_ITEM.VENDOR_NBR
       , T_WHSE_VENDOR.VENDOR_NAME
;