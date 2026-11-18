-- week 07 --
-- Task 1: Students in one department, sorted A-Z
-- Explanation: This query uses INNER JOIN to combine the Student and Department tables
-- using dept_id. It filters for students in Software Engineering
-- and sorts their names alphabetically in ascending order.

SELECT s.full_name, d.dept_name
FROM Student s
INNER JOIN Department d
ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;

-- Task 2: Courses with their lecturers (INNER JOIN)
-- Explanation: This query joins the Course, CourseAllocation and Lecturer
-- tables to display each course alongside the lecturer assigned to teach it.
-- Courses with multiple lecturers appear more than once.
SELECT c.course_title, l.full_name
FROM Course c
INNER JOIN CourseAllocation ca
ON c.course_id = ca.course_id
INNER JOIN Lecturer l
ON ca.lecturer_id = l.lecturer_id
ORDER BY c.course_title ASC;

-- Task 3: Students and their courses (LEFT JOIN)
-- Explanation: This query uses LEFT JOIN to display every student
-- and their enrolled courses. Students without enrolments are
-- still included, with NULL displayed for their course title.
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e
ON s.student_id = e.student_id
LEFT JOIN Course c
ON e.course_id = c.course_id
ORDER BY s.full_name;

-- Task 4: Filtering with AND, OR, IN and BETWEEN
-- Explanation: This query filters female students in Software Engineering
-- or Artificial Intelligence whose dates of birth fall between
-- 1 January 2004 and 31 December 2005.
SELECT s.full_name, s.gender, d.dept_name, s.date_of_birth
FROM Student s
INNER JOIN Department d
ON s.dept_id = d.dept_id
WHERE s.gender = 'F'
AND d.dept_name IN ('Software Engineering', 'Artificial Intelligence')
AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.full_name ASC;

-- Task 5: Paginating enrolments with LIMIT and OFFSET
-- Explanation: This query displays enrolment records in groups of 10.
-- LIMIT specifies how many records to display, while OFFSET specifies
-- how many records to skip.
SELECT *
FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 0;

-- Page 2: Display enrolments 11–20
SELECT *
FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 10;