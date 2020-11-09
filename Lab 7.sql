use sakila;



   -- 1- Get number of monthly active customers.
   
create or replace view user_activity as
select customer_id, convert(rental_date, date) as Activity_date,
date_format(convert(rental_date,date), '%m') as Activity_Month,
date_format(convert(rental_date,date), '%Y') as Activity_year
from rental;

select * from user_activity;

create or replace view Monthly_active_users as
select count(distinct customer_id) as Active_users, Activity_year, Activity_Month
from user_activity
group by Activity_year, Activity_Month
order by Activity_year, Activity_Month;

select * from Monthly_active_users;



   -- 2- Active users in the previous month.
   
   
   
   
create or replace view list_monthly_active_users as
select distinct customer_id as list_active_users, Activity_year, Activity_Month
from user_activity
order by Activity_year desc, Activity_Month;

select * from list_monthly_active_users;

   
   with cte_lmau as (
  select list_active_users, lag(list_active_users,1) over (partition by Activity_year) as last_month, Activity_year, Activity_month
  from list_monthly_active_users
)
select * from cte_lmau
where last_month is not null;
   
   
   
   
   -- 3- Percentage change in the number of active customers.
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   -- 4-Retained customers every month.
