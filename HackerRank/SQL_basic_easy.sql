/* Japanese cities names */
SELECT
    NAME
FROM
    city
WHERE
    countrycode = 'JPN';
/* Weather Observation Station 1 */
SELECT
    city,
    state
FROM
    station
ORDER BY
    city;
/* Weather Observation Station 2 */
SELECT
    round(SUM(lat_n), 2) AS sumLat_N,
    round(SUM(long_w), 2) AS sumLong_W
FROM
    station;
/* Weather Observation Station 3 */
SELECT
    DISTINCT city
FROM
    station
WHERE
    id % 2 = 0
ORDER BY
    city;
/* Weather Observation Station 4 */
SELECT
    COUNT(*) - COUNT(DISTINCT city) AS difference
FROM
    station;
/* Weather Observation Station 5 */
SELECT
    city,
    len(city)
FROM
    (
        SELECT
            top(1) *
        FROM
            station
        ORDER BY
            len(city),
            city
    ) A
UNION
SELECT
    city,
    len(city)
FROM
    (
        SELECT
            top(1) *
        FROM
            station
        ORDER BY
            len(city) DESC,
            city
    ) b;
/* Weather Observation Station 6 */
SELECT
    DISTINCT city
FROM
    station
WHERE
    city LIKE '[aeiou]%';
/* Weather Observation Station 7 */
SELECT
    DISTINCT city
FROM
    station
WHERE
    city LIKE '%[aeiou]';
/* Weather Observation Station 8 */
SELECT
    DISTINCT city
FROM
    station
WHERE
    city LIKE '[aeiou]%[aeiou]';
/* Weather Observation Station 9 */
SELECT
    DISTINCT city
FROM
    station
WHERE
    city NOT LIKE '[aeiou]%';
/* Weather Observation Station 10 */
SELECT
    DISTINCT city
FROM
    station
WHERE
    city NOT LIKE '%[aeiou]';
/* Weather Observation Station 11 */
SELECT
    DISTINCT city
FROM
    station
WHERE
    city NOT LIKE '%[aeiou]'
    OR city NOT LIKE '[aeiou]%';
/* Weather Observation Station 12 */
SELECT
    DISTINCT city
FROM
    station
WHERE
    city NOT LIKE '%[aeiou]'
    AND city NOT LIKE '[aeiou]%';
/* Higher Than 75 Marks */
SELECT
    NAME
FROM
    students
WHERE
    marks > 75
ORDER BY
    right(NAME, 3),
    id;
/* Employee Names */
SELECT
    NAME
FROM
    employee
ORDER BY
    NAME;
/* Employee Salaries */
SELECT
    NAME
FROM
    employee
WHERE
    salary > 2000
    AND months < 10
ORDER BY
    employee_id;
--------------------------
SELECT
    COUNT(*) AS numberOfCities
FROM
    city
WHERE
    population > 100000;
/* Revising Aggregations - The Sum Function */
SELECT
    SUM(population) AS sumOfCaliforniaCities
FROM
    city
WHERE
    district = 'California';
/* Revising Aggregations - Averages */
SELECT
    AVG(population) AS averageCaliforniaCityPopulation
FROM
    city
WHERE
    district = 'California';
/* Average Population */
SELECT
    FLOOR(AVG(population)) AS averageCityPopulation
FROM
    city;
/* Japan Population */
SELECT
    SUM(population) AS japaneseCitiesPopulation
FROM
    city
WHERE
    countrycode = 'JPN';
/* Population Density Difference */
SELECT
    MAX(population) - MIN(population) AS diffPopulation
FROM
    city;
/* Population Census */
SELECT
    SUM(C .population)
FROM
    city C
    INNER JOIN country co ON C .countrycode = co.code
WHERE
    co.continent = 'Asia';
/* Average Population of Each Continent */
SELECT
    co.continent,
    floor(AVG(ci.population)) AS averageCityPopulation
FROM
    city ci
    INNER JOIN country co ON ci.countrycode = co.code
GROUP BY
    co.continent;
/* The Blunder */
SELECT
    ceil(AVG(salary) - AVG(replace(salary, '0', '')))
FROM
    employees;
/* Top Earners */
SELECT
    months * salary AS totalSalary,
    COUNT(*) AS numberOfPeople
FROM
    employee
GROUP BY
    totalSalary
HAVING
    totalSalary = (
        SELECT
            MAX(months * salary)
        FROM
            employee
    );
SELECT
    truncate(SUM(lat_n), 4)
FROM
    station;
/* Weather Observation Station 13 */
SELECT
    truncate(SUM(lat_n), 4) AS suma
FROM
    station
WHERE
    lat_n BETWEEN 38.7880
    AND 137.2345;
/* Weather Observation Station 14 */
SELECT
    MAX(truncate(lat_n, 4)) AS greatestNumber
FROM
    station
WHERE
    lat_n < 137.2345;
/* Weather Observation Station 15 */
SELECT
    round(long_w, 4)
FROM
    station
WHERE
    lat_n < 137.2345
ORDER BY
    lat_n DESC
LIMIT
    1;
---or---
SELECT
    ROUND(long_w, 4)
FROM
    STATION
WHERE
    LAT_N = (
        SELECT
            MAX(LAT_N)
        FROM
            STATION
        WHERE
            LAT_N < 137.2345
    );
/* Weather Observation Station 16 */
SELECT
    round(lat_n, 4)
FROM
    station
WHERE
    lat_n = (
        SELECT
            MIN(lat_n)
        FROM
            station
        WHERE
            lat_n > 38.7780
    );
/* Weather Observation Station 17 */
SELECT
    round(long_w, 4)
FROM
    station
WHERE
    lat_n > 38.7780
ORDER BY
    lat_n
LIMIT
    1;
----or---
SELECT
    round(long_w, 4)
FROM
    station
WHERE
    lat_n = (
        SELECT
            MIN(lat_n)
        FROM
            station
        WHERE
            lat_n > 38.7780
    );
/* Weather Observation Station 18 */
SELECT
    round(
        abs(MIN(lat_n) - MAX(lat_n)) + abs(MIN(long_w) - MAX(long_w)),
        4
    ) AS ManhattenDistance
FROM
    station;
/* Weather Observation Station 19 */
SELECT
    round(
        sqrt(
            power(MIN(lat_n) - MAX(lat_n), 2) + power(MIN(long_w) - MAX(long_w), 2)
        ),
        4
    ) AS EuclideanDistance
FROM
    station;