----- Feature Engineering -----
# time_of_day

update sales
set time_of_day = (
		case when `time` between "00:00:00" and "12:00:00" then "Morning"
			 when `time` between "12:01:00" and "16:00:00" then "Afternoon"
             else "Evening"
		end);
	
----- Add day_name column
alter table sales add column day_name varchar (20);

update sales
set day_name = dayname(date);

----- Add month_name column

alter table sales add column month_name varchar(10);

update sales
set month_name = monthname(date);
----------------------------------------------------------------------------

--- How many unique cities does the data have?---
select distinct city
from sales;

--- In which city is each branch?
select distinct city,branch
from sales;

--- How may unique product lines does the data have?
select distinct product_line
from sales;

--- What is the most selling product_line
select product_line, 
	   count(product_line) as quantity
from sales
group by product_line
order by quantity desc;

--- What is the total revenue by month
select 
	month_name as month,
    sum(total) as total_revenue
from sales
group by month
order by total_revenue desc;

--- What is the most common payment method?
select payment, 
	   count(payment) as payment_count 
from sales 
group by payment
order by payment_count desc;

--- Which month had the largest COGS?
select month_name as month,
	   sum(cogs) as total_cogs
from sales
group by month
order by total_cogs desc;

--- Which product line had the largest revenue?
select product_line,
	   sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;

--- Which city has the largest revenue
select city,branch,
	   sum(total) as revenue_by_city
from sales
group by city,branch
order by revenue_by_city desc;

----------------------------------------------------------------------------

--- Number of sales made in each time of the day in holiday
select time_of_day,
	   count(*) total_sales
from sales
where day_name ="Sunday"
group by time_of_day
order by total_sales desc;

--- Which of the customer types brings the most revenue?
select customer_type,
	   sum(total) revenue
from sales
group by customer_type
order by revenue desc;

--- Which customer type pays the most in vat
select customer_type,
		avg(tax_pct) vat
from sales
group by customer_type;

--- How many unique payment methods does the data have?
select distinct payment
from sales;

--- What is the most common customer type?
select customer_type,
		count(*)
from sales 
group by customer_type;

--- What is the gender of most of the customer?
select gender,
	   count(*) gender_count
from sales
group by gender
order by gender_count desc;

--- Which day of the week has the best avg rating?
select day_name,
		avg(rating) avg_rating
from sales
group by day_name
order by avg_rating desc;

 







