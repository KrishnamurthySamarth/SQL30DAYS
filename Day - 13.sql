select e2.name, count(e2.name)
from employee_managers e1
join employee_managers e2
on e1.manager = e2.id
group by e2.name