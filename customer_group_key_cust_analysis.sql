Select g.CUSTOMER_GROUP_TYPE, g.CUSTOMER_GROUP_ID, g.CUSTOMER_GROUP_NAME, g.ADDRESS1, g.ADDRESS2, g.CITY, g.STATE, g.ZIP, g.TELEPHONE, g.OWNER, g.CONTACT, g.CONTACT_TELEPHONE, g.CONTACT_EXTENSION, x.FACILITYID, x.CUSTOMER_NBR_STND, c.NAME, c.STATUS_CD
  from ETLADMIN.T_WHSE_CUSTOMER_GROUP g inner join ETLADMIN.T_WHSE_CUSTOMER_GROUP_XREF x 
    on g.CUSTOMER_GROUP_TYPE = x.CUSTOMER_GROUP_TYPE
   and g.CUSTOMER_GROUP_ID = x.CUSTOMER_GROUP_ID
  inner join CRMADMIN.T_WHSE_CUST c
    on x.FACILITYID = c.FACILITYID 
   and x.CUSTOMER_NBR_STND = c.CUSTOMER_NBR_STND
 where g.CUSTOMER_GROUP_TYPE = 'Key Customers - 2010'
;

select max(g.CUSTOMER_GROUP_ID) from ETLADMIN.T_WHSE_CUSTOMER_GROUP g
;


Select corp.FACILITY_ID , corp.CORPORATION_ID , corp.NAME , cust.CUSTOMER_NO , cust.CUSTOMER_NO_FULL , cust.CUSTOMER_NBR_STND , cust.NAME , cust.ADDRESS1 , cust.ADDRES2 , cust.ADDRESS3 , cust.STATE_DESCRIPTION , cust.ZIP_CD 
  from CRMADMIN.T_WHSE_CORPORATION corp inner join CRMADMIN.T_WHSE_CUST cust
    on corp.FACILITY_ID = cust.FACILITYID
   and corp.CORPORATION_ID = cust.CUST_CORPORATION
 where cust.STATUS_CD not in ('D', 'Z')
;
