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
                          student_id CHAR(10) NOT NULL,
                          name VARCHAR(50) NOT NULL,
                          street VARCHAR(100) NOT NULL,
                          nr INTEGER NOT NULL CHECK (nr > 0),
                          postalcode INTEGER NOT NULL CHECK (postalcode BETWEEN 1000 AND 9999),
                          city VARCHAR(30) NOT NULL,
                          birth_date DATE NOT NULL CHECK (birth_date < CURRENT_DATE),
                          PRIMARY KEY (student_id)
);


SELECT * FROM students;

CREATE TABLE classes (
                         class_id INTEGER,
                         building CHAR(2),
                         floor CHAR(1),
                         roomnumber INTEGER
);

DROP TABLE IF EXISTS classes;

CREATE TABLE classes (
                         class_id INTEGER NOT NULL,
                         building CHAR(2) NOT NULL CHECK (building IN ('GR', 'PH', 'SW')),
                         floor INTEGER NOT NULL CHECK (floor > 0 AND floor <= 5),
                         roomnumber INTEGER NOT NULL CHECK (roomnumber > 0),
                         PRIMARY KEY (class_id)
);

CREATE TABLE students_classes (
                                  studentnumber CHAR(10),
                                  classnumber INTEGER
);

DROP TABLE IF EXISTS students_classes;


INSERT INTO students
(student_id, name, street, nr, postalcode, city, birth_date)
VALUES
    ('100', 'Albert Einstein', 'Mercer Street', 112, 8540, '
Princeton, New Jersey', '1879-03-14');
INSERT INTO classes (class_id, building, floor, roomnumber)
VALUES (1, 'GR', '1', 13);
INSERT INTO students_classes (studentnumber, classnumber)
VALUES (100, 1);