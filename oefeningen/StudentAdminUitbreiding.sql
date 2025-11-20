--oef1
SELECT s.first_name,
       s.last_name,g.section_id,AVG(g.numeric_grade) AS "gemHW"
FROM grades g
         JOIN enrollments e ON g.student_id = e.student_id
         JOIN students s ON e.student_id = s.student_id
WHERE UPPER(g.grade_type_code) LIKE 'HM'
GROUP BY s.first_name,s.last_name,g.section_id
HAVING AVG(g.numeric_grade) < 80
ORDER BY s.first_name;

--oef2
SELECT co.description,pr.description
FROM courses co
JOIN courses pr ON pr.prerequisite = co.course_no
ORDER BY co.description

--oef3

SELECT s.section_id,c.description,COUNT(DISTINCT e.student_id) AS AantalStudenten
FROM sections s
         JOIN courses c ON c.course_no = s.course_no
         JOIN enrollments e ON s.section_id = e.section_id
GROUP BY s.section_id,c.description
ORDER BY s.section_id

--oef4
SELECT c.description AS CursusZonderSecties
FROM courses c
         JOIN sections s ON c.course_no = s.course_no
GROUP BY c.description
HAVING COUNT(DISTINCT s.section_id) = 1;


--oef5
