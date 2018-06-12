
-- -------------
-- Export LEDGER
-- -------------

unload to 'c:\temp\ledger-ou.txt' delimiter '|'
SELECT
  CASE WHEN  A.BUSINESS_UNIT > ' ' THEN 'B_' ||  A.BUSINESS_UNIT ELSE  A.BUSINESS_UNIT END AS Business_Unit
, A.LEDGER
, A.ACCOUNT
, CASE WHEN  A.ACCOUNT > ' ' THEN 'A_' ||  A.ACCOUNT ELSE  A.ACCOUNT END as Prefixed_Account
, A.DEPTID
, CASE WHEN  A.DEPTID > ' ' THEN 'D_' ||  A.DEPTID ELSE  A.DEPTID END as Prefixed_Deptid
, A.OPERATING_UNIT
, CASE WHEN  A.OPERATING_UNIT > ' ' THEN 'O_' ||  A.OPERATING_UNIT ELSE  A.OPERATING_UNIT END as Prefixed_OperatingUnit
, A.PRODUCT
, CASE WHEN  A.PRODUCT > ' ' THEN 'P_' ||  A.PRODUCT ELSE  A.PRODUCT END as Prefixed_Product
, A.CURRENCY_CD
, B.DESCR
, B.STATISTICS_ACCOUNT
, B.UNIT_OF_MEASURE
, A.FISCAL_YEAR
, A.ACCOUNTING_PERIOD
, SUM( A.POSTED_TOTAL_AMT) as Sum_Posted_Total_Amt
 FROM PS_LEDGER A 
    , PS_GL_ACCOUNT_TBL B
WHERE A.LEDGER = 'ACTUALS' 
  AND A.FISCAL_YEAR = 2014 
--  AND A.ACCOUNTING_PERIOD IN (6)
  AND B.SETID = 'SPN'
  AND B.ACCOUNT = A.ACCOUNT
  AND B.EFFDT = (SELECT MAX(BB.EFFDT) FROM PS_GL_ACCOUNT_TBL BB WHERE BB.SETID = B.SETID AND BB.ACCOUNT = B.ACCOUNT)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
ORDER BY 1, 3, 5, 7
;



---
-- budget/forecast
--
--unload to 'c:\temp\ledger_budg_ou.txt' delimiter '|'


SELECT   CASE 
     WHEN A.BUSINESS_UNIT > ' ' THEN 'B_' || A.BUSINESS_UNIT 
     ELSE A.BUSINESS_UNIT 
END AS Business_Unit,
         A.LEDGER,
         A.ACCOUNT,
         CASE 
              WHEN A.ACCOUNT > ' ' THEN 'A_' || A.ACCOUNT 
              ELSE A.ACCOUNT 
         END as Prefixed_Account,
         A.DEPTID,
         CASE 
              WHEN A.DEPTID > ' ' THEN 'D_' || A.DEPTID 
              ELSE A.DEPTID 
         END as Prefixed_Deptid,
         A.OPERATING_UNIT,
         CASE 
              WHEN A.OPERATING_UNIT > ' ' THEN 'O_' || A.OPERATING_UNIT 
              ELSE A.OPERATING_UNIT 
         END as Prefixed_OperatingUnit,
         A.PRODUCT,
         CASE 
              WHEN A.PRODUCT > ' ' THEN 'P_' || A.PRODUCT 
              ELSE A.PRODUCT 
         END as Prefixed_Product,
         A.CURRENCY_CD,
         B.DESCR,
         B.STATISTICS_ACCOUNT,
         B.UNIT_OF_MEASURE,
         to_char(A.FISCAL_YEAR),
         to_char(A.ACCOUNTING_PERIOD),
         to_char(SUM( A.POSTED_TOTAL_AMT)) as Sum_Posted_Total_Amt
FROM     PS_LEDGER A,
--FROM     PS_LEDGER_BUDG A,
         PS_GL_ACCOUNT_TBL B
--WHERE A.LEDGER = 'BUDGETS' 
WHERE A.LEDGER = 'ACTUALS' 
--WHERE    A.LEDGER = 'FORECAST'
AND      A.FISCAL_YEAR = 2014
AND      B.SETID = 'SPN'
AND      B.ACCOUNT = A.ACCOUNT
AND      B.EFFDT = (SELECT MAX(BB.EFFDT) FROM PS_GL_ACCOUNT_TBL BB WHERE BB.SETID = B.SETID
     AND BB.ACCOUNT = B.ACCOUNT)
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
ORDER BY 1, 3, 5, 7, 9
;


-- -------------
-- PRODUCT Trees
-- -------------

select
 '1-Node' as sort1
