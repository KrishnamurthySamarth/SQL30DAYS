select * from FOOTER;

	select
		(select car from FOOTER where car is not null order by id desc limit 1) as car,
		(select length from FOOTER where length is not null order by id desc limit 1) as length,
		(select width from FOOTER where width is not null order by id desc limit 1) as width,
		(select height from FOOTER where height is not null order by id desc limit 1) as height;
