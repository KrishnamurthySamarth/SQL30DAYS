with cte as
(
		select *,
		case when substring(Day_Indicator, dayofweek(Dates), 1) = 1 then Dates else null end as Day_check
		from Day_Indicator
)
select Product_ID, Day_Indicator, Dates
from cte 
where Day_check is not null;