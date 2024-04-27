with cte as
(
		select test_id, lead(marks, 1) over () as next_score
		from student_tests
)
select s.test_id, cte.next_score 
from student_tests s join
cte on s.test_id = cte.test_id
where cte.next_score >= s.marks;

select s.test_id, cte.next_score 
from student_tests s join
cte on s.test_id = cte.test_id
where cte.next_score > s.marks;