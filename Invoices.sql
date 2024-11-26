select * from Invoices;

## WHAT IS THE AVERAGE INVOICE AMOUNT?
## IS THE INVOICE PAYMENT EVER LATE?
## WHO ARE THE TOP 5 PAYING CUSTOMERS?
## SUM OF AMOUNT PER QUARTER?

select round(avg(dollar_amount), 2)
as Average_Amount from Invoices;

select * from Invoices
where completed_date <> paid_date;

select customer_first, customer_last, sum(dollar_amount)
as Top_Customers from Invoices
group by customer_first, customer_last
order by Top_Customers desc
limit 5;

select * from Invoices 
where dollar_amount = NULL; ## checking for null values

(select 'Q1' as Quarter, sum(dollar_amount) as Quarter_Sales
from Invoices
where completed_date>= '2024-01-01' and completed_date <= '2024-03-31')
union all
(select 'Q2', sum(dollar_amount)
from Invoices
where completed_date>= '2024-04-01' and completed_date <= '2024-06-30')
union all
(select 'Q3', sum(dollar_amount)
from Invoices
where completed_date>= '2024-07-01' and completed_date <= '2024-09-30')
union all 
(select 'Q4', sum(dollar_amount)
from Invoices
where completed_date>= '2024-10-01' and completed_date <= '2024-12-31'); ## creates a temporary table showing quarter results

with Q3 as (
    select sum(dollar_amount) as Q3_End
    from Invoices                                                          
    where completed_date >= '2024-09-01' and completed_date <= '2024-09-30'
), ## find value of the 'end of quarter 3'
Q2 as (
    select sum(dollar_amount) as Q2_End
    from Invoices                                                            
    where completed_date >= '2024-06-01' and completed_date <= '2024-06-30'
) ## find the value of 'end of quarter 2'
select 
    Q3.Q3_End,
    Q2.Q2_End,
    (Q3.Q3_End / Q2.Q2_End) as End_Diff, ## dividing the quarters to find the 'end of quarter change'
    Q3.Q3_End * (Q3.Q3_End / Q2.Q2_End) as Q4_End_Prediction  ## multiply the end of quarter change by the end of quarter 3
from Q3, Q2;

## Since we haven't reached the end of Quarter 4 yet, I tried to predict the end of quarter 4 amount given the change between
## the two previous quarters. 



      


































