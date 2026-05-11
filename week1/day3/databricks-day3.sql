-- ==========================
-- sql joins
-- ==========================
use databricks;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO students VALUES
(1, 'Alice Johnson', 'alice@email.com'),
(2, 'Bob Smith', 'bob@email.com'),
(3, 'Charlie Brown', 'charlie@email.com'),
(4, 'Diana Prince', 'diana@email.com'),
(5, 'Ethan Hunt', 'ethan@email.com');
-- ============================================
-- TABLE: instructors
-- ============================================

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(100)
);

INSERT INTO instructors VALUES
(1, 'John Carter'),
(2, 'Sarah Lee'),
(3, 'Michael Scott'),
(4, 'Emma Watson');

-- ============================================
-- TABLE: courses
-- ============================================

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor_id INT
);

INSERT INTO courses VALUES
(101, 'SQL Basics', 1),
(102, 'Python Fundamentals', 2),
(103, 'Data Analytics', NULL),
(104, 'Cloud Computing', 3),
(105, 'Machine Learning', NULL);

-- ============================================
-- TABLE: enrollments
-- ============================================

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT
);

INSERT INTO enrollments(student_id, course_id) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 104);

-- ============================================
-- SQL JOINS ASSIGNMENT
-- ============================================
-- 1. All students and enrolled courses
SELECT s.student_name,
       c.course_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id;

-- 2. Courses with no students enrolled
select c.course_name from courses c 
left join enrollments e on c.course_id = e.course_id
where e.student_id is null;

-- 3. Instructors and courses they teach
select i.instructor_name,c.course_name from instructors i left join courses c 
on i.instructor_id=c. instructor_id;

-- 4. Courses without instructors
select * from courses where instructor_id is null;

-- 5. Students and enrollment info using RIGHT JOIN
select s.student_name,e.course_id from students s right join enrollments e on s.student_id=e.student_id;

-- 6. Students not enrolled in any course
select s.student_name,e.course_id from students s left join enrollments e on s.student_id=e.student_id where e.course_id is null;

-- 7. FULL OUTER JOIN between students and enrollments
-- MySQL alternative using UNION

select s.student_name,e.course_id from students s left join enrollments e on e.student_id=s.student_id
UNION
SELECT s.student_name,
       e.course_id
FROM students s
RIGHT JOIN enrollments e
ON s.student_id = e.student_id;

-- 8. Courses never appeared in enrollments
SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
WHERE e.course_id IS NULL;

-- 9. FULL OUTER JOIN instructors and courses
-- MySQL alternative using UNION
SELECT i.instructor_name,
       c.course_name
FROM instructors i
LEFT JOIN courses c
ON i.instructor_id = c.instructor_id

UNION

SELECT i.instructor_name,
       c.course_name
FROM instructors i
RIGHT JOIN courses c
ON i.instructor_id = c.instructor_id;

-- 10. Student, course, and instructor report
SELECT s.student_name,
       c.course_name,
       i.instructor_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id
LEFT JOIN instructors i
ON c.instructor_id = i.instructor_id;

-- ============================================
-- BONUS CHALLENGE
-- Every student and every course
-- ============================================

SELECT s.student_name,
       c.course_name
FROM students s
CROSS JOIN courses c;