CREATE TABLE zipcodes (
                          zip           VARCHAR(5)   CONSTRAINT pk_zipcodes PRIMARY KEY,
                          city          VARCHAR(25),
                          state         VARCHAR(2),
                          created_by    VARCHAR(30)  CONSTRAINT nn_zip_created_by NOT NULL,
                          created_date  DATE         CONSTRAINT nn_zip_created_date NOT NULL,
                          modified_by   VARCHAR(30),
                          modified_date DATE
);

CREATE TABLE students (
                          student_id        NUMERIC(8, 0) CONSTRAINT pk_students PRIMARY KEY,
                          salutation        VARCHAR(5),
                          first_name        VARCHAR(25),
                          last_name         VARCHAR(25)   CONSTRAINT nn_stud_last_name NOT NULL,
                          street_address    VARCHAR(50),
                          zip               VARCHAR(5)    CONSTRAINT nn_stud_zip NOT NULL,
                          phone             VARCHAR(15),
                          employer          VARCHAR(50),
                          registration_date DATE          DEFAULT CURRENT_DATE CONSTRAINT nn_stud_reg_date NOT NULL,
                          created_by        VARCHAR(30)   CONSTRAINT nn_stud_created_by NOT NULL,
                          created_date      DATE          CONSTRAINT nn_stud_created_date NOT NULL,
                          modified_by       VARCHAR(30),
                          modified_date     DATE,
                          CONSTRAINT c_stud_last_name CHECK (last_name = UPPER(last_name)),
                          CONSTRAINT fk_stud_zip FOREIGN KEY (zip) REFERENCES zipcodes(zip)
);

CREATE TABLE courses (
                         course_no     NUMERIC(8)    CONSTRAINT pk_courses PRIMARY KEY,
                         description   VARCHAR(50)   CONSTRAINT nn_cour_desc NOT NULL,
                         cost          NUMERIC(9, 2),
                         prerequisite  NUMERIC(8),
                         created_by    VARCHAR(30)   CONSTRAINT nn_cour_created_by NOT NULL,
                         created_date  DATE          CONSTRAINT nn_cour_created_date NOT NULL,
                         modified_by   VARCHAR(30),
                         modified_date DATE,
                         CONSTRAINT fk_cour_prerequisite FOREIGN KEY (prerequisite) REFERENCES courses(course_no)
);

CREATE TABLE instructors (
                             instructor_id  NUMERIC(8)   CONSTRAINT pk_instructors PRIMARY KEY,
                             salutation     VARCHAR(5),
                             first_name     VARCHAR(25),
                             last_name      VARCHAR(25),
                             street_address VARCHAR(50),
                             zip            VARCHAR(5),
                             phone          VARCHAR(15),
                             created_by     VARCHAR(30)  CONSTRAINT nn_inst_created_by NOT NULL,
                             created_date   DATE         CONSTRAINT nn_inst_created_date NOT NULL,
                             modified_by    VARCHAR(30),
                             modified_date  DATE,
                             CONSTRAINT fk_inst_zip FOREIGN KEY (zip) REFERENCES zipcodes(zip)
);

