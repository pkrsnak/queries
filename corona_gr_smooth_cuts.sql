 SET SQL_BIG_SELECTS=1;

SELECT   dc,
         waveDate,
         deliveryDate,
         dcItemId,
         invoiceId,
         storeNum,
         reqQty,
         netQty,
         shipQty,
         outCode
FROM     lineitem
WHERE    outCode in (45, 149)
AND      dc = 'G'
AND      waveDate >= '2020-03-21'
;





SET SQL_BIG_SELECTS=1;

SELECT   dc,
         waveDate,
         deliveryDate,
         dcItemId,
         invoiceId,
         storeNum,
         outCode,
         sum(reqQty) req_Qty,
         sum(netQty) net_Qty,
         sum(shipQty) ship_Qty
FROM     lineitem
WHERE    outCode in (45, 149)
AND      dc = 'G'
AND      waveDate >= '2020-03-21'
group by dc,
         waveDate,
         deliveryDate,
         dcItemId,
         invoiceId,
         storeNum,
         outCode
;