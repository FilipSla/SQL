/* Na kterých kategoriích vydělává společnost Abbas nejvíce? */
SELECT p.Category,
    SUM(s.Revenue) AS totalRevenue
FROM Manufacturer m
    INNER JOIN Product p ON m.ManufacturerID = p.ManufacturerID
    INNER JOIN Sales s ON p.ProductID = s.ProductID
WHERE m.Manufacturer = 'Abbas'
GROUP BY p.Category
ORDER BY totalRevenue DESC;