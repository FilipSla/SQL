SELECT
    State,
    SUM(Revenue) as totalRevenue
FROM
    Sales s
    INNER JOIN Country c ON s.Zip = c.Zip
GROUP BY
    State 
ORDER BY
    totalRevenue DESC;