USE sen307_202515093;
CREATE TABLE Department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Lecturer (
lecturer_id INT PRIMARY KEY AUTO_INCREMENT,
staff_no VARCHAR(20) NOT NULL UNIQUE,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
dept_id INT NOT NULL,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Student (
student_id INT PRIMARY KEY AUTO_INCREMENT,
matric_no VARCHAR(20) NOT NULL UNIQUE,
full_name VARCHAR(100) NOT NULL,
gender ENUM('M','F'),
date_of_birth DATE,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Course (
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_code VARCHAR(10) NOT NULL UNIQUE,
course_title VARCHAR(150) NOT NULL,
credit_units TINYINT NOT NULL DEFAULT 3,
description TEXT,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Enrolment (
enrolment_id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT NOT NULL,
course_id INT NOT NULL,
academic_session VARCHAR(9) NOT NULL DEFAULT '2026/2027',
semester ENUM('First','Second') NOT NULL DEFAULT 'First',
enrolled_on DATE DEFAULT (CURRENT_DATE),
UNIQUE (student_id, course_id, academic_session),
FOREIGN KEY (student_id) REFERENCES Student(student_id),
FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE CourseAllocation (
allocation_id INT PRIMARY KEY AUTO_INCREMENT,
course_id INT NOT NULL,
lecturer_id INT NOT NULL,
academic_session VARCHAR(9) NOT NULL DEFAULT '2026/2027',
UNIQUE (course_id, lecturer_id, academic_session),
FOREIGN KEY (course_id) REFERENCES Course(course_id),
FOREIGN KEY (lecturer_id) REFERENCES Lecturer(lecturer_id)
);

ALTER TABLE Student
ADD COLUMN phone VARCHAR(15) AFTER full_name;

ALTER TABLE Course
ADD CONSTRAINT chk_credit_units
CHECK (credit_units BETWEEN 1 AND 6);

INSERT INTO Department (dept_name)
VALUES (NULL);

INSERT INTO Course (course_code, course_title, credit_units)
VALUES ('TST101', 'Test', 9);

INSERT INTO Student (matric_no, full_name, dept_id)
VALUES ('TEST001', 'Test', 999);

INSERT INTO Student (matric_no, full_name, gender)
VALUES ('TEST002', 'Test', 'X');

SELECT COUNT(*) FROM Department;
SELECT COUNT(*) FROM Course;
SELECT COUNT(*) FROM Student;

INSERT INTO Department (dept_name)
VALUES ('Software Engineering');

INSERT INTO Department (dept_name)
VALUES ('Software Engineering');

DELETE FROM Department
WHERE dept_name = 'Software Engineering';

SHOW TABLES;

DESCRIBE Department;

DESCRIBE Lecturer;

DESCRIBE Student;

DESCRIBE Course;

DESCRIBE Enrolment;

DESCRIBE CourseAllocation;

-- =====================================
-- WEEK 6: INSERTING DEPARTMENTS & COURSES
-- =====================================

SELECT * FROM Department;
INSERT INTO Department (dept_name) VALUES
('Software Engineering'),
('Computer Science'),
('Artificial Intelligence'),
('Data Science'),
('Cybersecurity');

INSERT INTO Course (course_code, course_title, credit_units, description, dept_id) VALUES
('SEN307', 'Database Systems', 3,
'Relational database design, SQL queries, normalization, transactions and indexing using MySQL.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),

('SEN301', 'Software Architecture', 3,
'Architectural styles, design patterns, microservices and how to structure large software systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),

('COS301', 'Operating Systems', 3,
'Processes, threads, CPU scheduling, memory management and file systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),

('COS305', 'Computer Networks', 3,
'TCP/IP, routing, switching, LAN and WAN design and network protocols.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),

('AIN301', 'Introduction to Artificial Intelligence', 3,
'Intelligent agents, search algorithms, knowledge representation and reasoning.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),

('AIN305', 'Machine Learning', 3,
'Supervised and unsupervised learning, neural networks, deep learning and model evaluation.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),

('AIN307', 'Natural Language Processing', 3,
'Text processing, word embeddings, language models, sentiment analysis and chatbots.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),

('DTS301', 'Data Visualization and Analytics', 2,
'Exploratory data analysis, charts, dashboards and telling stories with data.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),

('DTS305', 'Big Data Technologies', 3,
'Distributed storage and processing of very large datasets with Hadoop and Spark.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),

('CYB301', 'Network Security', 3,
'Firewalls, cryptography, intrusion detection and protecting networks from attacks.',
(SELECT dept_id FROM Department WHERE dept_name = 'Cybersecurity'));

SELECT dept_id, dept_name FROM Department;
SELECT course_id, course_code FROM Course;

INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101', 'Dr Amaka Okafor', 'a.okafor@vua.edu.ng', 3),
('VUA/ST/102', 'Dr Musa Bello', 'm.bello@vua.edu.ng', 3),

('VUA/ST/103', 'Dr Chika Eze', 'c.eze@vua.edu.ng', 4),
('VUA/ST/104', 'Dr Ibrahim Yusuf', 'i.yusuf@vua.edu.ng', 4),

('VUA/ST/105', 'Dr Ngozi Nwosu', 'n.nwosu@vua.edu.ng', 5),
('VUA/ST/106', 'Dr Tunde Bakare', 't.bakare@vua.edu.ng', 5),

('VUA/ST/107', 'Dr Zainab Abdullahi', 'z.abdullahi@vua.edu.ng', 6),
('VUA/ST/108', 'Dr Emeka Obi', 'e.obi@vua.edu.ng', 6),

('VUA/ST/109', 'Dr Fatima Garba', 'f.garba@vua.edu.ng', 7),
('VUA/ST/110', 'Dr Kunle Adeyemi', 'k.adeyemi@vua.edu.ng', 7);
SELECT * FROM Lecturer;

INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id) VALUES

-- Software Engineering (dept_id 3)
('202515093', 'Jessica Okpede', 'F', '2004-03-29', 3),
('202515094', 'Ada Obi', 'F', '2005-03-14', 3),
('202515095', 'Daniel Eze', 'M', '2004-11-02', 3),
('202515096', 'Chiamaka Nwosu', 'F', '2005-07-21', 3),

-- Computer Science (dept_id 4)
('202515097', 'John Musa', 'M', '2004-09-12', 4),
('202515098', 'Maryam Ibrahim', 'F', '2005-02-18', 4),
('202515099', 'Samuel Adeyemi', 'M', '2003-12-05', 4),
('202515100', 'Blessing Okafor', 'F', '2005-06-30', 4),

-- Artificial Intelligence (dept_id 5)
('202515101', 'Emeka Chukwu', 'M', '2004-04-16', 5),
('202515102', 'Aisha Bello', 'F', '2005-08-09', 5),
('202515103', 'David Ojo', 'M', '2003-10-25', 5),
('202515104', 'Ngozi Eze', 'F', '2004-01-19', 5),

-- Data Science (dept_id 6)
('202515105', 'Tunde Bakare', 'M', '2004-05-11', 6),
('202515106', 'Fatima Garba', 'F', '2005-09-23', 6),
('202515107', 'Peter Okoro', 'M', '2003-07-14', 6),
('202515108', 'Ruth Danjuma', 'F', '2004-03-08', 6),

-- Cybersecurity (dept_id 7)
('202515109', 'Ibrahim Sani', 'M', '2004-06-17', 7),
('202515110', 'Esther Johnson', 'F', '2005-11-28', 7),
('202515111', 'Michael Osei', 'M', '2003-02-13', 7),
('202515112', 'Grace Onyekachi', 'F', '2004-12-20', 7);

SELECT * FROM Student;

SELECT student_id, matric_no, full_name FROM Student;

SELECT lecturer_id, full_name FROM Lecturer;

SELECT course_id, course_code FROM Course;

INSERT INTO Enrolment (student_id, course_id) VALUES
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),

(2, 2),
(3, 2),
(8, 2),
(9, 2),

(4, 3),
(5, 3),
(10, 3),
(11, 3),

(6, 4),
(7, 4),
(12, 4),
(13, 4),

(8, 5),
(9, 5),
(14, 5),
(15, 5),

(10, 6),
(11, 6),
(12, 6),
(16, 6),

(13, 7),
(14, 7),
(15, 7),
(17, 7),

(16, 8),
(17, 8),
(18, 8),
(19, 8),

(2, 9),
(5, 9),
(8, 9),
(11, 9),

(12, 10),
(13, 10);