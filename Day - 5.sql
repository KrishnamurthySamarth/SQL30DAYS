		
with cte1 as
(        	select s.emp_id, s.emp_name, d.deduction, cast((s.base_salary * (d.percentage/100)) as signed) as amount
			from salary s  join
			deduction d
),
	cte2 as
(        	select s.emp_id, s.emp_name, i.income, cast((s.base_salary * (i.percentage/100)) as signed) as amount
			from salary s  join
			income i
)
select * from cte1
union
select * from cte2