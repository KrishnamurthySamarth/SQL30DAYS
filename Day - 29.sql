with cte as 
(
	select *,
		   row_number() over(order by times) as rn,
		   row_number() over(partition by status order by times) as rn1,
			row_number() over(order by times)- row_number() over(partition by status order by times) as diff
	from login_details
	order by times
),
	cte2 as 
(
select min(times) as times,status,diff
from cte
group  by status,diff
),
	cte3 as
(
	select *,lead(status) over(order by times) as ld,lead(times) over(order by times) as ld1
	from cte2
)
select times as log_on,
        ld1 as log_off,
        minute(timediff(ld1,times)) as  duration
from cte3
where status ="on" and ld="off"