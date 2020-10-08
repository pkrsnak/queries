SELECT   d.DRIVERID,
         d.FIRSTNAME,
         d.MIDDLENAME,
         d.LASTNAME,
         d.TYPE,
         d.STATUS,
         d.SITEID,
         d.DOTRULE,
         d.LICENSENUMBER,
         d.ADDRESSTYPE,
         d.ADDRESSLINE1,
         d.ADDRESSLINE2,
         d.CITY,
         d.STATE,
         d.COUNTRY,
         d.ZIPCODE,
         d.PRIMARYPHONE,
         d.SECONDARYPHONE,
         d.CELLPHONE,
         d.FAX,
         d.PRIMARYEMAILID,
         d.SECONDARYEMAILID,
         d.DESCRIPTION,
         d.LOGINENABLED,
         d.ACCESSLEVELID,
         d.LOCALE,
         d.PROCESS_TYPE,
         d.PROCESS_TIMESTAMP,
         d.BSUNIT_ENTITY_ID,
         d.REG_ENTITY_ID,
         d.DRIVER_ENTITY_ID,
         d.DRIVER_TYPE_ENTITY_ID,
         dt.BSUNIT_ENTITY_ID,
         dt.REG_ENTITY_ID,
         dt.DRIVER_TYPE_ENTITY_ID,
         dt.DRIVER_TYPE_CD,
         dt.DRIVER_TYPE_DESC,
         dt.VIS_IN_ALL_REG_FLG,
         dt.PROCESS_TYPE,
         dt.PROCESS_TIMESTAMP
FROM     TRANSPORT.T_TRA_ACT_DRIVERS d 
         inner join TRANSPORT.T_TRA_ACT_DRIVER_TYPE dt on d.REG_ENTITY_ID = dt.REG_ENTITY_ID and d.DRIVER_TYPE_ENTITY_ID = dt.DRIVER_TYPE_ENTITY_ID