use Alcoholic_Beverages;
--- 1 Revenue
select * from Revenue_Beer;
select * from Revenue_Ethyl_Alcohol;
select * from Revenue_Intermediate_Products;
select * from Revenue_Sparkling_Wine;
select * from Revenue_Still_Wine;

---2 Health Issues
select * from SDR_alcohol_related_causes order by First_Reported_Value desc
select * from  Road_traffic_accidents


--- 3 WHO 
select * from Alcohol_expenditure_WHO order by Country
select * from Alcoholic_beverage_tax_WHO order by Country --- Alcoholic beverage tax revenue as a per cent of government revenue				
select * from Annual_revenue_from_alcohol_WHO order by Country



--- 1---1 Annual % change in Tax percentage 
---Alcoholic_beverage_tax_WHO

Select *, Dense_rank() over (order by change_Tax_percent_ ) As Tax_rank
from
(select Country,round ((last_Reported_value - First_Reported_Value)/(First_Reported_Value)/(last_reported_value_year-First_Reported_Value_Year)*100,3) as change_Tax_percent_
from Alcoholic_beverage_tax_WHO)a  where change_Tax_percent_ is not null



--- 2 Category wise heighest increase  revenue annual percentage countries

Select * from
(Select *, Dense_rank() over (order by Avg_annual_revenue desc) As revenue_rank
from
(select category, Country,round ((((last_Reported_value - First_Reported_Value)/First_Reported_Value)/6)*100 ,3) as Avg_Annual_Revenue
from Revenue_Beer)a where Avg_Annual_Revenue is not null) c
where revenue_rank = 1
union
Select * from
(Select *, Dense_rank() over (order by Avg_annual_revenue desc) As revenue_rank
from (select category,Country,round ((((last_Reported_value - First_Reported_Value)/First_Reported_Value)/6)*100 ,3) as Avg_Annual_Revenue
from Revenue_ethyl_alcohol)a where Avg_Annual_Revenue is not null) c
where revenue_rank = 1 
union
Select * from
(Select *, Dense_rank() over (order by Avg_annual_revenue desc) As revenue_rank
from (select Category, Country,round ((((last_Reported_value - First_Reported_Value)/First_Reported_Value)/6)*100,3) as Avg_Annual_Revenue
from Revenue_Intermediate_products)a  where Avg_Annual_Revenue is not null) c
where revenue_rank = 1 
union
select * from
(select *,Dense_Rank()over(order by Avg_Annual_Revenue desc) as Revenue_Rank_ from
(select category,Country,round ((((last_Reported_value - First_Reported_Value)/First_Reported_Value)/6)*100,3) as Avg_Annual_Revenue
from Revenue_Sparkling_Wine )AA where Avg_Annual_Revenue is not null) BB where Revenue_Rank_ =1  
union
select * from
(select *,Dense_Rank()over(order by Avg_Annual_Revenue desc ) as Revenue_Rank_ from
(select category,Country,round ((((last_Reported_value - First_Reported_Value)/First_Reported_Value)/6)*100,3) as Avg_Annual_Revenue
from Revenue_Still_Wine )AA where Avg_Annual_Revenue is not null) BB where Revenue_Rank_ = 1 

--- 3


select * into aggregated_level2 from
(Select a.Country,((a.Last_Reported_Value-a.First_Reported_Value)/6) as Avg_beer_revenue_per_year,
(b.Last_Reported_Value-b.First_Reported_Value) as Avg_Revenue_ethyl_alcohol_per_year,
((c.Last_Reported_Value-c.First_Reported_Value)/6) as Avg_Revenue_Intermediate_products_per_year,
((d.Last_Reported_Value-d.First_Reported_Value)/6) as Avg_Revenue_sparkling_wine_per_year,
((e.Last_Reported_Value-e.First_Reported_Value)/6) as Avg_Revenue_still_wine_per_year
from Revenue_beer as a inner join Revenue_ethyl_alcohol as b on a.Country=b.Country
inner join Revenue_Intermediate_products as c on b.Country=c.Country
inner join Revenue_sparkling_wine as d on c.Country=d.Country
inner join Revenue_still_wine as e on d.Country=e.Country)a
select*from aggregated_level2

select * from 
(select*,dense_rank() over(order by Total_Avg_revenue desc) as Revenue_Rank from
(Select Country ,(Avg_beer_revenue_per_year+ Avg_Revenue_ethyl_alcohol_per_year + Avg_Revenue_Intermediate_products_per_year + Avg_Revenue_sparkling_wine_per_year +Avg_Revenue_still_wine_per_year )
as Total_Avg_revenue from aggregated_level2 )AA)T where Total_Avg_revenue is not null

--- 4
---Revenue_beer lowest 5 
Select * from
(Select *, Dense_rank() over (order by Avg_annual_revenue ) As revenue_rank
from (select Country,round ((((last_Reported_value - First_Reported_Value)/First_Reported_Value)/6)*100 ,3) as Avg_Annual_Revenue
from Revenue_Beer)a where Avg_Annual_Revenue is not null) c
where revenue_rank between 1 and 5;

--- 5
--- Avg_percentage_Alcoholic_related_causes
select * from
(select *,Dense_Rank()over(order by Avg_percent_Acohol_related_causes desc) as Rank_ from
(select Country,
round ((((last_Reported_value - First_Reported_Value)/First_Reported_Value)/(last_Reported_value - First_Reported_Value))*100,3)
as Avg_percent_Acohol_related_causes
from SDR_alcohol_related_causes )AA)BB where Rank_ between 1 and 5

---6 

----Avg_percentage_Road__traffic_accidents
select * from
(select *,Dense_Rank()over(order by Avg_percent_Road_traffic_accidents desc) as _Rank_ from
(select Country,
round ((((last_Reported_value - First_Reported_Value)/First_Reported_Value)/(last_Reported_value - First_Reported_Value))*100,3)
as Avg_percent_Road_traffic_accidents
from Road_traffic_accidents )AA)BB where _Rank_ between 1 and 5