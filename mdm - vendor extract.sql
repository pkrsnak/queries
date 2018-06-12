SELECT   trim(adg.pkfoudgene.get_CNUF(a.aracfin)) master_vendor,
         trim(adg.pkfoudgene.get_DescriptionFournisseur(a.aracfin)) master_vendor_name,
         ARACEXR root_item,
		 trim(adg.pkstrucobj.get_desc (aracinr, 'NF')) root_desc,
         ARACEXVL lv_item,
		 trim(adg.pkartvl.get_vldesc (araseqvl, 'NF')) lv_desc,
         substr(ARAREFC,1,2) facility,
         substr(ARAREFC,3,6) biceps_item
FROM     adg.artuc a
WHERE    sysdate between a.araddeb and a.aradfin
AND      adg.pkfoudgene.get_CNUF(a.aracfin) = '124547'
order by ARACEXR, ARACEXVL, ARAREFC
;



--Root
SELECT pkstrucobj.get_desc (i_aracinr, 'NF') INTO v_isi_root_item_desc FROM DUAL;

--LV Desc
SELECT pkartvl.get_vldesc (i_araseqvl, 'NF') INTO v_isi_lv_description FROM DUAL;

--Nature's Way - 		895272
--Capital City Fruit-	124547
--Mastronardi-			229022