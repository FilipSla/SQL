/* Kolik mají výrobci produktů v různých kategoriích? */
SELECT
    m.Manufacturer,
    p.Category,
    COUNT(*) AS pocetProduktu
FROM Manufacturer m INNER JOIN Product p ON m.ManufacturerID = p.ManufacturerID
GROUP BY m.Manufacturer, p.Category
ORDER BY pocetProduktu DESC;