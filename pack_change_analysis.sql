SELECT   *
FROM     whmgr.dc_item
--WHERE    item_dept_cd between 70 and 72
where      case_upc_nbr in (1380030006, 1380030013, 1380030033, 1380030060, 1380030068, 1380030075, 1380030125, 1380030130, 1380030321, 1380030330, 1380030340, 1380030342, 1380030423, 1380030433, 1380030448, 1380030478, 1380030486, 1380030496, 1380030524, 1380030615, 1380031120)
AND     (purch_status_cd not in ('D', 'Z') or purch_status_cd is null)
;

select * from (
SELECT   *
FROM     whmgr.dc_item
--WHERE    item_dept_cd between 70 and 72
where (commodity_key = 2 or item_dept_cd between 70 and 72)
AND     (purch_status_cd not in ('D', 'Z') or purch_status_cd is null))
where case_upc_nbr in (select distinct case_upc_nbr from whmgr.dc_item where commodity_key = 2 and facility_id = 1)
;


SELECT   *
FROM     whmgr.dc_item
--WHERE    item_dept_cd between 70 and 72
where facility_id = 1
AND     (purch_status_cd not in ('D', 'Z') or purch_status_cd is null)
;