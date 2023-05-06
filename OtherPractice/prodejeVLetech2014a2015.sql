/* Prodeje v letech 2014 a 2015 */
SELECT
    YEAR(Date) AS Year,
    SUM(Revenue) AS totalRevenue
FROM Sales
WHERE YEAR([Date]) IN (2014,2015) AND MONTH([Date]) = 1
GROUP BY YEAR([Date])
ORDER BY totalRevenue DESC;