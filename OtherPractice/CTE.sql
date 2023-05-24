WITH CTE_manIDs AS (
    SELECT ManufacturerID
    FROM Product p
        INNER JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = 'Rural'
    GROUP BY ManufacturerID
)
SELECT *
FROM Manufacturer m
    LEFT JOIN CTE_manIDs mi ON m.ManufacturerID = mi.ManufacturerID
WHERE mi.ManufacturerID IS NULL;