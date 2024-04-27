with cte as 
(
	select country, age, row_number() over(partition by country order by age asc) as row_counts
    from people
    order by country, age asc
),
	cte1 as
(
	select country, max(row_counts) as max_count
    from cte
    group by country
)
select c1.country, c1.age
from cte c1 join
cte1 c2 on
c1.country = c2.country 
where c1.row_counts >= (c2.max_count)/2 and c1.row_counts <= (c2.max_count)/2 + 1
	
