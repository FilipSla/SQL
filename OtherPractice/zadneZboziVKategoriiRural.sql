/* Kteří výrobci nemají žádné zboží v kategorii Rural? */
SELECT m.Manufacturer
FROM Manufacturer m
    LEFT JOIN Product p ON m.ManufacturerID = p.ManufacturerID AND p.Category = 'Rural'
WHERE p.Category IS NULL
ORDER BY m.Manufacturer;