DROP TABLE S_PROGRAM_t CASCADE CONSTRAINTS;
DROP TABLE S_LOCATION_t CASCADE CONSTRAINTS;
DROP TABLE S_ROOMS_t CASCADE CONSTRAINTS;
DROP TABLE S_PROGRAM_ROOM_PAIR_t CASCADE CONSTRAINTS;
DROP TABLE S_LAB_t CASCADE CONSTRAINTS;
DROP TABLE S_LECTURE_ROOM_t CASCADE CONSTRAINTS;
DROP TABLE S_OFFICE_t CASCADE CONSTRAINTS;
DROP TABLE S_TECHNOLOGICAL_TOOLS_t CASCADE CONSTRAINTS;
DROP TABLE S_LAB_TOOLS_t CASCADE CONSTRAINTS;
DROP TABLE S_EMPLOYEE_t CASCADE CONSTRAINTS;
DROP TABLE S_INSTRUCTOR_t CASCADE CONSTRAINTS;
DROP TABLE S_ADMINISTRATIVE_t CASCADE CONSTRAINTS;
DROP TABLE S_INSTRUCTOR_TOOLS_t CASCADE CONSTRAINTS;
DROP TABLE S_EVENT_t CASCADE CONSTRAINTS;
DROP TABLE S_TRAINING_COURSE_t CASCADE CONSTRAINTS;
DROP TABLE S_COORDINATOR_T CASCADE CONSTRAINTS;
DROP TABLE S_TIMESLOT_t CASCADE CONSTRAINTS;
DROP TABLE S_SCHEDULE_t CASCADE CONSTRAINTS;

CREATE TABLE S_PROGRAM_t (
    ProgramID INT NOT NULL,
    ProgramName VARCHAR(30),
    EstablishingTime VARCHAR(6),
    ProgramDescription VARCHAR(35),
CONSTRAINT S_PROGRAM_PK PRIMARY KEY (ProgramID)
);

CREATE TABLE S_LOCATION_t (
    LocationID INT NOT NULL,
    LocationName varchar(25),
    LocationAddress varchar(30),
    LocationLmt Date,
    ProgramId INT NOT NULL,
CONSTRAINT S_LOCATION_PK PRIMARY KEY (LocationID)
);

CREATE TABLE S_ROOMS_t (
    RoomNumber INT NOT NULL,
    Room_Type VARCHAR(30),
    LocationId INT NOT NULL,
CONSTRAINT S_ROOMS_PK PRIMARY KEY (RoomNumber, LocationID),
CONSTRAINT S_ROOMS_FK FOREIGN KEY (LocationID) REFERENCES S_LOCATION_t(LocationID)
);

CREATE TABLE S_PROGRAM_ROOM_PAIR_t (
    LocationID INT NOT NULL,
    RoomNumber INT NOT NULL,
    ProgramID INT NOT NULL,
CONSTRAINT S_PROGRAM_ROOM_PAIR_PK1 PRIMARY KEY (LocationID, RoomNumber, ProgramID),
CONSTRAINT S_PROGRAM_ROOM_PAIR_FK1 FOREIGN KEY (LocationID, RoomNumber) REFERENCES S_ROOMS_t(LocationID, RoomNumber),
CONSTRAINT S_PROGRAM_ROOM_PAIR_FK2 FOREIGN KEY (ProgramID) REFERENCES S_PROGRAM_t(ProgramID)
);

CREATE TABLE S_LAB_t (
    LaLocationID INT NOT NULL,
    LaRoomNumber INT NOT NULL,
    Layout varchar(50),
    Occupancy varchar(3),
CONSTRAINT S_LAB_PK PRIMARY KEY (LaLocationID, LaRoomNumber),
CONSTRAINT S_LAB_FK FOREIGN KEY (LaLocationID, LaRoomNumber) REFERENCES S_ROOMS_t(LocationID, RoomNumber)
);

