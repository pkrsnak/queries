--Highlighted in yellow for the different SQL’s are values entered for the prompts from the Cognos Report.
--Case Cap Report by Range 
SELECT   T1.prod_id c1,
         T2.loc_id c2,
         T3.slcat_desc c3,
         T4.cse_hgt c4,
         T4.cse_wid c5,
         T4.cse_len c6,
         T4.inner_pack_hgt c7,
         T4.inner_pack_wid c8,
         T4.inner_pack_len c9,
         T5.loc_stor_cse_cap c10,
         T6.slhnd_desc c11,
         T7.whse_id c12
FROM     iplas T5,
         iprdd T4,
         iprod T1,
         iloc T2,
         slcat T3,
         slhnd T6,
         swhse T7
WHERE    T5.dc_id=T4.dc_id
AND      T5.prod_id=T4.prod_id
AND      T5.prdd_id=T4.prdd_id
AND      T4.dc_id=T1.dc_id
AND      T4.prod_id=T1.prod_id
AND      T5.dc_id=T2.dc_id
AND      T5.whse_id=T2.whse_id
AND      T5.loc_id=T2.loc_id
AND      T2.lcat_id=T3.lcat_id
AND      T2.lhnd_id=T6.lhnd_id
AND      T5.dc_id=T7.dc_id
AND      T5.whse_id=T7.whse_id
AND      8=T7.whse_id
AND      '170000'<=T2.loc_id
AND      '999999'>=T2.loc_id
AND      T3.slcat_desc='SELECTION                     '
AND      T6.slhnd_desc='CASE                          '
ORDER BY 1 asc;


--FD Report1 – BOH & ITEM dimensions v2
SELECT   T1.prod_id,
         T1.loc_id,
         T2.lic_plt_id,
         (T2.prod_qty*1.0e0)/T3.cse_unit,
         T4.sldes_desc,
         T5.whse_id,
         T6.slcat_desc,
         T7.description,
         T8.vend_id,
         T8.vend_name,
         T7.buyer_ref,
         T1.loc_stor_cse_cap,
         (T2.prod_qty*1.0e0)/T3.unit_ship_cse,
         T3.prod_sz,
         T3.vend_ti,
         T3.vend_hi,
         T3.cse_hgt,
         T3.cse_wid,
         T3.cse_len,
         T3.cse_wgt,
         T3.stor_ti,
         T3.stor_hi
FROM     ivend T8,
         iplas T1,
         iprdd T3,
         iinvd T2,
         iloc T9,
         sldes T4,
         swhse T5,
         slcat T6,
         iprod T7
WHERE    T8.dc_id=T3.dc_id
AND      T8.vend_id=T3.vend_id
AND      T1.dc_id=T3.dc_id
AND      T1.prod_id=T3.prod_id
AND      T1.prdd_id=T3.prdd_id
AND      T1.plas_id=T2.plas_id
AND      T1.dc_id=T9.dc_id
AND      T1.whse_id=T9.whse_id
AND      T1.loc_id=T9.loc_id
AND      T9.ldes_id=T4.ldes_id
AND      T1.dc_id=T5.dc_id
AND      T1.whse_id=T5.whse_id
AND      T9.lcat_id=T6.lcat_id
AND      T3.dc_id=T7.dc_id
AND      T3.prod_id=T7.prod_id
AND      T5.whse_id=5
;
--FD Report2 – Assigned Select Location FD version
SELECT   T1.whse_id c1,
         T1.loc_id c2,
         T2.slcat_desc c3,
         T3.sldes_desc c4,
         T4.slhnd_desc c5,
         T5.slsta_desc c6,
         T6.prod_id c7,
         T6.description c8,
         T7.loc_stor_cse_cap c9,
         T8.prod_sz c10,
         T8.vend_ti c11,
         T8.vend_hi c12,
         T8.stor_ti c13,
         T8.stor_hi c14,
         T8.cse_hgt c15,
         T8.cse_wid c16,
         T8.cse_len c17,
         T8.cse_wgt c18
FROM     iplas T7,
         iloc T1,
         slcat T2,
         sldes T3,
         slhnd T4,
         slsta T5,
         iprdd T8,
         iprod T6
WHERE    T7.dc_id=T1.dc_id
AND      T7.whse_id=T1.whse_id
AND      T7.loc_id=T1.loc_id
AND      T1.lcat_id=T2.lcat_id
AND      T1.ldes_id=T3.ldes_id
AND      T1.lhnd_id=T4.lhnd_id
AND      T1.lsta_id=T5.lsta_id
AND      T7.dc_id=T8.dc_id
AND      T7.prod_id=T8.prod_id
AND      T7.prdd_id=T8.prdd_id
AND      T8.dc_id=T6.dc_id
AND      T8.prod_id=T6.prod_id
AND      T1.whse_id=7
AND      T2.slcat_desc='Selection                     '
AND      T5.slsta_desc='ASSIGNED                      '
ORDER BY 1 asc, 2 asc, 7 asc
;
--IMLOA
select * from iloc
where whse_id = ?WhseId?
and loc_id >= ?FromLoc?
and loc_id <= ?ToLoc?
and lcat_id  = ?LcatID?
;

