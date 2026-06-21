-- # Joins
-- 
-- This file contains several exercises on joins. These topics are a step more involved and confusing than in the previous two files.
-- * [Tutorial on Joins](https://www.sqlitetutorial.net/sqlite-join/)
-- 
-- Here are a few other important notes I'd like you read before beginning:
-- * Make sure you read each question thoroughly.
-- * Don't skip problems, as some problems may rely on previous problems being done correctly.
-- * Make sure you are saving your answers as you go, as some answers will simply be reworkings of previous answers.
-- * A View is a virtual table that represents the result of a stored SELECT query. Unlike a physical table, it does not store data, but it can be queried like a table.
-- 
-- ## Joins
-- 
-- 62) Which employee made which sale?
-- Join the `employees` table onto the `transactions` table by `employee_id`. You only need to include the employee's first/last name from `employees`.

select e.firstname, e.lastname, t.* from employees e join "transactions" t on t."employee_id"=e."ID";

-- 63) What is the name of the employee who made the most in sales? Find this answer by doing a join as in the previous problem.
-- Your resulting query will be difficult for someone else to read.

select e.firstname, e.lastname, sum(t."quantity"*t."unit_price") as
'money_made' from "employees" e join "transactions" t on  t."employee_id"=e."ID" group by e."ID" order by money_made desc

-- 64) Solve the previous problem by joining `employees` onto the `trans_by_employee` view.


select e.firstname, e.lastname,t.total_cost from employees e join "trans_by_employee" t on t."employee_id" = e."ID" order by t.total_cost desc;

-- 65) Next, the company will try to give bonuses based on performance. Show all employees who've made more in sales than 1.5 times their salary.

select e.firstname, e.lastname,t.total_cost, e.salary from employees e join "trans_by_employee" t on t."employee_id" = e."ID" where e.salary*1.5 < t.total_cost
 order by t.total_cost desc;

-- 66) Do we have potentially erroneous rows? Find all transactions which occurred _before_ the employee was even hired! (Make sure each transaction only occupies one row).

select e."ID" ,e."startdate", t.* from employees e join "transactions" t on e."ID" = t."employee_id" where t."orderdate" < e."startdate" group by t."order_id"


-- 67) Among all transactions that occurred from 2015 to 2019, create a table that is the monthly revenue of our company versus the total trading volume of Yum! in that month. 
--Format the columns nicely. (Hint: look at the views) That is, a sample row of your result might look like this:
-- 
-- ```
-- | year | month | company_revenue | yum_trade_volume |
-- |------|-------|-----------------|------------------|
-- | 2017 |    03 |        $100,000 |      125,000,000 |
-- ```
-- 
-- * _Hint:_ You don't need any `WHERE` statements here. You can get the right answer simply by changing what kind of join you do!



select t."year",t.month,   printf('$%,.2d',t."total_cost") as company_revenue ,  printf('%,.2d',y."tot_volume")  as 'yum_trade_volume'
from "trans_by_month" t join "yum_by_month" y on t."year" = y."year"  and t."month" = y."month"