CREATE TABLE S_LECTURE_ROOM_t (
    LrLocationId INT NOT NULL,
    LrRoomNumber INT NOT NULL,
    Layout varchar(25),
    Occupancy varchar(3),
CONSTRAINT S_LECTURE_ROOM_PK PRIMARY KEY (LrLocationId, LrRoomNumber),
CONSTRAINT S_LECTURE_ROOM_FK FOREIGN KEY (LrLocationId, LrRoomNumber) REFERENCES S_ROOMS_t(LocationID, RoomNumber)
);

CREATE TABLE S_OFFICE_t (
    OLocationID INT NOT NULL,
    ORoomNumber INT NOT NULL,
    RoomTelephone VARCHAR(15),
CONSTRAINT S_OFFICE_PK PRIMARY KEY (OLocationID, ORoomNumber),
CONSTRAINT S_OFFICE_FK1 FOREIGN KEY (OLocationID, ORoomNumber) REFERENCES S_ROOMS_t(LocationID, RoomNumber)
);

CREATE TABLE S_TECHNOLOGICAL_TOOLS_t (
    ToolTypeID INT NOT NULL,
    DescriptionText VARCHAR(25),
CONSTRAINT S_TECHNOLOGICAL_TOOLS_PK PRIMARY KEY (ToolTypeID)
);

CREATE TABLE S_LAB_TOOLS_t (
    LaLocationID INT NOT NULL,
    LaRoomNumber INT NOT NULL,
    ToolTypeID INT NOT NULL,
CONSTRAINT S_Lab_Tools_PK PRIMARY KEY (LaLocationID, LaRoomNumber, ToolTypeID),
CONSTRAINT S_Lab_Tools_FK1 FOREIGN KEY (LaLocationID, LaRoomNumber) REFERENCES S_Lab_t(LaLocationID, LaRoomNumber),
CONSTRAINT S_Lab_Tools_FK2 FOREIGN KEY (ToolTypeID) REFERENCES S_TECHNOLOGICAL_TOOLS_t(ToolTypeID)
);

CREATE TABLE S_EMPLOYEE_t (
    EmployeeID INT NOT NULL,
    EmployeeName VARCHAR(25),
    Salary DECIMAL(10,2),
    DOB DATE,
CONSTRAINT S_EMPLOYEE_PK PRIMARY KEY (EmployeeID)
);

CREATE TABLE S_INSTRUCTOR_t (
    InEmployeeID INT NOT NULL,
    EducationLevel VARCHAR(25),
CONSTRAINT S_INSTRUCTOR_PK PRIMARY KEY (InEmployeeID),
CONSTRAINT S_INSTRUCTOR_FK FOREIGN KEY (InEmployeeID) REFERENCES S_EMPLOYEE_T(EmployeeID)
);

CREATE TABLE S_ADMINISTRATIVE_T (
    AdEmployeeID INT NOT NULL,
    AdminType VARCHAR(25),
    AdminLevel INT,
    Department VARCHAR(25),
CONSTRAINT S_ADMINISTRATIVE_PK PRIMARY KEY (AdEmployeeID),
CONSTRAINT S_ADMINISTRATIVE_FK FOREIGN KEY (AdEmployeeID) REFERENCES S_EMPLOYEE_T(EmployeeID)
);

CREATE TABLE S_INSTRUCTOR_TOOLS_t (
    InEmployeeID INT NOT NULL,
    ToolTypeID INT NOT NULL,
CONSTRAINT S_INSTRUCTOR_TOOLS_PK PRIMARY KEY (InEmployeeID, ToolTypeID),
CONSTRAINT S_INSTRUCTOR_TOOLS_FK1 FOREIGN KEY (InEmployeeID) REFERENCES S_INSTRUCTOR_t(InEmployeeID),
CONSTRAINT S_INSTRUCTOR_TOOLS_FK2 FOREIGN KEY (ToolTypeID) REFERENCES S_TECHNOLOGICAL_TOOLS_t(ToolTypeID)
);

