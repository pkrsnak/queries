--wmsods
SELECT   *
FROM     whmgr.aothd
WHERE    whse_id = 10
and start_dtim between today - 39 and today - 8

--group by 1