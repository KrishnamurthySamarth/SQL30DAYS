select cust_name, email
from feedback
where email REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@[a-zA-Z]+\.[a-zA-Z]{2,3}$'