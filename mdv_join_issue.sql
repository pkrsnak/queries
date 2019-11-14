Select * from whmgr.mdv_item;

SELECT  dept_cd, count(*)
         FROM     whmgr.mdv_item
group by dept_cd
;