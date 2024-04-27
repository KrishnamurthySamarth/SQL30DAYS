with cte as
(
	select *, sum(case when job_role is not null then '1' else '0'end) over (order by row_id) as flag
	from job_skills
)
select c1.row_id, 
case when c1.job_role is null then (select c2.job_role from cte c2 where c1.flag = c2.flag and c2.job_role is not null) else c1.job_role end as job_role, c1.skills
from cte c1

 