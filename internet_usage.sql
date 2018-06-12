Select * -- convert(char, date_time, 102), count(*) 
  from dbo.INCOMING inc,
       dbo.USER_NAMES un
 where un.USER_ID = inc.USER_ID
   and date_time between '2007-10-14 00:00:00.000' and '2007-10-23 00:00:00.00' 
   and un.user_login_name like '%105731%';
--group by convert(char, date_time, 102);

SELECT   un.USER_ID,
         un.USER_LOGIN_NAME,
         un.USER_FULL_NAME,
         inc.URL,
         inc.CATEGORY,
         inc.KEYWORD_ID,
         inc.FILE_TYPE_ID,
--         sum(inc.BYTES_SENT) tot_bytes_sent,
--         sum(inc.BYTES_RECEIVED) tot_bytes_received,
         sum(inc.DURATION) time_spent,
         sum(inc.HITS) total_hits
FROM     dbo.INCOMING inc,
         dbo.USER_NAMES un
WHERE    un.USER_ID = inc.USER_ID
AND      date_time between '2007-10-21 00:00:00.000' and '2007-10-28 00:00:00.00'
--and      un.USER_LOGIN_NAME = '105731'
GROUP BY un.USER_ID, un.USER_LOGIN_NAME, un.USER_FULL_NAME, inc.URL, 
         inc.CATEGORY, inc.KEYWORD_ID, inc.FILE_TYPE_ID
