/* Show the category_name and description from the categories table sorted by category_name. */
SELECT category_name,
    description
FROM categories
ORDER BY category_name;
/* Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain' */
SELECT contact_name,
    address,
    city
FROM customers
WHERE country NOT IN ('Germany', 'Mexico', 'Spain');
/* Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26 */
SELECT order_date,
    shipped_date,
    customer_id,
    freight
FROM orders
WHERE order_date = '2018-02-26';
/* Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date */
SELECT employee_id,
    order_id,
    customer_id,
    required_date,
    shipped_date
FROM orders
WHERE required_date < shipped_date;
/* Show first name, last name, and gender of patients who's gender is 'M'*/
SELECT first_name,
    last_name,
    gender
FROM patients
WHERE gender = 'M';
/* Show first name and last name of patients who does not have allergies. (null) */
SELECT first_name,
    last_name
FROM patients
WHERE allergies IS NULL;
/* Show first name of patients that start with the letter 'C' */
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';
/* Show first name and last name of patients that weight within the range of 100 to 120 (inclusive) */
SELECT first_name,
    last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;
/* 
 Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA' */
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;
/* Show first name and last name concatinated into one column to show their full name. */
SELECT concat(first_name, ' ', last_name) AS fullName
FROM patients;
/* 
 Show first name, last name, and the full province name of each patient.
 
 Example: 'Ontario' instead of 'ON' */
SELECT p.first_name,
    p.last_name,
    pr.province_name
FROM patients p
    INNER JOIN province_names pr ON p.province_id = pr.province_id;
/* Show how many patients have a birth_date with 2010 as the birth year.*/
SELECT COUNT(birth_date) AS suma
FROM patients
WHERE YEAR(birth_date) = 2010;
/* Show all columns for patients who have one of the following patient_ids:
 1,45,534,879,1000 */
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);
/* Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70 */
SELECT first_name,
    last_name,
    birth_date
FROM patients
WHERE height > 160
    AND weight > 70;
/* Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null */
SELECT first_name,
    last_name,
    allergies
FROM patients
WHERE allergies IS NOT NULL
    AND city = 'Hamilton';
/* 
 Based on the cities that our patients live in, show unique cities that are in province_id 'NS'? */
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';