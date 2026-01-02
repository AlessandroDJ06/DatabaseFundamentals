--oef1

SELECT to_char(birth_date,'YYYY/MM/DD') AS birth_date
FROM employees
UNION ALL
SELECT to_char(birth_date,'YYYY/MM/DD') AS birth_date
FROM family_members
ORDER BY birth_date asc;

--oef2
SELECT to_char(birth_date,'YYYY-MM-DD') AS birth_date
FROM employees
UNION ALL
SELECT to_char(birth_date,'YYYY-MM-DD') AS birth_date
FROM family_members;

--oef3
SELECT employee_id
FROM employees
EXCEPT
SELECT employee_id
FROM family_members

--oef4
SELECT employee_id
FROM employees
EXCEPT
SELECT manager_id
FROM departments

--oef5
SELECT employee_id,name,relationship,
       CASE
            WHEN extract(year FROM age(birth_date)) <18 THEN 'Child'
            ELSE 'Adult'
       END age_category
FROM family_members

--oef6
SELECT
    REPLACE(first_name || ' '  || COALESCE(infix || ' ','') || last_name, ' ', '/')
FROM employees;

SELECT e.employee_id,e.first_name,e.birth_date,COALESCE(f.name, 'Single') AS partner
FROM employees e
LEFT JOIN family_members f ON e.employee_id = f.employee_id AND f.relationship NOT IN ('DAUGHTER','SON');


--oef7
SELECT e.employee_id,e.first_name,e.birth_date,COALESCE(f.name, 'Single') AS partner,f.birth_date,
       CASE
       WHEN age(e.birth_date) > age(f.birth_date) THEN SPLIT_PART(f.name, ' ',1)
       ELSE e.first_name
       END first_name
FROM employees e
LEFT JOIN family_members f ON e.employee_id = f.employee_id AND f.relationship NOT IN ('DAUGHTER','SON');


SELECT p.location,SUM(t.hours) AS total_hours,
       CASE
           WHEN SUM(t.hours) < 50 THEN 'Project on Time'
           WHEN SUM(t.hours) BETWEEN 50 AND 80 THEN 'Project takes longer than expected'
           ELSE 'Project overdue'
           END Project_timing
FROM projects p
JOIN tasks t ON p.project_id = t.project_id
GROUP BY p.location;













