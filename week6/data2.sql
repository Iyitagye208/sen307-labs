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

SELECT * FROM Enrolment;

SELECT course_id, COUNT(*) AS total_students
FROM Enrolment
GROUP BY course_id;

SELECT student_id, full_name
FROM Student
WHERE student_id NOT IN (
    SELECT student_id FROM Enrolment
);

INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

SELECT course_id, COUNT(*) AS total_lecturers
FROM CourseAllocation
GROUP BY course_id;

SELECT matric_no, full_name, dept_id
FROM Student
WHERE matric_no = '202515094';

SET SQL_SAFE_UPDATES = 0;

UPDATE Student
SET dept_id = 4
WHERE matric_no = '202515094';

SET SQL_SAFE_UPDATES = 1;

SELECT matric_no, full_name, dept_id
FROM Student
WHERE matric_no = '202515094';

INSERT INTO Department (dept_name)
VALUES ('Library and Information Science');

INSERT INTO Student (matric_no, full_name, dept_id)
VALUES (
    '202515113',
    'Test Transfer Student',
    (SELECT dept_id
     FROM Department
     WHERE dept_name = 'Library and Information Science')
);

DELETE FROM Department
WHERE dept_name = 'Library and Information Science';

UPDATE Student
SET dept_id = (
    SELECT dept_id
    FROM Department
    WHERE dept_name = 'Software Engineering'
)
WHERE matric_no = '202515113';

DELETE FROM Department
WHERE dept_name = 'Library and Information Science';

SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers', COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students', COUNT(*) FROM Student
UNION ALL SELECT 'Courses', COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments', COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;