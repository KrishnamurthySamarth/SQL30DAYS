WITH RECURSIVE cte AS (
    SELECT MIN(from_dt) AS dt FROM vacation_plans
    UNION ALL
    SELECT dt + INTERVAL 1 DAY
    FROM cte
    WHERE dt < (SELECT MAX(to_dt) FROM vacation_plans)
),
flagcte AS (
    SELECT dt,
           CASE WHEN DAYNAME(dt) = 'Sunday' OR DAYNAME(dt) = 'Saturday' THEN 1 ELSE 0 END AS is_holiday
    FROM cte
),
numcte AS (
    SELECT id, emp_id, COUNT(dt) AS dts
    FROM vacation_plans v
    INNER JOIN flagcte c ON c.dt BETWEEN v.from_dt AND v.to_dt
    WHERE is_holiday = 0
    GROUP BY v.id, emp_id
),
joincte AS (
    SELECT n.id, n.emp_id, n.dts, l.balance, ROW_NUMBER() OVER (PARTITION BY n.emp_id ORDER BY n.id) AS rnk  
    FROM numcte n
    JOIN leave_balance l ON n.emp_id = l.emp_id
    ORDER BY n.emp_id, rnk
),
cte1 AS (
    SELECT id, emp_id, dts, balance, 
           (balance - dts) AS t_balance,
           rnk
    FROM joincte
    WHERE rnk = 1
    UNION ALL
    SELECT c1.id, c1.emp_id, c1.dts, c1.balance,
           (cte1.t_balance - c1.dts) AS t_balance,
           c1.rnk
    FROM joincte c1
    JOIN cte1 ON c1.emp_id = cte1.emp_id AND c1.rnk = cte1.rnk + 1
)
SELECT id, emp_id, dts as vacation_days, 
case when t_balance < 0 then "Insufficient" else "Approved" end as status_
FROM cte1
order by status_;
