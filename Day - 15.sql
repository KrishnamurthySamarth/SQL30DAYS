select * from friends;
with cte as
(
	select friend1, friend2
	from friends
	union all
	select friend2, friend1
	from friends
    order by 1
)
select f.friend1, f.friend2, count(c.friend2)
from friends f
left join cte c
on c.friend1 = f.friend1
and c.friend2 in (select c1.friend2 from cte c1 where c1.friend1 = f.friend2)
group by f.friend1, f.friend2