--oef1
SELECT salutation,last_name,first_name,street_address
FROM instructors
WHERE UPPER(street_address) LIKE '518 WEST 120TH';

--oef2
SELECT salutation,first_name,last_name
FROM students
WHERE UPPER(last_name) LIKE 'GRANT'
ORDER BY salutation DESC , first_name;

--oef3
SELECT student_id,salutation,first_name,last_name
FROM students
WHERE UPPER(salutation) LIKE 'MS.' AND UPPER(last_name) IN ('GRANT','ALLENDE')
ORDER BY last_name;

--oef4
SELECT student_id,section_id,enroll_date,final_grade
FROM enrollments
WHERE final_grade > 0;

--oef5
SELECT concat_ws(first_name,last_name,' ') AS "Name", street_address AS "Address",zip
FROM students
WHERE zip IN ('10048','11102','11209');

--oef6
SELECT student_id,first_name AS first,last_name AS last,zip
FROM students
WHERE zip like '11209' OR UPPER(last_name) LIKE 'ZUCKERBERG'
ORDER BY last_name DESC;

--oef7
SELECT description,prerequisite
FROM courses
WHERE prerequisite < 122;

--oef8
SELECT salutation, last_name as "LAST NAME", first_name AS "FIRST NAME",phone
FROM instructors
WHERE UPPER(last_name) NOT LIKE 'SCHORIN';

--oef9
SELECT DISTINCT first_name, last_name FROM students
WHERE zip = '10025'
ORDER BY student_id;
--dit geeft een error omdat student id niet in de select statement staat.

--oef10
SELECT description "desc", prerequisite "pre"
FROM courses
WHERE prerequisite IS NOT NULL
ORDER BY description;

--optie 1
SELECT description "desc", prerequisite "pre"
FROM courses
WHERE prerequisite IS NOT NULL
ORDER BY "desc";

--optie2
SELECT description "desc", prerequisite "pre"
FROM courses
WHERE prerequisite IS NOT NULL
ORDER BY 1;

--oef11
SELECT description,cost,prerequisite
FROM courses
WHERE cost = 1195 AND prerequisite BETWEEN 20 AND 25;

--oef12
SELECT course_no, cost
FROM courses
WHERE cost BETWEEN 1000 AND 1500;
--werkt wel omdat je kijkt of cost tussen 2getallen ligt.

--oef13
SELECT description, prerequisite
FROM courses
WHERE prerequisite NOT >= 140;
--werkt niet omdat je hier gwn kleiner dan kan gebruiken
SELECT description, prerequisite
FROM courses
WHERE prerequisite <= 140;
--dit werkt dus wel.

--oef14
SELECT description
FROM grade_types
WHERE description BETWEEN 'Midterm' AND 'Project'

--oef15
SELECT city
FROM zipcodes;
WHERE state NOT LIKE 'NY' ;

--oef16
SELECT student_id,last_name,zip
FROM students
WHERE zip BETWEEN '05000' AND '06825'
ORDER BY zip , last_name;

--oef17
SELECT student_id,last_name,zip
FROM students
WHERE zip IN ('06483','06605','06798','06820')
ORDER BY zip , last_name DESC;

--oef18
SELECT student_id,first_name AS first,last_name AS last
FROM students
WHERE UPPER(first_name) IN ('YVONNE','BRIAN','ANGEL') OR UPPER(last_name) LIKE 'TORRES'
ORDER BY last_name , first_name;

--oef19
SELECT student_id,first_name AS first, last_name AS last,registration_date AS registration
FROM students
WHERE registration_date < '2021-02-03'
ORDER BY last_name;

--oef20
SELECT letter_grade,grade_point,max_grade,min_grade
FROM grade_conversions
WHERE grade_point BETWEEN 3 AND 4;

--oef21
SELECT course_no,description,prerequisite
FROM courses
WHERE course_no < 100
ORDER BY prerequisite NULLS LAST;







