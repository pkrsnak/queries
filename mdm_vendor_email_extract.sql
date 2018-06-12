select  adg.pkfoudgene.get_cnuf(cctcfin) master_vendor_code, 
		adg.pkfoudgene.get_descriptioncnuf(adg.pkfoudgene.get_cnuf(cctcfin)) master_vendor_name,
		cctadre address_code,
		cctid contact_code,
		ccttelx contact_name,
		CCTMAIL email
   from adg.FOUCONTACT
order by adg.pkfoudgene.get_cnuf(cctcfin), cctadre, cctid