CREATE TABLE S_EVENT_t (
    EventID INT NOT NULL,
    AdEmployeeID INT NOT NULL,
    EventName VARCHAR(25),
    PlannedBudget DECIMAL(10,2),
    ApprovedBudget DECIMAL(10,2),
    EventDescription VARCHAR(25),
CONSTRAINT S_EVENTS_PK PRIMARY KEY (EventID),
CONSTRAINT S_EVENTS_FK FOREIGN KEY (AdEmployeeID) REFERENCES S_ADMINISTRATIVE_T(AdEmployeeID)
);

CREATE TABLE S_TRAINING_COURSE_t (
    TrainingCourseID INT NOT NULL,
    TrainingCourseName VARCHAR(30),
    TrainingCourseDescription VARCHAR(30),
    TrainingLevel VARCHAR(30),
    Price DECIMAL(10,2),
    InEmployeeID INT NOT NULL,
CONSTRAINT S_TRAINING_COURSE_PK PRIMARY KEY (TrainingCourseID),
CONSTRAINT S_TRAINING_COURSE_FK FOREIGN KEY (InEmployeeID) REFERENCES S_INSTRUCTOR_T(InEmployeeID)
);

CREATE TABLE S_COORDINATOR_T (
    AdEmployeeID INT NOT NULL,
    TrainingCourseID INT NOT NULL,
CONSTRAINT S_COORDINATOR_PK PRIMARY KEY (AdEmployeeID, TrainingCourseID),
CONSTRAINT S_COORDINATOR_FK1 FOREIGN KEY (AdEmployeeID) REFERENCES S_ADMINISTRATIVE_T(AdEmployeeID),
CONSTRAINT S_COORDINATOR_FK2 FOREIGN KEY (TrainingCourseID) REFERENCES S_TRAINING_COURSE_t(TrainingCourseID)
);

CREATE TABLE S_TIMESLOT_t ( 
    TSID INT NOT NULL, 
    DayOfWeek VARCHAR(10), 
    StartTime VARCHAR(10), 
    EndTime VARCHAR(10), 
    InEmployeeID INT, 
CONSTRAINT S_TIMESLOT_PK PRIMARY KEY (TSID),
CONSTRAINT S_TIMESLOT_FK FOREIGN KEY (InEmployeeID) REFERENCES S_INSTRUCTOR_t(InEmployeeID)
);

CREATE TABLE S_SCHEDULE_t ( 
    LocationID INT NOT NULL, 
    RoomNumber VARCHAR(10), 
    TSID INT NOT NULL, 
CONSTRAINT S_SCHEDULE_PK PRIMARY KEY (LocationID, RoomNumber, TSID), 
CONSTRAINT S_SCHEDULE_FK1 FOREIGN KEY (LocationID) REFERENCES S_Location_t(LocationID), 
CONSTRAINT S_SCHEDULE_FK2 FOREIGN KEY (TSID) REFERENCES S_TIMESLOT_t(TSID)
); 

DELETE FROM S_PROGRAM_t;
DELETE FROM S_LOCATION_t;
DELETE FROM S_ROOMS_t;
DELETE FROM S_PROGRAM_ROOM_PAIR_t;
DELETE FROM S_LAB_t;
DELETE FROM S_LECTURE_ROOM_t;
DELETE FROM S_OFFICE_t;
DELETE FROM S_TECHNOLOGICAL_TOOLS_t;
DELETE FROM S_LAB_TOOLS_t;
DELETE FROM S_EMPLOYEE_t;
DELETE FROM S_INSTRUCTOR_t;
DELETE FROM S_ADMINISTRATIVE_t;
DELETE FROM S_INSTRUCTOR_TOOLS_t;
DELETE FROM S_EVENT_t;
DELETE FROM S_TRAINING_COURSE_t;
DELETE FROM S_COORDINATOR_T;
DELETE FROM S_TIMESLOT_t;
DELETE FROM S_SCHEDULE_t;

