with cte as
(
	select *, dense_rank() over (partition by user_id order by user_id, login_date) as ranks
	from user_login
),
	cte1 as
(
	select *, date_sub(login_date, interval ranks day) as date_diff
	from cte
)
select user_id, max(login_date) as end_date, min(login_date) as start_date, (datediff(max(login_date), min(login_date)) + 1) as consecutive_days
from cte1
group by user_id, date_diff
having (datediff(max(login_date), min(login_date)) + 1) >=5