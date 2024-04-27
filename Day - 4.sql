select min(id) as id , 
(select name from Q4_data where name is not null group by name) as name,
(select location from Q4_data where location is not null group by location) as location
from Q4_data;
select max(id) as id , 
(select name from Q4_data where name is not null group by name) as name,
(select location from Q4_data where location is not null group by location) as location
from Q4_data;