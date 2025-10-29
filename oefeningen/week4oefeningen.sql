SELECT e.employee_id,
       e.last_name,
       e.first_name,
       e.department_id,
       d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;

--oef1
SELECT d.department_id
     ,d.department_name
     ,p.project_id
     ,p.project_name
     ,p.location
FROM departments d
JOIN projects p ON d.department_id = p.department_id
ORDER BY department_id,project_id;

--oef2
SELECT d.department_id,
       d.manager_id,
       d.department_id,
       e.last_name,
       e.salary,
       e.parking_spot
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id
ORDER BY 1;

--oef3
SELECT p.project_name,
       p.location,
       concat_ws(' ',e.first_name,e.infix,e.last_name),
       d.department_name
FROM projects p
JOIN tasks t ON p.project_id = t.project_id
JOIN employees e ON t.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id;

--oef4
SELECT p.project_name,
       p.location,
       concat_ws(' ',e.first_name,e.infix,e.last_name),
       d.department_name
FROM projects p
         JOIN tasks t ON p.project_id = t.project_id
         JOIN employees e ON t.employee_id = e.employee_id
         JOIN departments d ON e.department_id = d.department_id
WHERE LOWER(p.location) = 'eindhoven' OR lower(d.department_name) = 'administration';

--oef5

