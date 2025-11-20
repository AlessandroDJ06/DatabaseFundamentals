--oef1
CREATE TABLE students (
    student_id CHAR(10),
    name VARCHAR(50),
    street VARCHAR(100),
    nr NUMERIC(4),
    postalcode NUMERIC(4),
    city VARCHAR(30),
    birth_date DATE
);

SELECT * FROM students;
DROP TABLE IF EXISTS students;

--oef2
CREATE TABLE students (

);



























INSERT INTO students
(student_id, name, street, nr, postalcode, city, birth_date)
VALUES
    ('100', 'Albert Einstein', 'Mercer Street', 112, 8540, '
Princeton, New Jersey', '1879-03-14');
INSERT INTO classes (class_id, building, floor, roomnumber)
VALUES (1, 'GR', '1', 13);
INSERT INTO students_classes (studentnumber, classnumber)
VALUES (100, 1);