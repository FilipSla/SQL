SELECT YEAR([ DATE ]) AS YEAR,
    SUM(Revenue) AS totalRevenue
FROM Sales
WHERE YEAR([ DATE ]) IN (2014, 2015)
    AND MONTH([ DATE ]) = 1
GROUP BY YEAR([ DATE ])
ORDER BY YEAR;
--WHERE DATEPART(YEAR,[Date]) = 2014; --mám spoustu možností, jak dosáhnout výsledku