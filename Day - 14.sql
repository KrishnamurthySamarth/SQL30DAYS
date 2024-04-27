with recursive cte as 
(
	select serial_no
    from invoice
    where serial_no = (select min(serial_no) from invoice)
    union
    select (serial_no + 1)
    from cte
    where serial_no < (select max(serial_no) from invoice)
)
select serial_no
from cte
where serial_no not in (select serial_no from invoice)