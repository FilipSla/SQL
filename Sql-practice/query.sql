SELECT ceil(weight / 10) * 10 AS weightGroup,
    COUNT(*) AS patientCount
FROM patients
GROUP BY weightGroup
ORDER BY weightGroup DESC;
-------------------------------------
SELECT patient_id,
    weight,
    height,
    CASE
        WHEN weight / power(height * 0.01, 2) >= 30 THEN 1
        ELSE 0
    END AS isObese
FROM patients;
-------------------------------------
SELECT p.patient_id,
    p.first_name AS patientFirstName,
    p.last_name AS patientLastName,
    d.specialty AS doctorSpeciality
FROM patients p
    INNER JOIN admissions A ON p.patient_id = A .patient_id
    INNER JOIN doctors d ON A .attending_doctor_id = d.doctor_id
WHERE A .diagnosis = 'Epilepsy'
    AND d.first_name = 'Lisa';
-------------------------------------
SELECT DISTINCT p.patient_id,
    CONCAT(
        p.patient_id,
        len(p.last_name),
        YEAR(p.birth_date)
    ) AS temp_password
FROM patients p
    INNER JOIN admissions A ON p.patient_id = A .patient_id;
-----------------------------------
SELECT *
FROM patients
WHERE first_name LIKE '__r%'
    AND gender = 'F'
    AND MONTH(birth_date) IN (2, 5, 12)
    AND weight BETWEEN 60 AND 80
    AND patient_id % 2 = 1
    AND city = 'Kingston';
-----------------------------------
SELECT first_name,
    last_name,
    gender
FROM patients
WHERE gender = 'M';
-----------------------
SELECT first_name,
    last_name
FROM patients
WHERE allergies IS NULL;
--------------------
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';
----------------------
SELECT first_name,
    last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;
-----------------------
SELECT DISTINCT YEAR(birth_date) AS uniqueBirthYear
FROM patients
ORDER BY uniqueBirthYear ASC;
----------------------
SELECT patient_id,
    first_name
FROM patients
WHERE first_name LIKE 's__%__s';
-----------------------------
SELECT p.patient_id,
    p.first_name,
    p.last_name
FROM patients p
    INNER JOIN admissions A ON p.patient_id = A .patient_id
WHERE A .diagnosis = 'Dementia';
--------------------------------
SELECT SUM(
        CASE
            WHEN gender = 'M' THEN 1
        END
    ) AS maleCount,
    SUM(
        CASE
            WHEN gender = 'F' THEN 1
        END
    ) AS femaleCount
FROM patients;
-------------------------
SELECT first_name,
    last_name,
    allergies
FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies,
    first_name,
    last_name;
-------------------------
SELECT patient_id,
    diagnosis
FROM admissions
GROUP BY patient_id,
    diagnosis
HAVING COUNT(*) > 1;
---------------------------
SELECT city,
    COUNT(patient_id) AS patientsInCity
FROM patients
GROUP BY city
ORDER BY patientsInCity DESC,
    city;
---------------------
SELECT allergies,
    COUNT(*) AS allergiesCount
FROM patients
GROUP BY allergies
HAVING allergies IS NOT NULL
ORDER BY allergiesCount DESC;
----------------------
SELECT concat(upper(last_name), ',', lower(first_name)) AS fullName
FROM patients
ORDER BY first_name DESC;
-----------------------------
SELECT province_id,
    SUM(height) AS totalHeight
FROM patients
GROUP BY province_id
HAVING totalHeight >= 7000;
-----------------------
SELECT (MAX(weight) - MIN(weight)) AS diffWeight
FROM patients
WHERE last_name = 'Maroni';
-------------------------------
SELECT DAY(admission_date) AS days,
    COUNT(*) AS admissionCount
FROM admissions
GROUP BY days
ORDER BY admissionCount DESC;
------------------------------
SELECT *
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING MAX(admission_date);
-------------------------------
SELECT patient_id,
    attending_doctor_id,
    diagnosis
FROM admissions
WHERE (
        patient_id % 2 = 1
        AND attending_doctor_id IN (1, 5, 19)
    )
    OR (
        attending_doctor_id LIKE '%2%'
        AND len(patient_id) = 3
    );
------------------------------
SELECT d.first_name,
    d.last_name,
    COUNT(A .patient_id) AS totalAdmissions
FROM admissions A
    INNER JOIN doctors d ON A .attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id;
--------------------------------
SELECT d.doctor_id,
    concat(d.first_name, ' ', d.last_name) AS doctorFullName,
    MIN(A .admission_date) AS firstAdmission,
    MAX(A .admission_date) AS lastAdmission
FROM admissions A
    INNER JOIN doctors d ON A .attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id;