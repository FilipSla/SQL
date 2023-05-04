/* V kolika segmentech působí jednotlivý výrobci */
SELECT ManufacturerID,
    COUNT(DISTINCT SEGMENT) AS segmentsCount
FROM Product
GROUP BY ManufacturerID
ORDER BY segmentsCount DESC;