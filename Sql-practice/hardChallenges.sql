/* Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped"
 that displays "On Time" if the order shipped on time and "Late" if the order shipped late.
 Order by employee last_name, then by first_name, and then descending by number of orders. */
SELECT e.first_name,
    e.last_name,
    COUNT(*) AS num_orders,
    CASE
        WHEN o.shipped_date < o.required_date THEN 'On Time'
        ELSE 'Late'
    END AS Shipped
FROM employees e
    INNER JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.first_name,
    e.last_name,
    Shipped
ORDER BY last_name,
    first_name,
    COUNT(*) DESC;
/* Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group.
 Order the list by the weight group decending. For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc. */
SELECT floor(weight / 10) * 10 AS weight_group,
    COUNT(*) AS number_of_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;
/*Show patient_id, weight, height, isObese from the patients table.
 Display isObese as a boolean 0 or 1.
 Obese is defined as weight(kg)/(height(m)2) >= 30.
 weight is in units kg. height is in units cm. */
SELECT patient_id,
    weight,
    height,
    CASE
        WHEN weight /(power(height * 0.01, 2)) >= 30 THEN 1
        ELSE 0
    END AS isObese
FROM patients;
/* Show patient_id, first_name, last_name, and attending doctor's specialty.
 Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
 Check patients, admissions, and doctors tables for required information. */
SELECT p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
FROM patients p
    INNER JOIN admissions A ON p.patient_id = A .patient_id
    INNER JOIN doctors d ON A .attending_doctor_id = d.doctor_id
WHERE A .diagnosis = 'Epilepsy'
    AND d.first_name = 'Lisa';
/* All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
 
 The password must be the following, in order:
 1. patient_id
 2. the numerical length of patient's last_name
 3. year of patient's birth_date */
SELECT DISTINCT A .patient_id,
    concat(
        p.patient_id,
        len(p.last_name),
        YEAR(p.birth_date)
    ) AS temp_password
FROM patients p
    INNER JOIN admissions A ON p.patient_id = A .patient_id;
/* Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
 Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group. */
SELECT CASE
        WHEN patient_id % 2 = 0 THEN 'Yes'
        ELSE 'No'
    END AS has_insurance,
    SUM(
        CASE
            WHEN patient_id % 2 = 0 THEN 10
            ELSE 50
        END
    ) AS total_cost
FROM admissions
GROUP BY has_insurance;
/* Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name */
SELECT pr.province_name
FROM patients p
    INNER JOIN province_names pr ON p.province_id = pr.province_id
GROUP BY pr.province_name
HAVING SUM(
        CASE
            WHEN gender = 'M' THEN 1
        END
    ) > SUM(
        CASE
            WHEN gender = 'F' THEN 1
        END
    )
ORDER BY pr.province_name;
------------------------------
SELECT *
FROM patients
WHERE first_name LIKE '__r%'
    AND gender = 'F'
    AND MONTH(birth_date) IN (2, 5, 12)
    AND weight BETWEEN 60 AND 80
    AND patient_id % 2 = 1
    AND city = 'Kingston';