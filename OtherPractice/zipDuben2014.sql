/* Na kterém ZIP jsme v dubnu 2014 vydělali nejvíce? */
SELECT TOP 1 Zip,
    SUM(Revenue) AS totalProfit
FROM Sales
WHERE YEAR([ DATE ]) = 2014
    AND MONTH([ DATE ]) = 4
GROUP BY Zip
ORDER BY totalProfit DESC;