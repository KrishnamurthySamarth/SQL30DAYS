with cte as
(
	select  month(dates) as months, sum(cases_reported) as sums
	from covid_cases
    group by month(dates)
),
	cte2 as
(
	select months, sums, sum(sums) over(order by months) as cum_cases
	from cte
)
select months, 
case when months > 1 then (sums / LAG(cum_cases) OVER (ORDER BY months) * 100)
	 else '-' end as percentage_incease
from cte2
