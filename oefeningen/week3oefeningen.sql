--oefening1
SELECT employee_id
FROM family_members
WHERE relationship IN ('DAUGHTER','SON') AND birth_date > date('2007-01-01');

SELECT employee_id
FROM family_members
WHERE relationship IN ('DAUGHTER','SON') AND EXTRACT(YEAR FROM age(birth_date)) < '18';



--oefening2
SELECT employee_id,last_name,location, age(birth_date) AS age
FROM employees
WHERE location IN('Eindhoven','Maarssen') AND age(birth_date) > '30';

--oefening3
SELECT employee_id, age(birth_date) AS "age partner"
FROM family_members
WHERE relationship IN ('PARTNER') AND EXTRACT(YEAR FROM age(birth_date)) BETWEEN '35' AND '45';

--oefening4
SELECT first_name,last_name, to_char(birth_date, 'DD month YYYY') as "Date of birth",to_char(birth_date + INTERVAL '65 years','Day DD Month YYYY') AS pension
FROM employees;

--oefening5
SELECT name, TO_CHAR(birth_date, 'Day DD Month YYYY')
FROM family_members
ORDER BY age(birth_date);

SELECT name, TO_CHAR(birth_date, 'FMDay DD FMMonth YYYY')
FROM family_members
ORDER BY age(birth_date);

SET lc_time = 'fr_FR';
SELECT name, TO_CHAR(birth_date, 'TMDay DD TMMonth YYYY')
FROM family_members
ORDER BY age(birth_date);


--oefening6
SELECT first_name || ' ' || last_name AS full_name
FROM employees;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

SELECT CONCAT(first_name,LPAD(last_name ,LENGTH(last_name) +1) ) AS full_name
FROM employees;

--oefening7
SELECT RPAD(REGEXP_REPLACE(LOWER(street), '^z', ''),30,'*') AS new_address
FROM employees;

--oefening8
SELECT first_name,last_name
FROM employees
WHERE first_name LIKE '%o%' AND last_name LIKE '%o%';

--oefening9
SELECT last_name
FROM employees
WHERE LOWER(last_name) ~ '^[^o]*oo[^o]*$';

--oefening10
SELECT SUBSTRING(street, 1, 1) || REGEXP_REPLACE(SUBSTRING(LOWER(street) FROM 2), 'e', 'o') AS new_adress
FROM employees;

--oefening11
SELECT CONCAT(SUBSTRING(LOWER(first_name) FROM 1 FOR 3),'.',SUBSTRING(LOWER(last_name) FROM 1 FOR 3),'@',LOWER(department_name),'.be')
FROM departments,employees
ORDER BY first_name;