INSERT INTO S_PROGRAM_t (ProgramID, ProgramName, EstablishingTime, ProgramDescription)
VALUES  (1, 'English', '8:00', 'Languages & Linguistics');
INSERT INTO S_PROGRAM_t (ProgramID, ProgramName, EstablishingTime, ProgramDescription)
VALUES  (2, 'Python', '9:00', 'Information & Technology');
INSERT INTO S_PROGRAM_t (ProgramID, ProgramName, EstablishingTime, ProgramDescription)
VALUES  (3, 'Python', '10:00', 'Database System Development');
INSERT INTO S_PROGRAM_t (ProgramID, ProgramName, EstablishingTime, ProgramDescription)
VALUES  (4, 'Compuster Science', '11:00', 'Science & Engineering');
INSERT INTO S_PROGRAM_t (ProgramID, ProgramName, EstablishingTime, ProgramDescription)
VALUES  (5, 'Python', '12:00', 'Advanced Python');

INSERT INTO S_LOCATION_t  (LocationID, LocationName, LocationAddress, LocationLmt, ProgramID)
VALUES  (1, 'Foster', '1621 S 3rd St', '3/14/24', 1);
INSERT INTO S_LOCATION_t  (LocationID, LocationName, LocationAddress, LocationLmt, ProgramID)
VALUES  (2, 'Baylor Science Building', '101 Bagby Ave', '2/11/24', 2);
INSERT INTO S_LOCATION_t  (LocationID, LocationName, LocationAddress, LocationLmt, ProgramID)
VALUES  (3, 'Sid Richardson', '1410 S 3rd St', '12/29/23', 3);
INSERT INTO S_LOCATION_t  (LocationID, LocationName, LocationAddress, LocationLmt, ProgramID)
VALUES  (4, 'Cashion Academic Center', '1420 S 5th St', '3/01/24', 4);
INSERT INTO S_LOCATION_t  (LocationID, LocationName, LocationAddress, LocationLmt, ProgramID)
VALUES  (5, 'Draper Academic Building', '1420 S 7th St', '11/30/23', 5);

INSERT INTO S_ROOMS_t  (RoomNumber, Room_type, LocationId)
VALUES  (1, 'Lecture', 1);
INSERT INTO S_ROOMS_t  (RoomNumber, Room_type, LocationId)
VALUES  (2, 'Office', 2);
INSERT INTO S_ROOMS_t  (RoomNumber, Room_type, LocationId)
VALUES  (3, 'Music', 3);
INSERT INTO S_ROOMS_t  (RoomNumber, Room_type, LocationId)
VALUES  (4, 'Office', 4);
INSERT INTO S_ROOMS_t  (RoomNumber, Room_type, LocationId)
VALUES  (5, 'Office', 5);

INSERT INTO S_PROGRAM_ROOM_PAIR_t (LocationID, RoomNumber, ProgramID)
VALUES  (1, 1, 1);
INSERT INTO S_PROGRAM_ROOM_PAIR_t (LocationID, RoomNumber, ProgramID)
VALUES  (2, 2, 2);
INSERT INTO S_PROGRAM_ROOM_PAIR_t (LocationID, RoomNumber, ProgramID)
VALUES  (3, 3, 3);
INSERT INTO S_PROGRAM_ROOM_PAIR_t (LocationID, RoomNumber, ProgramID)
VALUES  (4, 4, 4);
INSERT INTO S_PROGRAM_ROOM_PAIR_t (LocationID, RoomNumber, ProgramID)
VALUES  (5, 5, 5);

INSERT INTO S_LAB_t (LaLocationId, LaRoomNumber, Layout, Occupancy)
VALUES (1, 1, '10 stations', 40);
INSERT INTO S_LAB_t (LaLocationId, LaRoomNumber, Layout, Occupancy)
VALUES (2, 2, '16 stations', 102);
INSERT INTO S_LAB_t (LaLocationId, LaRoomNumber, Layout, Occupancy)
VALUES (3, 3, '7 stations', 14);
INSERT INTO S_LAB_t (LaLocationId, LaRoomNumber, Layout, Occupancy)
VALUES (4, 4, '20 stations', 100);
INSERT INTO S_LAB_t (LaLocationId, LaRoomNumber, Layout, Occupancy)
VALUES (5, 5, '10 stations', 10);

