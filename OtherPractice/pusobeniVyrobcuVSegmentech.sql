/* Ve kterém segmentu působí nejvíce výrobců */
SELECT Segment,
    COUNT(DISTINCT ManufacturerID) as segmentCount
FROM Product
GROUP BY
    Segment
ORDER BY segmentCount DESC;