/* Kolik prodejů se uskutečnilo v dubnu 2014? */
SELECT COUNT(*) AS salesInApril2014
FROM Sales
WHERE YEAR([ DATE ]) = 2014
    AND MONTH([ DATE ]) = 4;
--WHERE DATEPART(YEAR,[Date]) = 2014 and...;