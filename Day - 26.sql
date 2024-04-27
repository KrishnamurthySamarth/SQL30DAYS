with recursive cte as ( 
select min(from_dt) as dt from vacation_plans
union
select dt+interval 1 day
from cte
where dt < (select max(to_dt) from vacation_plans)
), 
	flagcte as 
(
	select dt, 
    CASE WHEN DAYNAME(dt) = 'Sunday' OR DAYNAME(dt) = 'Saturday' THEN 1 ELSE 0 END AS is_holiday
    from cte
)
select * from flagcte;
select * from vacation_plans