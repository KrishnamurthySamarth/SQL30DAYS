with cte1 as
(
	select t1.hut1 as start_hut, h1.name as start_hut_name, h1.altitude as start_hut_altitude, t1.hut2 as end_hut
    from trails t1 join
    mountain_huts h1 on
    t1.hut1 = h1.id
),
	cte2 as
(
		select c.*, h2.name as end_hut_name, h2.altitude as end_hut_altitude
		from cte1 c join
		mountain_huts h2 on
		c.end_hut = h2.id
),
	cte3 as
(
	select
    case when start_hut_altitude > end_hut_altitude then start_hut else end_hut end as start_hut,
    case when start_hut_altitude > end_hut_altitude then start_hut_name else end_hut_name end as start_hut_name, 
    case when start_hut_altitude > end_hut_altitude then end_hut else start_hut end as end_hut,
    case when start_hut_altitude > end_hut_altitude then end_hut_name else start_hut_name end as end_hut_name
    from cte2
)

select c1.start_hut_name, c2.start_hut_name, c2.end_hut_name
from cte3 c1 join cte3 c2
on c1.end_hut = c2.start_hut