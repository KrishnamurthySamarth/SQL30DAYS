with cte1 as
(
		select 
		case when indicator = 'velocity' then value else '1' end as velocity,
		case when indicator = 'level' then value else '0' end as level
		from auto_repair
),
	cte2 as
(    
		select velocity, 
		case when velocity != 1 then lag(level,1) over() else '0' end as level
		from cte1
),
	cte3 as
    (
		select velocity, 
		case when level = 'good' then 1 else 0 end as Good,
		case when level = 'regular' then 1 else 0 end as Regular,
		case when level = 'wrong' then 1 else 0 end as wrong
		from cte2
	)
select velocity, sum(Good) as Good, sum(wrong) as Wrong, sum(Regular) as Regular
from cte3
where velocity != 1
group by velocity
order by velocity

