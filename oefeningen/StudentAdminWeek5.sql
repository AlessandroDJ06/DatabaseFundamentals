--oef1
--a
SELECT DISTINCT COUNT(student_id) AS number_of_enrollments
FROM enrollments;

--b
SELECT DISTINCT COUNT(section_no) AS number_of_different_sections
FROM sections;

--c
SELECT DISTINCT SUM(capacity) AS total_capacity,ROUND(AVG(capacity)) AS average_capacity,MIN(capacity) AS min_capacity,MAX(capacity) AS max_capacity
FROM sections;

--oef2
SELECT DISTINCT MAX(cost)
FROM courses;

--oef3
SELECT MIN(enroll_date) AS First, MAX(enroll_date) AS most_recent
FROM enrollments;

--oef4
SELECT COUNT(course_no)
FROM courses
WHERE prerequisite IS NULL;

--oef5
SELECT COUNT(DISTINCT student_id) AS aantal_inschrijvingen
FROM enrollments;

--oef6
SELECT MIN(description) AS "First in order ",MAX(description) AS "Last in order"
FROM courses;

--oef7
SELECT MAX(enroll_date)
FROM enrollments;

--oef8
SELECT location,COUNT(DISTINCT section_id) AS "Number of sections",SUM(capacity) AS "to capacity",MIN(capacity) AS "Minimum capacity",MAX(capacity) AS "Max capacity"
FROM sections
GROUP BY location;

--oef9
--A
SELECT location,instructor_id,COUNT(DISTINCT section_id) AS "Number of sections",SUM(capacity) AS "to capacity",MIN(capacity) AS "Minimum capacity",MAX(capacity) AS "Max capacity"
FROM sections
GROUP BY location,instructor_id
ORDER BY location;

--B
SELECT location,instructor_id,COUNT(DISTINCT section_id) AS "Number of sections",SUM(capacity) AS "to capacity",MIN(capacity) AS "Minimum capacity",MAX(capacity) AS "Max capacity"
FROM sections
GROUP BY location,instructor_id
HAVING SUM(capacity) > 50
ORDER BY "to capacity";

--C
SELECT location,instructor_id,COUNT(DISTINCT section_id) AS "Number of sections",SUM(capacity) AS "to capacity",MIN(capacity) AS "Minimum capacity",MAX(capacity) AS "Max capacity"
FROM sections
WHERE course_no > 99
GROUP BY location,instructor_id
HAVING SUM(capacity) > 50
ORDER BY "to capacity";

--D
SELECT location,COUNT(DISTINCT section_id) AS "Number of sections",SUM(capacity) AS "to capacity",MIN(capacity) AS "Minimum capacity",MAX(capacity) AS "Max capacity"
FROM sections
WHERE UPPER(location) LIKE 'L5%'
GROUP BY DISTINCT location
HAVING COUNT(location) >= 3
ORDER BY "to capacity";

--oef10
SELECT student_id,section_id,ROUND(AVG(numeric_grade))
FROM grades
WHERE UPPER(grade_type_code) LIKE 'HM'
GROUP BY student_id,section_id
HAVING ROUND(AVG(numeric_grade)) < 80
ORDER BY student_id,section_id;

--oef11
SELECT student_id,COUNT(section_id) AS "Number Of Sections"
FROM enrollments
GROUP BY student_id
HAVING COUNT(section_id) > 2
ORDER BY student_id;

--oef12
SELECT course_no,AVG(capacity) AS "AVG...",ROUND(AVG(capacity)) AS "Avg capacity..."
FROM sections
WHERE instructor_id = '101'
GROUP BY course_no;

--oef13
SELECT cost,COUNT(course_no)
FROM courses
GROUP BY cost
ORDER BY cost NULLS LAST;

--oef14
SELECT enroll_date,COUNT(student_id)
FROM enrollments
WHERE section_id = 90
GROUP BY enroll_date;

--oef15
SELECT employer,COUNT(DISTINCT student_id) AS "Number Of Students"
FROM students
GROUP BY employer
HAVING COUNT(DISTINCT student_id) > 4
ORDER BY "Number Of Students";

--oef16
SELECT instructor_id,COUNT(course_no)
FROM sections
GROUP BY instructor_id
ORDER BY instructor_id;

--oef17
SELECT section_id,MAX(numeric_grade)
FROM grades
WHERE UPPER(grade_type_code) = 'MT' AND section_id BETWEEN 85 AND 93
GROUP BY section_id;

--oef18
SELECT student_id,ROUND(AVG(numeric_grade)) AS "average evaluation"
FROM grades
GROUP BY student_id
HAVING COUNT(section_id) > 2
ORDER BY student_id;

--oef19
SELECT zip,COUNT(student_id) AS "Number Of Students"
FROM students
GROUP BY zip
HAVING COUNT(student_id) > 5;

--oef20
SELECT c.course_no,c.description
FROM courses c
LEFT JOIN sections s ON c.course_no = s.course_no
WHERE s.section_id IS NULL
ORDER BY c.course_no;

--oef21
SELECT c.description,c.prerequisite AS prereq,s.section_id,s.location
FROM courses c
LEFT JOIN sections s ON c.course_no = s.course_no
WHERE c.prerequisite = 350
ORDER BY s.section_id NULLS LAST;

--oef22
SELECT concat_ws(' ',i.last_name,i.first_name) AS "name lecutrer",z.state
FROM sections s
RIGHT JOIN instructors i ON i.instructor_id = s.instructor_id
LEFT JOIN zipcodes z ON i.zip = z.zip
WHERE s.section_id IS NULL;

--oef23
SELECT s.section_id, c.description AS unpopular_courses
FROM sections s
JOIN courses c ON c.course_no = s.course_no
LEFT JOIN enrollments e ON s.section_id = e.section_id
WHERE e.student_id IS NULL
ORDER BY s.section_id;

