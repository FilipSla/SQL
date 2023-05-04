/* Weather Observation Station 18 */
SELECT round(
        abs(MIN(lat_n) - MAX(lat_n)) + abs(MIN(long_w) - MAX(long_w)),
        4
    ) AS ManhattenDistance
FROM station;
/* Weather Observation Station 19 */
SELECT round(
        sqrt(
            power(MIN(lat_n) - MAX(lat_n), 2) + power(MIN(long_w) - MAX(long_w), 2)
        ),
        4
    ) AS EuclideanDistance
FROM station;
/* Median Value */
SET @row_index := -1;
SELECT round(AVG(subq.lat_n), 4) AS median_value
FROM (
        SELECT @row_index := @row_index + 1 AS row_index,
            lat_n
        FROM station
        ORDER BY lat_n
    ) AS subq
WHERE subq.row_index IN (FLOOR(@row_index / 2), CEIL(@row_index / 2));
/* Occupations - pivot */
SET @r1 = 0,
    @r2 = 0,
    @r3 = 0,
    @r4 = 0;
SELECT MIN(Doctor),
    MIN(Professor),
    MIN(Singer),
    MIN(Actor)
FROM (
        SELECT CASE
                WHEN Occupation = 'Doctor' THEN (@r1 := @r1 + 1)
                WHEN Occupation = 'Professor' THEN (@r2 := @r2 + 1)
                WHEN Occupation = 'Singer' THEN (@r3 := @r3 + 1)
                WHEN Occupation = 'Actor' THEN (@r4 := @r4 + 1)
            END AS RowNumber,
            CASE
                WHEN Occupation = 'Doctor' THEN NAME
            END AS Doctor,
            CASE
                WHEN Occupation = 'Professor' THEN NAME
            END AS Professor,
            CASE
                WHEN Occupation = 'Singer' THEN NAME
            END AS Singer,
            CASE
                WHEN Occupation = 'Actor' THEN NAME
            END AS Actor
        FROM Occupations
        ORDER BY NAME
    ) AS temp
GROUP BY RowNumber;
/* Top Competitors */
SELECT h.hacker_id,
    h.name
FROM hackers h
    INNER JOIN submission s ON h.hacker_id = s.hacker_id
    INNER JOIN challenges ch ON s.challenge_id = ch.challenge_id
    INNER JOIN difficulty d ON ch.difficulty_level = d.difficulty_level
WHERE s.score = d.score
GROUP BY h.hacker_id,
    h.name
HAVING COUNT(s.challenge_id) > 1
ORDER BY COUNT(*) DESC,
    h.hacker_id;
/* The Report */
SELECT CASE
        WHEN g.grade < 8 THEN NULL
        ELSE NAME
    END AS NAME,
    g.grade,
    s.marks
FROM students s
    INNER JOIN grades g ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC,
    NAME,
    s.marks;
/* Draw the triangle */
DECLARE @a INT = 1 WHILE @a <= 20
BEGIN
SELECT replicate('* ', @a)
SET @a = @a + 1
END
/* Symmetric Pairs */
SELECT f1.x,
    f1.y
FROM Functions f1
    INNER JOIN Functions f2 ON f1.x = f2.y
    AND f1.y = f2.x
GROUP BY f1.x,
    f1.y
HAVING COUNT(f1.x) > 1
    OR f1.x < f1.y
ORDER BY f1.x