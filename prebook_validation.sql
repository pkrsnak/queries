SELECT   no.DIVISIONNUMBER,
         no.ORDER_ID,
         no.ORDERCLASS,
         no.ORDERTYPE,
         no.DELIVERYDATE,
         no.STATUS,
         no.STORENUMBER,
         noi.ITEMUPC,
         noi.ITEMDESC,
         noi.QUANTITY,
         noi.RESERVEDATE,
         noi.SHIPDATE,
         noi.SOURCECODE,
         noi.STATUS,
         noi.REQUESTEDQTY
FROM     WCSADMIN.NFC_ORDER no,
         WCSADMIN.NFC_ORDERITEM noi
WHERE    no.ORDER_ID = noi.ORDER_ID
AND      noi.itemnumber in ('2957207')
and      no.DIVISIONNUMBER = 8