, n.tree_level_num as treelevel
, case tree_name when 'PRODUCTS' then 'PRD_' || n.parent_node_name
       end as parent
, case tree_name when 'PRODUCTS' then 'PRD_' || n.tree_node
       end as child
, tn.descr as alias
from pstreenode n
 , ps_tree_node_tbl tn
where n.setid in ('SPN')
  and n.tree_name in ('PRODUCTS')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and n.setid = tn.setid
  and n.tree_node = tn.tree_node
  and tn.effdt = (select max(tned.effdt) from ps_tree_node_tbl tned
                   where tned.setid = tn.setid
                     and tned.tree_node = tn.tree_node
                     and tned.effdt <= today)

union

select 
 '2-Leaf' as sort1
, 999  as treelevel
, case n.tree_name when 'PRODUCTS' then 'PRD_' || n.tree_node
       end as parent
, 'P_' || p.product as child
, p.descr as alias
from  pstreenode n
    , pstreeleaf l
    , ps_product_tbl p
where n.setid in ('SPN')
  and n.tree_name in ('PRODUCTS')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and n.parent_node_num > 0
  and n.setid = l.setid
  and n.setcntrlvalue = l.setcntrlvalue
  and n.tree_name = l.tree_name
  and n.effdt = l.effdt
  and l.tree_node_num between n.tree_node_num and tree_node_num_end
  and p.setid = n.setid
  and p.effdt = (select max(ped.effdt) from ps_product_tbl ped
                  where ped.setid = p.setid
                    and ped.product = p.product
                    and ped.effdt <= today)
  and p.eff_status = 'A'
  and p.product between l.range_from and l.range_to
  and n.tree_level_num = (select max(lvl.tree_level_num) from pstreenode lvl
                           where lvl.setid = n.setid
                             and lvl.setcntrlvalue = n.setcntrlvalue
                             and lvl.tree_name = n.tree_name
                             and lvl.effdt = n.effdt
                             and l.tree_node_num between lvl.tree_node_num and lvl.tree_node_num_end)
order by 1, 2
;

-- -------------
-- ACCOUNT Trees
-- -------------

select
 '1-Node' as sort1
, n.tree_level_num as treelevel
, case tree_name when 'RTL_ACCOUNTS' then 'RTL_' || n.parent_node_name
                 when 'ACCOUNT_CORP' then 'COR_' || n.parent_node_name
                 when 'ACCOUNTS' then 'ACC_'     || n.parent_node_name
       end as parent
, case tree_name when 'RTL_ACCOUNTS' then 'RTL_' || n.tree_node
                 when 'ACCOUNT_CORP' then 'COR_' || n.tree_node
                 when 'ACCOUNTS' then 'ACC_'     || n.tree_node
       end as child
, tn.descr as alias
from pstreenode n
 , ps_tree_node_tbl tn
where n.setid in ('SPN')
  and n.tree_name in ('ACCOUNTS')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and n.setid = tn.setid
  and n.tree_node = tn.tree_node
  and tn.effdt = (select max(tned.effdt) from ps_tree_node_tbl tned
                   where tned.setid = tn.setid
                     and tned.tree_node = tn.tree_node
                     and tned.effdt <= today)

union

select 
 '2-Leaf' as sort1
, 999  as treelevel
, case n.tree_name when 'RTL_ACCOUNTS' then 'RTL_' || n.tree_node
                   when 'ACCOUNT_CORP' then 'COR_' || n.tree_node
                   when 'ACCOUNTS' then     'ACC_' || n.tree_node
       end as parent
, 'A_' || a.account as child
, a.descr as alias
from  pstreenode n
    , pstreeleaf l
    , ps_gl_account_tbl a
where n.setid in ('SPN')
  and n.tree_name in ('ACCOUNTS')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and n.parent_node_num > 0
  and n.setid = l.setid
  and n.setcntrlvalue = l.setcntrlvalue
  and n.tree_name = l.tree_name
  and n.effdt = l.effdt
  and l.tree_node_num between n.tree_node_num and tree_node_num_end
  and a.setid = 'SPN'
  and a.effdt = (select max(aed.effdt) from ps_gl_account_tbl aed
                  where aed.setid = a.setid
                    and aed.account = a.account
                    and aed.effdt <= today)
  and a.account between l.range_from and l.range_to
  and n.tree_level_num = (select max(lvl.tree_level_num) from pstreenode lvl
                           where lvl.setid = n.setid
                             and lvl.setcntrlvalue = n.setcntrlvalue
                             and lvl.tree_name = n.tree_name
                             and lvl.effdt = n.effdt
                             and l.tree_node_num between lvl.tree_node_num and lvl.tree_node_num_end)
order by 1, 2
;


