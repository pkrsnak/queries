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
WHERE    outCode in (149)
AND      dc = 'G'
--AND      waveDate >= '2020-03-21'
AND      deliveryDate between '2020-09-27' and '2020-10-03'
group by dc,
         waveDate,
         deliveryDate,
         dcItemId,
         invoiceId,
         storeNum,
         outCode
;

--GR ORDER SMOOTHING--------------------------------------------------------------------------------------
--run this!
SET SQL_BIG_SELECTS=1;

SELECT   li.dc,
         li.waveDate,
         li.deliveryDate,
         li.dcItemId,
         o.invoiceNum,
         li.storeNum,
         li.outCode,
         li.reqQty,
         li.netQty,
         li.shipQty
FROM     lineitem li inner join dcorder o on li.rtlOrderId = o.rtlOrderId and li.dcOrderId = o.dcOrderId
WHERE    li.outCode in (149)
AND      li.dc = 'G'
--AND      waveDate >= '2020-03-21'
AND      li.deliveryDate between '2020-11-29' and '2020-12-05'
;
group by li.dc,
         li.waveDate,
         li.deliveryDate,
         li.dcItemId,
         o.invoiceNum,
         li.storeNum,
         li.outCode
;


--GR ORDER CANCELLED--------------------------------------------------------------------------------------
--run this!
SET SQL_BIG_SELECTS=1;

SELECT   li.dc,
         li.waveDate,
         li.deliveryDate,
         li.dcItemId,
         li.storeNum,
         li.rtlOrderId,
         li.dcOrderId,
         li.outCode,
         li.reqQty,
         li.netQty,
         li.shipQty
FROM     lineitem li 
         inner join dcorder o on li.rtlOrderId = o.rtlOrderId and li.dcOrderId = o.dcOrderId
WHERE    li.orderStatus = ('Cancelled')
AND      li.dc = 'G'
AND      li.deliveryDate between '2020-11-29' and '2020-12-05'
;
group by li.dc,
         li.waveDate,
         li.deliveryDate,
         li.dcItemId,
         o.invoiceNum,
         li.storeNum,
         li.outCode