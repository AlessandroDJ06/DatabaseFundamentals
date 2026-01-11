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




