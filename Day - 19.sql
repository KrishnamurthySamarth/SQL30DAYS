	with cte as 
	(
		SELECT date_format(order_time, '%b-%y') AS period, count(*) as count_late, 
        sum(CASE WHEN timediff(actual_delivery, order_time) > '00:30:00.000000' THEN no_of_pizzas ELSE 0 END) as free_pizzas
		FROM mytable
		where timediff(actual_delivery, order_time) > '00:30:00.000000'
		group by date_format(order_time, '%b-%y')
	)
	select c.period, round(100* (count_late/count_actual),1) as percentage_late, free_pizzas
	from 
	( select date_format(order_time, '%b-%y') AS period, count(*) as count_actual from mytable group by date_format(order_time, '%b-%y')) as sub1
	join cte c on sub1.period = c.period
	ORDER BY STR_TO_DATE(CONCAT('01-', c.period), '%d-%b-%y') ASC;
