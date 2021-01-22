SELECT   msh.ship_date,
         fr.nf_facility_code,
         cast(mst.exchange_ref_cd[2,10] as int) exchange_ref_cd,
         mpcx.commodity_cd,
         di.buyer_id,
         msh.vendor_id,
         mi.item_nbr,
         di.mdse_class_key,
         msh.order_nbr,
         msh.order_qty,
         msh.ship_qty,
         di.private_brand_key,
         msh.ext_cost_amt,
         msh.ext_drayage_amt,
         msh.tot_order_line_amt,
         msh.ship_error_cd
FROM     mdvods@ods_lnk:mdv_sales_hst msh,
         nfods@ods_lnk:facility_xref fr,
         mdvods@ods_lnk:mdv_ship_to mst,
         mdvods@ods_lnk:mdv_prod_cmdy_xref mpcx,
         datawhse02@dss_lnk:dc_item di,
         mdvods@ods_lnk:mdv_item mi
WHERE    case when cast(msh.dept_cd as int) = 270 then 61 else cast(msh.dept_cd as int) end = fr.nf_facility_code
AND      msh.ship_to_id = mst.ship_to_id
AND      msh.upc_cd = mi.case_upc_cd
AND      msh.dept_cd = cast(mi.dept_cd as int)
AND      mi.ps_prod_cd = mpcx.ps_prod_cd
AND      cast(mi.item_nbr as int)= di.item_nbr
AND      di.facility_id = fr.nf_facility_code
AND      msh.ship_date BETWEEN '01-15-2021' AND '01-20-2021'
;

select * from nfods@ods_lnk:facility_xref;