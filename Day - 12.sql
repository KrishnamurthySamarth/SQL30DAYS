WITH RECURSIVE cte AS (
    SELECT 
        employee, 
        manager, 
        CONCAT("Team ", ROW_NUMBER() OVER (ORDER BY employee)) AS team 
    FROM 
        company
    WHERE 
        manager IN (SELECT employee FROM company WHERE manager IS NULL)
    UNION ALL
    SELECT 
        co.employee, 
        co.manager, 
        cte.team 
    FROM 
        cte 
    JOIN 
        company co ON cte.employee = co.manager
),
cte2 AS (
    SELECT 
        team,
        (SELECT employee FROM company WHERE manager IS NULL) AS manager, 
        GROUP_CONCAT(employee) AS people 
    FROM 
        cte
    GROUP BY 
        team
)
SELECT 
    team,
    CONCAT(manager, ',', people) AS people 
FROM 
    cte2;
