select * from itemcode where (codeScheme, itemCode) in
(SELECT   codeScheme,
         itemCode
FROM     itemcode
WHERE    codeScheme = 'G'
GROUP BY codeScheme, itemCode
HAVING   count(*) > 1)
order by codeScheme , itemCode,  dc desc
;

select * from itemcode where codeScheme = 'G'