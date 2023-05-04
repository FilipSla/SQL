/* Show unique birth years from patients and order them by ascending. */
SELECT DISTINCT YEAR(birth_date) AS years
FROM patients
ORDER BY 1;
/* Show unique first names from the patients table which only occurs once in the list.
 For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output. */
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1;
/* Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long. */
SELECT patient_id,
    first_name
FROM patients
WHERE first_name LIKE 's__%__s';
/* Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
 Primary diagnosis is stored in the admissions table. */
SELECT p.patient_id,
    p.first_name,
    p.last_name
FROM patients p
    INNER JOIN admissions A ON p.patient_id = A .patient_id
WHERE A .diagnosis = 'Dementia';
/* Display every patient's first_name.
 Order the list by the length of each name and then by alphbetically */
SELECT first_name
FROM patients
ORDER BY len(first_name),
    first_name;
/* Display patient's full name,
 height in the units feet rounded to 1 decimal,
 weight in the unit pounds rounded to 0 decimals,
 birth_date,
 gender non abbreviated.
 
 Convert CM to feet by dividing by 30.48.
 Convert KG to pounds by multiplying by 2.205.*/
SELECT concat(first_name, ' ', last_name) AS patient_full_name,
    round(height / 30.48, 1) AS feet_height,
    round(weight * 2.205) AS pouds_height,
    birth_date,
    CASE
        WHEN gender = 'F' THEN 'Female'
        ELSE 'Male'
    END AS full_gender
FROM patients;
/* display the number of duplicate patients based on their first_name and last_name. */
SELECT first_name,
    last_name,
    COUNT(*) AS number_of_duplicates
FROM patients
GROUP BY first_name,
    last_name
HAVING COUNT(*) > 1;
/* For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem. */
SELECT concat(p.first_name, ' ', p.last_name) AS patient_full_name,
    A .diagnosis,
    concat(d.first_name, ' ', d.last_name) AS doctor_full_name
FROM patients p
    INNER JOIN admissions A ON p.patient_id = A .patient_id
    INNER JOIN doctors d ON A .attending_doctor_id = d.doctor_id;
/* Display the total amount of patients for each province. Order by descending. */
SELECT pr.province_name,
    COUNT(*) AS total_patients
FROM patients p
    INNER JOIN province_names pr ON p.province_id = pr.province_id
GROUP BY pr.province_id
ORDER BY COUNT(*) DESC;
/* For each doctor, display their id, full name, and the first and last admission date they attended. */
SELECT d.doctor_id,
    concat(d.first_name, ' ', d.last_name) AS doctor_full_name,
    MIN(A .admission_date) AS first_admission,
    MAX(A .admission_date) AS last_admission
FROM admissions A
    INNER JOIN doctors d ON A .attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id;
/* Show first_name, last_name, and the total number of admissions attended for each doctor.
 Every admission has been attended by a doctor. */
SELECT d.first_name,
    d.last_name,
    COUNT(*) AS total_admission
FROM admissions A
    INNER JOIN doctors d ON A .attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id;
/* 
 Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters. */
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
/* Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name. */
SELECT first_name,
    last_name,
    allergies
FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies,
    first_name,
    last_name;
/* Show first name, last name and role of every person that is either patient or doctor.
 The roles are either "Patient" or "Doctor" */
SELECT first_name,
    last_name,
    'Patient' AS role
FROM patients
UNION
ALL
SELECT first_name,
    last_name,
    'Doctor' AS role
FROM doctors;
/* Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis. */
SELECT patient_id,
    diagnosis
FROM admissions
GROUP BY patient_id,
    diagnosis
HAVING COUNT(*) > 1;
/* Show the total amount of male patients and the total amount of female patients in the patients table.
 Display the two results in the same row. */
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
/* Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions. */
SELECT DAY(admission_date) AS days,
    COUNT(*) AS total_admissions
FROM admissions
GROUP BY days
ORDER BY total_admissions DESC;
/* Display the total amount of patients for each province. Order by descending. */
SELECT pr.province_name,
    COUNT(*) AS total_patients
FROM patients p
    INNER JOIN province_names pr ON p.province_id = pr.province_id
GROUP BY pr.province_id
ORDER BY COUNT(*) DESC;
/* Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni' */
SELECT MAX(weight) - MIN(weight) AS diff
FROM patients
WHERE last_name = 'Maroni';
/* Show all allergies ordered by popularity. Remove NULL values from query. */
SELECT allergies,
    COUNT(*) AS total_patients
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY COUNT(*) DESC;
/* Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date. */
SELECT first_name,
    last_name,
    birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date;
/* Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000. */
SELECT province_id,
    SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING total_height >= 7000;