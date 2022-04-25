SELECT   STORE_NBR,
         XFER_ID,
         DATE(CREATE_TMSP) CREATE_TMSP,
         SUM(NET_RTL_PRC_AMT) NET_RTL_PRC_AMT,
         SUM(NET_COST_AMT) NET_COST_AMT
FROM     EDW.RTL.RTL_XFERS
WHERE    XFER_TYPE_ID=6
AND      DATE(CREATE_TMSP) BETWEEN '2021-11-08' AND '2021-11-17'
AND      ORIGIN LIKE '%PHQ%'
GROUP BY STORE_NBR, XFER_ID, DATE(CREATE_TMSP)
HAVING   SUM(NET_RTL_PRC_AMT)<>0
;

SELECT   *
FROM     EDW.RTL.RTL_XFER_DETAIL
WHERE    XFER_HEADER_ID IN (SELECT XFER_HEADER_PK FROM EDW.RTL.RTL_XFER_HEADER WHERE XFER_ID IN (54355,58835,56758,55409,55413,55410))
;


SELECT   ORDERING_DEPT,
         *
FROM     EDL.PHQ.RECEIVER
--WHERE    RCV_ID IN (54355,58835,56758,55409,55413,55410)
WHERE    RCV_ID IN (64332, 64913, 62558, 63871)
;


SELECT   *
FROM     RTL.RETAIL_ITEM
WHERE    RETAIL_ITEM_PK = 344429
;
