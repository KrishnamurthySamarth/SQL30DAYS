with recursive cte as (
		select 1 as digits
        union all
        select digits+1 as digits from cte
        where digits<(select max(id) from item)
),
cte1 as 
(
	select *,substring_index(substring_index(items,',',digits),',',-1) as vals
	from item
	join cte 
	where digits < LENGTH(items) - LENGTH(REPLACE(items, ',', '')) +2
)
select id, items,group_concat(length(vals) order by digits) as len from cte1 group by id, items