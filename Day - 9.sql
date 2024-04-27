select dates, group_concat(product_id) as product_id
from orders
group by customer_id, dates
union
select dates, product_id 
from orders
order by dates asc