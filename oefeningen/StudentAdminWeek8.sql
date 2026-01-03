--oef1
SELECT student_id
FROM students
except
SELECT student_id
FROM enrollments;

--oef2
SELECT course_no
FROM courses
EXCEPT
SELECT course_no
FROM sections;

--oef3
--A
SELECT last_name , 'student' AS status
FROM students
UNION ALL
SELECT last_name, 'instructor' AS status
FROM instructors;

--B
SELECT last_name , 'student' AS status
FROM students
UNION
SELECT last_name, 'instructor' AS status
FROM instructors;

--oef4
SELECT first_name
FROM students
INTERSECT
SELECT first_name
FROM instructors;

--oef5
SELECT zip,city,state
FROM zipcodes
WHERE zip in (
    SELECT zip
    FROM students
    INTERSECT
    SELECT zip
    FROM instructors
    )

--oef6
SELECT course_no
FROM sections
WHERE course_no IN (
    SELECT course_no
    FROM courses
    intersect
    SELECT prerequisite
    FROM courses
    )
GROUP BY course_no
HAVING count(*) >= 5;

SELECT course_no
FROM courses
WHERE prerequisite IS NOT NULL
INTERSECT
SELECT course_no
FROM sections
GROUP BY course_no
HAVING COUNT(*) >=5;

--oef7

SELECT student_id
FROM enrollments
EXCEPT
SELECT student_id
FROM grades

--oef8
SELECT c2.course_no
FROM courses c1
         JOIN courses c2 ON (c1.prerequisite = c2.course_no)
EXCEPT
SELECT course_no
FROM sections;

--oef9
SELECT AVG(CASE
               WHEN cost IS NULL THEN 0
               ELSE cost
           END) AS avg_cost
FROM courses;

--oef10
SELECT CASE
            WHEN prerequisite ISNULL THEN 'geen'
            ELSE CAST(prerequisite AS varchar)
            END AS prerequisite , count(course_no) AS num_courses
FROM courses
GROUP BY prerequisite
ORDER BY courses.prerequisite DESC NULLS FIRST

--oef11
SELECT c.course_no,c.description,COALESCE(to_char(p.prerequisite,'99999999'),'none') AS prereq,COALESCE(p.description,'none') AS description
FROM courses c
left JOIN courses p ON p.course_no = c.prerequisite
ORDER BY 1,3

--TEKST EN CONDITIONELE FUNCTIES

--1
SELECT city,initcap(lower(state))
FROM zipcodes
WHERE (to_number(zip,'99999')) < 5000 OR upper(state) = 'WV'
ORDER BY state,city

--oef2
SELECT rpad(city,30,'.') "CITY"
FROM zipcodes
WHERE UPPER(state) = 'CT' AND SUBSTRING(UPPER(city) ,1,1) BETWEEN 'A' AND 'M';


SELECT RPAD(city,20,'.') "CITY"
FROM zipcodes
WHERE UPPER(state) = 'CT' and SUBSTR(UPPER(city) ,1,1) BETWEEN 'A'
    AND 'M';

--oef3
SELECT last_name, position('a' IN last_name)
FROM students
WHERE position('a' IN last_name) > 8

--oef4
SELECT s.student_id,s.last_name,registration_date AS created_date, ('19/10/2021'-registration_date || 'dagen geleden') AS created_date
 FROM students s
WHERE s.student_id < 106

--oef5
SELECT DISTINCT section_id
FROM enrollments
WHERE enroll_date BETWEEN '1/10/2021' AND '31/10/2021'

--oef6
SELECT DISTINCT cost, cost+cost*0.5 AS "Kost + 50%", round(cost+cost*0.5) AS "Kost + 50 met afronding"
FROM courses
WHERE cost NOTNULL

--oef7
SELECT DISTINCT state, CASE
                WHEN UPPER(state) = 'NY' THEN 'NEW YORK'
                WHEN UPPER(state) = 'NJ' THEN 'NEW JERSEY'
                ELSE UPPER(state)
              END AS state
FROM zipcodes

--oef8
SELECT student_id,section_id,numeric_grade,
       CASE
            WHEN numeric_grade >= 90 THEN 'uitstekend'
            WHEN numeric_grade BETWEEN 80 AND 89 THEN 'voortreffelijk'
            ELSE 'kan beter'
            END AS nummeric_grade
FROM grades
WHERE UPPER(grade_type_code) = 'PA' AND section_id = 101

