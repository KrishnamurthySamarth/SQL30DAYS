with cte as
(
	select pv.session_id, time_to_sec(timediff(us.session_endtime, us.session_starttime)) as diff, post_id, perc_viewed
	from user_sessions us right join
	post_views pv on
	us.session_id = pv.session_id
)
select post_id, sum(((perc_viewed/100)*diff)) as Total_spent
from cte
group by post_id
having sum(((perc_viewed/100)*diff)) > 5
order by post_id desc;