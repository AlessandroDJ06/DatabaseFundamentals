--oef1
ALTER TABLE grades
ALTER COLUMN numeric_grade SET DEFAULT 0;

--oef2
ALTER TABLE grade_conversions
ALTER COLUMN grade_point SET DEFAULT 0;

--oef3
--a
ALTER TABLE enrollments
ADD CONSTRAINT fg_check_constraint
CHECK (final_grade BETWEEN 0 AND 100) NOT VALID;

--b
UPDATE enrollments
SET final_grade = 0
WHERE final_grade NOT BETWEEN 0 AND 100;

--c
ALTER TABLE enrollments
ADD CONSTRAINT fg_check_constraint
CHECK (final_grade BETWEEN 0 AND 100);

--d
ALTER TABLE courses
ADD CONSTRAINT co_max_cost_constraint
CHECK ( cost < 2000 ) NOT VALID;

UPDATE courses
SET cost = 2000
WHERE cost > 2000;

ALTER TABLE courses
ADD CONSTRAINT co_max_cost_constraint
CHECK ( cost < 2000 );

--oef4
UPDATE students
SET salutation = null
WHERE salutation NOT IN ('Rev','Ms.','Dr.');

ALTER TABLE students
ADD CONSTRAINT st_salutation_constraint
CHECK ( salutation IN ('Rev','Ms.','Dr.',null) );

ALTER TABLE instructors
ADD CONSTRAINT in_salutation_constraint
CHECK (salutation IN ('Rev','Ms.','Dr.',null)) NOT VALID;

--oef5
ALTER TABLE sections
ADD CONSTRAINT se_capacity_constraint
CHECK (capacity % 2 = 0 AND capacity BETWEEN 10 AND 25) NOT VALID;

--oef6
ALTER TABLE students
ADD COLUMN email VARCHAR(30);

--oef7
ALTER TABLE sections
    DROP CONSTRAINT sect_inst_fk;

ALTER TABLE sections
ADD CONSTRAINT sect_inst_fk
FOREIGN KEY (instructor_id) REFERENCES instructors ON DELETE SET NULL;

--oef8
SELECT * FROM students where student_id = 139;
SELECT * from enrollments;

ALTER TABLE enrollments
DROP CONSTRAINT enr_stu_fk;
DELETE fROM students where student_id = 139;

ALTER TABLE enrollments
ADD CONSTRAINT enr_stu_fk
FOREIGN KEY (student_id) REFERENCES students
ON DELETE CASCADE;

ALTER TABLE grades
DROP CONSTRAINT gr_enr_fk;

ALTER TABLE grades
ADD CONSTRAINT gr_enr_fk
FOREIGN KEY (student_id,section_id) REFERENCES enrollments
ON DELETE CASCADE;

--oef9
ALTER TABLE grade_type_weights
RENAME percent_of_final_grade TO percent_of_final;

--10
ALTER TABLE grade_type_weights
DROP COLUMN drop_lowest;

--DEEL2
ALTER TABLE sections
    DROP CONSTRAINT sect_inst_fk,
    ADD CONSTRAINT sect_inst_fk FOREIGN KEY (instructor_id)
        REFERENCES instructors(instructor_id) ON DELETE SET NULL,
    ALTER COLUMN instructor_id DROP NOT NULL;

--13
SELECT * FROM zipcodes;

INSERT INTO zipcodes (zip,city,state,created_by,created_date)
VALUES ('2000','Antwerpen','BE','Alessandro',CURRENT_DATE);

--14
INSERT INTO courses (course_no,description,cost,created_by,created_date)
VALUES (1,'SQL voor beginners',500,'Alessandro',CURRENT_DATE);

--15
SELECT * FROM sections;
SELECT instructor_id FROM instructors;
INSERT INTO sections (section_id, course_no, section_no, start_date_time, location, instructor_id,created_by, created_date)
VALUES (1,1,1,'2023-03-04','GR504',101,'Alessandro',CURRENT_DATE)

--16
ALTER TABLE students
ALTER COLUMN registration_date SET DEFAULT CURRENT_DATE;

--17
INSERT INTO students (student_id,first_name,last_name,zip,employer,created_by,created_date)
VALUES (1,'James','Cooke','2000','VIER','Alessandro',CURRENT_DATE);

SELECT * FROM students WHERE student_id = 1;

--18
INSERT INTO enrollments (student_id, section_id, enroll_date, created_by, created_date)
VALUES (1,1,CURRENT_DATE,'Alessandro',CURRENT_DATE);

--19
UPDATE sections
SET start_date_time = '2023-03-11'
WHERE section_id = 1;

--20
DELETE FROM enrollments
WHERE student_id = 1;

--21
DELETE FROM instructors
WHERE instructor_id=1;

--22
SELECT conname, pg_catalog.pg_get_constraintdef(r.oid, true) as condef
FROM pg_catalog.pg_constraint r
WHERE r.confrelid = 'public.courses'::regclass;


Select max(course_no) from courses;

ALTER TABLE sections
    ALTER COLUMN course_no
        SET DATA TYPE INTEGER;

ALTER TABLE courses
    ALTER COLUMN prerequisite SET DATA TYPE INTEGER,
    ALTER COLUMN course_no SET DATA TYPE INTEGER,
    ALTER COLUMN course_no
        ADD GENERATED ALWAYS AS IDENTITY ( START WITH 460 INCREMENT BY 10);

SELECT *
FROM courses
WHERE course_no=460;

INSERT INTO courses ( description, cost, prerequisite,created_by,created_date)
VALUES ('Testcourse', 1000, 10,user,CURRENT_DATE);

























