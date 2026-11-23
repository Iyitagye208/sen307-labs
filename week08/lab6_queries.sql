

USE sen307_202515093;


-- TASK 1: Count students enrolled in each course.
-- LEFT JOIN includes courses with zero enrolments.


SELECT
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
ORDER BY total_students DESC;


-- TASK 2: Find courses with more than 3, 5 and 7 students.
-- HAVING filters groups after GROUP BY.

-- Threshold: More than 3 students
SELECT
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(e.student_id) > 3;

-- Threshold: More than 5 students
SELECT
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(e.student_id) > 5;

-- Threshold: More than 7 students
SELECT
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(e.student_id) > 7;


-- TASK 3: Calculate the average number of courses per student.
-- LEFT JOIN includes students with zero courses.
-- The inner query counts courses per student.
-- The outer query calculates the average.

SELECT ROUND(AVG(course_count), 2) AS average_courses_per_student
FROM (
    SELECT
        s.student_id,
        COUNT(e.course_id) AS course_count
    FROM Student s
    LEFT JOIN Enrolment e
        ON s.student_id = e.student_id
    GROUP BY s.student_id
) AS per_student;


-- TASK 4: Find students who are not enrolled in any course.
-- The inner query retrieves student IDs from Enrolment.
-- NOT IN returns students whose IDs are absent from that result.

SELECT
    s.student_id,
    s.full_name
FROM Student s
WHERE s.student_id NOT IN (
    SELECT student_id
    FROM Enrolment
);


-- TASK 5: Find the student(s) with the highest number of
-- enrolments in each department.
-- The correlated subquery uses s.dept_id from the outer query.
-- ALL compares each student's count with every student's count
-- in the same department. Ties are allowed.

SELECT
    d.dept_name,
    s.full_name,
    (
        SELECT COUNT(*)
        FROM Enrolment e
        WHERE e.student_id = s.student_id
    ) AS courses
FROM Student s
JOIN Department d
    ON s.dept_id = d.dept_id
WHERE (
    SELECT COUNT(*)
    FROM Enrolment e
    WHERE e.student_id = s.student_id
) >= ALL (
    SELECT COUNT(*)
    FROM Student s2
     LEFT JOIN Enrolment e2
        ON s2.student_id = e2.student_id
    WHERE s2.dept_id = s.dept_id
    GROUP BY s2.student_id
)
ORDER BY d.dept_name;