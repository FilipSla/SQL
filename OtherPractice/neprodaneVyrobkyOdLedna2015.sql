/* Kteří výrobci neprodali od 1.1.2015 žádný výrobek? */
SELECT m.Manufacturer
FROM Product p
    INNER JOIN Sales s ON p.ProductID = s.ProductID AND s.Date > '2015-01-01'
    RIGHT JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
WHERE s.ProductID IS NULL
GROUP BY m.Manufacturer;