-- foreign_key.sql
-- This file shows how tables are related using foreign keys.

CREATE TABLE courses (
                         id INTEGER,
                         title TEXT NOT NULL,
                         PRIMARY KEY (id)
);

CREATE TABLE enrollments (
                             student_id INTEGER,
                             course_id INTEGER,
                             FOREIGN KEY (student_id) REFERENCES students(id),
                             FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Simple Explanation (English)
-- A FOREIGN KEY connects two tables.
--
-- student_id must exist in students(id).
--
-- course_id must exist in courses(id).
--
-- This creates a relationship between students and courses.
--
-- This is a many-to-many relationship example.
-- CREATE TABLE is used to create a new table.
--     courses is the name of the first table.
--     enrollments is the name of the second table.
--     Inside parentheses, we define columns.
--     INTEGER stores whole numbers.
--     TEXT stores strings.
--     PRIMARY KEY (id) means that the id column is the primary key of the courses table.
--     FOREIGN KEY (student_id) REFERENCES students(id) means that the student_id column in the enrollments table is a foreign key that references the id column in the students table.
--     FOREIGN KEY (course_id) REFERENCES courses(id) means that the course_id column in the enrollments table is a foreign key that references the id column in the courses table.
--     Each row in the courses table represents one course, and each row in the enrollments table represents a student's enrollment in a course.