INSERT INTO S_LECTURE_ROOM_t (LrLocationId, LrRoomNumber, Layout, Occupancy)
VALUES (1, 1, 'Rowed Tables', 30);
INSERT INTO S_LECTURE_ROOM_t (LrLocationId, LrRoomNumber, Layout, Occupancy)
VALUES (2, 2, 'Auditorium', 250);
INSERT INTO S_LECTURE_ROOM_t (LrLocationId, LrRoomNumber, Layout, Occupancy)
VALUES (3, 3, 'Individual Tables', 34);
INSERT INTO S_LECTURE_ROOM_t (LrLocationId, LrRoomNumber, Layout, Occupancy)
VALUES (4, 4, 'Auditorium', 60);
INSERT INTO S_LECTURE_ROOM_t (LrLocationId, LrRoomNumber, Layout, Occupancy)
VALUES (5, 5, 'Computer Tables', 48);

INSERT INTO S_OFFICE_t (OLocationID, ORoomNumber, RoomTelephone)
VALUES  (1, 1, '123-452-7890');
INSERT INTO S_OFFICE_t (OLocationID, ORoomNumber, RoomTelephone)
VALUES  (2, 2, '555-123-1629');
INSERT INTO S_OFFICE_t (OLocationID, ORoomNumber, RoomTelephone)
VALUES  (3, 3, '714-090-2376');
INSERT INTO S_OFFICE_t (OLocationID, ORoomNumber, RoomTelephone)
VALUES (4, 4, '512-399-6487');
INSERT INTO S_OFFICE_t (OLocationID, ORoomNumber, RoomTelephone)
VALUES (5, 5, '737-924-6653');

INSERT INTO S_Technological_Tools_t (ToolTypeID, DescriptionText)
VALUES (1, 'Combustion Analyzer');
INSERT INTO S_Technological_Tools_t (ToolTypeID, DescriptionText)
VALUES (2, 'Vacuum');
INSERT INTO S_Technological_Tools_t (ToolTypeID, DescriptionText)
VALUES (3, 'FM Translator');
INSERT INTO S_Technological_Tools_t (ToolTypeID, DescriptionText)
VALUES (4, 'Radio Probe');
INSERT INTO S_Technological_Tools_t (ToolTypeID, DescriptionText)
VALUES (5, 'Pressure Sensor');

INSERT INTO S_LAB_TOOLS_t (LaLocationID, LaRoomNumber, ToolTypeID)
VALUES (1, 1, 1);
INSERT INTO S_LAB_TOOLS_t (LaLocationID, LaRoomNumber, ToolTypeID)
VALUES (2, 2, 2);
INSERT INTO S_LAB_TOOLS_t (LaLocationID, LaRoomNumber, ToolTypeID)
VALUES (3, 3, 3);
INSERT INTO S_LAB_TOOLS_t (LaLocationID, LaRoomNumber, ToolTypeID)
VALUES (4, 4, 4);
INSERT INTO S_LAB_TOOLS_t (LaLocationID, LaRoomNumber, ToolTypeID)
VALUES (5, 5, 5);

INSERT INTO S_EMPLOYEE_T (EmployeeID, EmployeeName, Salary, DOB)
VALUES (1, 'Mike Tyson', 144000, '3/12/1969');
INSERT INTO S_EMPLOYEE_T (EmployeeID, EmployeeName, Salary, DOB)
VALUES (2, 'Michael Jackson', 299000, '11/08/1972');
INSERT INTO S_EMPLOYEE_T (EmployeeID, EmployeeName, Salary, DOB)
VALUES (3, 'Michael Jordan', 254000, '5/24/1968');
INSERT INTO S_EMPLOYEE_T (EmployeeID, EmployeeName, Salary, DOB)
VALUES (4, 'Michael Porter Jr', 142000, '7/13/1970');
INSERT INTO S_EMPLOYEE_T (EmployeeID, EmployeeName, Salary, DOB)
VALUES (5, 'Jeff Thomas', 144000, '3/10/1967');

