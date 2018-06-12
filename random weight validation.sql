--mw
Select FACILITYID, CUSTOMER_NO_FULL, sum(RANDOM_WGT) as tot_rw, sum(RANDOM_WGT) / 2000 as tot_tons, sum(QTY_SOLD) as tot_qty
from CRMADMIN.T_WHSE_SALES_HISTORY_DTL
where facilityid in ('001','002','003','005','008','009','040','054')
And BILLING_DATE between '2008-02-24' and '2008-03-22'
and RANDOM_WGT_FLG = 'R'
And RECORD_ID = '1'
group by FACILITYID, CUSTOMER_NO_FULL;


--swat
Select FACILITYID, CUSTOMER_NO_FULL, sum(RANDOM_WGT) as tot_rw, sum(RANDOM_WGT) / 2000 as tot_tons, sum(QTY_SOLD) as tot_qty
from CRMADMIN.T_WHSE_SALES_HISTORY_DTL
where facilityid in ('015','058','059','061','062','063','064')
And BILLING_DATE between '2008-02-24' and '2008-03-22'
and RANDOM_WGT_FLG = 'R'
group by FACILITYID, CUSTOMER_NO_FULL;
