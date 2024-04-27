with new_student_marks_cte as
(
	select student_id,'S1' as sub_id,coalesce(subject1,0) as marks_obt
	from student_marks
	union all
	select student_id,'S2' as sub_id,coalesce(subject2,0) as marks_obt
	from student_marks
	union all
	select student_id,'S3' as sub_id,coalesce(subject3,0) as marks_obt
	from student_marks
	union all
	select student_id,'S4' as sub_id,coalesce(subject4,0) as marks_obt
	from student_marks
	union all
	select student_id,'S5' as sub_id,coalesce(subject5,0) as marks_obt
	from student_marks
	union all
	select student_id,'S6' as sub_id,coalesce(subject6,0) as marks_obt
	from student_marks
),
cte_2 as
(
	select *,
	(case when marks_obt < pass_marks then sub.name end) as sub_failed
	from subjects sub
	inner join new_student_marks_cte st_marks on sub.id = st_marks.sub_id
    where marks_obt > 0
),
cte_3 as
(
	select
	student_id,
	round(avg(marks_obt),2) as percent_marks,
	coalesce(group_concat(sub_failed),'-') as failed_subs,
	(case when group_concat(sub_failed) is not null then 'Fail' else
		(case when avg(marks_obt) >= 70 then 'First Class' else
		(case when avg(marks_obt) between 50 and 70 then 'Second Class' else 'Third Class' end) end) end) as result
	from cte_2
	group by student_id
)

select
student_id, name,
percent_marks as percentage_marks,
failed_subs as failed_subjects,
result
from students stu
inner join cte_3 on stu.roll_no = cte_3.student_id;