select m.id, m.name,  count( distinct e.event_name) as no_of_event
from events e join
employees m on
e.emp_id = m.id
group by m.id, m.name
having count( distinct e.event_name) = 3
