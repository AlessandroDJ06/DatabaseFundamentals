--oef1
--bereken de projecten waarin minstens 3medewerkers aan werken dus enkel indien hours niet NULL is.

SELECT project_id, COUNT(employee_id)
FROM tasks
WHERE hours IS NOT NULL
GROUP BY project_id
HAVING COUNT(employee_id) >= 3
ORDER BY project_id;

--oef2
SELECT project_id, project_name
FROM projects
where project_id IN (SELECT project_id
                    FROM tasks
                    WHERE hours IS NOT NULL
                    GROUP BY project_id
                    HAVING COUNT(employee_id) >= 3
                    ORDER BY project_id);

--oef3
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (SELECT employee_id
                      FROM tasks
                      WHERE hours > 10
                        AND project_id IN (SELECT project_id
                                           FROM projects
                                           WHERE UPPER(project_name) = 'ORDERMANAGEMENT'))
ORDER BY 1, 2;

--oef4


















































































SELECT e.employee_id,e.last_name, COUNT(*) aantal
FROM employees e
JOIN family_members fm ON (e.employee_id = fm.employee_id)
WHERE


