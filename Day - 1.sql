with cte as 
(
		select *,
        case
			when brand1 > brand2 then concat(coalesce(brand1,''),coalesce(brand2,''),year)
			when brand2 > brand1 then concat(coalesce(brand2,''),coalesce(brand1,''),year)
        end as u_id
        from brands
),
cte_rn as 
(
	select *,
    row_number() over (partition by u_id order by u_id) as rn
    from cte
)
select brand1, brand2, year, custom1, custom2, custom3, custom4
from cte_rn
where rn = 1
or (custom1 <> custom3 and custom2 <> custom4)