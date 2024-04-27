with cte1 as
(
	select hotel, avg(rating) as average_rating 
	from hotel_ratings
	group by hotel
),
	cte2 as
(
	select h.*, c.average_rating, rank() over (partition by h.hotel order by abs(h.rating - c.average_rating) desc) as rank_V
	from hotel_ratings h join
	cte1 c on
	h.hotel = c.hotel
)
select hotel, year, rating
from cte2
where rank_V > 1
