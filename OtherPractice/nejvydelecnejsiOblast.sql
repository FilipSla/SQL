/* V které oblasti jsme vydělali nejvíce? */
SELECT TOP 1 C .Region,
    SUM(s.Revenue) AS totalRevenue
FROM Country C
    INNER JOIN Sales s ON C .Zip = s.Zip
GROUP BY C .Region
ORDER BY totalRevenue DESC;