--oef9
SELECT last_name,registration_date, to_char(registration_date,'DD-MM-YYYY') AS "REG.DATE",to_char(registration_date,'Dy') AS day
FROM students
WHERE student_id IN (123,161,190)

--oef10
SELECT course_no, COALESCE(to_char(cost,'99999'),'onbekende kost') AS kost
FROM courses
WHERE course_no > 300

--oef11
SELECT concat_ws(' ',SUBSTRING(UPPER(first_name) FOR 1 FROM 1),initcap(last_name))
FROM students
WHERE UPPER(last_name) LIKE 'E%'

--oef12
SELECT student_id,salutation,first_name,last_name
FROM students
WHERE first_name LIKE '%.%' AND UPPER(salutation) = 'MS.'
ORDER BY length(last_name)

--oef13
SELECT student_id,first_name,last_name,zip
FROM students
WHERE zip = '10025' AND UPPER(first_name) LIKE '%Y%' OR SUBSTRING(UPPER(last_name) FROM 1 FOR 1) BETWEEN 'W' AND 'Z'

--oef14
SELECT description, prerequisite
FROM courses
WHERE UPPER(description) like 'INTRO TO%' AND prerequisite ISNULL

--oef15
SELECT length('Ik tel zoveel letters in totaal')

--oef16
SELECT student_id,salutation,first_name,last_name
FROM students
WHERE UPPER(salutation) = 'MS.' AND UPPER(last_name) IN ('ALLENDE','GRANT')
ORDER BY length(last_name)

--oef17
SELECT last_name,first_name
FROM instructors
WHERE UPPER(last_name) LIKE '_O%'

--oef18
SELECT CONCAT('vandaag is het ',RPAD(to_char(current_date,'DD/MM/YYYY'),14,'*'))

--oef19
SELECT CONCAT('vandaag is het ',RPAD(to_char(current_date,'Day'),10,'*'),' de ',to_char(current_date,'DD TH'))

--oef20
SELECT course_no,replace(description,'Java','C#')
FROM courses
WHERE UPPER(description) LIKE '%JAVA%'

--oef21
SELECT section_id,grade_type_code,created_date,modified_date
FROM grade_type_weights
WHERE NULLIF(created_date,modified_date) ISNULL

--oef22
--a
SELECT course_no,description,COALESCE(to_char(prerequisite,'99999'),'geen voorkennis vereist')
FROM courses
WHERE UPPER(description) LIKE '%INTRO%'
ORDER BY course_no

--b
SELECT course_no,description,
       CASE
           WHEN prerequisite ISNULL THEN 'geen voorkennis vereist'
           ELSE concat('Opgelet prerequisite nodig van',to_char(prerequisite,'99999'))
       END AS prerequisite
FROM courses
WHERE UPPER(description) LIKE '%INTRO%'
ORDER BY course_no

--c
SELECT student_id,section_id,grade_type_code,ROUND((numeric_grade/100)*20) AS nummeric_grade_op_20
FROM grades
WHERE UPPER(grade_type_code) = 'PA'
ORDER BY 1

--oef23
SELECT extract(MONTH FROM AGE(current_date,'15-09-2025'::date)) AS MAANDEN_AL_BEZIG

--oef24
--A
SELECT section_id,concat(start_date_time,' ',to_char(start_date_time,'day'))
FROM sections
WHERE section_id BETWEEN 80 AND 89;

--B
SELECT section_id,start_date_time,
    CASE to_char(start_date_time,'fmday')
        WHEN 'tuesday' THEN to_char(start_date_time+6,'DD-MM-YYYY fmday')
        WHEN 'wednesday' THEN to_char(start_date_time+5,'DD-MM-YYYY fmday')
        WHEN 'thursday' THEN to_char(start_date_time+4,'DD-MM-YYYY fmday')
        WHEN 'friday' THEN to_char(start_date_time+3,'DD-MM-YYYY fmday')
        WHEN 'saturday' THEN to_char(start_date_time+2,'DD-MM-YYYY fmday')
        WHEN 'sunday' THEN to_char(start_date_time+1,'DD-MM-YYYY fmday')
    ELSE to_char(start_date_time,'DD-MM-YYYY fmday')
    END AS new_start_date
FROM sections
WHERE section_id BETWEEN 80 AND 89;

--oef25
--a
SELECT student_id,section_id,TO_CHAR(enroll_date,'DD month YYYY')
FROM enrollments
WHERE section_id = 117

--b
SELECT student_id,section_id,TO_CHAR(enroll_date,'"The "DDth" in the "WWth" week of the year "YYYY')
FROM enrollments
WHERE section_id = 117