-- ------------------
-- OPERATING UNIT Tree
-- New request 08/13/2014
-- ------------------

select 
 '1-Node' as sort1
, n.tree_level_num as treelevel
, case tree_name when 'SN_OU' then 'OU_' || n.parent_node_name
       end as parent
, case tree_name when 'SN_OU' then 'OU_' || n.tree_node
       end as child
, tn.descr as alias
--, n.* 
from pstreenode n
 , ps_tree_node_tbl tn
where n.setid in ('SHARE')
  and n.tree_name in ('SN_OU')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and tn.setid = 'SPN'
  and n.tree_node = tn.tree_node
  and tn.effdt = (select max(tned.effdt) from ps_tree_node_tbl tned
                   where tned.setid = tn.setid
                     and tned.tree_node = tn.tree_node
--                     and tned.effdt <= n.effdt)
                     and tned.effdt <= today)

--  and n.parent_node_num > 0

--order by 1, 2

union

select
 '2-Leaf' as sort1
, 999  as treelevel
, case n.tree_name when 'SN_OU' then 'OU_' || n.tree_node
       end as parent
, 'O_' || o.operating_unit as child
, o.descr as alias
--, n.tree_level_num
--,'--start-node--', n.*, '--start-leaf--',l.*, '--start-ou--', o.*
from  pstreenode n
    , pstreeleaf l
    , ps_oper_unit_tbl o
where n.setid in ('SHARE')
  and n.tree_name in ('SN_OU')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and n.parent_node_num > 0
  and n.setid = l.setid
  and n.setcntrlvalue = l.setcntrlvalue
  and n.tree_name = l.tree_name
  and n.effdt = l.effdt
--  and l.tree_node_num between n.tree_node_num and tree_node_num_end
  and l.tree_node_num = n.tree_node_num
  and o.setid = n.setid
  and o.effdt = (select max(oed.effdt) from ps_oper_unit_tbl oed
                  where oed.setid = o.setid
                    and oed.operating_unit = o.operating_unit
                    and oed.effdt <= today)
  and o.eff_status = 'A'
  and o.operating_unit between l.range_from and l.range_to
  and n.tree_level_num = (select max(lvl.tree_level_num) from pstreenode lvl
                           where lvl.setid = n.setid
                             and lvl.setcntrlvalue = n.setcntrlvalue
                             and lvl.tree_name = n.tree_name
                             and lvl.effdt = n.effdt
--                             and l.tree_node_num between lvl.tree_node_num and lvl.tree_node_num_end)
                             and l.tree_node_num = lvl.tree_node_num)
order by 1, 2, 3
;

-- ------------------
-- BUSINESS UNIT Tree
-- ------------------

select
 '1-Node' as sort1
, n.tree_level_num as treelevel
, case tree_name when 'BUSINESS_UNITS' then 'BU_' || n.parent_node_name
       end as parent
, case tree_name when 'BUSINESS_UNITS' then 'BU_' || n.tree_node
       end as child
, tn.descr as alias
from pstreenode n
 , ps_tree_node_tbl tn
where n.setid in ('SPN')
  and n.tree_name in ('BUSINESS_UNITS')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and n.setid = tn.setid
  and n.tree_node = tn.tree_node
  and tn.effdt = (select max(tned.effdt) from ps_tree_node_tbl tned
                   where tned.setid = tn.setid
                     and tned.tree_node = tn.tree_node
                     and tned.effdt <= today)

union

select 
 '2-Leaf' as sort1
, 999  as treelevel
, case n.tree_name when 'BUSINESS_UNITS' then 'BU_' || n.tree_node
       end as parent
, 'B_' || b.business_unit as child
, b.descr as alias
from  pstreenode n
    , pstreeleaf l
    , ps_bus_unit_tbl_fs b
where n.setid in ('SPN')
  and n.tree_name in ('BUSINESS_UNITS')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and n.parent_node_num > 0
  and n.setid = l.setid
  and n.setcntrlvalue = l.setcntrlvalue
  and n.tree_name = l.tree_name
  and n.effdt = l.effdt
  and l.tree_node_num between n.tree_node_num and tree_node_num_end
  and b.business_unit between l.range_from and l.range_to
  and n.tree_level_num = (select max(lvl.tree_level_num) from pstreenode lvl
                           where lvl.setid = n.setid
                             and lvl.setcntrlvalue = n.setcntrlvalue
                             and lvl.tree_name = n.tree_name
                             and lvl.effdt = n.effdt
                             and l.tree_node_num between lvl.tree_node_num and lvl.tree_node_num_end)
order by 1, 2
;

-- -------------
-- Export LEDGER
-- -------------

