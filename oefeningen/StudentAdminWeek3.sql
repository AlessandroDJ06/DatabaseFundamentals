--oef1
SELECT city,state
FROM zipcodes
WHERE UPPER(state) LIKE 'WV' OR zip < '05000';

--oef2
SELECT RPAD(city,15,'.')
FROM zipcodes
WHERE UPPER(state) LIKE 'CT';

--oef3
SELECT last_name, POSITION('A' IN UPPER(last_name)) AS "Letter a"
FROM students
WHERE POSITION('A' IN UPPER(last_name)) > 8;

--oef4
SELECT student_id,last_name,created_date , concat((current_date - created_date),' dagen geleden') AS created_date
FROM students
WHERE student_id < 106;

--oef5
SELECT DISTINCT section_id
FROM enrollments
WHERE enroll_date BETWEEN '2021-10-1' AND '2021-10-31';

--oef6
SELECT DISTINCT cost,cost * 1.5 AS "kost + 50%",ROUND(cost * 1.5) AS "Kost + 50% met afronding"
FROM courses
WHERE cost IS NOT NULL;

--oef7
SELECT last_name,registration_date,TO_CHAR(registration_date,'DD-MM-YYYY') AS "REG.DATE", TO_CHAR(registration_date, 'Dy') AS day
FROM students
WHERE student_id IN (123,161,190);

--oef8
SELECT SUBSTRING(first_name FROM 1 FOR 1) || ' ' || last_name AS Naam
FROM students
WHERE UPPER(last_name) LIKE 'E%'
ORDER BY last_name;

--oef9
SELECT student_id,salutation,first_name,last_name
FROM students
WHERE UPPER(first_name) LIKE '%.%' AND UPPER(salutation) LIKE 'MS.'
ORDER BY LENGTH(last_name);

--oef10
SELECT student_id,first_name AS voornaam,last_name AS achternaam,zip
FROM students
WHERE SUBSTRING(UPPER(last_name) FROM 1 FOR 1) BETWEEN 'W' AND 'Z' OR UPPER(first_name) LIKE '%Y%' AND zip LIKE '10025'
ORDER BY student_id;

--oef11
SELECT CONCAT('intro to ',description),prerequisite
FROM courses
WHERE prerequisite IS NULL;

--oef12
SELECT LENGTH('ik tel zoveel letters in totaal');

--oef13
SELECT student_id,salutation,first_name,last_name
FROM students
WHERE UPPER(salutation) LIKE 'MS.' AND UPPER(last_name) IN ('ALLENDE','GRANT')
ORDER BY LENGTH(last_name);

--oef14
SELECT last_name , first_name
FROM instructors
WHERE UPPER(last_name) LIKE '_O%'
ORDER BY last_name DESC ;

--oef15
SELECT CONCAT('vandaag is het ',TO_CHAR(current_date,'DD/MM/YYYY'),'****') AS "welke dag zijn we?";

--oef16
SELECT CONCAT('vandaag is het ',RPAD(TO_CHAR(current_date,'Day'),10,'*'),' de ',TO_CHAR(current_date, 'DD') ,'TH') AS "welke dag zijn we?";

--oef17
SELECT course_no,REPLACE(description,'Java','C#')
FROM courses
WHERE UPPER(description) LIKE '%JAVA%';

--oef18
SELECT student_id,section_id,grade_type_code,ROUND(numeric_grade/5)
FROM grades
WHERE UPPER(grade_type_code) LIKE 'PA';

--oef19
SELECT EXTRACT(MONTH FROM AGE(current_date,date('2025-09-15')));

--oef20
SELECT section_id,TO_CHAR(start_date_time,'DD/MM/YYYY Day')
FROM sections
WHERE section_id BETWEEN 80 AND 89;

--oef21
--a
SELECT student_id,section_id,TO_CHAR(enroll_date,'DD month YYYY') AS inschrijvingsdatum
FROM enrollments
WHERE section_id = 117
ORDER BY inschrijvingsdatum;

--b
SELECT student_id,section_id,TO_CHAR(enroll_date,'"The "DDth" in the "WW"th week of the year "YYYY') AS inschrijvingsdatum
FROM enrollments
WHERE section_id = 117
ORDER BY inschrijvingsdatum;



