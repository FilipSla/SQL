/* Které výrobky z kategorie Youth se v roce 2014 neprodaly? */
SELECT p.Product
FROM Product p 
    LEFT JOIN Sales s on p.ProductID = s.ProductID AND YEAR(S.[Date]) = 2014
WHERE Category = 'Youth' AND s.ProductID IS NULL;