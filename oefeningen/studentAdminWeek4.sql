--oef1
SELECT s.last_name,z.zip,z.state,z.city
FROM students s
JOIN zipcodes z ON s.zip = z.zip
WHERE CAST(z.zip AS INTEGER) < 3000
ORDER BY z.zip;

--oef2
SELECT s.first_name,s.last_name,s.student_id,e.enroll_date
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
WHERE e.enroll_date < '2021-02-03'
ORDER BY s.last_name;

--oef3
SELECT s.course_no,c.description,s.section_no
FROM sections s
JOIN courses c ON s.course_no = c.course_no
WHERE c.prerequisite IS NULL
ORDER BY s.course_no,s.section_no;

--oef4
SELECT e.student_id,s.course_no,e.enroll_date,s.section_id
FROM enrollments e
JOIN sections s ON s.section_id = e.section_id
JOIN courses c ON s.course_no = c.course_no
WHERE UPPER(C.description) LIKE 'INTRO TO INFORMATION SYSTEMS'
ORDER BY e.student_id;

--oef5
SELECT s.student_id,i.instructor_id,s.zip AS "Student ZIP",i.zip AS "Instructor ZIP"
FROM students s
JOIN zipcodes z ON s.zip = z.zip
JOIN instructors i ON i.zip = z.zip
WHERE s.zip = i.zip
ORDER BY s.student_id,i.instructor_id DESC;

--oef6
SELECT s.course_no AS course,s.section_id AS section,e.student_id AS student
FROM enrollments e
JOIN sections s ON s.section_id = e.section_id
JOIN instructors i ON i.instructor_id = s.instructor_id
JOIN courses c ON c.course_no = s.course_no
WHERE i.zip LIKE '10025' AND c.prerequisite IS NULL
ORDER BY e.student_id;

--oef7
SELECT CONCAT_WS(' ',i.first_name,i.last_name) AS name,i.street_address,CONCAT(z.city,', ',z.state,' ',z.zip),TO_CHAR(s.start_date_time,'YYYY-MM-DD') AS start_date,s.section_id AS section
FROM instructors i
JOIN sections s ON i.instructor_id = s.instructor_id
JOIN zipcodes z ON i.zip = z.zip
WHERE TO_CHAR(s.start_date_time,'YYYY-MM-DD') BETWEEN '2021-04-1' AND '2021-04-30'
ORDER BY name;

--oef8
SELECT s.student_id,s.first_name,s.last_name
FROM students s
JOIN zipcodes z ON z.zip = s.zip
WHERE UPPER(z.state) LIKE 'CT'
ORDER BY s.student_id;

--oef9
SELECT concat_ws(' ',s.first_name,s.last_name) AS name , e.section_id, g.grade_type_code AS "evaluation_type",g.numeric_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g ON g.student_id = e.student_id
WHERE UPPER(concat_ws(' ',s.first_name,s.last_name)) LIKE 'DANIEL WICELINSKI' AND e.section_id = 87;

--oef10
SELECT e.student_id,st.first_name,st.last_name,s.course_no,g.numeric_grade,gc.letter_grade,g.section_id
FROM enrollments e
JOIN sections s ON e.section_id = s.section_id
JOIN grades g ON e.student_id = g.student_id
JOIN students st ON e.student_id = st.student_id
JOIN grade_conversions gc ON g.numeric_grade BETWEEN gc.min_grade AND gc.max_grade
WHERE s.course_no = 420 AND UPPER(g.grade_type_code) LIKE 'FI'
ORDER BY st.last_name;

--oef11
SELECT s.student_id, s.first_name,s.last_name,e.section_id,t.percent_of_final_grade AS pot,g.grade_type_code,g.numeric_grade
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN grades g ON e.student_id = g.student_id
JOIN grade_type_weights t ON g.section_id = t.section_id
WHERE g.numeric_grade < 80 AND UPPER(g.grade_type_code) LIKE 'PJ'
ORDER BY s.last_name;

--oef12
SELECT c.description,s.section_no,s.location,s.capacity
FROM sections s
JOIN courses c ON c.course_no = s.course_no
WHERE upper(location) LIKE 'L211'
ORDER BY c.description;

--oef13
SELECT c.description,s.section_no,s.start_date_time
FROM courses c
JOIN sections s ON c.course_no = s .course_no
JOIN enrollments e ON s.section_id = e.section_id
JOIN students st ON st.student_id = e.student_id
WHERE UPPER(CONCAT(st.first_name,' ',st.last_name)) LIKE  'JOSEPH GERMAN'
ORDER BY c.description;

--oef14
SELECT s.course_no,c.description,g.section_id
FROM sections s
JOIN courses c ON s.course_no = c.course_no
JOIN grade_type_weights g ON g.section_id = s.section_id
WHERE UPPER(g.grade_type_code) LIKE 'PA' AND g.percent_of_final_grade = 25
ORDER BY s.course_no;

--oef15
SELECT s.first_name,s.last_name,g.numeric_grade
FROM enrollments e
JOIN grades g ON g.student_id = e.student_id
JOIN students s ON s.student_id = e.student_id
WHERE UPPER(g.grade_type_code) LIKE 'PJ' AND g.numeric_grade >= 99
ORDER BY s.first_name DESC;

--oef16
SELECT s.student_id,s.last_name,s.first_name,e.section_id,CONCAT(g.grade_type_code,' ',g.grade_code_occurrence) AS quiz, g.numeric_grade
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN grades g ON g.student_id = s.student_id
WHERE s.zip LIKE '10956' AND UPPER(g.grade_type_code) LIKE 'QZ'

--oef17
SELECT s.course_no,s.section_no,i.first_name,i.last_name
FROM sections s
JOIN courses c ON c.course_no = s.course_no
JOIN instructors i ON i.instructor_id = s.instructor_id
WHERE c.prerequisite = 20
ORDER BY c.course_no;

--oef19
SELECT c.course_no,c.description AS course_description,c.prerequisite,p.description AS prerequisite_description
FROM courses c
JOIN courses p ON c.prerequisite = p.course_no
ORDER BY c.course_no;

--oef20
SELECT DISTINCT i.first_name ,i.last_name,z.zip
FROM instructors i
JOIN instructors z ON i.zip = z.zip AND i.instructor_id < z.instructor_id
ORDER BY z.zip,i.first_name;

--oef21