INSERT INTO S_INSTRUCTOR_T  (InEmployeeID, EducationLevel)
VALUES (1, 'Master');
INSERT INTO S_INSTRUCTOR_T  (InEmployeeID, EducationLevel)
VALUES (2, 'PHD');
INSERT INTO S_INSTRUCTOR_T  (InEmployeeID, EducationLevel)
VALUES (3, 'Master');
INSERT INTO S_INSTRUCTOR_T  (InEmployeeID, EducationLevel)
VALUES (4, 'Master');
INSERT INTO S_INSTRUCTOR_T  (InEmployeeID, EducationLevel)
VALUES (5, 'PHD');

Insert into S_Administrative_T(AdEmployeeID, AdminType, AdminLevel, Department)
Values(1, 'Coordinator', 1, 'Math');
Insert into S_Administrative_T(AdEmployeeID, AdminType, AdminLevel, Department)
Values(2, 'Coordinator', 2, 'Science');
Insert into S_Administrative_T(AdEmployeeID, AdminType, AdminLevel, Department)
Values(3, 'Manager', 3, 'Math');
Insert into S_Administrative_T(AdEmployeeID, AdminType, AdminLevel, Department)
Values(4, 'Manager', 4, 'MIS');
Insert into S_Administrative_T(AdEmployeeID, AdminType, AdminLevel, Department)
Values(5, 'Coordinator', 5, 'Finance');

INSERT INTO S_Instructor_Tools_t(InEmployeeID, ToolTypeID)
VALUES(1, 1);
INSERT INTO S_Instructor_Tools_t(InEmployeeID, ToolTypeID)
VALUES(2, 2);
INSERT INTO S_Instructor_Tools_t(InEmployeeID, ToolTypeID) --Instructor 3 is trained in 2 tools--
VALUES(3, 2);
INSERT INTO S_Instructor_Tools_t(InEmployeeID, ToolTypeID)
VALUES(3, 3);
INSERT INTO S_Instructor_Tools_t(InEmployeeID, ToolTypeID)
VALUES(4, 4);
INSERT INTO S_Instructor_Tools_t(InEmployeeID, ToolTypeID)
VALUES(5, 5);

INSERT INTO S_Event_t (EventID, AdEmployeeID, EventName, PlannedBudget, ApprovedBudget, EventDescription)
VALUES(1, 1, 'Orientation 1', 1000, 1000, 'Meet People');
INSERT INTO S_Event_t (EventID, AdEmployeeID, EventName, PlannedBudget, ApprovedBudget, EventDescription)
VALUES(2, 2, 'Orientation 2', 500, 500, 'Meet People');
INSERT INTO S_Event_t (EventID, AdEmployeeID, EventName, PlannedBudget, ApprovedBudget, EventDescription)
VALUES(3, 3, 'Networking 1', 250, 200, 'Connect with people');
INSERT INTO S_Event_t (EventID, AdEmployeeID, EventName, PlannedBudget, ApprovedBudget, EventDescription)
VALUES(4, 4, 'Networking 2', 200, 200, 'Connect with people');
INSERT INTO S_Event_t (EventID, AdEmployeeID, EventName, PlannedBudget, ApprovedBudget, EventDescription)
VALUES(5, 5, 'InfoSession', 350, 300, 'Learn about courses');