unload to 'c:\temp\ledger-ou.txt' delimiter '|'
SELECT
  CASE WHEN  A.BUSINESS_UNIT > ' ' THEN 'B_' ||  A.BUSINESS_UNIT ELSE  A.BUSINESS_UNIT END AS Business_Unit
, A.LEDGER
, A.ACCOUNT
, CASE WHEN  A.ACCOUNT > ' ' THEN 'A_' ||  A.ACCOUNT ELSE  A.ACCOUNT END as Prefixed_Account
, A.DEPTID
, CASE WHEN  A.DEPTID > ' ' THEN 'D_' ||  A.DEPTID ELSE  A.DEPTID END as Prefixed_Deptid
, A.OPERATING_UNIT
, CASE WHEN  A.OPERATING_UNIT > ' ' THEN 'O_' ||  A.OPERATING_UNIT ELSE  A.OPERATING_UNIT END as Prefixed_OperatingUnit
, A.PRODUCT
, CASE WHEN  A.PRODUCT > ' ' THEN 'P_' ||  A.PRODUCT ELSE  A.PRODUCT END as Prefixed_Product
, A.CURRENCY_CD
, B.DESCR
, B.STATISTICS_ACCOUNT
, B.UNIT_OF_MEASURE
, A.FISCAL_YEAR
, A.ACCOUNTING_PERIOD
, SUM( A.POSTED_TOTAL_AMT) as Sum_Posted_Total_Amt
 FROM PS_LEDGER A 
    , PS_GL_ACCOUNT_TBL B
WHERE A.LEDGER = 'ACTUALS' 
  AND A.FISCAL_YEAR = 2014 
--  AND A.ACCOUNTING_PERIOD IN (6)
  AND B.SETID = 'SPN'
  AND B.ACCOUNT = A.ACCOUNT
  AND B.EFFDT = (SELECT MAX(BB.EFFDT) FROM PS_GL_ACCOUNT_TBL BB WHERE BB.SETID = B.SETID AND BB.ACCOUNT = B.ACCOUNT)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
ORDER BY 1, 3, 5, 7
;


-- ----------------
-- DEPARTMENT Trees
-- ----------------

select distinct
 '1-Node' as sort1
, n.tree_level_num as treelevel
, case tree_name when 'NEW_DEPT' then 'NEW_DEPT_' || n.parent_node_name
                 when 'DEPT_ID'  then 'DEPT_'     || n.parent_node_name
       end as parent
, case tree_name when 'NEW_DEPT' then 'NEW_DEPT_' || n.tree_node
                 when 'DEPT_ID'  then 'DEPT_'     || n.tree_node
       end as child
, tn.descr as alias
from pstreenode n
 , ps_tree_node_tbl tn
where n.setid in ('SHARE')
  and n.tree_name in ('NEW_DEPT')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and tn.setid = 'SPN'
  and n.tree_node = tn.tree_node
  and tn.effdt = (select max(tned.effdt) from ps_tree_node_tbl tned
                   where tned.setid = tn.setid
                     and tned.tree_node = tn.tree_node
                     and tned.effdt <= today)

UNION

select 
 '2-Leaf' as sort1
, 999 as treelevel
, case n.tree_name when 'NEW_DEPT' then 'NEW_DEPT_' || n.tree_node
                   when 'DEPT_ID'  then 'DEPT_'     || n.tree_node
       end as parent
, 'D_' || d.deptid as child
, d.descr as alias
from  pstreenode n
    , pstreeleaf l
    , ps_dept_tbl d
where n.setid in ('SHARE')
  and n.tree_name in ('NEW_DEPT')
  and n.effdt = (select max(ned.effdt) from pstreenode ned
                  where ned.setid = n.setid
                    and ned.tree_name = n.tree_name)
  and n.parent_node_num > 0
  and n.setid = l.setid
  and n.setcntrlvalue = l.setcntrlvalue
  and n.tree_name = l.tree_name
  and n.effdt = l.effdt
  and l.tree_node_num between n.tree_node_num and tree_node_num_end
  and d.setid = n.setid
  and d.effdt = (select max(ded.effdt) from ps_dept_tbl ded
                  where ded.setid = d.setid
                    and ded.deptid = d.deptid
                    and ded.effdt <= today)
  and d.deptid between l.range_from and l.range_to
  and n.tree_level_num = (select max(lvl.tree_level_num) from pstreenode lvl
                           where lvl.setid = n.setid
                             and lvl.setcntrlvalue = n.setcntrlvalue
                             and lvl.tree_name = n.tree_name
                             and lvl.effdt = n.effdt
                             and l.tree_node_num between lvl.tree_node_num and lvl.tree_node_num_end)

order by 1, 2
;



