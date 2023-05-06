SELECT
    c.State,
    p.Category,
    SUM(s.Revenue) as totalRevenue
FROM
    Product p 
    INNER JOIN Sales s ON p.ProductID = s.ProductID
    INNER JOIN Country c on s.Zip = c.Zip
GROUP BY
    State,
    Category
ORDER BY
    p.Category,
    totalRevenue DESC;