INSERT INTO s_training_course_t(TrainingCourseID, TrainingCourseName, TrainingCourseDescription, TrainingLevel, Price, InEmployeeID)
VALUES(1, 'Python', 'Learn MIS', 'Master', 500, 1);
INSERT INTO s_training_course_t(TrainingCourseID, TrainingCourseName, TrainingCourseDescription, TrainingLevel, Price, InEmployeeID)
VALUES(2, 'Python', 'Learn IT', 'Professional', 750, 2);
INSERT INTO s_training_course_t(TrainingCourseID, TrainingCourseName, TrainingCourseDescription, TrainingLevel, Price, InEmployeeID)
VALUES(3, 'Art', 'Learn Art', 'Intro', 300, 3);
INSERT INTO s_training_course_t(TrainingCourseID, TrainingCourseName, TrainingCourseDescription, TrainingLevel, Price, InEmployeeID)
VALUES(4, 'Modeling', 'Learn to Financial Model', 'Master', 700, 4);
INSERT INTO s_training_course_t(TrainingCourseID, TrainingCourseName, TrainingCourseDescription, TrainingLevel, Price, InEmployeeID)
VALUES(5, 'Personal Finance', 'Learn to Budget', 'Intro', 250, 5);

INSERT INTO S_coordinator_t(AdEmployeeID, TrainingCourseID)
VALUES(1, 1);
INSERT INTO S_coordinator_t(AdEmployeeID, TrainingCourseID)
VALUES(2, 2);
INSERT INTO S_coordinator_t(AdEmployeeID, TrainingCourseID)
VALUES(3, 3);
INSERT INTO S_coordinator_t(AdEmployeeID, TrainingCourseID)
VALUES(4, 4);
INSERT INTO S_coordinator_t(AdEmployeeID, TrainingCourseID)
VALUES(5, 5);

INSERT INTO S_TIMESLOT_t(TSID, DayOfWeek, StartTime, EndTime, InEmployeeID)
VALUES(1, 'Monday', '9:00', '11:00', 1);
INSERT INTO S_TIMESLOT_t(TSID, DayOfWeek, StartTime, EndTime, InEmployeeID)
VALUES(2, 'Tuesday', '10:00', '12:00', 2);
INSERT INTO S_TIMESLOT_t(TSID, DayOfWeek, StartTime, EndTime, InEmployeeID)
VALUES(3, 'Tuesday', '2:00', '4:00', 3);
INSERT INTO S_TIMESLOT_t(TSID, DayOfWeek, StartTime, EndTime, InEmployeeID)
VALUES(4, 'Wednesday', '8:00', '10:00', 4);
INSERT INTO S_TIMESLOT_t(TSID, DayOfWeek, StartTime, EndTime, InEmployeeID)
VALUES(5, 'Wednesday', '12:00', '2:00', 5);

Insert into S_SCHEDULE_t (LocationID, RoomNumber, TSID)
Values(1, '1', 1);
Insert into S_SCHEDULE_t (LocationID, RoomNumber, TSID)
Values(2, '2', 2);
Insert into S_SCHEDULE_t (LocationID, RoomNumber, TSID)
Values(3, '3', 3);
Insert into S_SCHEDULE_t (LocationID, RoomNumber, TSID)
Values(4, '4', 4);
Insert into S_SCHEDULE_t (LocationID, RoomNumber, TSID)
Values(5, '5', 5);

DESC S_PROGRAM_t;
DESC S_LOCATION_t;
DESC S_ROOMS_t;
DESC S_PROGRAM_ROOM_PAIR_t;
DESC S_LAB_t;
DESC S_LECTURE_ROOM_t;
DESC S_OFFICE_t;
DESC S_TECHNOLOGICAL_TOOLS_t;
DESC S_LAB_TOOLS_t;
DESC S_EMPLOYEE_t;
DESC S_INSTRUCTOR_t;
DESC S_ADMINISTRATIVE_t;
DESC S_INSTRUCTOR_TOOLS_t;
DESC S_EVENT_t;
DESC S_TRAINING_COURSE_t;
DESC S_COORDINATOR_T;
DESC S_TIMESLOT_t;
DESC S_SCHEDULE_t;