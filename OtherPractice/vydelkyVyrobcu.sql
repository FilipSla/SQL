/* Který výrobce nám vydělal nejvíc celkem? */
SELECT p.ManufacturerID,
    SUM(s.Revenue) AS totalRevenue
FROM Sales s
    INNER JOIN Product p ON s.ProductID = p.ProductID
GROUP BY p.ManufacturerID
ORDER BY totalRevenue DESC;