drop table if exists students ;
drop table if exists subjects;
drop table if exists exam;

CREATE TABLE students (
    student_id VARCHAR(6) PRIMARY KEY,
    firstname VARCHAR(20) NOT NULL,
    surname VARCHAR(20) NOT NULL,
    lastname VARCHAR(20) NOT NULL,
    group_num VARCHAR(2) NOT NULL,
    phone_num INT(12) UNSIGNED NOT NULL
);

CREATE TABLE subjects (
    subject_id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(20) NOT NULL,
    teacher_name VARCHAR(20) NOT NULL
);

CREATE TABLE exam (
    student_id VARCHAR(6),
    subject_id TINYINT UNSIGNED,
    mark VARCHAR(4) NOT NULL,
    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(subject_id) REFERENCES subjects(subject_id),
    PRIMARY KEY (student_id , subject_id)
);