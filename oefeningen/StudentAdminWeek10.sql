--DEEL2 correlated subqueries
--oef5
SELECT course_no,description
FROM courses s
WHERE s.course_no NOT IN (
    SELECT se.course_no
    FROM sections se
    );

--oef6
SELECT concat(i.last_name,' ',i.first_name),(
    SELECT z.state
    FROM zipcodes z
    WHERE z.zip = i.zip
    )
FROM instructors i
WHERE i.instructor_id NOT IN (
    SELECT s.instructor_id
    FROM sections s
    );

--oef7
SELECT section_id,(
    SELECT c.description
    FROM courses c
    WHERE s.course_no = c.course_no
    )
FROM sections s
WHERE s.section_id NOT IN (
    SELECT e.section_id
    FROM enrollments e
    );

--oef8
SELECT s.section_id,s.capacity
FROM sections s
WHERE s.section_id IN (
    SELECT e.section_id
    FROM enrollments e
    GROUP BY e.section_id,s.capacity
    HAVING COUNT(e.student_id) = s.capacity
    );

--oef9
SELECT g.section_id, (
    SELECT c.description
    FROM courses c
    WHERE c.course_no = (
        SELECT s.course_no
        FROM sections s
        WHERE g.section_id = s.section_id
        )
    ),g.student_id,g.numeric_grade
FROM grades g
WHERE UPPER(g.grade_type_code) = 'PJ' AND
      g.numeric_grade = (
          SELECT MAX(numeric_grade)
          FROM grades
          WHERE UPPER(grade_type_code) = 'PJ' AND section_id = g.section_id
          )
ORDER BY 1;

SELECT s.section_id,description,student_id,numeric_grade
FROM grades g
         JOIN sections s ON (g.section_id=s.section_id)
         JOIN courses c ON (c.course_no=s.course_no)
WHERE UPPER(grade_type_code)='PJ'
  AND numeric_grade=( SELECT MAX(numeric_grade)
                      FROM grades
                      WHERE UPPER(grade_type_code)='PJ'
                        AND section_id=g.section_id)
ORDER BY 1;

--oef10
-- met where not exists
--a
SELECT i.instructor_id,i.first_name,i.last_name,i.street_address
FROM instructors i
WHERE NOT EXISTS(
    SELECT *
    FROM sections s
    WHERE i.instructor_id = s.instructor_id
);

SELECT i.instructor_id,i.first_name,i.last_name,i.street_address
FROM instructors i
WHERE i.instructor_id NOT IN(
    SELECT s.instructor_id
    FROM sections s
    WHERE i.instructor_id = s.instructor_id
);

--b
SELECT s.student_id,s.first_name,s.last_name
FROM students s
WHERE s.zip IN (
    SELECT z.zip
    FROM zipcodes z
    WHERE UPPER(z.state) = 'CT'
    )
  AND NOT EXISTS(
        SELECT 'x'
        FROM enrollments e
        WHERE e.student_id = s.student_id
);

SELECT student_id, first_name, last_name
FROM students s
         JOIN zipcodes z ON (s.zip=z.zip)
WHERE UPPER(z.state) = 'CT'
  AND NOT EXISTS (    SELECT 'x'
                      FROM enrollments e
                      WHERE E.student_id = S.student_id);

--c
--zonder exists
SELECT c.course_no,c.description
FROM courses c
WHERE c.course_no IN (
    SELECT s.course_no
    FROM sections s
    WHERE UPPER(s.location) = 'L211'
    );
--met exists
SELECT course_no, description
FROM courses c
WHERE EXISTS (  SELECT 'x'
                FROM sections s
                WHERE s. course_no = c. course_no
                  AND LOCATION = 'L211');

--oef11
SELECT c.course_no,c.description
FROM courses c
WHERE not exists(SELECT prerequisite
                        FROM courses co
                        WHERE co.prerequisite = c.course_no);
--oef12
SELECT AVG(g.numeric_grade),g.section_id,g.student_id
FROM grades g
GROUP BY g.student_id,g.section_id
HAVING AVG(g.numeric_grade) > (
    SELECT AVG(numeric_grade) *1.05
    FROM grades
    WHERE g.section_id = section_id
    );

--oef13
--met joins
SELECT AVG(g.numeric_grade),s.course_no,g.student_id
FROM grades g
JOIN sections s ON g.section_id = s.section_id
GROUP BY g.student_id,s.course_no,g.section_id
HAVING AVG(g.numeric_grade) > (
    SELECT AVG(numeric_grade) *1.05
    FROM grades gr
    JOIN sections se ON gr.section_id = se.section_id
    WHERE se.course_no = s.course_no
);

--zonder joins
SELECT
    g.student_id,
    (SELECT s.course_no
     FROM sections s
     WHERE s.section_id = g.section_id
    ) AS course_no,
    AVG(g.numeric_grade) AS avg_grade
FROM grades g
GROUP BY g.student_id, g.section_id
HAVING AVG(g.numeric_grade) > (
    SELECT AVG(gr.numeric_grade) * 1.05
    FROM grades gr
    WHERE gr.section_id IN (
        SELECT s2.section_id
        FROM sections s2
        WHERE s2.course_no = (
            SELECT s3.course_no
            FROM sections s3
            WHERE s3.section_id = g.section_id
        )
    )
);

--oef14
--a
SELECT * FROM courses;
INSERT INTO courses
         VALUES((SELECT MAX(course_no)+1 FROM courses),
                'Advanced SQL',
                1500,
                (SELECT course_no FROM courses WHERE UPPER(description) LIKE 'INTRO TO SQL'),
                'Alessandro',
                CURRENT_DATE,
                'Alessandro',
                CURRENT_DATE);
SELECT *
FROM courses
ORDER BY course_no desc;

--b
SELECT * FROM sections;
INSERT INTO sections
VALUES(
       (SELECT MAX(section_id)+1 FROM sections),
       (SELECT course_no FROM courses WHERE UPPER(description) = 'ADVANCED SQL'),
       1,
       '2019-06-08',
       'L214',
        (SELECT instructor_id FROM instructors WHERE UPPER(concat_ws(' ',first_name,last_name)) = 'TODD SMYTHE'),
       15,
       'Alessandro',
       CURRENT_DATE,
       'Alessandro',
       CURRENT_DATE
      );
SELECT * from sections
ORDER BY section_id desc;

--c
SELECT * FROM students;

INSERT INTO students
VALUES (
        (SELECT MAX(student_id)+1 FROM students),
        'Ms.',
        'Lucy',
        'Coopers',
        null,
        '06880',
        null,
        null,
        CURRENT_DATE,
        'Alessandro',
        CURRENT_DATE,
        'Alessandro',
        CURRENT_DATE
       );

SELECT * FROM students
ORDER BY student_id desc;

--d
SELECT *
FROM courses
ORDER BY course_no desc;

SELECT * FROM enrollments;
INSERT INTO enrollments
VALUES (
        (SELECT student_id FROM students WHERE UPPER(CONCAT(first_name,' ',last_name)) = 'LUCY COOPERS'),
        (SELECT section_id FROM sections WHERE course_no = 451),
        CURRENT_DATE,
        0,
        'Alessandro',
        CURRENT_DATE,
        'Alessandro',
        CURRENT_DATE
       );

SELECT * FROM enrollments ORDER BY created_date desc;
