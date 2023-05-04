/* Jaká byla max., min. a průměrná tržba v roce 2014 */
SELECT MAX(Revenue) AS maxRevenue,
    MIN(Revenue) AS minRevenue,
    AVG(Revenue) AS averageRevenue
FROM Sales
WHERE YEAR([ DATE ]) = 2014;