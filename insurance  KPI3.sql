use `insurance project`;
select account_executive,income_class,sum(amount) from brokerage group by account_executive,income_class;
select account_executive,income_class,sum(amount) from fees group by account_executive,income_class;
select account_executive,income_class,sum(amount) from brokerage group by account_executive,income_class
union
select account_executive,income_class,sum(amount) from fees group by account_executive,income_class;
 select Account_executive,
    sum(case when income_class = 'New' then amount_new else 0 end) as new_achmnt,
    sum(case when income_class = 'Cross Sell' then amount_new else 0 end) as Cr_sl_achmnt,
    sum(case when income_class = 'Renewal' then amount_new else 0 end) as Rn_achmnt
    from achmnt_2
    group by account_executive;
    select Account_executive,
    sum(case when income_class = 'New' then amount_new else 0 end) as new_achmnt,
    sum(case when income_class = 'Cross Sell' then amount_new else 0 end) as Cr_sl_achmnt,
    sum(case when income_class = 'Renewal' then amount_new else 0 end) as Rn_achmnt
    from achmnt_2
    group by account_executive;
    select Account_executive,
    sum(case when income_class = 'New' then amount else 0 end) as new_invoice,
    sum(case when income_class = 'Cross Sell' then amount else 0 end) as Cr_sl_invoice,
    sum(case when income_class = 'Renewal' then amount else 0 end) as Rn_invoice
    from invoice_new
    group by account_executive;
		


