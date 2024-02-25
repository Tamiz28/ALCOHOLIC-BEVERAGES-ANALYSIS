# ALCOHOLIC-BEVERAGES-ANALYSIS
We created a Dashboard for Sales of Alcoholic Beverages Analysis Country wise 

use Alcoholic_Beverages;

select * from Revenue_Beer;
select * from Revenue_Ethyl_Alcohol;
select * from Revenue_Intermediate_Products;
select * from Revenue_Sparkling_Wine;
select * from Revenue_Still_Wine;

---1 find Top 5 contries with Avg_Annual_Revenue in Beer
select * from
(select *,Dense_Rank()over(order by Avg_Annual_Revenue ) as Revenue_Rank_ from
(select Country,((last_Reported_value - First_Reported_Value) /First_Reported_Value )/6 *100  as Avg_Annual_Revenue
from Revenue_Beer)AA)BB where Revenue_Rank_ between 1 and 5 ;


---2 find Top 5 contries with Avg_Annual_Revenue in Ethyl_Alcohol
select * from
(select *,Dense_Rank()over(order by Avg_Annual_Revenue desc) as Revenue_Rank_ from
(select Country,(last_Reported_value - First_Reported_Value) /6  as Avg_Annual_Revenue
from Revenue_Ethyl_Alcohol )AA)BB where Revenue_Rank_ between 1 and 5 ;

---3  find Top 5 contries with Avg_Annual_Revenue in Intermediate_Products
select * from
(select *,Dense_Rank()over(order by Avg_Annual_Revenue desc) as Revenue_Rank_ from
(select Country,(last_Reported_value - First_Reported_Value) /6  as Avg_Annual_Revenue
from Revenue_Intermediate_Products )AA)BB where Revenue_Rank_ between 1 and 5 ;

---4 find Top 5 contries with Avg_Annual_Revenue in Sparkling_Wine
select * from
(select *,Dense_Rank()over(order by Avg_Annual_Revenue desc) as Revenue_Rank_ from
(select Country,(last_Reported_value - First_Reported_Value) /6  as Avg_Annual_Revenue
from Revenue_Sparkling_Wine )AA)BB where Revenue_Rank_ between 1 and 5 ;

---5  find Top 5 contries with Avg_Annual_Revenue in Still_Wine 
select * from
(select *,Dense_Rank()over(order by Avg_Annual_Revenue desc) as Revenue_Rank_ from
(select Country,(last_Reported_value - First_Reported_Value) /6  as Avg_Annual_Revenue
from Revenue_Still_Wine)AA)BB where Revenue_Rank_ between 1 and 5 ;



---top countries of each segment on the basis of Heighest revenue

---1 from Revenue_Beer

select * from (
select  country ,Last_Reported_Value,DENSE_RANK()over(order by Last_Reported_Value desc) as Beer_Revenue_Rank_ 
from Revenue_Beer)AA where Beer_Revenue_Rank_ = 1;  

--- 2 from Revenue_Ethyl_Alcohol
select * from (
select  country ,Last_Reported_Value,DENSE_RANK()over(order by Last_Reported_Value desc) as Revenue_Rank_ 
from Revenue_Ethyl_Alcohol)AA where Revenue_Rank_ = 1;  

---3 from Revenue_Intermediate_Products
select * from (
select  country ,Last_Reported_Value,DENSE_RANK()over(order by Last_Reported_Value desc) as Revenue_Rank_ 
from Revenue_Intermediate_Products )AA where Revenue_Rank_ = 1;  

---4 from Revenue_Sparkling_Wine
select * from (
select  country ,Last_Reported_Value,DENSE_RANK()over(order by Last_Reported_Value desc) as Revenue_Rank_ 
from Revenue_Sparkling_Wine )AA where Revenue_Rank_ = 1;  

---5 from Revenue Still_Wine

select * from (
select  country ,Last_Reported_Value,DENSE_RANK()over(order by Last_Reported_Value desc) as Revenue_Rank_ 
from Revenue_Still_Wine )AA where Revenue_Rank_ = 1;  


--- Final Result 
select * from (
select  country ,Last_Reported_Value,DENSE_RANK()over(order by Last_Reported_Value desc) as Revenue_Rank_ 
from Revenue_Beer)AA where Revenue_Rank_ = 1
union 
select * from (
select  country ,Last_Reported_Value,DENSE_RANK()over(order by Last_Reported_Value desc) as Revenue_Rank_ 
from Revenue_Ethyl_Alcohol)AA where Revenue_Rank_ = 1;  

select * from Alcohol_expenditure_WHO
select * from Road_traffic_accidents
