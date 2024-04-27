WITH RECURSIVE cte AS (
    SELECT 
        rnk, 
        bus_id, 
        arrival_time, 
        capacity, 
        p_count, 
        boarded, 
        total_boarded
    FROM (
        SELECT 
            ROW_NUMBER() OVER (ORDER BY b.arrival_time) AS rnk, 
            b.bus_id, 
            b.arrival_time, 
            b.capacity, 
            COUNT(p.passenger_id) AS p_count, 
            LEAST(COUNT(p.passenger_id), b.capacity) AS boarded, 
            LEAST(COUNT(p.passenger_id), b.capacity) AS total_boarded
        FROM 
            buses b 
        JOIN 
            passengers p ON p.arrival_time <= b.arrival_time
        GROUP BY 
            b.bus_id, b.arrival_time, b.capacity
    ) AS sub1
    WHERE 
        rnk = 1
    UNION ALL
    SELECT 
        c2.rnk, 
        c2.bus_id, 
        c2.arrival_time, 
        c2.capacity, 
        c2.p_count,
        LEAST(c2.capacity, (c2.p_count - c1.total_boarded)) AS boarded, 
        c1.total_boarded + LEAST(c2.capacity, (c2.p_count - c1.total_boarded)) AS total_boarded
    FROM 
        cte c1 
    JOIN (
        SELECT 
            ROW_NUMBER() OVER (ORDER BY b.arrival_time) AS rnk, 
            b.bus_id, 
            b.arrival_time, 
            b.capacity, 
            COUNT(p.passenger_id) AS p_count
        FROM 
            buses b 
        JOIN 
            passengers p ON p.arrival_time <= b.arrival_time
        GROUP BY 
            b.bus_id, b.arrival_time, b.capacity
    ) AS c2 ON c2.rnk = c1.rnk + 1
)
SELECT 
    bus_id, boarded as passengers_cnt
FROM 
    cte
ORDER BY
	bus_id
