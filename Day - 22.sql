with cte1 as (
    select home_team as teams from ipl_results
    union 
    select away_team as teams from ipl_results
),
cte2 as (
    select teams, result, dates, row_number() over(partition by teams order by dates) as id
    from cte1 c1
    left join ipl_results r on r.home_team = c1.teams or r.away_team = c1.teams
),
cte3 as (
    select *,  (id - row_number() over (partition by teams order by dates)) as rnk
    from cte2
    where result = teams
),
	cte4 as
(
	select teams, count(1) over(partition by teams, rnk order by id range between unbounded preceding and unbounded following) as streak	
	from cte3
)
select teams , max(streak) as max_streak
from cte4
group by teams
order by max_streak desc
