--1)Database Creation
-- Create the StudentInfo table
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(50),
    DOB DATE,
    PHONE_NO VARCHAR(20),
    EMAIL_ID VARCHAR(50),
    ADDRESS VARCHAR(100)
);
-- Create the CoursesInfo table
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(50),
    COURSE_INSTRUCTOR_NAME VARCHAR(50)
);
-- Create the EnrollmentInfo table
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);
--2)Data Creation
INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES
    (1, 'Stephie', '1991-11-24', '123-456-7890', 'Stephieh@example.com', 'Villivakkam chennai'),
    (2, 'Hennah', '1992-12-25', '987-654-3210', 'Hennah@yahoo.com', 'anna nagar chennai'),
    (3, 'Edwin', '1993-01-26', '111-222-3333', 'edwin_93@example.com', 'Pondicherry');
INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES
    (101, 'Generative AI', 'Stephie'),
    (102, 'Prompt Engineering', 'Hennah'),
    (103, 'Predictive AI', 'Edwin');
	-- Insert sample data into EnrollmentInfo table
INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES
    (1, 1, 101, 'Enrolled'),
    (2, 1, 102, 'Enrolled'),
	(3, 1, 103, 'Not Enrolled'),
    (4, 2, 101, 'Not Enrolled'),
	(5, 2, 102, 'Not Enrolled'),
    (6, 2, 103, 'Enrolled'),
    (7, 3, 102, 'Enrolled'),
	(8, 3, 101, 'Enrolled'),
	(9, 3, 103, 'Not Enrolled');
--3)Retrieve the Student Information
--a) Retrieve student details, such as student name, contact information, and enrollment status:
	SELECT si.STU_NAME, si.STU_ID,Course_Id, si.PHONE_NO, si.EMAIL_ID, ei.ENROLL_STATUS
FROM StudentInfo si
JOIN EnrollmentInfo ei ON si.STU_ID = ei.STU_ID;

--Select * From StudentInfo
--Select * From CoursesInfo
--select * from EnrollmentInfo

--delete from CoursesInfo where COURSE_ID in (101,102,103);
--ALTER TABLE EnrollmentInfo DROP FOREIGN KEY STU_ID;
--Updated Course instructor names
Update CoursesInfo
Set COURSE_INSTRUCTOR_NAME = 'John'
where COURSE_INSTRUCTOR_NAME = 'Hennah'

--b) Retrieve a list of courses in which a specific student is enrolled:
SELECT ci.COURSE_NAME , ei.STU_ID, si.STU_NAME, ei.ENROLL_STATUS
FROM EnrollmentInfo ei
JOIN CoursesInfo ci ON ci.COURSE_ID = ei.COURSE_ID
JOIN StudentInfo si ON ei.STU_ID = si.STU_ID
WHERE ei.STU_ID = 1 and ei.ENROLL_STATUS= 'Enrolled' ;  -- Replace 1 with the desired student ID

--c) Retrieve course information, including course name and instructor information:
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo;

--d) Retrieve course information for a specific course:
SELECT COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_ID = 101;  -- Replace 101 with the desired course ID

--e) Retrieve course information for multiple courses:
SELECT COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_ID IN (101, 102);  -- Replace with desired course IDs

--4)Reporting and Analytics
--a) Number of students enrolled in each course:
SELECT ci.COURSE_NAME, count(distinct ei.STU_ID) As No_Of_Students
FROM CoursesInfo ci
left JOIN EnrollmentInfo ei ON ci.COURSE_ID = ei.COURSE_ID and ei.ENROLL_STATUS= 'Enrolled'
GROUP BY ci.COURSE_NAME;

--b) List of students enrolled in a specific course:
SELECT COURSE_NAME,STU_NAME
FROM StudentInfo si
JOIN EnrollmentInfo ei ON si.STU_ID = ei.STU_ID
JOIN CoursesInfo ci ON ci.COURSE_ID = ei.COURSE_ID and ei.ENROLL_STATUS= 'Enrolled'
WHERE ci.COURSE_NAME = 'Predictive AI';  -- Replace with desired course name

--c) Count of enrolled students for each instructor:
SELECT ci.COURSE_INSTRUCTOR_NAME, COUNT(ei.STU_ID) As No_Of_Students
FROM CoursesInfo ci
JOIN EnrollmentInfo ei ON ci.COURSE_ID = ei.COURSE_ID and ei.ENROLL_STATUS= 'Enrolled'
GROUP BY ci.COURSE_INSTRUCTOR_NAME;

--d) List of students enrolled in multiple courses:
SELECT si.STU_NAME
FROM StudentInfo si
JOIN EnrollmentInfo ei ON si.STU_ID = ei.STU_ID and ei.ENROLL_STATUS= 'Enrolled'
GROUP BY si.STU_NAME
HAVING COUNT(COURSE_ID) > 1;


--e) Courses with the highest number of enrolled students((arranging from highest to lowest):
SELECT ci.COURSE_NAME, COUNT(ei.STU_ID) AS ENROLLED_STUDENTS
FROM CoursesInfo ci
JOIN EnrollmentInfo ei ON ci.COURSE_ID = ei.COURSE_ID and ENROLL_STATUS= 'Enrolled'
GROUP BY ci.COURSE_NAME
ORDER BY ENROLLED_STUDENTS DESC;






