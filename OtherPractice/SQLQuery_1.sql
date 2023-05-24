SELECT
    m.Manufacturer,
    SUM(Units) as totalUnits
FROM Sales s
INNER JOIN Product p ON s.ProductID = p.ProductID
INNER JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
GROUP BY m.Manufacturer
ORDER BY totalUnits DESC;