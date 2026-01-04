--oef1
SELECT course_no,description,prerequisite
FROM courses
WHERE prerequisite IN (
    SELECT course_no
    FROM courses
    WHERE UPPER(description) LIKE '%INTRO TO PROGRAMMING%'
    )
ORDER BY 1;

--oef2
SELECT course_no,description
FROM courses
WHERE course_no IN (
    SELECT course_no
    FROM sections
    WHERE instructor_id IN (
        SELECT instructor_id
        FROM instructors
        WHERE UPPER(CONCAT_WS(' ',first_name,last_name)) LIKE 'FERNAND HANKS'
        )
    )
ORDER BY 1;

--oef3
SELECT student_id,last_name,first_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM grades
    WHERE section_id = 95
      AND UPPER(grade_type_code) = 'FI'
      AND numeric_grade < (
          SELECT numeric_grade
          FROM grades
          WHERE UPPER(grade_type_code) = 'FI'
            AND section_id = 95
            AND student_id IN (
              SELECT student_id
              FROM students
              WHERE UPPER(CONCAT_WS(' ',first_name,last_name)) ='MARIA MARTIN'
              )
        )

    )
ORDER BY 1,3,2;

--oef4
SELECT student_id,first_name,last_name
FROM students
WHERE zip IN (
    SELECT zip
    FROM zipcodes
    WHERE UPPER(state) = 'CT'
    )
    AND student_id NOT IN (
        SELECT student_id
        FROM enrollments
    )
ORDER BY 3;

--oef5
SELECT course_no,description
FROM courses
WHERE course_no IN (
    SELECT course_no
    FROM sections
    WHERE location = 'L211'
    )
ORDER BY 1;

--oef6
SELECT student_id,first_name,last_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE section_id IN (
        SELECT section_id
        FROM sections
        WHERE course_no IN (
            SELECT course_no
            FROM courses
            WHERE UPPER(description) LIKE '%INTRO TO SQL%'
            )
        )
    )
ORDER BY 1,2,3;

--oef7
SELECT course_no,description,cost
FROM courses
WHERE cost IN (
    SELECT MIN(cost)
    FROM courses
    )
ORDER BY 1,3;

--oef8
SELECT section_id,number_per_section AS aantal_huiswerken
FROM grade_type_weights
WHERE grade_type_code = 'HM' AND number_per_section IN (
    SELECT MIN(number_per_section)
    FROM grade_type_weights
    )
ORDER BY 1;

--oef9
--a
SELECT student_id,first_name,last_name
FROM students
WHERE student_id IN (
        SELECT student_id
        FROM grades
        WHERE grade_type_code = 'HM'
        GROUP BY student_id
        HAVING AVG(numeric_grade) IN (
            SELECT AVG(numeric_grade)
            FROM grades
            WHERE grade_type_code = 'HM'
            GROUP BY student_id
            ORDER BY 1 desc FETCH FIRST 1 ROW ONLY
        )
    )
ORDER BY 1;

--b
SELECT s.student_id,s.last_name,s.first_name,AVG(g.numeric_grade) As gemiddelde_score
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.grade_type_code = 'HM'
GROUP BY s.student_id
HAVING AVG(g.numeric_grade) IN (
    SELECT AVG(numeric_grade)
    FROM grades
    WHERE grade_type_code = 'HM'
    GROUP BY student_id
    ORDER BY 1 desc FETCH FIRST 1 ROW ONLY
    );

--oef10
SELECT s.student_id,s.first_name,s.last_name,COUNT(e.section_id)
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.section_id) IN (
    SELECT COUNT(section_id)
    FROM enrollments
    GROUP BY student_id
    ORDER BY 1 desc FETCH FIRST 1 ROW ONLY
    )
ORDER BY 1,2;

--oef11
SELECT section_id,capacity
FROM sections
WHERE course_no IN (SELECT course_no
                    FROM courses
                    WHERE cost= (SELECT MIN(cost)
                                 FROM courses))
  AND capacity<=(SELECT AVG(capacity)
                 FROM sections);

--oef12
SELECT s.course_no,c.description,s.capacity
FROM sections s
JOIN courses c ON s.course_no = c.course_no
WHERE c.description NOTNULL
AND s.capacity <= (SELECT AVG(capacity)
                   FROM sections)
ORDER BY 1;


--VIEWS
--a
CREATE VIEW v_programming_courses AS
    SELECT course_no,description,prerequisite
    FROM courses
    WHERE UPPER(description) LIKE '%PROGRAM%';

SELECT * FROM v_programming_courses;

--b
--UPDATE v_programming_courses
--SET cost=2000
--WHERE UPPER(description)='PROGRAMMING TECHNIQUES'
--kan niet omdat COST niet voorkomt in de view

--c
DELETE FROM v_programming_courses
WHERE UPPER(description) ='INTRO TO SQL'