CREATE TABLE sections (
                          section_id      NUMERIC(8)  CONSTRAINT pk_sections PRIMARY KEY,
                          course_no       NUMERIC(8)  CONSTRAINT nn_sec_course_no NOT NULL,
                          section_no      NUMERIC(3)  CONSTRAINT nn_sec_section_no NOT NULL,
                          start_date_time DATE,
                          location        VARCHAR(50),
                          instructor_id   NUMERIC(8)  CONSTRAINT nn_sec_inst_id NOT NULL,
                          capacity        NUMERIC(3),
                          created_by      VARCHAR(30) CONSTRAINT nn_sec_created_by NOT NULL,
                          created_date    DATE        CONSTRAINT nn_sec_created_date NOT NULL,
                          modified_by     VARCHAR(30),
                          modified_date   DATE,
                          CONSTRAINT u_sec_course_no UNIQUE (course_no, section_no),
                          CONSTRAINT fk_sec_course FOREIGN KEY (course_no) REFERENCES courses(course_no),
                          CONSTRAINT fk_sec_instructor FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

CREATE TABLE enrollments (
                             student_id    NUMERIC(8),
                             section_id    NUMERIC(8),
                             enroll_date   DATE          CONSTRAINT nn_enr_date NOT NULL,
                             final_grade   NUMERIC(3),
                             created_by    VARCHAR(30)   CONSTRAINT nn_enr_created_by NOT NULL,
                             created_date  DATE          CONSTRAINT nn_enr_created_date NOT NULL,
                             modified_by   VARCHAR(30),
                             modified_date DATE,
                             CONSTRAINT pk_enrollments PRIMARY KEY (student_id, section_id),
                             CONSTRAINT fk_enr_student FOREIGN KEY (student_id) REFERENCES students(student_id),
                             CONSTRAINT fk_enr_section FOREIGN KEY (section_id) REFERENCES sections(section_id)
);

CREATE TABLE grade_types (
                             grade_type_code CHAR(2)     CONSTRAINT pk_grade_types PRIMARY KEY,
                             description     VARCHAR(50) CONSTRAINT nn_grt_desc NOT NULL,
                             created_by      VARCHAR(30) CONSTRAINT nn_grt_created_by NOT NULL,
                             created_date    DATE        CONSTRAINT nn_grt_created_date NOT NULL,
                             modified_by     VARCHAR(30),
                             modified_date   DATE
);

CREATE TABLE grade_type_weights (
                                    section_id             NUMERIC(8, 0),
                                    grade_type_code        CHAR(2),
                                    number_per_section     NUMERIC(3, 0) CONSTRAINT nn_gtw_num NOT NULL,
                                    percent_of_final_grade NUMERIC(3, 0) CONSTRAINT nn_gtw_pct NOT NULL,
                                    drop_lowest            CHAR(1)       CONSTRAINT nn_gtw_drop NOT NULL,
                                    created_by             VARCHAR(30)   CONSTRAINT nn_gtw_created_by NOT NULL,
                                    created_date           DATE          CONSTRAINT nn_gtw_created_date NOT NULL,
                                    modified_by            VARCHAR(30),
                                    modified_date          DATE,
                                    CONSTRAINT pk_grade_type_weights PRIMARY KEY (section_id, grade_type_code),
                                    CONSTRAINT c_gtw_drop_lowest CHECK (drop_lowest IN ('Y', 'N')),
                                    CONSTRAINT fk_gtw_section FOREIGN KEY (section_id) REFERENCES sections(section_id),
                                    CONSTRAINT fk_gtw_grade_type FOREIGN KEY (grade_type_code) REFERENCES grade_types(grade_type_code)
);

CREATE TABLE grades (
                        student_id            NUMERIC(8),
                        section_id            NUMERIC(8),
                        grade_type_code       CHAR(2),
                        grade_type_occurrence NUMERIC(38),
                        numeric_grade         NUMERIC(3, 0) DEFAULT 0 CONSTRAINT nn_gra_grade NOT NULL,
                        comments              VARCHAR(2000),
                        created_by            VARCHAR(30)   CONSTRAINT nn_gra_created_by NOT NULL,
                        created_date          DATE          CONSTRAINT nn_gra_created_date NOT NULL,
                        modified_by           VARCHAR(30),
                        modified_date         DATE,
                        CONSTRAINT pk_grades PRIMARY KEY (student_id, section_id, grade_type_code, grade_type_occurrence),
                        CONSTRAINT fk_gra_enrollment FOREIGN KEY (student_id, section_id) REFERENCES enrollments(student_id, section_id),
                        CONSTRAINT fk_gra_gt_weight FOREIGN KEY (section_id, grade_type_code) REFERENCES grade_type_weights(section_id, grade_type_code)
);

CREATE TABLE grade_conversions (
                                   letter_grade  VARCHAR(2)    CONSTRAINT pk_grade_conversions PRIMARY KEY,
                                   grade_point   NUMERIC(3, 2) DEFAULT 0 CONSTRAINT nn_grc_point NOT NULL,
                                   max_grade     NUMERIC(3, 0) CONSTRAINT nn_grc_max NOT NULL,
                                   min_grade     NUMERIC(3, 0) CONSTRAINT nn_grc_min NOT NULL,
                                   created_by    VARCHAR(30)   CONSTRAINT nn_grc_created_by NOT NULL,
                                   created_date  DATE          CONSTRAINT nn_grc_created_date NOT NULL,
                                   modified_by   VARCHAR(30),
                                   modified_date DATE
);