--NE Loc Prod Lic and Case (Rsv Pallets)
SELECT   T1.prod_id,
         T1.loc_id,
         T2.lic_plt_id,
         (T2.prod_qty*1.0e0)/T3.cse_unit,
         T2.cde_dt,
         T4.sldes_desc,
         T5.whse_id,
         T6.slcat_desc,
         T7.description
FROM     iplas T1,
         iinvd T2,
         iprdd T3,
         iloc T8,
         sldes T4,
         swhse T5,
         slcat T6,
         iprod T7
WHERE    T1.plas_id=T2.plas_id
AND      T1.dc_id=T3.dc_id
AND      T1.prod_id=T3.prod_id
AND      T1.prdd_id=T3.prdd_id
AND      T1.dc_id=T8.dc_id
AND      T1.whse_id=T8.whse_id
AND      T1.loc_id=T8.loc_id
AND      T8.ldes_id=T4.ldes_id
AND      T1.dc_id=T5.dc_id
AND      T1.whse_id=T5.whse_id
AND      T8.lcat_id=T6.lcat_id
AND      T3.dc_id=T7.dc_id
AND      T3.prod_id=T7.prod_id
AND      T5.whse_id=7
AND      '0'<=T1.loc_id
AND      'ZZZZZZ'>=T1.loc_id
AND      T6.slcat_desc='Selection                     '
ORDER BY 1 asc
;

--Product Listing By Range – Whse(Scott)
SELECT   T1.whse_id c1,
         T1.loc_id c2,
         T2.lic_plt_id c3,
         T1.prod_id c4,
         T3.description c5,
         T4.slcat_desc c6
FROM     iplas T1,
         iinvd T2,
         iprdd T5,
         iprod T3,
         iloc T6,
         slcat T4
WHERE    T1.plas_id=T2.plas_id
AND      T1.dc_id=T5.dc_id
AND      T1.prod_id=T5.prod_id
AND      T1.prdd_id=T5.prdd_id
AND      T5.dc_id=T3.dc_id
AND      T5.prod_id=T3.prod_id
AND      T1.dc_id=T6.dc_id
AND      T1.whse_id=T6.whse_id
AND      T1.loc_id=T6.loc_id
AND      T6.lcat_id=T4.lcat_id
AND      8=T1.whse_id
AND      T1.loc_id between '40000' and '80ZZZZ'
AND      T4.slcat_desc='SELECTION                     '
ORDER BY 1 asc, 2 asc
;

--Replenishment by Range – Total by Slot (14days)(P for Whse) 
SELECT   T1.lhty_id c21,
         T1.wust_id c22,
         T2.prod_id c23,
         T1.to_loc_id c24,
         T1.whse_id c25,
         T1.lic_plt_id c26
FROM     aothd T1,
         iprdd T3,
         iprod T2
WHERE    T1.dc_id=T3.dc_id
AND      T1.prod_id=T3.prod_id
AND      T1.prdd_id=T3.prdd_id
AND      T3.dc_id=T2.dc_id
AND      T3.prod_id=T2.prod_id
AND      7=T1.whse_id
AND      T1.lhty_id='LD'
AND      '00000'<=T1.to_loc_id
AND      'ZZZZZZ'>=T1.to_loc_id
AND      T1.wust_id='COM'
ORDER BY 5 asc, 4 asc, 3 asc, 2 asc, 1 asc;

SELECT   T1.lhty_id c15,
         T1.wust_id c16,
         T2.prod_id c17,
         T1.to_loc_id c18,
         T1.whse_id c19,
         count(T1.lic_plt_id) c20
FROM     aothd T1,
         iprdd T3,
         iprod T2
WHERE    T1.dc_id=T3.dc_id
AND      T1.prod_id=T3.prod_id
AND      T1.prdd_id=T3.prdd_id
AND      T3.dc_id=T2.dc_id
AND      T3.prod_id=T2.prod_id
AND      7=T1.whse_id
AND      T1.lhty_id='LD'
AND      '00000'<=T1.to_loc_id
AND      'ZZZZZZ'>=T1.to_loc_id
AND      T1.wust_id='COM'
GROUP BY T1.whse_id, T1.to_loc_id, T2.prod_id, T1.wust_id, T1.lhty_id
ORDER BY 5 asc, 4 asc, 3 asc, 2 asc, 1 asc
;

SELECT   T1.whse_id c13,
         count(T1.lic_plt_id) c14
FROM     aothd T1,
         iprdd T3,
         iprod T2
WHERE    T1.dc_id=T3.dc_id
AND      T1.prod_id=T3.prod_id
AND      T1.prdd_id=T3.prdd_id
AND      T3.dc_id=T2.dc_id
AND      T3.prod_id=T2.prod_id
AND      7=T1.whse_id
AND      T1.lhty_id='LD'
AND      '00000'<=T1.to_loc_id
AND      'ZZZZZZ'>=T1.to_loc_id
AND      T1.wust_id='COM'
GROUP BY T1.whse_id
;



