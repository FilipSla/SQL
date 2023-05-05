/* Ve kterých státech se od 2. ledna do 5.ledna 2015 nic neprodalo? */
SELECT c.State
FROM Country c
    LEFT JOIN Sales s ON c.Zip = s.Zip AND [Date] BETWEEN '2015-01-02' AND '2015-01-05'
GROUP BY c.[State]
HAVING SUM(Revenue) IS NULL;